package com.droneSystem.manager;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Transaction;

import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.DroneDAO;
import com.droneSystem.util.KeyValueWithOperator;


public class DroneManager {
	private DroneDAO m_dao = new DroneDAO();
	
	/**
	 * 根据Drone Id 查找 Drone对象
	 * @param id Drone Id
	 * @return Drone对象
	 */
	public Drone findById(int id) {
		return m_dao.findById(id);
	}
	
	/**
	 * 插入一条Drone记录
	 * @param drone Drone对象
	 * @return 插入成功，返回true；否则返回false
	 */
	public boolean save(Drone drone){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {	
			m_dao.save(drone);
			tran.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return false;
		} finally {
			m_dao.closeSession();
		}
	}
	
	/**
	 * 更新一条Drone记录
	 * @param drone Drone对象
	 * @return 更新成功，返回true；否则返回false
	 */
	public boolean update(Drone drone){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {			
			m_dao.update(drone);
			tran.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return false;
		} finally {
			m_dao.closeSession();
		}
	}
	
	/**
	 * 根据Drone Id,删除CheckPoint对象
	 * @param id CheckPoint id
	 * @return 删除成功，返回true；否则返回false
	 */
	public boolean deleteById(int id){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {			
			Drone u = m_dao.findById(id);
			if(u == null){
				return true;
			}else{
				m_dao.delete(u);
			}			
			tran.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return false;
		} finally {
			m_dao.closeSession();
		}
	}	
	
	/**
	 * 分页函数
	 * @param currentPage 当前页码
	 * @param pageSize 每页的记录数
	 * @param arr 条件键值对
	 * @return 分页后的User列表
	 */
	public List<Drone> findPagedAll(int currentPage, int pageSize, KeyValueWithOperator...arr) {
		try {
			return m_dao.findPagedAll("Drone", currentPage,pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Drone> findAllDrone() {
		try {
			return m_dao.findAll();
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 分页函数
	 * @param currentPage 当前页码
	 * @param pageSize 每页的记录数
	 * @return 分页后的Specification列表
	 */
	public List<Drone> findPagedAll(int currentPage, int pageSize, List<KeyValueWithOperator> arr) {
		try {
			return m_dao.findPagedAll("Drone", currentPage, pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}
	
	
	/**
	 * 得到所有Drone记录数
	 * @return Drone记录数
	 */
	public int getTotalCount(KeyValueWithOperator...arr){
		return m_dao.getTotalCount("Drone", arr);		
	}
	
	/**
	 * 得到所有Drone记录数
	 * @return CheckPoint记录数
	 */
	public int getTotalCount(List<KeyValueWithOperator> arr){
		return m_dao.getTotalCount("Drone",arr);		
	}
	
	/**
	 * 多条件组合查询
	 * @param instance 条件的组合
	 * @return 符合条件的记录
	 */
	public List findByExample(Drone instance) {
		return m_dao.findByExample(instance);
	}

	
	/**
	 * 
	 * @param arr
	 * @return
	 */
	public List<Drone> findByVarProperty(KeyValueWithOperator...arr){
		try{
			return m_dao.findByVarProperty("Drone", arr);
		}
		catch(Exception e){
			return null;
		}
	}
	
	/**
	* 分页显示数据
	*@param queryString:查询语句（HQL）
	* @param currentPage
	* 当前页码, 从 1 开始
	* @param pageSize
	* 每页显示数据量
	* @param arr 查询语句中?对应的值
	* @return 分页后的数据列表- List
	*/
	public List findPageAllByHQL(String queryString, int currentPage, int pageSize, Object...arr){
		try{
			return m_dao.findPageAllByHQL(queryString, currentPage, pageSize, arr);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	* 分页显示数据
	*@param queryString:查询语句（HQL）
	* @param currentPage
	* 当前页码, 从 1 开始
	* @param pageSize
	* 每页显示数据量
	* @param arr 查询语句中?对应的值
	* @return 分页后的数据列表- List
	*/
	public List findPageAllByHQL(String queryString, int currentPage, int pageSize, List<Object> arr){
		try{
			return m_dao.findPageAllByHQL(queryString, currentPage, pageSize, arr);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	* 分页显示数据
	* @param currentPage
	* 当前页码, 从 1 开始
	* @param pageSize
	* 每页显示数据量
	* @param orderby：按照哪个字段排序
	* @param asc：true 增序 false 减序
	* @param arr:为查询条件的(键-值)对数组
	* @return 分页后的数据列表- List<TaskAssign>
	*/
	public List<Drone> findPagedAllBySort(int currentPage, int pageSize, String orderby,boolean asc,List<KeyValueWithOperator> condList){
		try{
			return m_dao.findPagedAllBySort("Drone", currentPage, pageSize, orderby, asc, condList);
		}catch(Exception e){
			return null;
		}
	}
	
	/**
	 * 得到记录总数
	 * @param queryString 查询语句（HQL）
	 * @param arr 查询语句中?对应的值
	 * @return
	 */
	public int getTotalCountByHQL(String queryString,Object...arr) {
		try{
			return m_dao.getTotalCountByHQL(queryString, arr);
		}catch(Exception ex){
			return 0;
		}
	}
	
	/**
	 * 得到记录总数
	 * @param queryString 查询语句（HQL）
	 * @param arr 查询语句中?对应的值
	 * @return
	 */
	public int getTotalCountByHQL(String queryString,List<Object> arr) {
		try{
			return m_dao.getTotalCountByHQL(queryString, arr);
		}catch(Exception ex){
			return 0;
		}
	}
	
	public Boolean updateSandVolumeByFile(String fileName) {
		try{
			Map<String,String> a = readFileByLines(fileName);
			int id = Integer.parseInt(a.get("id")); 
			Drone drone = findById(id);
			
			for(Map.Entry<String, String> entry : a.entrySet()){
				if(entry.getKey().equals("latitude")){
					drone.setLatitude(Double.parseDouble(entry.getValue()));
				}
				if(entry.getKey().equals("Longtitude")){
					drone.setLongitude(Double.parseDouble(entry.getValue()));
				}
				
			}
			return true;
		}catch(Exception ex){
			return false;
		}
	}
	public Map<String,String> readFileByLines(String fileName) {
		File file = new File(fileName);
		Map<String,String> hMap = new HashMap<String,String>();
		BufferedReader reader = null; 
		try {
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;  
			while ((tempString = reader.readLine()) != null) {
				String[] strs = tempString.split(":");
				hMap.put(strs[0], strs[1]);
			}
			reader.close();  
			return hMap;
		} catch (IOException  e) {
			
			e.printStackTrace();
			return null;  
		} finally {  
             if (reader != null) {  
                 try {  
                    reader.close();  
                 } catch (IOException e1) {  
                 }  
             }  
         }
		
	}
	/**
	* 根据HQL更新
	* @param updateString HQL语句（update 表名 set 字段=值 where 条件）
	* @param arr 参数
	* @return 更新操作影响的记录数
	*/
	public int updateByHQL(String updateString, Object...arr) {		
		Transaction tran = m_dao.getSession().beginTransaction();
		try{
			int i = m_dao.updateByHQL(updateString, arr);
			tran.commit();
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return 0;
		}finally {
			m_dao.closeSession();
		}
	}
}

