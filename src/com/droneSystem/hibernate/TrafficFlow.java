package com.droneSystem.hibernate;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * SysUser entity. @author MyEclipse Persistence Tools
 */

public class TrafficFlow implements java.io.Serializable {

	// Fields

	private Integer id;
	private Drone drone;
	private Video video;
	private Timestamp time;
	private Double volume;
	
	// Constructors

	/** default constructor */
	public TrafficFlow() {
	}

	/** full constructor 
	 **/
	public TrafficFlow(Drone drone,
			Video video, Timestamp time, Double volume) {
		this.drone = drone;
		this.video = video;
		this.time = time;
		this.volume = volume;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Drone getDrone() {
		return this.drone;
	}

	public void setDrone(Drone drone) {
		this.drone = drone;
	}
	
	public Double getVolume() {
		return this.volume;
	}

	public void setVolume(Double volume) {
		this.volume = volume;
	}
	
	public Video getVideo() {
		return this.video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}
	
	public Timestamp getTime() {
		return this.time;
	}
	
	public void setTime(Timestamp time) {
		this.time = time;
	}



}