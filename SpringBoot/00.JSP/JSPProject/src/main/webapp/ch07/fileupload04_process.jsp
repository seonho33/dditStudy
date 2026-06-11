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
                     // 파일을 업로드 하기 위한 방법
                     // 1. Local 환경에 업로드
                     // - C:/upload 폴더에 파일을 업로드 설정
                     // JSP에서는 서버를 설정하기 위한 xml 파일을 활용하지 않고 tomcat 자체의 설정을
                     // 활용해 로컬 환경에 업로드 된 파일을 가져올 수 있도록 설정합니다.
                     // server.xml 내, Context 태그를 통해 관련 설정을 추가합니다.
                     // 이때, reloadable 설정은 true 로 설정합니다.
                     // - <Context docBase="C:/upload" path="/upload" reloadable="true"/>
                     // Context.xml 내, allowCasualMultipartParsing="true" path="/" 설정
                     String path = "C:/upload/images";
                     
                     File tempFile = new File(path);
                     //해당 폴더 위치가 존재하지 않을 떄, 폴더를 생성한다.
                     if(!tempFile.exists()){
                        tempFile.mkdirs(); // 해당 위치에 폴더를 생성                        
                     }
                     
                     out.println("<h5 class='customer_text'>Result</h5>");
                     out.println("<p class='ddit_text'># 일반 데이터</p>");
                     
                     //request로 넘어온 파라미터의 key(input 요소의 name)들을 꺼낸다.
                     Enumeration<String> en = request.getParameterNames();
                     out.println("<table class='table table-bordered'>");
                     out.println("   <tr>");
                     out.println("        <th>Name</th>");
                     out.println("        <th>Value</th>");
                     out.println("   </tr>");
                     
                     //일반 데이터를 Enumeration 으로 꺼냈으니 아래에 출력
                     while(en.hasMoreElements()){
                        out.println("<tr>");
                        // nextElement() 메소드를 통해 key를 꺼낸다..
                        String key = en.nextElement();
                        out.println("   <td>");
                        out.println("      <p class='ddit_text'>"+key+"</p>");
                        out.println("   </td>");
                        out.println("   <td>");
                        out.println("      <p class='dditd_text'>"+
                                       request.getParameter(key)+"</p>");
                        out.println("   </td>");
                        out.println("</tr>");
                     }
                     out.println("</table>");
                     Collection<Part> collect = request.getParts();
                     Iterator<Part> ite = collect.iterator();
                     
                     out.println("<table class='table table-bordered'>");
                     out.println("   <tr>");
                     out.println("        <th>Name</th>");
                     out.println("        <th>Filename</th>");
                     out.println("        <th>Size</th>");
                     out.println("        <th>ContentType</th>");
                     out.println("        <th>파일확인</th>");
                     out.println("   </tr>");
                     
                     //iterator 의 ite 가 가진 데이터가 없을때까지 실행해 꺼낸다
                     while(ite.hasNext()){
                        Part part = ite.next();
                        String name = part.getName();
                        if(name.equals("filename")){
                           out.println("<tr>");
                           out.println("   <td>"+part.getName()+"</td>");
                           out.println("   <td>"+part.getSubmittedFileName()+"</td>");
                           out.println("   <td>"+part.getSize()+"</td>");
                           out.println("   <td>"+part.getContentType()+"</td>");
                           out.println("   <td>");
                           %>
                  <a class="ddit_btn ddit_btn_outline_primary"
                     href="/upload/<%=part.getSubmittedFileName()%>" target="_blank">파일 확인</a>
                           <%
                           out.println("   </td>");                           
                           out.println("</tr>");
                           
                           //파일 복사(C:/upload/images.jpg)
                           part.write(path + "/" + part.getSubmittedFileName());
                        }
                     }
                     out.println("</table>");
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