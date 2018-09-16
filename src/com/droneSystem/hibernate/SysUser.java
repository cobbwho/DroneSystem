package com.droneSystem.hibernate;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * SysUser entity. @author MyEclipse Persistence Tools
 */

public class SysUser implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String brief;
	private String userName;
	private String password;
	private Boolean gender;
	private String jobNum;
	private Date birthday;
	private String idnum;
	private String education;
	private String degree;
	private String jobTitle;
	private String homeAdd;
	private String tel;
	private String cellphone1;
	private String cellphone2;
	private String email;
	private Integer status;
	private Department department;
	private Timestamp cancelDate;

	// Constructors

	/** default constructor */
	public SysUser() {
	}

	/** minimal constructor 
	 **/
	public SysUser(String name, String brief, String userName, String password,
			Boolean gender, String jobNum, Date birthday, String idnum,
			String homeAdd, String tel, String cellphone1, String email, 
			Integer status) {
		this.name = name;
		this.brief = brief;
		this.userName = userName;
		this.password = password;
		this.gender = gender;
		this.jobNum = jobNum;
		this.birthday = birthday;
		this.idnum = idnum;
		this.homeAdd = homeAdd;
		this.tel = tel;
		this.cellphone1 = cellphone1;
		this.email = email;
		this.status = status;
	}

	/** full constructor 
	 **/
	public SysUser(String name, String brief, String userName, String password,
			Boolean gender, String jobNum, Date birthday,
			String idnum, String education, String degree, String jobTitle, String homeAdd,
			String tel, String cellphone1, String cellphone2,
			String email, Integer status, Department department, Timestamp cancelDate) {
		this.name = name;
		this.brief = brief;
		this.userName = userName;
		this.password = password;
		this.gender = gender;
		this.jobNum = jobNum;
		this.birthday = birthday;
		this.idnum = idnum;
		this.education = education;
		this.degree = degree;
		this.jobTitle = jobTitle;
		this.homeAdd = homeAdd;
		this.tel = tel;
		this.cellphone1 = cellphone1;
		this.cellphone2 = cellphone2;
		this.email = email;
		this.status = status;
		this.department = department;
		this.cancelDate = cancelDate;
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

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getGender() {
		return this.gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	public String getJobNum() {
		return this.jobNum;
	}

	public void setJobNum(String jobNum) {
		this.jobNum = jobNum;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getIdnum() {
		return this.idnum;
	}

	public void setIdnum(String idnum) {
		this.idnum = idnum;
	}

	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getDegree() {
		return this.degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getJobTitle() {
		return this.jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getHomeAdd() {
		return this.homeAdd;
	}

	public void setHomeAdd(String homeAdd) {
		this.homeAdd = homeAdd;
	}


	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCellphone1() {
		return this.cellphone1;
	}

	public void setCellphone1(String cellphone1) {
		this.cellphone1 = cellphone1;
	}

	public String getCellphone2() {
		return this.cellphone2;
	}

	public void setCellphone2(String cellphone2) {
		this.cellphone2 = cellphone2;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Timestamp getCancelDate() {
		return this.cancelDate;
	}

	public void setCancelDate(Timestamp cancelDate) {
		this.cancelDate = cancelDate;
	}

}