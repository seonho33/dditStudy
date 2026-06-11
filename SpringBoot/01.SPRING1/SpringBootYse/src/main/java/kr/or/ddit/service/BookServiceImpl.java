package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IBookMapper;

//일반적으로 서비스 레이어는 인터페이스와 클래스를 함께 사용합니다.
//스프링은 직접 클래스를 생성하는 것을 지양하고 인터페이스를 통해 접근하는 것을 권장하는 프레임 워크입니다.
//
@Service
public class BookServiceImpl implements IBookService {

	@Autowired
	private IBookMapper mapper;
	
	/**
	 * <p>책 등록</p>
	 * 
	 * @since SpringBootYse 1.0
	 * @author junesker
	 * @param Map 등록할 책 데이터(title, category, price)
	 * @return 성공 책ID, 실패 null
	 */
	@Override
	public String insertBook(Map<String, Object> param) {
		
		// insert 구문은 입력이 성공하면 1, 실패하면 0을 리턴합니다
		int affectRowCount = mapper.insert(param);
		if(affectRowCount>0) {//등록 성공!
			// 등록 후 방금 등록한 게시글 id를 리턴합니다.!
			return param.get("book_id").toString();
		}
		//등록 실패
		return null;
	}
	
	/**
	 * <p>책 상세보기</p>
	 * 
	 * @since SpringBootYse 1.0
	 * @author junesker
	 * @param int 책 ID
	 * @return ID에 해당하는 책 정보
	 */
	@Override
	public Map<String, Object> selectBook(int bookId) {
		return mapper.selectBook(bookId);
	}

	/**
	 * <p>책 수정</p>
	 * 
	 * @since SpringBootYse 1.0
	 * @author junesker
	 * @param Map 등록할 책 데이터(title, category, price)
	 * @return 성공 1(true),0(false)
	 */
	@Override
	public boolean updateBook(Map<String, Object> map) {
		int affectRowCount = mapper.update(map);
		return affectRowCount == 1;
	}
	
	/**
	 * <p>책 삭제</p>
	 * 
	 * @since SpringBootYse 1.0
	 * @author junesker
	 * @param Map 책 ID
	 * @return 성공 1(true),0(false)
	 */
	@Override
	public boolean removeBook(Map<String, Object> map) {
		int affectRowCount = mapper.remove(map);
		return affectRowCount == 1;
	}
	
	
	/**
	 * <p>책 목록</p>
	 * 
	 * @since SpringBootYse 1.0
	 * @author junesker
	 * @param map 책 키워드
	 * @return List 책 목록
	 */
	@Override
	public List<Map<String, Object>> selectBookList(Map<String, Object> map) {
		
		return mapper.selectBookList(map);
	}


}
