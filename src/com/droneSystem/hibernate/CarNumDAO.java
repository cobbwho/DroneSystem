package com.droneSystem.hibernate;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * Point entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.droneSystem.hibernate.Point
 * @author MyEclipse Persistence Tools
 */

public class CarNumDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(CarNumDAO.class);
	// property constants
	public static final String TRAFFICFLOW_ID = "trafficflow_id";
	public static final String CAR_NUM = "carNum";
	public static final String TIME = "time";
	public static final String VIDEO_ID = "video_id";

	public void save(CarNum transientInstance) {
		log.debug("saving CarNum instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(CarNum persistentInstance) {
		log.debug("deleting CarNum instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public CarNum findById(java.lang.Integer id) {
		log.debug("getting CarNum instance with id: " + id);
		try {
			CarNum instance = (CarNum) getSession().get(
					"com.droneSystem.hibernate.CarNum", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(CarNum instance) {
		log.debug("finding CarNum instance by example");
		try {
			List results = getSession().createCriteria(
					"com.droneSystem.hibernate.CarNum").add(
					Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding CarNum instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from CarNum as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByCarNum(Object carNum) {
		return findByProperty(CAR_NUM, carNum);
	}
	
	public List findByTrafficflow_id(Object trafficflow_id) {
		return findByProperty(TRAFFICFLOW_ID, trafficflow_id);
	}

	public List findByTime(Object time) {
		return findByProperty(TIME, time);
	}


	public List findAll() {
		log.debug("finding all CarNum instances");
		try {
			String queryString = "from CarNum";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public CarNum merge(CarNum detachedInstance) {
		log.debug("merging CarNum instance");
		try {
			CarNum result = (CarNum) getSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(CarNum instance) {
		log.debug("attaching dirty CarNum instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(CarNum instance) {
		log.debug("attaching clean CarNum instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}