package com.droneSystem.hibernate;

import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class Drone implements java.io.Serializable {

	// Fields

	private Integer id;
	private String code;
	private String manufacturer;
	private String model;
	private Double weight;
	private Double height;
	private Double longitude;
	private Double latitude;
	private Integer isTask;
	private Integer status;
	private String videoUrl;
	

	// Constructors

	/** default constructor */
	public Drone() {
	}


	/** minimal constructor 
	 **/
	public Drone(String code, Integer status) {
		this.code = code;
		this.status = status;
	}
	
	/** full constructor */
	public Drone(String code, String manufacturer, String model, Double weight, 
			Double height,Double longitude, Double latitude, Integer isTask, String videoUrl, Integer status) {
		this.code = code;
		this.manufacturer = manufacturer;
		this.model = model;
		this.weight = weight;
		this.height = height;
		this.longitude =longitude;
		this.latitude = latitude;
		this.isTask = isTask;
		this.videoUrl = videoUrl;
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
	
	public String getVideoUrl() {
		return this.videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	
	public String getManufacturer() {
		return this.manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getModel() {
		return this.model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Double getHeight() {
		return this.height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}
	
	public Double getWeight() {
		return this.weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
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
	
	public Integer getIsTask() {
		return this.isTask;
	}

	public void setIsTask(Integer isTask) {
		this.isTask = isTask;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}