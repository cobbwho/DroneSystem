package com.droneSystem.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.droneSystem.hibernate.CarNumDAO;
import com.droneSystem.hibernate.Drone;
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
import com.droneSystem.javacv.framerecorder;
import com.droneSystem.manager.CarNumManager;
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
		Integer method = Integer.parseInt(req.getParameter("method"));	//�ж�����ķ�������
		HttpUtil hUtil = new HttpUtil();
		DroneManager  droneMgr = new DroneManager();
		VideoManager vMgr = new VideoManager();
		SnowVolumeManager snowVMgr = new SnowVolumeManager();
		SandVolumeManager sandVMgr = new SandVolumeManager();
		TrafficFlowManager TFMgr = new TrafficFlowManager();
		CarNumManager carNumMgr = new CarNumManager();
		switch (method) {
		case 0: //��ѯ��������ִ����������˻�
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
					option.put("status", drone.getStatus());
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
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
			
		case 1: //���ݸ��ٹ�·��ѯ��������ִ����������˻�
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
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
		case 11: //�½����˻�
			System.out.println(new Timestamp(System.currentTimeMillis()) + " : ���յ��½����˻�����");
			JSONObject res11 = new JSONObject();
			try {
				InputStream is= null;
				is = req.getInputStream();
				String bodyInfo = IOUtils.toString(is, "utf-8");
				System.out.println(bodyInfo);
				JSONObject orderSheetJson = new JSONObject(bodyInfo).getJSONObject("Drone");
				String Code = orderSheetJson.getString("code");
				String Manufacturer = orderSheetJson.getString("manufacturer");
				String Model = orderSheetJson.getString("model");
				String Weight = orderSheetJson.getString("weight");
				String Longitude = orderSheetJson.getString("longitude");
				String Latitude = orderSheetJson.getString("latitude");
				String videoUrl = orderSheetJson.getString("videoUrl");
				
				double weight = Double.parseDouble(Weight);
				double longitude = Double.parseDouble(Longitude);
				double latitude = Double.parseDouble(Latitude);
				List<Drone> droneList = droneMgr.findByCode(Code);
				if(droneList.size() != 0){
					res11.put("isOK", true);
					res11.put("msg", "�������Ϊ��" + Code + "�����˻�������ӹ���");
					res11.put("droneId", droneList.get(0).getId());
					break;
				}
				Drone drone = new Drone();
				drone.setCode(Code);
				drone.setManufacturer(Manufacturer);
				drone.setModel(Model);
				drone.setWeight(weight);
				drone.setIsTask(1);
				drone.setLongitude(longitude);
				drone.setLatitude(latitude);
				drone.setVideoUrl(videoUrl);
				drone.setStatus(1);
				drone.setClicked(false);
				droneMgr.save(drone);
				
				res11.put("isOK", true);
				res11.put("droneId", drone.getId());
				System.out.println("�½����˻��ɹ���");
				} catch (Exception e) {
					try {
						res11.put("isOK", false);
						res11.put("msg", String.format("����ʧ�ܣ�������Ϣ��%s", (e!=null && e.getMessage()!=null)?e.getMessage():"��"));
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
						log.debug("exception in DroneServlet-->case 2", e);
					}else{
						log.error("error in DroneServlet-->case 2", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res11.toString());
					//System.out.println(res.toString());
				}
			break;
		case 2: //���˻�ʵʱ���½ӿ�
			System.out.println(new Timestamp(System.currentTimeMillis()) + " : ���յ��������˻�����");
			JSONObject res2 = new JSONObject();
			try {
				InputStream is= null;
				is = req.getInputStream();
				String bodyInfo = IOUtils.toString(is, "utf-8");
				System.out.println(bodyInfo);
				JSONObject orderSheetJson = new JSONObject(bodyInfo).getJSONObject("Drone");
				String DroneId  = orderSheetJson.getString("droneId");	//���˻�ID
				String Longitude = orderSheetJson.getString("longitude");
				String Latitude = orderSheetJson.getString("latitude");
				String Height = orderSheetJson.getString("height");
				String Angle = orderSheetJson.getString("angle");
				String IsTask = orderSheetJson.getString("isTask");
				String Speed = orderSheetJson.getString("speed");
				String videoUrl = orderSheetJson.getString("videoUrl");
						
				int droneId = Integer.parseInt(DroneId);
				double longitude = Double.parseDouble(Longitude);
				double latitude = Double.parseDouble(Latitude);
				double height = Double.parseDouble(Height);
				double angle = Double.parseDouble(Angle);
				double speed = Double.parseDouble(Speed);
				int isTask = Integer.parseInt(IsTask);
				
				Drone drone = droneMgr.findById(droneId);
				drone.setAngle(angle);
				drone.setHeight(height);
				drone.setLongitude(longitude);
				drone.setLatitude(latitude);
				drone.setVideoUrl(videoUrl);
				drone.setIsTask(isTask);
				drone.setSpeed(speed);
				droneMgr.update(drone);
				
				res2.put("isOK", true);
				System.out.println("�������˻��ɹ���");
				} catch (Exception e) {
					try {
						res2.put("isOK", false);
						res2.put("msg", String.format("����ʧ�ܣ�������Ϣ��%s", (e!=null && e.getMessage()!=null)?e.getMessage():"��"));
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
		
		case 3: //���Է���  ��ȡ��Ƶ����������Ƶ�ļ���������Ƶ���ƴ������ݿ�
			JSONObject res3 = new JSONObject();
			try {
				int droneId = Integer.parseInt(req.getParameter("droneId"));
				String type = req.getParameter("type");
				String inputFile = req.getParameter("inputStream");
				Drone drone = droneMgr.findById(droneId);
				if(drone.getClicked()==true){
					break;
				}
				drone.setClicked(true);

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
		        v.setType(ReqType);
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
			        f.frameRecord(inputFile, outputFile,1,ReqType,id, drone, v);
				}if(ReqType == 2){		
					SandVolume sandv = new SandVolume();
					sandv.setDrone(drone);
					sandv.setVideo(v);
					sandv.setTime(time);
					sandv.setSandVolume(0.0);
					sandVMgr.save(sandv);
					int id = sandv.getId();
//					inputFile = "D://test//SZ.mp4";
			        f.frameRecord(inputFile, outputFile,1,ReqType,id, drone, v);
				}if(ReqType == 3){
					TrafficFlow tf = new TrafficFlow();
					tf.setDrone(drone);
					tf.setVideo(v);
					tf.setTime(time);
					tf.setVolumeLeft(0.0);
					tf.setVolumeRight(0.0);
					TFMgr.save(tf);
					int id = tf.getId();
//					inputFile = "D://test//LL.mp4";
			        f.frameRecord(inputFile, outputFile,1,ReqType,id, drone, v);
				}
				

				res3.put("isOK", true);
				} catch (Exception e) {
					try {
						res3.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
		case 4: //���Է���
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
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
		case 5: //���Է���
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
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
		case 6: //���Է���
			JSONObject res6 = new JSONObject();
			try {
				String droneId = req.getParameter("droneId");
				Drone drone = droneMgr.findById(Integer.parseInt(droneId));
				String type = req.getParameter("type");
				List<Video> videos =  vMgr.findByVarProperty(new KeyValueWithOperator("drone", drone, "="));
				Video video = videos.get(videos.size()-1);
				int reqType = Integer.parseInt(type);
				Double ts = 0.0;
				Double tsLeft = 0.0;
				Double tsRight = 0.0;
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
					tsLeft = tf.getVolumeLeft();
					tsRight = tf.getVolumeRight();
					time = tf.getTime();
				}
					
				if(reqType == 3){
					res6.put("isOK", true);
					res6.put("tsLeft", tsLeft);
					res6.put("tsRight", tsRight);
					res6.put("time", time);
				}else{
					res6.put("isOK", true);
					res6.put("ts", ts);
					res6.put("time", time);
				}
				
				} catch (Exception e) {
					try {
						res6.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
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
		case 7: //���Է���
			JSONObject res7 = new JSONObject();
			try {
				CarNumDAO carNumDao = new CarNumDAO();
				String droneId = req.getParameter("droneId");
				Drone drone = droneMgr.findById(Integer.parseInt(droneId));
				List<Video> videos =  vMgr.findByVarProperty(new KeyValueWithOperator("drone", drone, "="));
				Video video = videos.get(videos.size()-1);
				List<CarNum> carNums = carNumMgr.findByVarProperty(new KeyValueWithOperator("video", video, "="));
				CarNum nowNum = carNums.get(carNums.size()-1);
				List<Object> keys = new ArrayList<Object>();
				keys.add(nowNum.getTime());
				keys.add(video);
				int lastMinNumLeft = 0;
				int lastMinNumRight = 0;
				int carNumLeft = 0;
				int carNumRight = 0;
				List<CarNum> result =carNumDao.findByHQL("select model from CarNum as model where DateDiff(Minute,model.time, ? )=1 and model.video = ? order by model.time ", keys);		
				if(result.size() == 0){
					
				}else{
					CarNum lastMin = result.get(0);
					lastMinNumLeft = lastMin.getCarNumLeft();
					lastMinNumRight = lastMin.getCarNumRight();
				} 
				carNumLeft = nowNum.getCarNumLeft() - lastMinNumLeft;
				carNumRight = nowNum.getCarNumRight() - lastMinNumRight;
					
				Timestamp time = new Timestamp(System.currentTimeMillis());
			
					
				res7.put("isOK", true);
				res7.put("time", time);
				res7.put("carNumLeft", carNumLeft);
				res7.put("carNumRight", carNumRight);
				} catch (Exception e) {
					try {
						res7.put("isOK", false);
					} catch (JSONException ex) {
						ex.printStackTrace();
					}
					if(e.getClass() == java.lang.Exception.class){ //�Զ������Ϣ
						log.debug("exception in DroneServlet-->case 7", e);
					}else{
						log.error("error in DroneServlet-->case 7", e);
					} 

				}finally{
					resp.setContentType("text/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write(res7.toString());
					//System.out.println(res.toString());
				}
			break;
		}
	}

}
