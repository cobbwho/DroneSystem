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

public class PointDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(PointDAO.class);
	// property constants
	public static final String NAME = "name";
	public static final String CODE = "code";
	public static final String BRIEF = "brief";
	public static final String HIGHWAY_ID = "highwayId";
	public static final String LONGITUDE = "longitude";
	public static final String LATITUDE = "latitude";
	public static final String STATUS = "status";

	public void save(Point transientInstance) {
		log.debug("saving Point instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Point persistentInstance) {
		log.debug("deleting Point instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Point findById(java.lang.Integer id) {
		log.debug("getting Point instance with id: " + id);
		try {
			Point instance = (Point) getSession().get(
					"com.droneSystem.hibernate.Point", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Point instance) {
		log.debug("finding Point instance by example");
		try {
			List results = getSession().createCriteria(
					"com.droneSystem.hibernate.Point").add(
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
		log.debug("finding Point instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Point as model where model."
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
	
	public List findByCode(Object code) {
		return findByProperty(CODE, code);
	}

	public List findByBrief(Object brief) {
		return findByProperty(BRIEF, brief);
	}

	public List findByDepartmentId(Object highwayId) {
		return findByProperty(HIGHWAY_ID, highwayId);
	}
	
	public List findByLongitude(Object longitude) {
		return findByProperty(LONGITUDE, longitude);
	}

	public List findByLatitude(Object latitude) {
		return findByProperty(LATITUDE, latitude);
	}

	public List findByStatus(Object status) {
		return findByProperty(STATUS, status);
	}


	public List findAll() {
		log.debug("finding all Point instances");
		try {
			String queryString = "from Point";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Point merge(Point detachedInstance) {
		log.debug("merging Point instance");
		try {
			Point result = (Point) getSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Point instance) {
		log.debug("attaching dirty Point instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Point instance) {
		log.debug("attaching clean Point instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}