package com.droneSystem.hibernate;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class SnowVolume implements java.io.Serializable {

	// Fields

	private Integer id;
	private Drone drone;
	private Double snowVolume;
	private Video video;
	private Timestamp time;

	// Constructors

	/** default constructor */
	public SnowVolume() {
	}

	/** full constructor */
	public SnowVolume(Drone drone, Double snowVolume, Video video, Timestamp time) {
		this.drone = drone;
		this.snowVolume = snowVolume;
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
	
	public Double getSnowVolume() {
		return this.snowVolume;
	}

	public void setSnowVolume(Double snowVolume) {
		this.snowVolume = snowVolume;
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