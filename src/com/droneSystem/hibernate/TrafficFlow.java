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
	private Double volumeLeft;
	private Double volumeRight;
	// Constructors

	/** default constructor */
	public TrafficFlow() {
	}

	/** full constructor 
	 **/
	public TrafficFlow(Drone drone,
			Video video, Timestamp time, Double volumeLeft, Double volumeRight) {
		this.drone = drone;
		this.video = video;
		this.time = time;
		this.volumeLeft = volumeLeft;
		this.volumeRight = volumeRight;
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
	
	public Double getVolumeLeft() {
		return this.volumeLeft;
	}

	public void setVolumeLeft(Double volumeLeft) {
		this.volumeLeft = volumeLeft;
	}
	
	public Double getVolumeRight() {
		return this.volumeRight;
	}

	public void setVolumeRight(Double volumeRight) {
		this.volumeRight = volumeRight;
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