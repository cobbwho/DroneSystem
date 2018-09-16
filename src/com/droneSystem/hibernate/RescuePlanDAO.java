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
 * RescuePlan entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.droneSystem.hibernate.RescuePlan
 * @author MyEclipse Persistence Tools
 */

public class RescuePlanDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(RescuePlanDAO.class);
	// property constants
	public static final String SNOWVOLUME = "snowVolume";
	public static final String TIME = "time";
	public static final String INORGANIC_SNOW_MELTING_AGENT = "inorganicSnowMeltingAgent";
	public static final String ORGANIC_SNOW_MELTING_AGENT = "organicSnowMeltingAgent";
	public static final String DIESEL = "diesel";
	public static final String MILLING_WASTE = "millingWaste";
	public static final String GRAVEL = "gravel";
	public static final String GRASS_MAT = "grassMat";
	public static final String SHOVEL = "shovel";
	public static final String BROOM = "broom";
	public static final String SNOW_CHAIN = "snowChain";
	public static final String GRADER = "grader";
	public static final String ICE_MELTING_CAR = "iceMeltingCar";
	public static final String SCOOTER = "scooter";
	public static final String TRUCK = "truck";
	public static final String LOADER = "loader";
	public static final String PERSON = "person";

	public void save(RescuePlan transientInstance) {
		log.debug("saving RescuePlan instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(RescuePlan persistentInstance) {
		log.debug("deleting RescuePlan instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public RescuePlan findById(java.lang.Integer id) {
		log.debug("getting RescuePlan instance with id: " + id);
		try {
			RescuePlan instance = (RescuePlan) getSession().get(
					"com.droneSystem.hibernate.RescuePlan", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(RescuePlan instance) {
		log.debug("finding RescuePlan instance by example");
		try {
			List results = getSession()
					.createCriteria("com.droneSystem.hibernate.RescuePlan")
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
		log.debug("finding RescuePlan instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from RescuePlan as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findBySnowVolume(Object snowVolume) {
		return findByProperty(SNOWVOLUME, snowVolume);
	}

	public List findByTime(Object time) {
		return findByProperty(TIME, time);
	}

	public List findByInorganicSnowMeltingAgent(Object inorganicSnowMeltingAgent) {
		return findByProperty(INORGANIC_SNOW_MELTING_AGENT, inorganicSnowMeltingAgent);
	}

	public List findByOrganicSnowMeltingAgent(Object organicSnowMeltingAgent) {
		return findByProperty(ORGANIC_SNOW_MELTING_AGENT, organicSnowMeltingAgent);
	}

	public List findByDiesel(Object diesel) {
		return findByProperty(DIESEL, diesel);
	}

	public List findByMillingWaste(Object millingWaste) {
		return findByProperty(MILLING_WASTE, millingWaste);
	}

	public List findByGravel(Object gravel) {
		return findByProperty(GRAVEL, gravel);
	}

	public List findByGrassMat(Object grassMat) {
		return findByProperty(GRASS_MAT, grassMat);
	}

	public List findByShovel(Object shovel) {
		return findByProperty(SHOVEL, shovel);
	}

	public List findByBroom(Object broom) {
		return findByProperty(BROOM, broom);
	}

	public List findBySnowChain(Object snowChain) {
		return findByProperty(SNOW_CHAIN, snowChain);
	}

	public List findByGrader(Object grader) {
		return findByProperty(GRADER, grader);
	}

	public List findByIceMeltingCar(Object iceMeltingCar) {
		return findByProperty(ICE_MELTING_CAR, iceMeltingCar);
	}

	public List findByScooter(Object scooter) {
		return findByProperty(SCOOTER, scooter);
	}

	public List findByTruck(Object truck) {
		return findByProperty(TRUCK, truck);
	}

	public List findByLoader(Object loader) {
		return findByProperty(LOADER, loader);
	}

	public List findByPerson(Object person) {
		return findByProperty(PERSON, person);
	}

	public List findAll() {
		log.debug("finding all RescuePlan instances");
		try {
			String queryString = "from RescuePlan";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public RescuePlan merge(RescuePlan detachedInstance) {
		log.debug("merging RescuePlan instance");
		try {
			RescuePlan result = (RescuePlan) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(RescuePlan instance) {
		log.debug("attaching dirty RescuePlan instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(RescuePlan instance) {
		log.debug("attaching clean RescuePlan instance");
		try {
			getSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}