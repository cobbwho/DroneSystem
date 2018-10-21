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
	 * ����Drone Id ���� Drone����
	 * @param id Drone Id
	 * @return Drone����
	 */
	public Drone findById(int id) {
		return m_dao.findById(id);
	}
	public List findByCode(String code) {
		return m_dao.findByCode(code);
	}
	/**
	 * ����һ��Drone��¼
	 * @param drone Drone����
	 * @return ����ɹ�������true�����򷵻�false
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
	 * ����һ��Drone��¼
	 * @param drone Drone����
	 * @return ���³ɹ�������true�����򷵻�false
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
	 * ����Drone Id,ɾ��CheckPoint����
	 * @param id CheckPoint id
	 * @return ɾ���ɹ�������true�����򷵻�false
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
	 * ��ҳ����
	 * @param currentPage ��ǰҳ��
	 * @param pageSize ÿҳ�ļ�¼��
	 * @param arr ������ֵ��
	 * @return ��ҳ���User�б�
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
	 * ��ҳ����
	 * @param currentPage ��ǰҳ��
	 * @param pageSize ÿҳ�ļ�¼��
	 * @return ��ҳ���Specification�б�
	 */
	public List<Drone> findPagedAll(int currentPage, int pageSize, List<KeyValueWithOperator> arr) {
		try {
			return m_dao.findPagedAll("Drone", currentPage, pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}
	
	
	/**
	 * �õ�����Drone��¼��
	 * @return Drone��¼��
	 */
	public int getTotalCount(KeyValueWithOperator...arr){
		return m_dao.getTotalCount("Drone", arr);		
	}
	
	/**
	 * �õ�����Drone��¼��
	 * @return CheckPoint��¼��
	 */
	public int getTotalCount(List<KeyValueWithOperator> arr){
		return m_dao.getTotalCount("Drone",arr);		
	}
	
	/**
	 * ��������ϲ�ѯ
	 * @param instance ���������
	 * @return ���������ļ�¼
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
	* ��ҳ��ʾ����
	*@param queryString:��ѯ��䣨HQL��
	* @param currentPage
	* ��ǰҳ��, �� 1 ��ʼ
	* @param pageSize
	* ÿҳ��ʾ������
	* @param arr ��ѯ�����?��Ӧ��ֵ
	* @return ��ҳ��������б�- List
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
	* ��ҳ��ʾ����
	*@param queryString:��ѯ��䣨HQL��
	* @param currentPage
	* ��ǰҳ��, �� 1 ��ʼ
	* @param pageSize
	* ÿҳ��ʾ������
	* @param arr ��ѯ�����?��Ӧ��ֵ
	* @return ��ҳ��������б�- List
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
	* ��ҳ��ʾ����
	* @param currentPage
	* ��ǰҳ��, �� 1 ��ʼ
	* @param pageSize
	* ÿҳ��ʾ������
	* @param orderby�������ĸ��ֶ�����
	* @param asc��true ���� false ����
	* @param arr:Ϊ��ѯ������(��-ֵ)������
	* @return ��ҳ��������б�- List<TaskAssign>
	*/
	public List<Drone> findPagedAllBySort(int currentPage, int pageSize, String orderby,boolean asc,List<KeyValueWithOperator> condList){
		try{
			return m_dao.findPagedAllBySort("Drone", currentPage, pageSize, orderby, asc, condList);
		}catch(Exception e){
			return null;
		}
	}
	
	/**
	 * �õ���¼����
	 * @param queryString ��ѯ��䣨HQL��
	 * @param arr ��ѯ�����?��Ӧ��ֵ
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
	 * �õ���¼����
	 * @param queryString ��ѯ��䣨HQL��
	 * @param arr ��ѯ�����?��Ӧ��ֵ
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
	* ����HQL����
	* @param updateString HQL��䣨update ���� set �ֶ�=ֵ where ������
	* @param arr ����
	* @return ���²���Ӱ��ļ�¼��
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

