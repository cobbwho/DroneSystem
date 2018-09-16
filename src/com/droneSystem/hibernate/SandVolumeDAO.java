package com.droneSystem.hibernate;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * Task entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.droneSystem.hibernate.Task
 * @author MyEclipse Persistence Tools
 */

public class SandVolumeDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(SandVolumeDAO.class);
	// property constants
	public static final String VIDEO = "video";
	public static final String TIME = "time";
	public static final String DRONE = "drone";
	public static final String SANDVOLUME = "sandVolume";
	

	public void save(SandVolume transientInstance) {
		log.debug("saving SandVolume instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(SandVolume persistentInstance) {
		log.debug("deleting SandVolume instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public SandVolume findById(java.lang.Integer id) {
		log.debug("getting SandVolume instance with id: " + id);
		try {
			SandVolume instance = (SandVolume) getSession().get(
					"com.droneSystem.hibernate.SandVolume", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(SandVolume instance) {
		log.debug("finding SandVolume instance by example");
		try {
			List results = getSession().createCriteria(
					"com.droneSystem.hibernate.SandVolume").add(
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
		log.debug("finding SandVolume instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from SandVolume as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByVideo(Object video) {
		return findByProperty(VIDEO, video);
	}

	public List findByTime(Object time) {
		return findByProperty(TIME, time);
	}
	
	public List findByDrone(Object drone) {
		return findByProperty(DRONE, drone);
	}
	
	public List findBySandVolume(Object sandVolume) {
		return findByProperty(SANDVOLUME, sandVolume);
	}


	public List findAll() {
		log.debug("finding all SandVolume instances");
		try {
			String queryString = "from SandVolume";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public SandVolume merge(SandVolume detachedInstance) {
		log.debug("merging SandVolume instance");
		try {
			SandVolume result = (SandVolume) getSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(SandVolume instance) {
		log.debug("attaching dirty SandVolume instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(SandVolume instance) {
		log.debug("attaching clean SandVolume instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}