﻿package com.droneSystem.servlet.user;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.me.JSONArray;
import org.json.me.JSONException;
import org.json.me.JSONObject;

import com.droneSystem.hibernate.Department;
import com.droneSystem.hibernate.RolePrivilege;
import com.droneSystem.hibernate.SysUser;
import com.droneSystem.hibernate.UserRole;
import com.droneSystem.manager.DepartmentManager;
import com.droneSystem.manager.RolePrivilegeManager;
import com.droneSystem.manager.UserManager;
import com.droneSystem.manager.UserRoleManager;
import com.droneSystem.util.DateTimeFormatUtil;
import com.droneSystem.util.ExportUtil;
import com.droneSystem.util.KeyValueWithOperator;
import com.droneSystem.util.LetterUtil;
import com.droneSystem.util.SystemCfgUtil;
import com.droneSystem.util.UIDUtil;
import com.droneSystem.util.UrlInfo;

public class UserServlet extends HttpServlet {

	private static Log log = LogFactory.getLog(UserServlet.class);
	/**
	 * Constructor of the object.
	 */
	public UserServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UserManager userMgr = new UserManager();	
		//String userId = request.getParameter("userId");
		Integer method = Integer.parseInt(request.getParameter("method"));	//判断请求的方法类型
		//System.out.println("session created");
		switch (method) {
		case 0: // 分页查询
			JSONObject res = new JSONObject();
			try {
				//String info = request.getParameter("Id");
				String queryStr = "from SysUser as model ";
				List<Object> list = new ArrayList<Object>();
				int page = 1;
				if (request.getParameter("page") != null)
					page = Integer.parseInt(request.getParameter("page").toString());
				int rows = 10;
				if (request.getParameter("rows") != null)
					rows = Integer.parseInt(request.getParameter("rows").toString());
				List<Object[]> result;
				int total;
				result = userMgr.findPageAllByHQL("select model " + queryStr + " order by model.status asc, model.jobNum asc", page, rows, list);
				total = userMgr.getTotalCountByHQL("select count(model) " + queryStr, list);
				JSONArray options = new JSONArray();
				//如果你有幸看到这段话，提醒你不要用Object[] obj去for:each这个result你会奔溃的...
					for (Object obj : result) {
						SysUser user = (SysUser)obj;
						JSONObject option = new JSONObject();
						option.put("Id", user.getId());
						option.put("Name", user.getName());
						//option.put("Brief", user.getBrief());
						option.put("userName", user.getUserName());
						//option.put("Gender", user.getGender());
						//option.put("JobNum", user.getJobNum());
						//option.put("Birthday", user.getBirthday());
						//option.put("IDNum", user.getIdnum());
						option.put("Education", user.getEducation());
						//option.put("Degree", user.getDegree());					
						option.put("JobTitle", user.getJobTitle());
						//option.put("Tel", user.getTel());
						//option.put("Cellphone1", user.getCellphone1());
						//option.put("Cellphone2", user.getCellphone2());
						//option.put("DepartmentId", user.getDepartment().getId());
						//option.put("Email", user.getEmail());
						option.put("Status", user.getStatus());
						
						options.put(option);
					}
					res.put("total", total);
					res.put("rows", options);
				} catch (Exception e) {
					try {
						res.put("total", 0);
						res.put("rows", new JSONArray());
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in UserServlet-->case 0", e);
					}else{
						log.error("error in UserServlet-->case 0", e);
					} 

				}finally{
					response.setContentType("text/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(res.toString());
					//System.out.println(res.toString());
				}
			break;
		case 1:	//新增用户
			SysUser sysuser = initUser(request, 0);		
			if(userMgr.isUserNameExist(sysuser.getUserName())){//用户名已存在
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':false,'msg':'用户名已存在'}");	
			}else{	//用户名不存在
				try{
					
					//MessageDigest md = MessageDigest.getInstance("SHA-1");	//设置初始密码，密码用SHA-1算法加密后存放
					//user.setPassword(new String(md.digest(user.getJobNum().getBytes())));	
					sysuser.setPassword(request.getParameter("Password"));
					JSONObject retObj=new JSONObject();
					boolean res1 = userMgr.save(sysuser);
					retObj.put("IsOK", res1);
					retObj.put("msg", res1?"员工添加成功！":"员工添加失败，请重新添加！");
					response.setContentType("text/html;charset=utf-8");
					response.getWriter().write(retObj.toString());
				}catch(Exception e){
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in UserServlet-->case 1", e);
					}else{
						log.error("error in UserServlet-->case 1", e);
					} 
					response.setContentType("text/html;charset=utf-8");
					response.getWriter().write("{'IsOK':false,'msg':'员工添加失败，请重新添加！'}");
				}
			}
			break;
		case 2:	//修改用户信息
			try{
				SysUser user = initUser(request, Integer.valueOf(request.getParameter("Id")));
				if(user == null){
					response.setContentType("text/html;charset=utf-8");
					response.getWriter().write("{'IsOK':false,'msg':'修改失败，该用户不存在'}");	
				}else{
					user.setPassword(request.getParameter("Password"));
					if(userMgr.update(user)){
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().write("{'IsOK':true,'msg':'修改成功}");	
					}else{
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().write("{'IsOK':false,'msg':'修改失败'}");	
					}
				}					
			}catch(Exception e){
				if(e.getClass() == java.lang.Exception.class){ //自定义的消息
					log.debug("exception in UserServlet-->case 2", e);
				}else{
					log.error("error in UserServlet-->case 2", e);
				} 
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':false,'msg':'修改失败'}");	
			}		
			break;
		case 3:	//重置密码
			try{
				List<SysUser> check = userMgr.findByVarProperty(new KeyValueWithOperator("userName", request.getParameter("userName"), "="));
				if(check == null||check.size()==0){
					response.setContentType("text/html;charset=utf-8");
					response.getWriter().write("{'IsOK':false,'msg':'重置密码失败，该用户不存在'}");	
				}else{
					SysUser user = check.get(0);
					//MessageDigest md = MessageDigest.getInstance("SHA-1");	//重置初始密码，密码用SHA-1算法加密后存放						
					if(userMgr.update(user)){
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().write("{'IsOK':true,'msg':'重置密码成功'}");	
					}else{
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().write("{'IsOK':false,'msg':'重置密码失败'}");	
					}
				}					
			}catch(Exception e){
				if(e.getClass() == java.lang.Exception.class){ //自定义的消息
					log.debug("exception in UserServlet-->case 3", e);
				}else{
					log.error("error in UserServlet-->case 3", e);
				} 
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':false,'msg':'重置密码失败'}");	
			}		
			break;
		case 4:	//用户登录
			JSONObject retJSON = new JSONObject();
			try{
				String pwd = request.getParameter("password");
				//MessageDigest md = MessageDigest.getInstance("SHA-1");	//重置初始密码，密码用SHA-1算法加密后存放	
				SysUser filter = new SysUser();
				String userName = request.getParameter("userName");
				filter.setUserName(userName);
				filter.setStatus(0);
				List<SysUser> result1 = userMgr.findByExample(filter);
				if(result1 != null && result1.size() == 1){
					if(!result1.get(0).getPassword().equals(pwd)){
						throw new Exception("用户名或者密码不正确！");
					}
					
					//存储已登录用户的权限列表Map
					ServletContext context = this.getServletContext();
					Map<Integer, Map<Integer,UrlInfo>> pMap = (Map<Integer, Map<Integer,UrlInfo>>)context.getAttribute(SystemCfgUtil.ContextAttrNameUserPrivilegesMap);
					if(pMap == null){	//第一个用户登录
						pMap = new HashMap<Integer, Map<Integer,UrlInfo>>();
						context.setAttribute(SystemCfgUtil.ContextAttrNameUserPrivilegesMap, pMap);
					}
					if(!pMap.containsKey(result1.get(0).getId())){
						Map<Integer, UrlInfo> pRetMap = new RolePrivilegeManager().getPrivilegesByUserId(result1.get(0).getId());
						if(pRetMap != null){
							pMap.put(result1.get(0).getId(), pRetMap);
						}
					}
					if(UserLog.getInstance().UserLogin(result1.get(0).getId(), request.getRemoteAddr(),request)){	//登录成功
						HttpSession session = request.getSession(true);
						session.setAttribute(SystemCfgUtil.SessionAttrNameLoginUser, result1.get(0));
						retJSON.put("IsOK", true);
						return ;
					}else{	//已登录
						throw new Exception("用户已登录，一个账号不允许同时在两个地方登录！");
					}
				}
				throw new Exception("用户名或者密码不正确！");
			}catch(Exception e){
				if(e.getClass() == java.lang.Exception.class){ //自定义的消息
					log.debug("exception in UserServlet-->case 4", e);
				}else{
					log.error("error in UserServlet-->case 4", e);
				} 
				try {
					retJSON.put("IsOK", false);
					retJSON.put("msg", String.format("登陆失败！错误信息：%s", (e!=null && e.getMessage()!=null)?e.getMessage():"无"));
				} catch (JSONException e1) {}
			}finally{
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write(retJSON.toString());
			}
			break;
		case 5:	//用户登出
			JSONObject retJSON5 = new JSONObject();
			try{
				HttpSession session = request.getSession();
				if(session != null){
					session.setAttribute("FromLogout", true);
					session.invalidate();
				}
//				request.getRequestDispatcher("/index.jsp").forward(request, response);
				retJSON5.put("IsOK", true);
				//System.out.println("userlogged out");
			}catch(Exception e){
				try {
					retJSON5.put("IsOK", false);
					retJSON5.put("msg", String.format("退出系统失败！错误信息：%s", (e!=null && e.getMessage()!=null)?e.getMessage():"无"));
				} catch (JSONException e1) {}
				
				if(e.getClass() == java.lang.Exception.class){ //自定义的消息
					log.debug("exception in UserServlet-->case 5", e);
				}else{
					log.error("error in UserServlet-->case 5", e);
				}
			}finally{
				response.setContentType("text/json;charset=utf-8");
				response.getWriter().write(retJSON5.toString());
			}
			break;
		case 6:	//前端控件中输入用户名AutoComplete查询符合条件的用户列表（默认前三十个）,业务过程中使用，不包括已注销人员
			String userNameStr = request.getParameter("QueryName");	//查询的用户姓名
			JSONArray jsonArray = new JSONArray();
			try {
				if(userNameStr != null && userNameStr.trim().length() > 0){
					String cusName =  new String(userNameStr.trim().getBytes("ISO-8859-1"), "GBK");	//解决URL传递中文乱码问题
					//cusName = LetterUtil.String2Alpha(cusName);	//返回字母简码
					String queryStr = "from SysUser model where (model.brief like ? or model.name like ? or model.jobNum like ?) and model.status = 0";
					List<SysUser> retList = userMgr.findPageAllByHQL(queryStr, 1, 30, "%" + cusName + "%", "%" + cusName + "%", "%" + cusName + "%");
					if(retList != null){
						for(SysUser user : retList){
							JSONObject jsonObj = new JSONObject();
							jsonObj.put("jobNum", user.getJobNum());
							jsonObj.put("name", user.getName());
							jsonObj.put("id", user.getId());
							jsonArray.put(jsonObj);	
						}
					}
				}
			} catch (Exception e) {
				if(e.getClass() == java.lang.Exception.class){ //自定义的消息
					log.debug("exception in UserServlet-->case 6", e);
				}else{
					log.error("error in UserServlet-->case 6", e);
				} 
			}finally{
				response.setContentType("text/json;charset=gbk");
				response.getWriter().write(jsonArray.toString());
			}
			break;
		case 7://修改密码
			//String pwd = request.getParameter("old_pwd");
			String new_pwd = request.getParameter("Password");
			SysUser user = (SysUser)request.getSession().getAttribute("LOGIN_USER");
//			if(!pwd.equals(user.getPassword()))
//			{
//				response.setContentType("text/html;charset=utf-8");
//				response.getWriter().write("{'IsOK':false,'msg':'原密码错误'}");
//			}
//			if{
			user.setPassword(new_pwd);
			if(userMgr.update(user)){
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':true,'msg':'密码修改成功'}");	
			}else{
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':false,'msg':'密码修改失败'}");	
			}
//			}
			break;
		case 8://注销用户
			String id = request.getParameter("Id");
			SysUser del_user = userMgr.findById(Integer.valueOf(id));
			del_user.setStatus(1);
			del_user.setCancelDate(new Timestamp(System.currentTimeMillis()));
			if(userMgr.update(del_user)){
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':true,'msg':'注销成功！'}");	
			}else{
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':false,'msg':'注销失败！'}");	
			}
			break;
		case 9://重置密码
			String username = request.getParameter("userName");
			String jobNum = request.getParameter("JobNum");
			List<SysUser> check = userMgr.findByVarProperty(new KeyValueWithOperator("userName", username, "="),new KeyValueWithOperator("jobNum", jobNum, "="));
			if(check==null||check.size()==0)
			{
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write("{'IsOK':false,'msg':'用户名与工号不一致，请确认！'}");	
			}
			else
			{
				SysUser user1 = check.get(0);
				user1.setPassword(user1.getJobNum());
				if(userMgr.update(user1)){
					response.setContentType("text/html;charset=utf-8");
					response.getWriter().write("{'IsOK':true,'msg':'重置密码成功！'}");	
				}else{
					response.setContentType("text/html;charset=utf-8");
					response.getWriter().write("{'IsOK':false,'msg':'重置密码失败！'}");	
				}
			}
			break;
		case 10://导出
			String paramsStr = request.getParameter("paramsStr");
			JSONObject retObj7 = new JSONObject();
			try {
				JSONObject params = new JSONObject(paramsStr);
				String queryStr = "select model from SysUser as model,ProjectTeam as model1 where 1=1 and model.projectTeamId = model1.id ";
				List<Object> list = new ArrayList<Object>();
				if(params.length()!=0)
				{
					String queryname = params.getString("queryname");
					String queryGender = params.getString("queryGender");
					String queryJobTitle = params.getString("queryJobTitle");
					String queryDepartment = params.getString("queryDepartment");
					String queryProjectTeam = params.getString("queryProjectTeam");
					String queryStatus = params.getString("queryStatus");
					String queryType = params.getString("queryType");
					String queryTel = params.getString("queryTel");
					String queryIDNum = params.getString("queryIDNum");
					String queryPolStatus = params.getString("queryPolStatus");
					if(queryname != null&&!queryname.equals(""))
					{
						String userName = URLDecoder.decode(queryname, "UTF-8");
						list.add("%" + userName + "%");
						list.add("%" + userName + "%");
						queryStr = queryStr + "and (model.brief like ? or model.name like ?) ";
					}
					if(queryGender != null&&!queryGender.equals("undefined"))
					{
						String userGenderStr = URLDecoder.decode(queryGender, "UTF-8");
						list.add(Integer.valueOf(userGenderStr).equals(0));
						queryStr = queryStr + "and model.gender = ? ";
					}
					if(queryJobTitle != null&&!queryJobTitle.equals(""))
					{
						String userJobTitleStr = URLDecoder.decode(queryJobTitle, "UTF-8");
						list.add("%" + userJobTitleStr + "%");
						queryStr = queryStr + "and model.jobTitle like ? ";
					}
					if(queryDepartment != null&&!queryDepartment.equals(""))
					{
						String userDepartmentStr = URLDecoder.decode(queryDepartment, "UTF-8");
						list.add(LetterUtil.isNumeric(userDepartmentStr)?Integer.valueOf(userDepartmentStr):0);
						list.add("%" + userDepartmentStr + "%");
						list.add("%" + userDepartmentStr + "%");
						queryStr = queryStr + "and model.projectTeamId in (select model1.id from ProjectTeam as model1 where model1.department.id = ? or model1.department.name like ? or model1.department.brief like ?) ";
					}
					if(queryProjectTeam != null&&!queryProjectTeam.equals(""))
					{
						String userProjectTeamStr = URLDecoder.decode(queryProjectTeam, "UTF-8");
						list.add(LetterUtil.isNumeric(userProjectTeamStr)?Integer.valueOf(userProjectTeamStr):0);
						list.add("%" + userProjectTeamStr + "%");
						list.add("%" + userProjectTeamStr + "%");
						queryStr = queryStr + "and (model.projectTeamId = ? or model.projectTeamId in (select model1.id from ProjectTeam as model1 where model1.name like ? or model1.brief like ?)) ";
					}
					if(queryStatus != null&&!queryStatus.equals(""))
					{
						String userStatusStr = URLDecoder.decode(queryStatus, "UTF-8");
						list.add(LetterUtil.isNumeric(userStatusStr)?Integer.valueOf(userStatusStr):0);
						queryStr = queryStr + "and model.status = ? ";
					}
					if(queryType != null&&!queryType.equals(""))
					{
						String userTypeStr = URLDecoder.decode(queryType, "UTF-8");
						list.add(LetterUtil.isNumeric(userTypeStr)?Integer.valueOf(userTypeStr):0);
						queryStr = queryStr + "and model.type = ? ";
					}
					if(queryTel != null&&!queryTel.equals(""))
					{
						String userTelStr = URLDecoder.decode(queryTel, "UTF-8");
						list.add("%" + userTelStr + "%");
						list.add("%" + userTelStr + "%");
						list.add("%" + userTelStr + "%");
						queryStr = queryStr + "and (model.tel like ? or model.cellphone1 like ? or model.cellphone2 like ?) ";
					}
					if(queryIDNum != null&&!queryIDNum.equals(""))
					{
						String userIDNumStr = URLDecoder.decode(queryIDNum, "UTF-8");
						list.add("%" + userIDNumStr + "%");
						queryStr = queryStr + "and model.idnum like ? ";
					}
					if(queryPolStatus != null&&!queryPolStatus.equals(""))
					{
						String userPolStatusStr = URLDecoder.decode(queryPolStatus, "UTF-8");
						list.add("%" + userPolStatusStr + "%");
						queryStr = queryStr + "and model.politicsStatus like ? ";
					}
				}
				String filePath = ExportUtil.ExportToExcel(queryStr + "order by model1.proTeamCode asc,model.jobNum asc", list, null, "formatExcel", "formatTitle", UserManager.class);				
				retObj7.put("IsOK", filePath.equals("")?false:true);
				retObj7.put("Path", filePath);
			} catch (Exception e) {
				if(e.getClass() == java.lang.Exception.class){	//自定义的消息
					log.debug("exception in UserServlet-->case 10", e);
				}else{
					log.error("error in UserServlet-->case 10", e);
				}
				try {
					retObj7.put("IsOK", false);
					retObj7.put("Path", "");
				} catch (JSONException e1) {}
			}finally{
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write(retObj7.toString());
			}
			break;

		case 13: // 根据角色名和姓名查询是否授权
			JSONObject res2= new JSONObject();;	
			int total=0;
			try {
				String roleId = request.getParameter("roleId");
				String queryname = request.getParameter("queryname");
				if(roleId==null)
				{
					throw new Exception("角色为空");//角色为空
				}
				String userNameStr1="";
				if(queryname != null&&!queryname.equals(""))
				{
					userNameStr1 = URLDecoder.decode(queryname, "UTF-8");
				}
				UserRoleManager role_user_mag = new UserRoleManager();
				total=role_user_mag.getTotalCount(new KeyValueWithOperator("role.id",Integer.valueOf(URLDecoder.decode(roleId, "UTF-8")),"="),
						new KeyValueWithOperator("status", 0, "="),new KeyValueWithOperator("sysUser.name", "%" + userNameStr1 + "%", "like"));
				List<UserRole> role_users = role_user_mag.findByVarProperty(new KeyValueWithOperator("role.id",Integer.valueOf(URLDecoder.decode(roleId, "UTF-8")),"="),
						new KeyValueWithOperator("status", 0, "="),new KeyValueWithOperator("sysUser.name", "%" + userNameStr1 + "%", "like"));
				JSONArray options2 = new JSONArray();
				if(role_users== null||role_users.size()==0)
				{
					throw new Exception("查询结果为空");//查询结果为空
				}
				for (UserRole temp1:role_users) {
					JSONObject option = new JSONObject();
					option.put("userroleId", temp1.getId());
					option.put("roleId", temp1.getRole().getId());
					option.put("Id", temp1.getSysUser().getId());
					option.put("JobNum", temp1.getSysUser().getJobNum());  //用户工号
					option.put("Name", temp1.getSysUser().getName());//用户姓名
					option.put("userName", temp1.getSysUser().getUserName());//用户名
					option.put("JobTitle", temp1.getSysUser().getJobTitle());//行政职务
					options2.put(option);
				}
				res2.put("total", total);
				res2.put("rows", options2);
			} catch (Exception ex) {
				if(ex.getClass() == java.lang.Exception.class){	//自定义的消息
					log.debug("exception in UserServlet-->case 13", ex);
				}else{
					log.error("error in UserServlet-->case 13", ex);
				}
				try {
					res2.put("total", 0);
					res2.put("rows", new JSONArray());
				} catch (JSONException e1) {}
			}finally{
				response.setContentType("text/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(res2.toString());
			}
			break;
		case 14://导出个人或者全部权限信息
			
			JSONObject retObj14 = new JSONObject();
			try {
				String paramsStr14 = request.getParameter("paramsStr");
				List<JSONObject> result= new ArrayList<JSONObject>();
				if(paramsStr14==null||paramsStr14.length()==0){
					result= new RolePrivilegeManager().ExportPrivilegesByUserId(null);//导出全部用户名的权限
				}else{
					int userid=Integer.parseInt(paramsStr14);	
					result = new RolePrivilegeManager().ExportPrivilegesByUserId(userid);//导出个人的权限
				}
				String filePath = ExportUtil.ExportToExcelByResultSet(result,null, "formatExcel", "formatTitle", RolePrivilegeManager.class);				
				retObj14.put("IsOK", filePath.equals("")?false:true);
				retObj14.put("Path", filePath);
			} catch (Exception e) {
				if(e.getClass() == java.lang.Exception.class){	//自定义的消息
					log.debug("exception in UserServlet-->case 10", e);
				}else{
					log.error("error in UserServlet-->case 10", e);
				}
				try {
					retObj14.put("IsOK", false);
					retObj14.put("Path", "");
				} catch (JSONException e1) {}
			}finally{
				response.setContentType("text/html;charset=utf-8");
				response.getWriter().write(retObj14.toString());
			}
			break;
		case 15: // 分页查询(GrantRole)中使用
			JSONObject res15 = new JSONObject();
			try {
				String queryname = request.getParameter("queryname");
				
				String queryStr = "from SysUser as model,ProjectTeam as pro where 1=1 and model.projectTeamId = pro.id and model.status = 0 ";
				List<Object> list = new ArrayList<Object>();
				if(queryname != null&&!queryname.equals(""))
				{
					String userNameStr15 = URLDecoder.decode(queryname, "UTF-8");
					
					list.add("%" + userNameStr15 + "%");
					list.add("%" + userNameStr15 + "%");
					queryStr = queryStr + "and (model.brief like ? or model.name like ?) ";
				}
				
				int page = 1;
				if (request.getParameter("page") != null)
					page = Integer.parseInt(request.getParameter("page").toString());
				int rows = 10;
				if (request.getParameter("rows") != null)
					rows = Integer.parseInt(request.getParameter("rows").toString());
				List<Object[]> result;
				int total15;
				List<JSONObject> resultP;
				StringBuilder priString;
				result = userMgr.findPageAllByHQL("select model,pro " + queryStr + " order by pro.proTeamCode asc,model.jobNum asc", page, rows, list);
				total15 = userMgr.getTotalCountByHQL("select count(model) "+queryStr, list);
				JSONArray options = new JSONArray();
					for (Object[] obj : result) {
						SysUser user15 = (SysUser)obj[0];
						JSONObject option = new JSONObject();
						option.put("Id", user15.getId());
						option.put("Name", user15.getName());
						option.put("Brief", user15.getBrief());
						option.put("userName", user15.getUserName());
						option.put("JobNum", user15.getJobNum());		
						option.put("IDNum", user15.getIdnum());						
						option.put("JobTitle", user15.getJobTitle());
						option.put("DepartmentId", user15.getDepartment().getId());
						option.put("Status", user15.getStatus());
						
						resultP = new ArrayList<JSONObject>();
						priString = new StringBuilder();
						resultP = new RolePrivilegeManager().ExportAlonePrivilegesByUserId(user15.getId());//导出个人的权限
						for(int j = 0;j<resultP.size();j++)
						{							
							JSONObject objpri = (JSONObject)resultP.get(j);
							String RoleName = objpri.getString("RoleName");
							if(!priString.toString().contains(RoleName+";")){
								priString.append(objpri.getString("RoleName")).append(";");
							}
							
						}
						option.put("UserRoles",priString.toString());
						
						options.put(option);
					}
					res15.put("total", total15);
					res15.put("rows", options);
				} catch (Exception e) {
					try {
						res15.put("total", 0);
						res15.put("rows", new JSONArray());
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in UserServlet-->case 15", e);
					}else{
						log.error("error in UserServlet-->case 15", e);
					} 

				}finally{
					response.setContentType("text/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(res15.toString());
					//System.out.println(res.toString());
				}
			break;
		case 16:	//前端控件中输入用户名AutoComplete查询符合条件的用户列表（默认前三十个）,查询统计中使用，包括已注销人员
			String userNameStr16 = request.getParameter("QueryName");	//查询的用户姓名
			JSONArray jsonArray16 = new JSONArray();
			try {
				if(userNameStr16 != null && userNameStr16.trim().length() > 0){
					String cusName =  new String(userNameStr16.trim().getBytes("ISO-8859-1"), "GBK");	//解决URL传递中文乱码问题
					//cusName = LetterUtil.String2Alpha(cusName);	//返回字母简码
					String queryStr = "from SysUser model where model.brief like ? or model.name like ? or model.jobNum like ?";
					List<SysUser> retList = userMgr.findPageAllByHQL(queryStr, 1, 30, "%" + cusName + "%", "%" + cusName + "%", "%" + cusName + "%");
					if(retList != null){
						for(SysUser temp : retList){
							JSONObject jsonObj = new JSONObject();
							jsonObj.put("jobNum", temp.getJobNum());
							jsonObj.put("name", temp.getName());
							jsonObj.put("id", temp.getId());
							jsonArray16.put(jsonObj);	
						}
					}
				}
			} catch (Exception e) {
				if(e.getClass() == java.lang.Exception.class){ //自定义的消息
					log.debug("exception in UserServlet-->case 16", e);
				}else{
					log.error("error in UserServlet-->case 16", e);
				} 
			}finally{
				response.setContentType("text/json;charset=gbk");
				response.getWriter().write(jsonArray16.toString());
			}
			break;
		}
		
		
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	
	private SysUser initUser(HttpServletRequest req, int id) {
		SysUser user;
		if(id==0)
		{
			user = new SysUser();
		}
		else
		{
			UserManager um = new UserManager();
			user = um.findById(id);
			if(user==null)
				return null;
		}
				
		String Name = req.getParameter("Name");
		String Brief = req.getParameter("userName");
		String userName =  req.getParameter("userName");
		String JobNum = req.getParameter("Password");
		String WorkLocation = req.getParameter("WorkLocation");
		String Gender = req.getParameter("Gender");
		Date Birthday = new Date(System.currentTimeMillis());
		String IDNum = req.getParameter("IDNum");
		String JobTitle = req.getParameter("JobTitle");
		String Education = req.getParameter("Education");
		String Degree = req.getParameter("Degree");
		String HomeAdd = req.getParameter("HomeAdd");
		String Tel = req.getParameter("Tel");
		String Cellphone1 = req.getParameter("Cellphone1");
		String Cellphone2 = req.getParameter("Cellphone2");
		String Email = req.getParameter("Email");
		int DepartmentId = Integer.valueOf(req.getParameter("DepartmentId"));
		DepartmentManager depMgr= new DepartmentManager();
		Department dep = depMgr.findById(DepartmentId);
		int Status = 0;
		if(user.getStatus()!=null&&user.getStatus()==1&&Status==0)
		{
			user.setStatus(Status);
			user.setCancelDate(null);
		}
		else
			user.setStatus(Status);
		String Remark = req.getParameter("Remark");				
		
		user.setName(Name);
		user.setBrief(Brief==null?"":Brief);
		user.setJobNum(JobNum==null?"":JobNum);
		user.setUserName(id==0?userName:user.getUserName());
		user.setGender(Integer.valueOf(Gender).equals(0));
		user.setBirthday(Birthday);
		user.setIdnum(IDNum==null?"":IDNum);
		user.setJobTitle(JobTitle==null?"":JobTitle);
		user.setEducation(Education==null?"":Education);
		user.setDegree(Degree==null?"":Degree);
		user.setHomeAdd(HomeAdd==null?"":HomeAdd);
		user.setTel(Tel==null?"":Tel);
		user.setCellphone1(Cellphone1==null?"":Cellphone1);
		user.setCellphone2(Cellphone2==null?"":Cellphone2);
		user.setEmail(Email==null?"":Email);
		user.setDepartment(dep);
		user.setStatus(Status);
		
		return user;
	}

}
