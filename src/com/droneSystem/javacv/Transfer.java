package com.droneSystem.javacv;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FFmpegFrameRecorder;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.Java2DFrameConverter;

import com.droneSystem.hibernate.Highway;
import com.droneSystem.manager.HighwayManager;
import com.droneSystem.util.HttpUtil;

public class Transfer {
	
	public static String videoFramesPath = "D:/test1";
	public void frameRecord(String inputFile, String outputFile, int audioChannel)  
            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception {  
          
            boolean isStart=true;//该变量建议设置为全局控制变量，用于控制录制结束 
     try{
        // 获取视频源  
        FFmpegFrameGrabber grabber = new FFmpegFrameGrabber(inputFile);  
        // 流媒体输出地址，分辨率（长，高），是否录制音频（0:不录制/1:录制）  
        FFmpegFrameRecorder recorder = new FFmpegFrameRecorder(outputFile, 1280, 720, audioChannel);  
        // 开始取视频源  
        recordByFrame(grabber, recorder, isStart);  
     }catch(Exception e){
    	 e.printStackTrace();
     }
     
    }
 
 public void recordByFrame(FFmpegFrameGrabber grabber, FFmpegFrameRecorder recorder, Boolean status)  
            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception {  
        try {//建议在线程中使用该方法  
            grabber.start();  
            recorder.start();  
            Frame frame = null;  
            int flag = 0;
            while (status&& (frame = grabber.grabFrame()) != null) {  
                recorder.record(frame);  
                String fileName = videoFramesPath + "/img_" + String.valueOf(flag) + ".jpg";
                File outPut = new File(fileName); 
                frame = grabber.grabImage();  
                ImageIO.write(FrameToBufferedImage(frame), "jpg", outPut);
                HttpUtil hUtil = new HttpUtil();
				String sandVolume = hUtil .doPost("http://127.0.0.1:4050", "{\"UAVID\":\"1\", " + fileName+ "}");
                HighwayManager HMgr = new HighwayManager();
                Highway h = HMgr.findById(4);
                h.setLength(Double.parseDouble(sandVolume));
                flag++; 
            }  
            recorder.stop(); 	
            grabber.stop();  
        } finally {  
            if (grabber != null) {  
                grabber.stop();  
            }  
        }  
    }  
 
 public BufferedImage FrameToBufferedImage(Frame frame) {  
        //创建BufferedImage对象  
        Java2DFrameConverter converter = new Java2DFrameConverter();  
        BufferedImage bufferedImage = converter.getBufferedImage(frame);  
        return bufferedImage;  
    } 
}
