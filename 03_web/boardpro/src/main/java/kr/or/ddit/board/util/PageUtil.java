package kr.or.ddit.board.util;

public class PageUtil {

	public static String pageList(int startPage, int endPage, int totalPage, int page) {
		
		String pager = "<ul class=\"pagination\">";
		
		//이전버튼 
		if(startPage > 1) {
			pager += "<li class=\"page-item\"><a id=\"prev\" class=\"page-link\" href=\"#\">Previous</a></li>";
		}
		
		//페이지번호 1,2
		for(int i = startPage; i<=endPage ; i++) {
			
			if(i==page) {
				pager += "<li class=\"page-item active\"><a class=\"page-link pageno\" href=\"#\">"+i+"</a></li>";
			}else {
				pager +="<li class=\"page-item\"><a class=\"page-link pageno\" href=\"#\">"+i+"</a></li>";
			}
		}
		
		//다음버튼
		if(endPage <totalPage) {
			pager+= "<li class=\"page-item\"><a id=\"next\" class=\"page-link\" href=\"#\">Next</a></li>";
		}
		
		pager += "</ul>";
		
		return pager;
	}
}
