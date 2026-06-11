<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
    
   <c:choose>
      <c:when test="${requestScope.result > 0 }">
         {
     		 "flag" : "ok"
   		 }
      </c:when>
    
      <c:otherwise>
          {
      		"flag" : "no"
    	  }
      </c:otherwise>
   </c:choose> 
    
<%-- <%
//contrller에서 저장한 결과값 꺼내기 
int res= (Integer)request.getAttribute("result");

if(res> 0 ){
%>
    {
      "flag" : "ok"
    }
	
<% }else{ %>
  
    {
      "flag" : "no"
    }
<%	
}
%> --%>