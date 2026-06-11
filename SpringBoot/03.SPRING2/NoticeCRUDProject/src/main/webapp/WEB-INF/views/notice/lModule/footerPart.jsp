<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/dist/js/adminlte.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">

<c:if test="${not empty message }">
	Swal.fire({
		title : "${message }",
		icon : "success",
		draggable : true
	});
	<c:remove var="message" scope="request"/>
	<c:remove var="message" scope="session"/>
</c:if>
function sweetAlert(type, msg){
	Swal.fire({
		title : msg,
		icon : type,
		draggable : true		
	});
}

</script>