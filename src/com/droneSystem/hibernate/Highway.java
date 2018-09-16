package com.droneSystem.hibernate;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * SysUser entity. @author MyEclipse Persistence Tools
 */

public class Highway implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String brief;
	private String code;
	private Point startPoint;
	private Point endPoint;
	private Double length;
	private Double width;
	private Integer laneNum;
	private Integer designSpeed;
	private Integer maxLonGrade;
	private Integer rank;
	private Integer status;
	

	// Constructors

	/** default constructor */
	public Highway() {
	}

	/** full constructor 
	 **/
	public Highway(String name, String brief, String code, Point startPoint,
			Point endPoint, Double length, Double width, Integer rank, 
			Integer laneNum, Integer designSpeed, Integer maxLonGrade, Integer status) {
		this.name = name;
		this.brief = brief;
		this.code = code;
		this.startPoint = startPoint;
		this.endPoint = endPoint;
		this.length = length;
		this.width = width;
		this.laneNum = laneNum;
		this.designSpeed = designSpeed;
		this.maxLonGrade = maxLonGrade;
		this.rank = rank;
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

	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}
	
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Point getStartPoint() {
		return this.startPoint;
	}

	public void setStartPoint(Point startPoint) {
		this.startPoint = startPoint;
	}
	
	public Point getEndPoint() {
		return this.endPoint;
	}

	public void setEndPoint(Point endPoint) {
		this.endPoint = endPoint;
	}
	
	public Double getLength() {
		return this.length;
	}

	public void setLength(Double length) {
		this.length = length;
	}

	public Double getWidth() {
		return this.width;
	}

	public void setWidth(Double width) {
		this.width = width;
	}

	public Integer getLaneNum() {
		return this.laneNum;
	}

	public void setLaneNum(Integer laneNum) {
		this.laneNum = laneNum;
	}
	
	public Integer getDesignSpeed() {
		return this.designSpeed;
	}

	public void setDesignSpeed(Integer designSpeed) {
		this.designSpeed = designSpeed;
	}
	
	public Integer getMaxLonGrade() {
		return this.maxLonGrade;
	}

	public void setMaxLonGrade(Integer maxLonGrade) {
		this.maxLonGrade = maxLonGrade;
	}
	
	public Integer getRank() {
		return this.rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}
	
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}


}