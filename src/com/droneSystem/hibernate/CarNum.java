package com.droneSystem.hibernate;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class CarNum implements java.io.Serializable {

	// Fields

	private Integer id;
	private TrafficFlow trafficFlow;
	private Integer carNum;
	private Timestamp time;
	private Video video;
	// Constructors

	/** default constructor */
	public CarNum() {
	}
	
	/** minimal constructor */
	public CarNum(TrafficFlow trafficFlow, Integer carNum, Timestamp time, Video video) {
		this.trafficFlow = trafficFlow;
		this.carNum = carNum;
		this.time = time;
		this.video = video;
	}
	

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public TrafficFlow getTrafficFlow() {
		return this.trafficFlow;
	}

	public void setTrafficFlow(TrafficFlow trafficFlow) {
		this.trafficFlow = trafficFlow;
	}
	
	public Video getVideo() {
		return this.video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}
	
	public Integer getCarNum() {
		return this.carNum;
	}

	public void setCarNum(Integer carNum) {
		this.carNum = carNum;
	}

	public Timestamp getTime() {
		return this.time;
	}
	
	public void setTime(Timestamp time) {
		this.time = time;
	}

}