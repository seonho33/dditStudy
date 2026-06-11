<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    <c:choose>
             <c:when test="${requestScope.cnt>0}">
                 {
                  	"flag" : "가입성공" 
                 } 
            </c:when> 
            
           <c:otherwise>
				{
					"flag" : "가입실패"
				}
            </c:otherwise>
    </c:choose>