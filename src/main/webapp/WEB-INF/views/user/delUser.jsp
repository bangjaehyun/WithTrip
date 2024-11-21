<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>With Trip</title>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<style>
body {
    font-family: Arial, sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    margin: 0;
    background-color: #f9f9f9;
}
.popup-container {
    width: 350px;
    border: 1px solid #ccc;
    padding: 20px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    background-color: #fff;
}
h3 {
    color: #333;
    font-size: 1.8em;
    margin-bottom: 20px;
}
table {
    width: 100%;
    margin-bottom: 20px;
}
td {
    padding: 8px 0;
    text-align: left;
    font-size: 1em;
}
input[type="text"], input[type="password"] {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
}
button {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    font-size: 1em;
    cursor: pointer;
    border: 1px solid #ccc;
    background-color: #0073e6;
    color: white;
    border-radius: 4px;
}
button:hover {
    background-color: #005bb5;
}
button.cancel {
    background-color: #ccc;
    color: #333;
}
button.cancel:hover {
    background-color: #999;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/myPageHeader.jsp" />
	<form action="/user/delUser" method="post" id="delUser">
		<h3>회원 탈퇴</h3>
		<input type="hidden" name="userNo" value="${loginUser.userNo}">
		<input type="hidden" name="userType" value="${loginUser.userType}">
		<c:choose>
		<c:when test="${loginUser.userType eq 5}">
	    <table>
	        <tr>
	            <td>아이디</td>
	            <td><input type="text" class="input-error" value="${loginUser.userId}" readonly></td>
	        </tr>
	        <tr>
	            <td>비밀번호</td>
	            <td><input type="password" id="pwChk" name="pwChk"></td>
	        </tr>
	        <tr>
	            <td colspan="2" style="text-align: center;">
	                <button type="button" onclick="delUserBtn()">회원탈퇴</button>
	                <button type="button" onclick="cancelBtn()">취소</button>
	            </td>
	        </tr>
	    </table>
	    </c:when>
	    <c:otherwise>
	    	<table>
	        <tr>
	            <td>이메일</td>
	            <td><input type="text" class="input-error" value="${loginUser.userEmail}" readonly></td>
	        </tr>
	        <tr>
	            <td colspan="2" style="text-align: center;">
	                <button type="button" onclick="delApiUserBtn()">회원탈퇴</button>
	                <button type="button" onclick="cancelBtn()">취소</button>
	            </td>
	        </tr>
	    </table>
	    </c:otherwise>
	    </c:choose>
	</form><!-- 탈퇴버튼 클릭시 조건이 성립하면 delUserServlet으로 이동해서 회원탈퇴 진행 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<script>
		//회원 삭제 버튼
		function delUserBtn(){
			swal({
				title : "알림",
				text : "정말 회원을 탈퇴하시겠습니까?",
				icon : "error",
				buttons : {
					cancel : {
						text : "취소",
						value : false,
						visible : true,
						closeModal : true
					},
					confirm : {
						text : "탈퇴",
						value : true,
						visible : true,
						closeModal : true
					}
				}
			}).then(function(isConfirm){
				if(isConfirm){
					$.ajax ({
						url : "/user/delUser",
						type : "post",
						data : {"userNo" : "${loginUser.userNo}", 
								"pwChk" : $('#pwChk').val()}, 
						success : function(res){
							console.log(res);
							if(res == "0"){
								msg('알림', '회원 탈퇴가 완료되었습니다', 'success', 'window.self.close();window.opener.location.href = "/";');
							}else{
								msg('알림', '회원 탈퇴중 오류가 발생했습니다', 'error');
							}												
						},
						error : function(){
							console.log("회원 탈퇴 ajax 오류");
						}
					});
				}
			});
		}
	
		//API로그인 유저 회원탈퇴
		function delApiUserBtn() {
			swal({
				title : "알림",
				text : "정말 회원을 탈퇴하시겠습니까?",
				icon : "error",
				buttons : {
					cancel : {
						text : "취소",
						value : false,
						visible : true,
						closeModal : true
					},
					confirm : {
						text : "탈퇴",
						value : true,
						visible : true,
						closeModal : true
					}
				}
			}).then(function(isConfirm){
				if(isConfirm){
					$.ajax ({
						url : "/user/delApiUser",
						type : "post",
						data : {
							"userNo" : "${loginUser.userNo}"
							},
						success : function(res){
							if(res == "0"){
								msg('알림', '회원 탈퇴가 완료되었습니다', 'success');
								window.self.close(); 
								window.opener.location.href="/";
							}else{
								msg('알림', '회원 탈퇴중 오류가 발생했습니다', 'error');
							}
						},
						error : function(){
							console.log("회원 탈퇴 ajax 오류");
						}
					});
				}
			});
		}
		
		//회원 삭제 윈도우 창 나가기
		function cancelBtn(){
			self.close();
		}
	</script>
</body>
</html>