package com.droneSystem.hibernate;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * Highway entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.droneSystem.hibernate.Highway
 * @author MyEclipse Persistence Tools
 */

public class HighwayDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(HighwayDAO.class);
	// property constants
	public static final String NAME = "name";
	public static final String BRIEF = "brief";
	public static final String CODE = "code";
	public static final String START_POINT = "startPoint";
	public static final String END_POINT = "endPoint";
	public static final String LENGTH = "length";
	public static final String WIDTH = "width";
	public static final String LANE_NUM = "laneNum";
	public static final String MAX_LON_GRADE = "maxLonGrade";
	public static final String DESIGN_SPEED = "designSpeed";
	public static final String RANK = "rank";	
	public static final String STATUS = "status";

	public void save(Highway transientInstance) {
		log.debug("saving Highway instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Highway persistentInstance) {
		log.debug("deleting Highway instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Highway findById(java.lang.Integer id) {
		log.debug("getting Highway instance with id: " + id);
		try {
			Highway instance = (Highway) getSession().get(
					"com.droneSystem.hibernate.Highway", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Highway instance) {
		log.debug("finding Highway instance by example");
		try {
			List results = getSession().createCriteria(
					"com.droneSystem.hibernate.Highway").add(
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
		log.debug("finding Highway instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Highway as model where model."
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
	
	public List findByCode(Object code) {
		return findByProperty(CODE, code);
	}
	public List findByStartPoint(Object startPoint) {
		return findByProperty(START_POINT, startPoint);
	}
	public List findByEndPoint(Object endPoint) {
		return findByProperty(END_POINT, endPoint);
	}
	public List findByLength(Object length) {
		return findByProperty(LENGTH, length);
	}
	public List findByWidth(Object width) {
		return findByProperty(WIDTH, width);
	}
	public List findByLaneNum(Object laneNum) {
		return findByProperty(LANE_NUM, laneNum);
	}
	public List findByDesignSpeed(Object designSpeed) {
		return findByProperty(DESIGN_SPEED, designSpeed);
	}
	public List findByMaxLonGrade(Object maxLonGrade) {
		return findByProperty(MAX_LON_GRADE, maxLonGrade);
	}
	public List findByRank(Object rank) {
		return findByProperty(RANK, rank);
	}
	
	public List findByStatus(Object status) {
		return findByProperty(STATUS, status);
	}

	public List findAll() {
		log.debug("finding all Highway instances");
		try {
			String queryString = "from Highway";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Highway merge(Highway detachedInstance) {
		log.debug("merging Highway instance");
		try {
			Highway result = (Highway) getSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Highway instance) {
		log.debug("attaching dirty Highway instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Highway instance) {
		log.debug("attaching clean Highway instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}