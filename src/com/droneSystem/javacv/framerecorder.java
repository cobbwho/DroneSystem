package com.droneSystem.javacv;

import java.awt.image.BufferedImage;
import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;



import org.bytedeco.javacpp.avcodec;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FFmpegFrameRecorder;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.Java2DFrameConverter;
import org.json.me.JSONObject;

import com.droneSystem.util.HttpUtil;

import com.droneSystem.hibernate.CarNum;
import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.Record;
import com.droneSystem.hibernate.SandVolume;
import com.droneSystem.hibernate.SnowVolume;
import com.droneSystem.hibernate.TrafficFlow;
import com.droneSystem.hibernate.Video;
import com.droneSystem.manager.CarNumManager;
import com.droneSystem.manager.RecordManager;
import com.droneSystem.manager.SandVolumeManager;
import com.droneSystem.manager.SnowVolumeManager;
import com.droneSystem.manager.TrafficFlowManager;
//获取流地址并且保存视频帧发送出去，并且录制视频帧保存本地
public class framerecorder {
	public static String videoFramesPath = "D:/test1"; 

	 public static void frameRecord(String inputFile, String outputFile, int audioChannel, int type, int id, Drone drone, Video video)  
	            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception {  
	          
	            boolean isStart=true;//该变量建议设置为全局控制变量，用于控制录制结束 
	     try{
	        // 获取视频源 
	        FFmpegFrameGrabber grabber = new FFmpegFrameGrabber(inputFile);  
	        grabber.setOption("rtsp_transport","http");
	        // 流媒体输出地址，分辨率（长，高），是否录制音频（0:不录制/1:录制）  
	        FFmpegFrameRecorder recorder = new FFmpegFrameRecorder(outputFile, 1920, 1080, audioChannel); 
	        recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264); // avcodec.AV_CODEC_ID_H264，编码
	        recorder.setInterleaved(true);
	        recorder.setFrameRate(25);
	        // 开始取视频源 

	        recordByFrame(grabber, recorder, isStart,type, id, drone, video);  
	     }catch(Exception e){
	    	 e.printStackTrace();
	     }
	     
	    }
	 
	 public static void recordByFrame(FFmpegFrameGrabber grabber, FFmpegFrameRecorder recorder, Boolean status, int reqType, int id, Drone drone, Video video)  
	            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception { 
			SnowVolumeManager snowVMgr = new SnowVolumeManager();
			SandVolumeManager sandVMgr = new SandVolumeManager();
			TrafficFlowManager TFMgr = new TrafficFlowManager();
			
			RecordManager reMgr = new RecordManager();
			CarNumManager carMgr = new CarNumManager();
			SnowVolume snowv = new SnowVolume();
			SandVolume sandv = new SandVolume();
			double latitude = drone.getLatitude();
			double longitude = drone.getLongitude();
			TrafficFlow tf = new TrafficFlow();
			if(reqType == 1){
            	snowv = snowVMgr.findById(id);
            }
            if(reqType == 2){
            	sandv = sandVMgr.findById(id);
            }
            if(reqType == 3){
            	tf = TFMgr.findById(id);
            }
	        try {//建议在线程中使用该方法  
	            grabber.start();  
	            recorder.start();  
	            Frame frame = null;  
	            int flag = 0;
	            int num = 0;
	            while (status&& (frame = grabber.grabFrame()) != null) {  
	                recorder.record(frame);  
	                String fileName = videoFramesPath + "/img_" + String.valueOf(flag) + ".jpg";
	                File outPut = new File(fileName); 
	                frame = grabber.grabImage();  
	                if(frame!=null){
	                	ImageIO.write(FrameToBufferedImage(frame), "jpg", outPut);
	                }else{
	                	break;
	                }
	                HttpUtil hUtil = new HttpUtil();
	                Timestamp time = new Timestamp(System.currentTimeMillis());
	                System.out.println(time);
	                
	                if(flag%20 == 1){
	                	Record record = new Record();
		                record.setDrone(drone);
		                record.setType(reqType);
		                record.setTime(time);
		                record.setVideo(video);
//						String Volume = hUtil .doPost("http://127.0.0.1:4050", "{\"UAVID\":\"1\", \"ImgSrc\":\""+fileName+"\",\"Lat\":\""+latitude+"\",\"Lon\":\""+longitude+"\", \"ReqType\":\"" + reqType +"\"}");
//						JSONObject resp = new JSONObject(Volume); 
//						if(reqType == 1){
//			            	snowv.setSnowVolume(Double.parseDouble(resp.getString("Value")));
//			            	snowv.setTime(time);
//			            	snowVMgr.update(snowv);
//			            	record.setValue(Double.parseDouble(resp.getString("Value")));
//			            	
//			            }
//			            if(reqType == 2){
//			            	sandv.setSandVolume(Double.parseDouble(resp.getString("Value")));
//			            	sandv.setTime(time);
//			            	sandVMgr.update(sandv);
//			            	record.setValue(Double.parseDouble(resp.getString("Value")));
//			            }
			            if(reqType == 3){
//			            	tf.setVolumeLeft(Double.parseDouble(resp.getString("ValueLeft")));
//			            	tf.setVolumeRight(Double.parseDouble(resp.getString("ValueRight")));
			            	tf.setVolumeLeft(1.1);
			            	tf.setVolumeRight(1.1);
			            	tf.setTime(time);
			            	TFMgr.update(tf);
//			            	record.setValueLeft(Double.parseDouble(resp.getString("ValueLeft"))); 
//			            	record.setValueRight(Double.parseDouble(resp.getString("ValueRight"))); 
			            	record.setValueLeft(1.1);
			            	record.setValueRight(1.1);
			            	reMgr.save(record);
			            	CarNum carNum = new CarNum();
			            	carNum.setTrafficFlow(tf);
			            	carNum.setTime(time);
			            	carNum.setVideo(video);
//			            	carNum.setCarNumLeft(Integer.parseInt(resp.getString("TrackLeft")));
//			            	carNum.setCarNumRight(Integer.parseInt(resp.getString("TrackRight")));
			            	carNum.setCarNumLeft(num);
			            	carNum.setCarNumRight(num);
			            	carMgr.save(carNum);
			            	
			            }
	                }
	                flag++; 
	                num++;
	                
	            }  
	            recorder.stop();  
	            grabber.stop();  
	        } finally {  
	            if (grabber != null) {  
	                grabber.stop();  
	            }  
	        }  
	    }   

	 public static BufferedImage FrameToBufferedImage(Frame frame) {  
	        //创建BufferedImage对象  
	        Java2DFrameConverter converter = new Java2DFrameConverter();  
	        BufferedImage bufferedImage = converter.getBufferedImage(frame);  
	        return bufferedImage;  
	    }  

	 
}
