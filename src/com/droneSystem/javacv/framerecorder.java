package com.droneSystem.javacv;

import java.awt.image.BufferedImage;
import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;



import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FFmpegFrameRecorder;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.Java2DFrameConverter;
import org.json.me.JSONObject;

import com.droneSystem.util.HttpUtil;

import com.droneSystem.hibernate.CarNum;
import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.Highway;
import com.droneSystem.hibernate.Record;
import com.droneSystem.hibernate.SandVolume;
import com.droneSystem.hibernate.SnowVolume;
import com.droneSystem.hibernate.TrafficFlow;
import com.droneSystem.hibernate.Video;
import com.droneSystem.manager.CarNumManager;
import com.droneSystem.manager.HighwayManager;
import com.droneSystem.manager.RecordManager;
import com.droneSystem.manager.SandVolumeManager;
import com.droneSystem.manager.SnowVolumeManager;
import com.droneSystem.manager.TrafficFlowManager;
//��ȡ����ַ���ұ�����Ƶ֡���ͳ�ȥ������¼����Ƶ֡���汾��
public class framerecorder {
	public static String videoFramesPath = "D:/test1"; 

	 public static void frameRecord(String inputFile, String outputFile, int audioChannel, int type, int id, Drone drone, Video video)  
	            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception {  
	          
	            boolean isStart=true;//�ñ�����������Ϊȫ�ֿ��Ʊ��������ڿ���¼�ƽ��� 
	     try{
	        // ��ȡ��ƵԴ  
	        FFmpegFrameGrabber grabber = new FFmpegFrameGrabber(inputFile);  
	        // ��ý�������ַ���ֱ��ʣ������ߣ����Ƿ�¼����Ƶ��0:��¼��/1:¼�ƣ�  
	        FFmpegFrameRecorder recorder = new FFmpegFrameRecorder(outputFile, 1920, 1080, audioChannel);  
	        // ��ʼȡ��ƵԴ 

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
	        try {//�������߳���ʹ�ø÷���  
	            grabber.start();  
	            recorder.start();  
	            Frame frame = null;  
	            int flag = 0;
	            
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
	                Record record = new Record();
	                record.setDrone(drone);
	                record.setType(reqType);
	                record.setTime(time);
	                record.setVideo(video);
	                
	                if(flag%20 == 1){
						//String Volume = hUtil .doPost("http://127.0.0.1:4050", "{\"UAVID\":\"1\", \"ImgSrc\":\""+fileName+"\", \"ReqType\":\"" + reqType +"\"}");
						//JSONObject resp = new JSONObject(Volume); 
						if(reqType == 1){
			            	snowv.setSnowVolume(Double.parseDouble("7"));
			            	snowv.setTime(time);
			            	snowVMgr.update(snowv);
			            	record.setValue(Double.parseDouble("7"));
			            	
			            }
			            if(reqType == 2){
			            	sandv.setSandVolume(Double.parseDouble("7"));
			            	sandv.setTime(time);
			            	sandVMgr.update(sandv);
			            	record.setValue(Double.parseDouble("7"));
			            }
			            if(reqType == 3){
//			            	tf.setVolume(Double.parseDouble("7"));
			            	tf.setVolume(1.1);
			            	tf.setTime(time);
			            	TFMgr.update(tf);
//			            	record.setValue(Double.parseDouble("7"));
			            	record.setValue(1.1);
			            	CarNum carNum = new CarNum();
			            	carNum.setTrafficFlow(tf);
			            	carNum.setTime(time);
//			            	carNum.setCarNum(Integer.parseInt("7"));
			            	carNum.setCarNum(10);
			            }
	                }
	                flag++; 
	                reMgr.save(record);
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
	        //����BufferedImage����  
	        Java2DFrameConverter converter = new Java2DFrameConverter();  
	        BufferedImage bufferedImage = converter.getBufferedImage(frame);  
	        return bufferedImage;  
	    }  
	
}
