package com.droneSystem.servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.me.JSONArray;
import org.json.me.JSONException;
import org.json.me.JSONObject;

import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.Department;
import com.droneSystem.hibernate.Highway;
import com.droneSystem.manager.DepartmentManager;
import com.droneSystem.manager.DroneManager;
import com.droneSystem.manager.HighwayManager;
import com.droneSystem.util.KeyValueWithOperator;

public class HighwayServlet extends HttpServlet {
	private static final Log log = LogFactory.getLog(HighwayServlet.class);
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Integer method = Integer.parseInt(req.getParameter("method"));	//判断请求的方法类型
		HighwayManager hMgr = new HighwayManager();
		switch (method) {
		case 0:	//查询所有告诉公路
			JSONObject retJSON9 = new JSONObject();
			int totalSize9 = 0;
			try {
				JSONArray jsonArray = new JSONArray();
				int page = 0;	//当前页面
				if (req.getParameter("page") != null)
					page = Integer.parseInt(req.getParameter("page").toString());
				int rows = 10;	//页面大小
				if (req.getParameter("rows") != null)
					rows = Integer.parseInt(req.getParameter("rows").toString());
				
					List<KeyValueWithOperator> condList = new ArrayList<KeyValueWithOperator>();
					condList.add(new KeyValueWithOperator("status",0, "="));//选择正常状态的高速公路
					totalSize9 = hMgr.getTotalCount(condList);
					List<Highway> retList = hMgr.findPagedAllBySort(page, rows, "code", true, condList);
					if(retList != null && retList.size() > 0){
						for(Highway highway : retList){
							if(highway.getStatus()==0){
								JSONObject jsonObj = new JSONObject();
								jsonObj.put("Id", highway.getId());
								jsonObj.put("Code", highway.getCode());
								jsonObj.put("Name", highway.getName());
								jsonObj.put("StartPointLongitude", highway.getStartPoint().getLongitude());
								jsonObj.put("StartPointLatitude", highway.getStartPoint().getLatitude());
								jsonObj.put("EndPointLongitude", highway.getEndPoint().getLongitude());
								jsonObj.put("EndPointLatitude", highway.getEndPoint().getLatitude());
								jsonObj.put("Length", highway.getLength());
								jsonObj.put("LaneNum", highway.getLaneNum());
								jsonObj.put("DesignSpeed", highway.getDesignSpeed());
								jsonObj.put("MaxLonGrade", highway.getMaxLonGrade());
								
								jsonObj.put("Status", highway.getStatus());
								
								jsonArray.put(jsonObj);	
							}
						}
					}
				
				retJSON9.put("total", totalSize9);
				retJSON9.put("rows", jsonArray);
			} catch (Exception e) {
				
				try {
					retJSON9.put("total", 0);
					retJSON9.put("rows", new JSONArray());
				} catch (JSONException e1) {
				}
				if(e.getClass() == java.lang.Exception.class){	//自定义的消息
					log.debug("exception in HighwayServlet-->case 0", e);
				}else{
					log.error("error in HighwayServlet-->case 0", e);
				}
			}finally{
				resp.setContentType("text/json;charset=utf-8");
				resp.getWriter().write(retJSON9.toString());
			}
			
			break;
		}
	}

}
