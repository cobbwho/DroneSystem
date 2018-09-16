package com.droneSystem.hibernate;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * Drone entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.droneSystem.hibernate.Drone
 * @author MyEclipse Persistence Tools
 */

public class DroneDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(DroneDAO.class);
	// property constants
	public static final String CODE = "code";
	public static final String MANUFACTURER = "manufacturer";
	public static final String MODEL = "model";
	public static final String WEIGHT = "weight";
	public static final String HEIGHT = "height";
	public static final String LONGITUDE = "longitude";
	public static final String LATITUDE = "latitude";
	public static final String IS_TASK = "istask";
	public static final String VIDEOURL = "videourl";
	public static final String STATUS = "status";

	public void save(Drone transientInstance) {
		log.debug("saving Drone instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Drone persistentInstance) {
		log.debug("deleting Drone instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Drone findById(java.lang.Integer id) {
		log.debug("getting Drone instance with id: " + id);
		try {
			Drone instance = (Drone) getSession().get(
					"com.droneSystem.hibernate.Drone", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Drone instance) {
		log.debug("finding Drone instance by example");
		try {
			List results = getSession().createCriteria(
					"com.droneSystem.hibernate.Drone").add(
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
		log.debug("finding Drone instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Drone as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByCode(Object code) {
		return findByProperty(CODE, code);
	}

	public List findByManufacturer(Object manufacturer) {
		return findByProperty(MANUFACTURER, manufacturer);
	}

	public List findByModel(Object model) {
		return findByProperty(MODEL, model);
	}
	
	public List findByHeight(Object height) {
		return findByProperty(HEIGHT, height);
	}
	
	public List findByWeight(Object weight) {
		return findByProperty(WEIGHT, weight);
	}
	
	public List findByLongitude(Object longitude) {
		return findByProperty(LONGITUDE, longitude);
	}

	public List findByVideoUrl(Object videoUrl) {
		return findByProperty(VIDEOURL, videoUrl);
	}
	
	public List findByLatitude(Object latitude) {
		return findByProperty(LATITUDE, latitude);
	}

	public List findByIsTask(Object isTask) {
		return findByProperty(IS_TASK, isTask);
	}
	
	public List findByStatus(Object status) {
		return findByProperty(STATUS, status);
	}


	public List findAll() {
		log.debug("finding all Drone instances");
		try {
			String queryString = "from Drone";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Drone merge(Drone detachedInstance) {
		log.debug("merging Drone instance");
		try {
			Drone result = (Drone) getSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Drone instance) {
		log.debug("attaching dirty Drone instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Drone instance) {
		log.debug("attaching clean Drone instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}