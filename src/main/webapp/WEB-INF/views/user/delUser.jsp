<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    font-family: Arial, sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    margin: 0;
}
.popup-container {
    width: 400px;
    border: 1px solid #ccc;
    padding: 20px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
}
legend {
    font-size: 1.5em;
    font-weight: bold;
}
table {
    width: 100%;
    margin-top: 10px;
}
td {
    padding: 8px;
    text-align: left;
    font-size: 1em;
}
input[type="text"], input[type="password"] {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
}
.input-error {
    border: 1px solid black;
}
button {
    padding: 8px 16px;
    margin: 5px;
    font-size: 1em;
    cursor: pointer;
    border: 1px solid #ccc;
    background-color: #fff;
}
button:hover {
    background-color: #f0f0f0;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/myPageHeader.jsp" />
	<form action="/user/delUser" method="post" id="delUser">
		<legend>회원 탈퇴</legend>
		<input type="hidden" name="userNo" value="${loginUser.userNo}">
	    <table>
	        <tr>
	            <td>아이디</td>
	            <td><input type="text" class="input-error" value="${loginUser.userId}" readonly></td>
	        </tr>
	        <tr>
	            <td>비밀번호</td>
	            <td><input type="password" id="pwChk"></td>
	        </tr>
	        <tr>
	            <td colspan="2" style="text-align: center;">
	                <button onclick="delUserBtn()">회원탈퇴</button>
	                <button onclick="cancelBtn()">취소</button>
	            </td>
	        </tr>
	    </table>
	</form><!-- 탈퇴버튼 클릭시 조건이 성립하면 delUserServlet으로 이동해서 회원탈퇴 진행 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<script>
		//회원 삭제 버튼
		function delUserBtn(){
			let pwChk = $('#pwChk');
			//let userPw = '${loginUser.userPw}'; <- 로그인 전에 쓰면 오류생겨서 막아놨어요
			
			if(pwChk.val() == userPw){
				$('#delUser').submit();
			}else{
				msg('알림', '비밀번호가 일치하지 않습니다', 'warning');
				return;
			}
		}
		
		//회원 삭제 윈도우 창 나가기
		function cancelBtn(){
			self.close();
		}
	</script>
</body>
</html>