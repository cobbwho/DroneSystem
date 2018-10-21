package com.droneSystem.filter;


import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.json.me.JSONArray;
import org.json.me.JSONObject;

import com.droneSystem.hibernate.SysUser;
import com.droneSystem.manager.RolePrivilegeManager;
import com.droneSystem.util.SysStringUtil;
import com.droneSystem.util.SystemCfgUtil;
import com.droneSystem.util.UrlInfo;
import com.sun.jmx.snmp.Enumerated;

/**
 * ��֤�û�Ȩ��
 * @author Zhan
 *
 */
public class AuthFilter extends HttpServlet implements Filter {
	private static final String ProjectName = SystemCfgUtil.ProjectName;	//��Ŀ���ƣ�����URL������Դ����
	private static final Log log = LogFactory.getLog(AuthFilter.class);
	public static List<UrlInfo> unProtectedResJsp = null;
	public static List<UrlInfo> unProtectedResServlet = null;
	private static Element rootElement = null;
	
//	private FilterConfig config=null;
	private String unprotectedUrlsFilePath = null;

	public AuthFilter() {}

	public void init(FilterConfig filtercfg)
			throws javax.servlet.ServletException {
//		this.config = filtercfg;
//		this.unprotectedUrlsFilePath = config.getInitParameter("filepath");
		this.unprotectedUrlsFilePath = SystemCfgUtil.UnprotectedUrlsConfigFilePath;
		try {
			getUnprotectedResources();
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(String.format("Ȩ����֤��������ʼ��ʧ��:%s", e.getMessage()==null?"":e.getMessage()));
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterchain) throws java.io.IOException,
			javax.servlet.ServletException {
		try {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse resp = (HttpServletResponse) response;
			
//			System.out.println("in AuthFilter->doFilter(): getRequestURL + queryString: "
//					+ req.getRequestURI().toString() + "?"
//					+ req.getQueryString());
//			System.out.println(req.getHeader("x-requested-with"));
//			Enumeration<String> e = req.getHeaderNames();
//			while(e.hasMoreElements()){
//				String name = e.nextElement();
//				System.out.println(name+"    "+req.getHeader(name));
//			}
//			System.out.println(req.getParameter("form_submit_request_type_byzhan"));//form('submit')��ʽ�ύʱ���ֶε�ֵΪ"form_submit_ajax";
			
			log.debug("in AuthFilter->doFilter(): getRequestURL + queryString: "
					+ req.getRequestURI().toString() + "?"
					+ req.getQueryString());
			boolean isUnprotected = isUnprotectedUrl(req);
			if (isUnprotected) {
				filterchain.doFilter(request, response);
				return;
			}

			
			if (req.getSession().getAttribute("LOGIN_USER") == null) {
				String requestFlag = req.getHeader("x-requested-with");//�ж��Ƿ����첽�ύ
				if(requestFlag !=null && requestFlag.equalsIgnoreCase("XMLHttpRequest")){
					JSONObject retObj = new JSONObject();
					retObj.put("IsOK", false);
					retObj.put("msg", "��û�����Ȩ��ִ�иò�����");
					retObj.put("total", 0);
					retObj.put("rows", new JSONArray());
					resp.setContentType(SysStringUtil.ResponseContentType.Type_AjaxSubmit);
					PrintWriter out = resp.getWriter();
					out.print(retObj.toString());
					out.flush();
					out.close();
				}else{//һ��http����:����form('submit')��ʽ������תҳ�棩��ֱ�ӵ�form�ύ��ҳ����ת����
					if(req.getParameter("form_submit_request_type_byzhan") != null && req.getParameter("form_submit_request_type_byzhan").equals("form_submit_ajax")){ //ͨ��form('submit')��ʽ�ύ
						JSONObject retObj = new JSONObject();
						retObj.put("IsOK", false);
						retObj.put("msg", "��û�����Ȩ��ִ�иò�����");
						retObj.put("total", 0);
						retObj.put("rows", new JSONArray());
						resp.setContentType(SysStringUtil.ResponseContentType.Type_FormSubmit);
						PrintWriter out = resp.getWriter();
						out.print(retObj.toString());
						out.flush();
						out.close();
					}else{
						resp.sendRedirect(req.getContextPath()+"/noPrivilege.htm");
					}
				}
				return;
			}
			
			//�ܱ�������Դ���û������ѵ�¼
			SysUser loginUser = (SysUser) req.getSession().getAttribute("LOGIN_USER");
			//��ȡ�ѵ�¼�û���Ȩ���б�Map
			ServletContext context = req.getSession().getServletContext();
			Map<Integer, Map<Integer, UrlInfo>> pMap = (Map<Integer, Map<Integer, UrlInfo>>)context.getAttribute(SystemCfgUtil.ContextAttrNameUserPrivilegesMap);
			if(pMap == null || loginUser == null){
				//��ʾ
				String requestFlag = req.getHeader("x-requested-with");//�ж��Ƿ����첽�ύ
				if(requestFlag !=null && requestFlag.equalsIgnoreCase("XMLHttpRequest")){
					JSONObject retObj = new JSONObject();
					retObj.put("IsOK", false);
					retObj.put("msg", "��û�����Ȩ��ִ�иò�����");
					retObj.put("total", 0);
					retObj.put("rows", new JSONArray());
					resp.setContentType(SysStringUtil.ResponseContentType.Type_AjaxSubmit);
					PrintWriter out = resp.getWriter();
					out.print(retObj.toString());
					out.flush();
					out.close();
				}else{//һ��http����:����form('submit')��ʽ������תҳ�棩��ֱ�ӵ�form�ύ��ҳ����ת����
					if(req.getParameter("form_submit_request_type_byzhan") != null && req.getParameter("form_submit_request_type_byzhan").equals("form_submit_ajax")){ //ͨ��form('submit')��ʽ�ύ
						JSONObject retObj = new JSONObject();
						retObj.put("IsOK", false);
						retObj.put("msg", "��û�����Ȩ��ִ�иò�����");
						retObj.put("total", 0);
						retObj.put("rows", new JSONArray());
						resp.setContentType(SysStringUtil.ResponseContentType.Type_FormSubmit);
						PrintWriter out = resp.getWriter();
						out.print(retObj.toString());
						out.flush();
						out.close();
					}else{
						resp.sendRedirect(req.getContextPath()+"/noPrivilege.htm");
					}
				}
				return;
			}
			if(!pMap.containsKey(loginUser.getId())){
				Map<Integer, UrlInfo> pRetMap = new RolePrivilegeManager().getPrivilegesByUserId(loginUser.getId());
				if(pRetMap != null){
					pMap.put(loginUser.getId(), pRetMap);
				}
			}
			if (!checkSafe(req, pMap.get(loginUser.getId()))) {	//�û�������ֹ������ִ�иò���
				filterchain.doFilter(request, response);
				return;
			} else {
				//��ʾ
				String requestFlag = req.getHeader("x-requested-with");//�ж��Ƿ����첽�ύ
				if(requestFlag !=null && requestFlag.equalsIgnoreCase("XMLHttpRequest")){
					JSONObject retObj = new JSONObject();
					retObj.put("IsOK", false);
					retObj.put("msg", "��û�����Ȩ��ִ�иò�����");
					retObj.put("total", 0);
					retObj.put("rows", new JSONArray());
					resp.setContentType(SysStringUtil.ResponseContentType.Type_AjaxSubmit);
					PrintWriter out = resp.getWriter();
					out.print(retObj.toString());
					out.flush();
					out.close();
				}else{//һ��http����:����form('submit')��ʽ������תҳ�棩��ֱ�ӵ�form�ύ��ҳ����ת����
					if(req.getParameter("form_submit_request_type_byzhan") != null && req.getParameter("form_submit_request_type_byzhan").equals("form_submit_ajax")){ //ͨ��form('submit')��ʽ�ύ
						JSONObject retObj = new JSONObject();
						retObj.put("IsOK", false);
						retObj.put("msg", "��û�����Ȩ��ִ�иò�����");
						retObj.put("total", 0);
						retObj.put("rows", new JSONArray());
						resp.setContentType(SysStringUtil.ResponseContentType.Type_FormSubmit);
						PrintWriter out = resp.getWriter();
						out.print(retObj.toString());
						out.flush();
						out.close();
					}else{
						resp.sendRedirect(req.getContextPath()+"/noPrivilege.htm");
					}
				}
			}

		} catch (Exception e) {
			log.error("error in authorization filter", e);
		}
	}

	/**
	 * �ж�һ�������Ƿ�Ϊ�Ǳ�����Դ
	 * @param request
	 * @return ������Ϊ�Ǳ�����Դ������true�����򣬷���false
	 */
	private boolean isUnprotectedUrl(HttpServletRequest request) {
		String url = request.getRequestURI().toString();
		if(url.equals("/droneSystem/DroneServlet.do")){
			return true;
		}
		int index = url.indexOf(ProjectName);
		if (index > -1) {
			url = url.substring(index + ProjectName.length());
		}
		String queryString = request.getQueryString();
		
		List<UrlInfo> unProtectedRes = null;
		if(url.endsWith(".do")){
			unProtectedRes = unProtectedResServlet;
		}else{
			unProtectedRes = unProtectedResJsp;
		}
		for(UrlInfo unProtUrl : unProtectedRes) {
			if(unProtUrl.isMatchUrl(url, queryString)){	//�Ƿ�ƥ��
				return true;
			}
		}
		return false;
	}

	/**
	 * �ж�һ���û��Ƿ� ��ӵ�У���ֹ������ ĳ����Դ��Ȩ��
	 * @param request���û��������Դ
	 * @param pSet :�û�ӵ�е�Ȩ��Url(��ʽ��URI����URI?����)
	 * @return �û� ��ӵ�У���ֹ������ ����Դ��Ȩ���򷵻�true�����򣬷���false
	 */
	private boolean checkSafe(HttpServletRequest request, Map<Integer, UrlInfo> pUrlMap) {
		if(pUrlMap == null){
			return false;
		}
		String uri = request.getRequestURI().toString();
		int index = uri.indexOf(ProjectName);
		if (index > -1) {
			uri = uri.substring(index + ProjectName.length());
		}
		String queryString = request.getQueryString();
		
		Iterator<Entry<Integer, UrlInfo>> iter = pUrlMap.entrySet().iterator();
		while(iter.hasNext()){
			Entry<Integer, UrlInfo> e = iter.next();
			if(e.getValue().isMatchUrl(uri, queryString)){	//�Ƿ�ӵ��Ȩ��
				return true;
			}
		}
		return false;
	}

	public void destroy() {
//		this.config = null;
		this.unprotectedUrlsFilePath = null;
	}

	/**
	 * ���������ļ�
	 * @param cfgFilePath �����ļ����·��
	 */
	private void load(String cfgFilePath) throws Exception {
		URL url = AuthFilter.class.getClassLoader().getResource(cfgFilePath);
		rootElement = new SAXBuilder().build(url).getRootElement();
	}

	/**
	 * ��������ļ���ָ�����Ƶ�Element
	 * @param elementName
	 * @return
	 */
	private Element getElement(String elementName) throws Exception {
		return rootElement.getChild(elementName);
	}

	/**
	 * ��ȡ���ܷ������Ƶ���Դ��Ϣ�б�
	 */
	private void getUnprotectedResources() throws Exception {
		if(rootElement == null){
			load(this.unprotectedUrlsFilePath);
		}
		if (unProtectedResJsp == null) {
			unProtectedResJsp = new ArrayList<UrlInfo>();
			Element interceptors = getElement("unprotectedurls-jsp");
			List<Element> urlList = interceptors.getChildren("unprotectedurl");
			Iterator<Element> it = urlList.iterator();
			Element tmpElement = null;
			while (it.hasNext()) {
				tmpElement = it.next();
				String url = tmpElement.getAttributeValue("url");
				if(url != null){
					unProtectedResJsp.add(new UrlInfo(url));
				}
				
			}
		}
		if (unProtectedResServlet == null) {
			unProtectedResServlet = new ArrayList<UrlInfo>();
			Element interceptors = getElement("unprotectedurls-servlet");
			List<Element> urlList = interceptors.getChildren("unprotectedurl");
			Iterator<Element> it = urlList.iterator();
			Element tmpElement = null;
			while (it.hasNext()) {
				tmpElement = it.next();
				String url = tmpElement.getAttributeValue("url");
				if(url != null){
					unProtectedResServlet.add(new UrlInfo(url));
				}
			}
		}
	}

	public static void main(String[] args) {

		AuthFilter tools = new AuthFilter();
		try{
			tools.load("META-INF/unprotectedurls.xml");
			tools.getUnprotectedResources();
			// System.out.println(unProtectedRes.toString());
//			for(String str : unProtectedResJsp){
//				System.out.println(str);
//			}
		}catch(Exception e){
			e.printStackTrace();
		}

	}

}
