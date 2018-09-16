package com.droneSystem.hibernate;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * SysUser entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.droneSystem.hibernate.SysUser
 * @author MyEclipse Persistence Tools
 */

public class SysUserDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(SysUserDAO.class);
	// property constants
	public static final String NAME = "name";
	public static final String BRIEF = "brief";
	public static final String USER_NAME = "userName";
	public static final String PASSWORD = "password";
	public static final String GENDER = "gender";
	public static final String BRITHDAY = "brithday";
	public static final String JOB_NUM = "jobNum";
	public static final String IDNUM = "idnum";
	public static final String EDUCATION = "education";
	public static final String DEGREE = "degree";
	public static final String JOB_TITLE = "jobTitle";
	public static final String HOME_ADD = "homeAdd";
	public static final String TEL = "tel";
	public static final String CELLPHONE1 = "cellphone1";
	public static final String CELLPHONE2 = "cellphone2";
	public static final String EMAIL = "email";
	public static final String DEPARTMENT_ID = "departmentId";
	public static final String STATUS = "status";

	public void save(SysUser transientInstance) {
		log.debug("saving SysUser instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(SysUser persistentInstance) {
		log.debug("deleting SysUser instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public SysUser findById(java.lang.Integer id) {
		log.debug("getting SysUser instance with id: " + id);
		try {
			SysUser instance = (SysUser) getSession().get(
					"com.droneSystem.hibernate.SysUser", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(SysUser instance) {
		log.debug("finding SysUser instance by example");
		try {
			List results = getSession()
					.createCriteria("com.droneSystem.hibernate.SysUser")
					.add(Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding SysUser instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from SysUser as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findByBrief(Object brief) {
		return findByProperty(BRIEF, brief);
	}

	public List findByUserName(Object userName) {
		return findByProperty(USER_NAME, userName);
	}

	public List findByPassword(Object password) {
		return findByProperty(PASSWORD, password);
	}

	public List findByGender(Object gender) {
		return findByProperty(GENDER, gender);
	}

	public List findByJobNum(Object jobNum) {
		return findByProperty(JOB_NUM, jobNum);
	}

	public List findByBirthplace(Object birthday) {
		return findByProperty(BRITHDAY, birthday);
	}

	public List findByIdnum(Object idnum) {
		return findByProperty(IDNUM, idnum);
	}

	public List findByEducation(Object education) {
		return findByProperty(EDUCATION, education);
	}

	public List findByDegree(Object degree) {
		return findByProperty(DEGREE, degree);
	}

	public List findByJobTitle(Object jobTitle) {
		return findByProperty(JOB_TITLE, jobTitle);
	}

	public List findByHomeAdd(Object homeAdd) {
		return findByProperty(HOME_ADD, homeAdd);
	}

	public List findByTel(Object tel) {
		return findByProperty(TEL, tel);
	}

	public List findByCellphone1(Object cellphone1) {
		return findByProperty(CELLPHONE1, cellphone1);
	}

	public List findByCellphone2(Object cellphone2) {
		return findByProperty(CELLPHONE2, cellphone2);
	}

	public List findByEmail(Object email) {
		return findByProperty(EMAIL, email);
	}

	public List findByDepartmentId(Object departmenId) {
		return findByProperty(DEPARTMENT_ID, departmenId);
	}

	public List findByStatus(Object status) {
		return findByProperty(STATUS, status);
	}

	public List findAll() {
		log.debug("finding all SysUser instances");
		try {
			String queryString = "from SysUser";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public SysUser merge(SysUser detachedInstance) {
		log.debug("merging SysUser instance");
		try {
			SysUser result = (SysUser) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(SysUser instance) {
		log.debug("attaching dirty SysUser instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(SysUser instance) {
		log.debug("attaching clean SysUser instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}