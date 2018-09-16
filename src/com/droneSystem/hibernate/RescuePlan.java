package com.droneSystem.hibernate;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * SysUser entity. @author MyEclipse Persistence Tools
 */

public class RescuePlan implements java.io.Serializable {

	// Fields

	private Integer id;
	private SnowVolume snowVolume;
	private Timestamp time;
	private Double inorganicSnowMeltingAgent;
	private Double organicSnowMeltingAgent;
	private Double diesel;
	private Double millingWaste;
	private Double gravel;
	private Integer grassMat;
	private Integer shovel;
	private Integer broom;
	private Integer snowChain;
	private Integer grader;
	private Integer iceMeltingCar;
	private Integer scooter;
	private Integer truck;
	private Integer loader;
	private Integer person;
	// Constructors

	/** default constructor */
	public RescuePlan() {
	}

	/** minimal constructor 
	 **/
	public RescuePlan(SnowVolume snowVolume, 
			Timestamp time) {
		this.snowVolume = snowVolume;
		this.time = time;
	}

	/** full constructor 
	 **/
	public RescuePlan(SnowVolume snowVolume, Timestamp time, Double inorganicSnowMeltingAgent, Double organicSnowMeltingAgent,
			Double diesel, Double millingWaste,  Double gravel, Integer grassMat, Integer shovel, Integer broom, Integer snowChain,
			Integer grader, Integer iceMeltingCar, Integer scooter, Integer truck, Integer loader, Integer person
			) {
		this.snowVolume = snowVolume;
		this.time = time;
		this.inorganicSnowMeltingAgent = inorganicSnowMeltingAgent;
		this.organicSnowMeltingAgent = organicSnowMeltingAgent;
		this.diesel = diesel;
		this.millingWaste = millingWaste;
		this.gravel = gravel;
		this.grassMat = grassMat;
		this.shovel = shovel;
		this.broom = broom;
		this.snowChain = snowChain;
		this.grader = grader;
		this.iceMeltingCar = iceMeltingCar;
		this.scooter = scooter;
		this.truck = truck;
		this.loader = loader;
		this.person = person;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SnowVolume getSnowVolume() {
		return this.snowVolume;
	}

	public void setSnowVolume(SnowVolume snowVolume) {
		this.snowVolume = snowVolume;
	}
	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}
	public Double getInorganicSnowMeltingAgent() {
		return this.inorganicSnowMeltingAgent;
	}

	public void setInorganicSnowMeltingAgent(Double inorganicSnowMeltingAgent) {
		this.inorganicSnowMeltingAgent = inorganicSnowMeltingAgent;
	}
	public Double getOrganicSnowMeltingAgent() {
		return this.organicSnowMeltingAgent;
	}

	public void setOrganicSnowMeltingAgent(Double organicSnowMeltingAgent) {
		this.organicSnowMeltingAgent = organicSnowMeltingAgent;
	}
	public Double getDiesel() {
		return this.diesel;
	}

	public void setDiesel(Double diesel) {
		this.diesel = diesel;
	}
	public Double getMillingWaste() {
		return this.millingWaste;
	}

	public void setMillingWaste(Double millingWaste) {
		this.millingWaste = millingWaste;
	}
	public Double getGravel() {
		return this.gravel;
	}

	public void setGravel(Double gravel) {
		this.gravel = gravel;
	}
	public Integer getGrassMat() {
		return this.grassMat;
	}

	public void setGrassMat(Integer grassMat) {
		this.grassMat = grassMat;
	}
	public Integer getShovel() {
		return this.shovel;
	}

	public void setShovel(Integer shovel) {
		this.shovel = shovel;
	}
	public Integer getBroom() {
		return this.broom;
	}

	public void setBroom(Integer broom) {
		this.broom = broom;
	}
	public Integer getSnowChain() {
		return this.snowChain;
	}

	public void setSnowChain(Integer snowChain) {
		this.snowChain = snowChain;
	}
	public Integer getGrader() {
		return this.grader;
	}

	public void setGrader(Integer grader) {
		this.grader = grader;
	}
	public Integer getIceMeltingCar() {
		return this.iceMeltingCar;
	}

	public void setIceMeltingCar(Integer iceMeltingCar) {
		this.iceMeltingCar = iceMeltingCar;
	}
	public Integer getScooter() {
		return this.scooter;
	}

	public void setScooter(Integer scooter) {
		this.scooter = scooter;
	}
	public Integer getTruck() {
		return this.truck;
	}

	public void setTruck(Integer truck) {
		this.truck = truck;
	}
	public Integer getLoader() {
		return this.loader;
	}

	public void setLoader(Integer loader) {
		this.loader = loader;
	}
	
	public Integer getPerson() {
		return this.person;
	}

	public void setPerson(Integer person) {
		this.person = person;
	}
}