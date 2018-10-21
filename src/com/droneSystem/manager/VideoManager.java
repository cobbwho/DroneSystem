package com.droneSystem.manager;



import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Transaction;

import com.droneSystem.hibernate.Drone;
import com.droneSystem.hibernate.Video;
import com.droneSystem.hibernate.VideoDAO;
import com.droneSystem.util.KeyValueWithOperator;


public class VideoManager {
	private VideoDAO m_dao = new VideoDAO();
	
	/**
	 * ����Video Id ���� Video����
	 * @param id Video Id
	 * @return Video����
	 */
	public Video findById(int id) {
		return m_dao.findById(id);
	}
	
	/**
	 * ����Video Id ���� Video����
	 * @param id Video Id
	 * @return Video����
	 */
	public List findByDrone(Drone drone) {
		return m_dao.findByDrone(drone);
	}
	/**
	 * ����һ��Video��¼
	 * @param video Video����
	 * @return ����ɹ�������true�����򷵻�false
	 */
	public boolean save(Video video){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {	
			m_dao.save(video);
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
	 * ����һ��Video��¼
	 * @param video Video����
	 * @return ���³ɹ�������true�����򷵻�false
	 */
	public boolean update(Video video){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {			
			m_dao.update(video);
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
	 * ����Video Id,ɾ��Video����
	 * @param id Video id
	 * @return ɾ���ɹ�������true�����򷵻�false
	 */
	public boolean deleteById(int id){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {			
			Video u = m_dao.findById(id);
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
	 * @return ��ҳ���Video�б�
	 */
	public List<Video> findPagedAll(int currentPage, int pageSize, KeyValueWithOperator...arr) {
		try {
			return m_dao.findPagedAll("Video", currentPage,pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * ��ҳ����
	 * @param currentPage ��ǰҳ��
	 * @param pageSize ÿҳ�ļ�¼��
	 * @return ��ҳ���Video�б�
	 */
	public List<Video> findPagedAll(int currentPage, int pageSize, List<KeyValueWithOperator> arr) {
		try {
			return m_dao.findPagedAll("Video", currentPage, pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}
	
	
	/**
	 * �õ�����Video��¼��
	 * @return Video��¼��
	 */
	public int getTotalCount(KeyValueWithOperator...arr){
		return m_dao.getTotalCount("Video", arr);		
	}
	
	/**
	 * �õ�����Video��¼��
	 * @return Video��¼��
	 */
	public int getTotalCount(List<KeyValueWithOperator> arr){
		return m_dao.getTotalCount("Video",arr);		
	}
	
	/**
	 * ��������ϲ�ѯ
	 * @param instance ���������
	 * @return ���������ļ�¼
	 */
	public List findByExample(Video instance) {
		return m_dao.findByExample(instance);
	}

	
	/**
	 * 
	 * @param arr
	 * @return
	 */
	public List<Video> findByVarProperty(KeyValueWithOperator...arr){
		try{
			return m_dao.findByVarProperty("Video", arr);
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

