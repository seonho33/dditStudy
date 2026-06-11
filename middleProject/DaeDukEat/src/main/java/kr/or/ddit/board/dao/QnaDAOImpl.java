package kr.or.ddit.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.common.util.MyBatisUtil;

/**
 * QNA DAO 구현체
 */
public class QnaDAOImpl implements IQnaDAO {
    
    private static QnaDAOImpl instance = new QnaDAOImpl();
    private QnaDAOImpl() {}
    public static QnaDAOImpl getInstance() {
        return instance;
    }
    
    @Override
    public int insertQna(QnaVO qna) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.insert("qna.insertQna", qna);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public List<QnaVO> selectAllQnas() throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<QnaVO> list = null;
        
        try {
            list = session.selectList("qna.selectAllQnas");
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public QnaVO selectQnaById(Long qnaId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        QnaVO qna = null;
        
        try {
            qna = session.selectOne("qna.selectQnaById", qnaId);
        } finally {
            if(session != null) session.close();
        }
        
        return qna;
    }
    
    @Override
    public int updateQna(QnaVO qna) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("qna.updateQna", qna);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int insertAnswer(QnaVO qna) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("qna.insertAnswer", qna);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int deleteQna(Long qnaId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.delete("qna.deleteQna", qnaId);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int getTotalCount() throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            count = session.selectOne("qna.getTotalCount");
        } finally {
            if(session != null) session.close();
        }
        
        return count;
    }
    
    @Override
    public List<QnaVO> selectQnasWithPaging(int offset, int limit) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<QnaVO> list = null;
        
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("offset", offset);
            params.put("limit", limit);
            
            list = session.selectList("qna.selectQnasWithPaging", params);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public List<QnaVO> selectMyQnas(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<QnaVO> list = null;
        
        try {
            list = session.selectList("qna.selectMyQnas", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public List<QnaVO> searchByTitle(String keyword) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<QnaVO> list = null;
        
        try {
            list = session.selectList("qna.searchByTitle", keyword);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public List<QnaVO> selectByStatus(String statusYn) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<QnaVO> list = null;
        
        try {
            list = session.selectList("qna.selectByStatus", statusYn);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
}