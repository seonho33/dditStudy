<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/dist/js/adminlte.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(function(){
	bsCustomFileInput.init();
})


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

function DaumPostcode() {
    new kakao.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }


            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('memPostcode').value = data.zonecode;
            document.getElementById("memAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddress2").focus();
        }
    }).open();
}

</script>