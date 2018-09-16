package com.droneSystem.hibernate;

import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class Point implements java.io.Serializable {

	// Fields

	private Integer id;
	private String code;
	private String name;
	private String brief;
	private Highway highway;
	private Double longitude;
	private Double latitude;
	private Integer status;

	// Constructors

	/** default constructor */
	public Point() {
	}

	/** full constructor */
	public Point(String name, String code, String brief, Double longitude, 
			Double latitude, Integer status) {
		this.name = name;
		this.code = code;
		this.brief = brief;
		this.highway = highway;
		this.longitude =longitude;
		this.latitude = latitude;
		this.status = status;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	public Highway getHighway() {
		return this.highway;
	}

	public void setHighway(Highway highway) {
		this.highway = highway;
	}

	public Double getLongitude() {
		return this.longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	
	public Double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}