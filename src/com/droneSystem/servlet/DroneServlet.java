package com.droneSystem.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FFmpegFrameRecorder;
import org.json.me.JSONArray;
import org.json.me.JSONException;
import org.json.me.JSONObject;

import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.Department;
import com.droneSystem.hibernate.Highway;
import com.droneSystem.hibernate.SandVolume;
import com.droneSystem.hibernate.SandVolumeDAO;
import com.droneSystem.hibernate.SnowVolume;
import com.droneSystem.hibernate.SnowVolumeDAO;
import com.droneSystem.hibernate.Task;
import com.droneSystem.hibernate.TaskDAO;
import com.droneSystem.hibernate.TrafficFlow;
import com.droneSystem.hibernate.TrafficFlowDAO;
import com.droneSystem.hibernate.Video;
import com.droneSystem.hibernate.VideoDAO;
import com.droneSystem.javacv.Transfer;
import com.droneSystem.javacv.framerecorder;
import com.droneSystem.manager.DepartmentManager;
import com.droneSystem.manager.DroneManager;
import com.droneSystem.manager.HighwayManager;
import com.droneSystem.manager.SandVolumeManager;
import com.droneSystem.manager.SnowVolumeManager;
import com.droneSystem.manager.TaskManager;
import com.droneSystem.manager.TrafficFlowManager;
import com.droneSystem.manager.VideoManager;
import com.droneSystem.util.HttpUtil;
import com.droneSystem.util.KeyValueWithOperator;

public class DroneServlet extends HttpServlet {
	private static final Log log = LogFactory.getLog(DroneServlet.class);
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Integer method = Integer.parseInt(req.getParameter("method"));	//判断请求的方法类型
		HttpUtil hUtil = new HttpUtil();
		DroneManager  droneMgr = new DroneManager();
		VideoManager vMgr = new VideoManager();
		SnowVolumeManager snowVMgr = new SnowVolumeManager();
		SandVolumeManager sandVMgr = new SandVolumeManager();
		TrafficFlowManager TFMgr = new TrafficFlowManager();
		switch (method) {
		case 0: //查询所有正在执行任务的无人机
			JSONObject res = new JSONObject();
			try {
				
				int droneNum = 0;
				List<Drone> result =  droneMgr.findAllDrone();
				JSONArray options = new JSONArray();
				for(Drone drone : result){
					JSONObject option = new JSONObject();
					option.put("droneId", drone.getId());
					option.put("code", drone.getCode());
					option.put("longitude", drone.getLongitude());
					option.put("latitude", drone.getLatitude());
					option.put("videoUrl", drone.getVideoUrl());
					droneNum++;
					options.put(option);
				}
				res.put("total", droneNum);
				res.put("drones", options);
				} catch (Exception e) {
					try {
						res.put("total", 0);
						res.put("drones", new JSONArray());
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 0", e);
					}else{
						log.error("error in DroneServlet-->case 0", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res.toString());
					//System.out.println(res.toString());
				}
			break;
			
		case 1: //根据高速公路查询所有正在执行任务的无人机
			JSONObject res1 = new JSONObject();
			try {
				String highwayId = req.getParameter("Id");
				HighwayManager highwayMgr = new HighwayManager();
				TaskManager  taskMgr = new TaskManager();
				TaskDAO taskDao = new TaskDAO();
				Highway highway = highwayMgr.findById(Integer.parseInt(highwayId));
				List<Task> result =  taskDao.findByHighway(highway);
				JSONArray options = new JSONArray();
				for(Task task : result){
					JSONObject option = new JSONObject();
					Drone drone = task.getDrone();
					option.put("droneId", drone.getId());
					option.put("code", drone.getCode());
					option.put("longitude", drone.getLongitude());
					option.put("latitude", drone.getLatitude());
					option.put("videoUrl", drone.getVideoUrl());
					options.put(option);
				}
				res1.put("drones", options);
				} catch (Exception e) {
					try {
						res1.put("total", 0);
						res1.put("drones", new JSONArray());
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 1", e);
					}else{
						log.error("error in DroneServlet-->case 1", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res1.toString());
					//System.out.println(res.toString());
				}
			break;
		case 2: //无人机实时更新接口
			JSONObject res2 = new JSONObject();
			try {
				int droneId = Integer.parseInt(req.getParameter("id"));
				double longitude = Double.parseDouble(req.getParameter("longitude"));
				double latitude = Double.parseDouble(req.getParameter("latitude"));
				double height = Double.parseDouble(req.getParameter("height"));
				String videoUrl = req.getParameter("videoUrl");
				
				Drone drone = droneMgr.findById(droneId);
				drone.setHeight(height);
				drone.setLongitude(longitude);
				drone.setLatitude(latitude);
				drone.setVideoUrl(videoUrl);
				droneMgr.update(drone);
				
				res2.put("isOK", true);
				} catch (Exception e) {
					try {
						res2.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 2", e);
					}else{
						log.error("error in DroneServlet-->case 2", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res2.toString());
					//System.out.println(res.toString());
				}
			break;
			
		case 3: //测试方法  读取视频流，保存视频文件，并将视频名称存入数据库
			JSONObject res3 = new JSONObject();
			try {
//				int droneId = Integer.parseInt(req.getParameter("id"));
				int droneId = 1;

				String type = req.getParameter("type");
				String inputFile = req.getParameter("inputStream");
				Drone drone = droneMgr.findById(droneId);
				Video v = new Video();
//				String inputFile = "rtsp://localhost:8554/123"; 
				Date date = new Date();
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				Timestamp time = new Timestamp(System.currentTimeMillis());
				String outputFileName = simpleDateFormat.format(date);
		        String outputFile = outputFileName + ".mp4"; 
		        int ReqType = Integer.parseInt(type);
		        
		        v.setCode(outputFileName);
		        v.setDrone(drone);
		        v.setStatus(0);
		        v.setTime(time);
		        v.setVideo(outputFile);
		        vMgr.save(v);
		        
		        framerecorder f = new framerecorder();
		        if(ReqType == 1){
					SnowVolume snowv = new SnowVolume();
					snowv.setDrone(drone);
					snowv.setVideo(v);
					snowv.setTime(time);
					snowv.setSnowVolume(0.0);
					snowVMgr.save(snowv);
					int id = snowv.getId();
//					inputFile = "D://test//XZ.mp4";
			        f.frameRecord(inputFile, outputFile,1,ReqType,id);
				}if(ReqType == 2){		
					SandVolume sandv = new SandVolume();
					sandv.setDrone(drone);
					sandv.setVideo(v);
					sandv.setTime(time);
					sandv.setSandVolume(0.0);
					sandVMgr.save(sandv);
					int id = sandv.getId();
//					inputFile = "D://test//SZ.mp4";
			        f.frameRecord(inputFile, outputFile,1,ReqType,id);
				}if(ReqType == 3){
					TrafficFlow tf = new TrafficFlow();
					tf.setDrone(drone);
					tf.setVideo(v);
					tf.setTime(time);
					tf.setVolume(0.0);
					TFMgr.save(tf);
					int id = tf.getId();
//					inputFile = "D://test//LL.mp4";
			        f.frameRecord(inputFile, outputFile,1,ReqType,id);
				}
				

				res3.put("isOK", true);
				} catch (Exception e) {
					try {
						res3.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 3", e);
					}else{
						log.error("error in DroneServlet-->case 3", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res3.toString());
					//System.out.println(res.toString());
				}
			break;
		case 4: //测试方法
			JSONObject res4 = new JSONObject();
			try {
				String ts = req.getParameter("type");
				int t = Integer.parseInt(ts);
				HighwayManager hMgr = new HighwayManager();
				Highway h = hMgr.findById(4);
				Double Scale = h.getLength();
				Double ttt= 0.0;
				if(t%3==0){
					ttt = 0.643;
				}if(t%3==1){
					ttt = 0.012;
				}if(t%3==2){
					ttt = 0.141;
				}
				res4.put("isOK", true);
				res4.put("ts", ttt);
				} catch (Exception e) {
					try {
						res4.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 4", e);
					}else{
						log.error("error in DroneServlet-->case 4", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res4.toString());
					//System.out.println(res.toString());
				}
			break;
		case 5: //测试方法
			JSONObject res5 = new JSONObject();
			try {
				String type = req.getParameter("type");
				String test = "";
				if(type.equals("1")){
					test = hUtil.doPost("http://127.0.0.1:4050", "{\"UAVID\":\"1\", \"ImgSrc\":\"C:/test2-2.jpg\", \"ReqType\":\"1\"}");

				}if(type.equals("2")){
					test = hUtil.doPost("http://127.0.0.1:4050", "{\"UAVID\":\"1\", \"ImgSrc\":\"C:/SZtest_2.jpg\", \"ReqType\":\"2\"}");

				}if(type.equals("3")){
					test = hUtil.doPost("http://127.0.0.1:4050", "{\"UAVID\":\"1\", \"ImgSrc\":\"C:/LLtest_2.png\", \"ReqType\":\"3\"}");

				}
				res5.put("isOK", true);
				res5.put("ts", test);
				} catch (Exception e) {
					try {
						res5.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 6", e);
					}else{
						log.error("error in DroneServlet-->case 6", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res5.toString());
					//System.out.println(res.toString());
				}
			break;
		case 6: //测试方法
			JSONObject res6 = new JSONObject();
			try {
				String videoId = req.getParameter("videoId");
				String type = req.getParameter("type");
				Video video = vMgr.findById(Integer.parseInt(videoId));
				int reqType = Integer.parseInt(type);
				
				Double ts = 0.0;
				Timestamp time = new Timestamp(System.currentTimeMillis());
				if(reqType == 1){
					SnowVolumeDAO snowVDao = new SnowVolumeDAO();
					SnowVolume snowv = (SnowVolume) snowVDao.findByVideo(video).get(0);
					ts = snowv.getSnowVolume();
					time = snowv.getTime();	
				}if(reqType == 2){
					SandVolumeDAO sandVDao = new SandVolumeDAO();
					SandVolume sandv = (SandVolume) sandVDao.findByVideo(video).get(0);
					ts = sandv.getSandVolume();
					time = sandv.getTime();
				}if(reqType == 3){
					TrafficFlowDAO TFVDao = new TrafficFlowDAO();
					TrafficFlow tf = (TrafficFlow) TFVDao.findByVideo(video).get(0);
					ts = tf.getVolume();
					time = tf.getTime();
				}
					
					
				res6.put("isOK", true);
				res6.put("ts", ts);
				res6.put("time", time);
				} catch (Exception e) {
					try {
						res6.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //自定义的消息
						log.debug("exception in DroneServlet-->case 6", e);
					}else{
						log.error("error in DroneServlet-->case 6", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res6.toString());
					//System.out.println(res.toString());
				}
			break;
		}
	}

}
