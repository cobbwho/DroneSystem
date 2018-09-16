package com.droneSystem.hibernate;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class SandVolume implements java.io.Serializable {

	// Fields

	private Integer id;
	private Drone drone;
	private Double sandVolume;
	private Video video;
	private Timestamp time;

	// Constructors

	/** default constructor */
	public SandVolume() {
	}

	/** full constructor */
	public SandVolume(Drone drone, Double sandVolume, Video video, Timestamp time) {
		this.drone = drone;
		this.sandVolume = sandVolume;
		this.video = video;
		this.time = time;
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
	
	public Double getSandVolume() {
		return this.sandVolume;
	}

	public void setSandVolume(Double sandVolume) {
		this.sandVolume = sandVolume;
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