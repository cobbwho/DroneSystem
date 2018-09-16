package com.droneSystem.servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.me.JSONArray;
import org.json.me.JSONException;
import org.json.me.JSONObject;

import com.droneSystem.hibernate.Highway;
import com.droneSystem.hibernate.HighwayDAO;
import com.droneSystem.hibernate.TrafficFlow;

public class TrafficServlet extends HttpServlet {
	private static final Log log = LogFactory.getLog(TrafficServlet.class);
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Integer method = Integer.parseInt(req.getParameter("method"));	//判断请求的方法类型
		switch (method) {
		case 0: //地图流量查询
			JSONObject res = new JSONObject();
			try {
				String HighwayName = req.getParameter("queryname");
				
				int type = Integer.parseInt(req.getParameter("type"));
				if(type == 1){
					
				}
						
				
				String queryStr = "from SysUser as model,ProjectTeam as pro where 1=1 and model.projectTeamId = pro.id ";
				List<Object> list = new ArrayList<Object>();
				if(HighwayName != null&&!HighwayName.equals(""))
				{
					String userNameStr = URLDecoder.decode(HighwayName, "UTF-8");
					
					list.add("%" + userNameStr + "%");
					list.add("%" + userNameStr + "%");
					queryStr = queryStr + "and (model.brief like ? or model.name like ?) ";
				}
			
				JSONArray option = new JSONArray();
					
					res.put("rows", option);
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
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res.toString());
					//System.out.println(res.toString());
				}
			break;
		}
	}

}
