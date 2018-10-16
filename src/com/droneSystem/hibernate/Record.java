package com.droneSystem.hibernate;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class Record implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer type;
	private Drone drone;
	private Double valueLeft;
	private Double valueRight;
	private Timestamp time;
	private Video video;

	// Constructors

	/** default constructor */
	public Record() {
	}
	
	/** minimal constructor */
	public Record(Integer type, Drone drone, Video video, Timestamp time, Double valueLeft, Double valueRight) {
		this.type = type;
		this.drone = drone;
		this.video = video;
		this.time = time;
		this.valueLeft = valueLeft;
		this.valueRight = valueRight;
	}
	

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	public Drone getDrone() {
		return this.drone;
	}

	public void setDrone(Drone drone) {
		this.drone = drone;
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

	public Double getValueLeft() {
		return this.valueLeft;
	}

	public void setValueLeft(Double valueLeft) {
		this.valueLeft = valueLeft;
	}
	
	public Double getValueRight() {
		return this.valueRight;
	}

	public void setValueRight(Double valueRight) {
		this.valueRight = valueRight;
	}
	
}