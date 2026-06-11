package kr.or.ddit.board.vo;

public class PageInfo {

	// 페이지 처리(start,end,startpage,endPage, totalpage) 및 검색처리(stype, sword)를 위한 vo역할
	private int perList ;	// 한 페이지당 출력하는 글 갯수
	private int perPage ;	// 현재 보여지는 페이지 개수
	private int totalRecord;// 전체 글 갯수 - 조건에 따라 달라짐
	
	private int page ; // 현재 페이지 번호 - 출력할 게시글의 번호(가상번호)를 계산 또는 시작페이지 번호와 끝 페이지 번호를 계산
	
	private SearchVO svo;	//page, stype, sword
	
	public PageInfo() {		//PageInfo pinfo = new PageInfo()
		this(3,2);			//pinfo.svo.page pinfo.svo.stype pinfo.svo.sword
	}
	
	public PageInfo(int perList,int perPage) {
		this.perList=perList;
		this.perPage=perPage;
	}

	public int getPerList() {
		return perList;
	}

	public void setPerList(int perList) {
		this.perList = perList;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public SearchVO getSvo() {
		return svo;
	}

	public void setSvo(SearchVO svo) {
		this.svo = svo;
	}
	
	public int getTotalPage() {
		int totalPage = (int)Math.ceil(totalRecord/(double)perList);
		return totalPage;
	}
	
	public int getStartPage() {
		if(page>getTotalPage()) page = getTotalPage();
		int startPage = ((page-1)/perPage*perPage)+1;
		return startPage;
	}
	
	public int getEndPage() {
		int endPage = getStartPage() + perPage - 1;
		if(endPage>getTotalPage()) endPage = getTotalPage();
		
		return endPage;
	}

	public int getStart() {
		if(page>getTotalPage()) page = getTotalPage();
		int start = (page-1)*perList + 1;
		return start;
	}
	
	public int getEnd() {
		int end = getStart() + perList -1;
		if(end>totalRecord ) end = totalRecord;
		
		return end;
	}
	
	@Override
	public String toString() {
		
		return "totalRecord = " + totalRecord + "\n"
				+"totalPage = " + getTotalPage()+"\n"
				+"start = " + getStart()+"\n"
				+"end = " + getEnd()+"\n"
				+"startPage = "+getStartPage()+"\n"
				+"endPage = " + getEndPage();
	}
	
}