package com.droneSystem.hibernate;

import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class Task implements java.io.Serializable {

	// Fields

	private Integer id;
	private String code;
	private Highway highway;
	private Drone drone;
	private String description;
	private int status;
	

	// Constructors

	/** default constructor */
	public Task() {
	}


	/** minimal constructor 
	 **/
	public Task(String code, Highway highway, Drone drone, Integer status) {
		this.code = code;
		this.highway = highway;
		this.drone = drone;
		this.status = status;
	}
	
	/** full constructor */
	public Task(String code, Highway highway, Drone drone, String description,Integer status) {
		this.code = code;
		this.highway = highway;
		this.drone = drone;
		this.description = description;
		this.status = status;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Highway getHighway() {
		return this.highway;
	}

	public void setHighway(Highway highway) {
		this.highway = highway;
	}
	
	public Drone getDrone() {
		return this.drone;
	}

	public void setDrone(Drone drone) {
		this.drone = drone;
	}
	
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}