package com.droneSystem.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.me.JSONArray;
import org.json.me.JSONException;
import org.json.me.JSONObject;

import com.droneSystem.hibernate.CarNum;
import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.Record;
import com.droneSystem.hibernate.Video;
import com.droneSystem.manager.CarNumManager;
import com.droneSystem.manager.DroneManager;
import com.droneSystem.manager.RecordManager;
import com.droneSystem.manager.VideoManager;
import com.droneSystem.util.KeyValueWithOperator;

public class VideoServlet extends HttpServlet {
	private static final Log log = LogFactory.getLog(VideoServlet.class);
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Integer method = Integer.parseInt(req.getParameter("method"));	//判断请求的方法类型
		DroneManager  droneMgr = new DroneManager();
		VideoManager vMgr = new VideoManager();
		CarNumManager cnMgr = new CarNumManager();
		RecordManager rMgr = new RecordManager();
		switch (method) {
		case 0: //分页查询所有的视频
			JSONObject res = new JSONObject();
			try {
				int page = 0;	//当前页面
				if (req.getParameter("page") != null)
					page = Integer.parseInt(req.getParameter("page").toString());
				int rows = 10;	//页面大小
				if (req.getParameter("rows") != null)
					rows = Integer.parseInt(req.getParameter("rows").toString());
					
				String BeginDate = req.getParameter("BeginDate");
				String EndDate = req.getParameter("EndDate");
				
				String droneId = req.getParameter("droneId");
				Drone drone = droneMgr.findById(Integer.parseInt(droneId));
				int VideoNum = 0;
				List<KeyValueWithOperator> keys = new ArrayList<KeyValueWithOperator>();
				if(droneId!= null && droneId.equals("")){
					keys.add(new KeyValueWithOperator("drone", drone, "="));
				}
				if(BeginDate != null && BeginDate.length() > 0){
					keys.add(new KeyValueWithOperator("time", new Timestamp(Date.valueOf(BeginDate).getTime()), ">="));
				}
				if(EndDate != null && EndDate.length() > 0){
					keys.add(new KeyValueWithOperator("time", new Timestamp(Date.valueOf(EndDate).getTime()), "<"));
				}
				
				List<Video> resultList =  vMgr.findPagedAll(page, rows, keys);
				VideoNum = vMgr.getTotalCount(keys);
				JSONArray options = new JSONArray();
				for(Video video : resultList){
					JSONObject option = new JSONObject();
					option.put("id", video.getId());
					option.put("code", video.getCode());
					option.put("video",video.getVideo());
					option.put("time", video.getTime());
					option.put("droneCode", video.getDrone().getCode());
					option.put("type", video.getType());
					options.put(option);
				}
				res.put("total", VideoNum);
				res.put("videos", options);
				} catch (Exception e) {
					try {
						res.put("total", 0);
						res.put("videos", new JSONArray());
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in VideoServlet-->case 0", e);
					}else{
						log.error("error in VideoServlet-->case 0", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res.toString());
					//System.out.println(res.toString());
				}
			break;
		case 1: //导出车流量报表
			JSONObject res1 = new JSONObject();
			try {
				String videoId = req.getParameter("id");
				int vId = Integer.parseInt(videoId);
				Video v = vMgr.findById(vId);
				List<Record> recordList = rMgr.findByVarProperty(new KeyValueWithOperator("video", v, "="));
				
//				List<CarNum> resultList = cnMgr.findByVarProperty(new KeyValueWithOperator("video", v, "="));
//				int listSize = resultList.size();
				int listSize = recordList.size();
				int interval = listSize/100 + 1;
				int reqSize = listSize/interval;
				JSONArray options = new JSONArray();
				for(int i = 0; i < reqSize; i = i + interval){
					JSONObject option = new JSONObject();
//					CarNum cn = resultList.get(i);
//					option.put("carNumLeft", cn.getCarNumLeft());
//					option.put("carNumRight", cn.getCarNumRight());
//					option.put("time", cn.getTime());
					Record r = recordList.get(i);
					option.put("valueLeft", r.getValueLeft());
					option.put("valueRight", r.getValueRight());
					option.put("time", r.getTime());
					options.put(option);
				}
				res1.put("total", reqSize);
				res1.put("carNums", options);
				
				} catch (Exception e) {
					try {
						res1.put("total", 0);
						res1.put("carNum", new JSONArray());
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in VideoServlet-->case 1", e);
					}else{
						log.error("error in VideoServlet-->case 1", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res1.toString());
					//System.out.println(res.toString());
				}
			break;
			

		}
	}

}
