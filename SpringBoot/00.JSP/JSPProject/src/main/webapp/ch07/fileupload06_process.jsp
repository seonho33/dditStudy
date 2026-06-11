<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
   <%@ include file="/module/header2.jsp"%>
   
   <div class="services_section layout_padding">
      <div class="container">
         <h1 class="services_taital"><%=IndexRepository.getChapter("CH07")%></h1>
         <p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
         <div class="services_section_2">
            <div class="row">
               <div class="col-md-12">
               
                  <%
                     String path = "C:/upload/images";
                  	 String id = request.getParameter("id");   
                  	 String pw = request.getParameter("pw");   
                  	 String gender = request.getParameter("gender");   
                  	 if(gender.equals("M")){
                  		 gender="남자";
                  	 }else{
                  		 gender="여자";
                  	 }
                  
                  
                     File tempFile = new File(path);
                     if(!tempFile.exists()){
                        tempFile.mkdirs();                     
                     }
                     
                     out.println("<h5 class='customer_text'>가입을 완료합니다!</h5>");
                     
                     Enumeration<String> en = request.getParameterNames();
                     
					 out.println("<p class='ddit_text'>아이디 : "+ id);
					 out.println("<p class='ddit_text'>비밀번호 : "+ pw);
					 out.println("<p class='ddit_text'>성별 : "+ gender);
                     
                     Collection<Part> collect = request.getParts();
                     Iterator<Part> ite = collect.iterator();
                     
                     out.println("<div class='row'>");
                     //iterator 의 ite 가 가진 데이터가 없을때까지 실행해 꺼낸다
                     while(ite.hasNext()){
                    	 out.println("<div class='col-md-3'>");
                    	 out.println("<table class='table table-bordered'>");
                        Part part = ite.next();
                        pageContext.setAttribute("part", part);
                        String name = part.getName();
                        //파일 복사(C:/upload/images.jpg)
                        part.write(path + "/" + part.getSubmittedFileName());
                        
                        if(name.equals("filename")){
                           out.println("<tr>");
                           out.println("   <td>");
                           %>
<%--                            <img src="/upload/images/<%=part.getSubmittedFileName()%>" alt=""> --%>
                           <img src="/upload/images/${part.getSubmittedFileName()}" alt="">
                           <%
                           out.println("	</td></tr><tr>");	
                           out.println("   <td><p class='ddit_text'> 파일명 : "+part.getSubmittedFileName()+"</p>");
                           out.println("   <p class='ddit_text'> 파일크기 : "+part.getSize()+"</p>");
                           out.println("   <p class='ddit_text'> 파일타입 : "+part.getContentType()+"</p>");
                           out.println("   </td>");
                           out.println("</tr>");
                        }
                     out.println("</table>");
                     out.println("</div>");
                     }
                     out.println("</div>");
                  %>
               </div>
            </div>
         </div>
      </div>
   </div>

   <%@ include file="/module/footer.jsp"%>
   <%@ include file="/module/footerPart.jsp"%>
   
</body>
</html>