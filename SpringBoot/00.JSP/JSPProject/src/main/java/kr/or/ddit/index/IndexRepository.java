package kr.or.ddit.index;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IndexRepository {
	
	// 챕터별 데이터 목록을 관리하고 챕터별 예제 소스 목록을 함께 관리할 수 있도록
	// In-Memory 공간으로 활용한다.
	
	private List<IndexVO> indexList = new ArrayList<IndexVO>();
	private static Map<String, String> chaptMap = new HashMap<>();
	
	//싱글톤
	private static IndexRepository instance = null;
	public static IndexRepository getInstance() {
		if(instance == null) {
			instance = new IndexRepository();
		}
		return instance;
	}
	//InMemory 내 챕터, 제목, 챕터별URL, 챕터별소스페이지 정보를 담기 위한 준비
	private IndexRepository() {
		String[] chapters = {
				"CH01","CH03","CH04","CH05","CH06","CH07","CH08","CH17"
		};	//챕터 제목 설정
		String[] titles = {
			"CH01. JSP 개요", "CH03. 디렉티브 태그", "CH04. 액션 태그", "CH05. 내장객체",
			"CH06. 폼 태그", "CH07. 파일 업로드", "CH08. 유효성 검사","CH17. 태그 라이브러리"
		};
		//챕터별  URL 설정
		String[] chaptMoveUrls = {
				"/ch01/welcome.jsp","","","","","","",""
		};
		//챕터별 소스 페이지 설정
		String[][] sourceArr = {
				{"welcome.jsp"},	//ch01	
				{"taglib.jsp","ch03_test.jsp"},	//ch03	
				{"ch04info.jsp","form.jsp","result.jsp"},	//ch04	
				{}, //ch05
				{},	//ch06	
				{},	//ch07	
				{},	//ch08	
				{}	//ch017	
		};
		//정보를 담을 List 설정
		for(int i=0; i<chapters.length; i++) {
			IndexVO indexVO = new IndexVO();
			indexVO.setChapter(chapters[i]);
			indexVO.setTitle(titles[i]);
			indexVO.setChapterMoveUrl(chaptMoveUrls[i]);
			
			//각 챕터별 소스 페이지 등록
			List<String> sourceList = new ArrayList<String>();
			for(int j=0; j < sourceArr[i].length; j++) {
				sourceList.add(sourceArr[i][j]);
			}
			indexVO.setSourceList(sourceList);
			indexList.add(indexVO);

			//Map에 챕터 등록하기
			chaptMap.put(chapters[i], titles[i]);
		}
	}
	
	public List<IndexVO> getIndexList(){
		return indexList;
	}
	
	public static String getChapter(String chapter){
		return chaptMap.get(chapter);
	}
}
