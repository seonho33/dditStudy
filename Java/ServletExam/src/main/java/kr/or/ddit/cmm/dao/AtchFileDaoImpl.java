package kr.or.ddit.cmm.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.cmm.vo.AtchFileDetailVO;
import kr.or.ddit.cmm.vo.AtchFileVO;
import kr.or.ddit.util.MyBatisUtil;

public class AtchFileDaoImpl implements IAtchFileDao {
	
	private static IAtchFileDao fileDao = new AtchFileDaoImpl();
	
	private AtchFileDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	public static IAtchFileDao getInstance() {
		return fileDao;
	}

	@Override
	public int insertAtchFile(AtchFileVO atchFileVO) {
		
		int cnt = 0;
		
		try(SqlSession session = MyBatisUtil.getSqlSession(false)){
			
			 cnt = session.insert("atchFile.insertAtchFile", atchFileVO);
			
			 if(cnt > 0) {
				 session.commit();
			 }
			 
		}catch(PersistenceException ex) {
			ex.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public int insertAtchFileDetail(AtchFileDetailVO detailVO) {
		
		int cnt = 0;
		
		try(SqlSession session = MyBatisUtil.getSqlSession(false)){
			
			 cnt = session.insert("atchFile.insertAtchFileDetail", detailVO);
			
			 if(cnt > 0) {
				 session.commit();
			 }
			 
		}catch(PersistenceException ex) {
			ex.printStackTrace();
		}
		
		return cnt;
	}
	
	

	@Override
	public AtchFileVO getAtchFile(AtchFileVO atchFileVO) {
		
		try(SqlSession session = MyBatisUtil.getSqlSession(true)){
			atchFileVO = session
					.selectOne("atchFile.getAtchFile", atchFileVO);
		}catch(PersistenceException ex) {
			ex.printStackTrace();
		}
		
		return atchFileVO;
	}

	@Override
	public AtchFileDetailVO getAtchFileDetail(AtchFileDetailVO detailVO) {
		try(SqlSession session = MyBatisUtil.getSqlSession(true)){
			detailVO = session
					.selectOne("atchFile.getAtchFileDetail", detailVO);
		}catch(PersistenceException ex) {
			ex.printStackTrace();
		}
		
		return detailVO;
	}
	
	
	public static void main(String[] args) {
		
		AtchFileDaoImpl dao = new AtchFileDaoImpl();
		
		AtchFileVO atchFileVO = new AtchFileVO();
		int cnt = dao.insertAtchFile(atchFileVO);
		
		if(cnt > 0) {
			System.out.println("insertAtchFile 작업 성공...");
		}else {
			System.out.println("insertAtchFile 작업 실패!!!");
		}
		
		AtchFileDetailVO detailVO = new AtchFileDetailVO();
		detailVO.setAtchFileId(atchFileVO.getAtchFileId());
		detailVO.setFileStreCours("d:/D_Other/aaa.jpg");
		detailVO.setOrignlFileNm("aaa.jpg");
		detailVO.setStreFileNm("agcdfsdaf");
		detailVO.setFileExtsn("jpg");
		detailVO.setFileSize(50);
		
		cnt = dao.insertAtchFileDetail(detailVO);
		
		
		if(cnt > 0) {
			System.out.println("insertAtchFileDetail 작업 성공...");
		}else {
			System.out.println("insertAtchFileDetail 작업 실패!!!");
		}
		
		atchFileVO = dao.getAtchFile(atchFileVO);
		
		System.out.println("리스트 : ");
		
		for(AtchFileDetailVO atchFileDetailVO 
				: atchFileVO.getAtchFileDetailList()) {
			System.out.println(atchFileDetailVO);
		}
		
		
		detailVO.setAtchFileId(182);
		detailVO.setFileSn(2);
		detailVO = dao.getAtchFileDetail(detailVO);
		System.out.println("detailVO : " + detailVO);
		
	}

}
