<%@page import="kr.or.ddit.index.IndexVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- headerPart 영역 -->
<%@ include file="/module/headPart.jsp" %>


</head>

<body>
<!-- header 영역 -->
<%@ include file="/module/header.jsp" %>

<%
IndexRepository dao = IndexRepository.getInstance();
	List<IndexVO> indexList = dao.getIndexList();
%>

   <div class="services_section layout_padding" id="study">
      <div class="container">
         <h1 class="services_taital">CHAPTER </h1>
         <p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
         <div class="services_section_2">
            <div class="row">
            	<% 
            		for(int i = 0; i<indexList.size();i++){
            			IndexVO index = indexList.get(i);
            		
            	%>
            
               <div class="col-md-4 pb-5">
				  <img src="${pageContext.request.contextPath}/resources/images/chapter/<%=i+1 %>.jpg" class="services_img">

				  <h4 class="ddit_chapter text-center"><%=index.getTitle()%></h4>
				  <p class="customer_text pt-2">예제 목록</p>
				  <p class="ddit_text pb-4">
				  <% 
				  for(int j=0; j<index.getSourceList().size();j++){
					  String source = index.getSourceList().get(j);
				  %>
	<a
href="${pageContext.request.contextPath}/<%=index.getChapter().toLowerCase() %>/<%=source %>">
	<%= "- " +source %>
</a><br/>
				 <% 
				  }
				 %>
				  </p>
               </div>
               <% 
            		}
               %>
               
           </div>
         </div>
      </div>
   </div>

<!-- footer 영역 -->

<%@ include file="/module/footer.jsp" %>
<%@ include file="/module/footerPart.jsp" %>

   
</body>

</html>