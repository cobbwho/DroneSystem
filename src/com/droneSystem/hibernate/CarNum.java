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
	private Integer carNumLeft;
	private Integer carNumRight;
	private Timestamp time;
	private Video video;
	// Constructors

	/** default constructor */
	public CarNum() {
	}
	
	/** minimal constructor */
	public CarNum(TrafficFlow trafficFlow, Integer carNumLeft, Integer carNumRight, Timestamp time, Video video) {
		this.trafficFlow = trafficFlow;
		this.carNumLeft = carNumLeft;
		this.carNumRight = carNumRight;
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
	
	public Integer getCarNumLeft() {
		return this.carNumLeft;
	}

	public void setCarNumLeft(Integer carNumLeft) {
		this.carNumLeft = carNumLeft;
	}
	
	public Integer getCarNumRight() {
		return this.carNumRight;
	}

	public void setCarNumRight(Integer carNumRight) {
		this.carNumRight = carNumRight;
	}

	public Timestamp getTime() {
		return this.time;
	}
	
	public void setTime(Timestamp time) {
		this.time = time;
	}

}