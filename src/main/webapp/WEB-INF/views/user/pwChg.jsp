<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
.header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 74px;
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 10;
}
html, body {
	width: 100vw;
	height: 100vh;
	overflow: hidden;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
.wrap {
	margin-top: 74px;
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	height: 200px;
}
.item-wrap {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
}
.item-wrap > input:first-of-type {
	margin-top: 20px;
}
.item-wrap > input {
	margin: 10px 0;
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
	<div class="wrap">
	<jsp:include page="/WEB-INF/views/common/myPageHeader.jsp" />
			<form action="/user/pwChg" method="post">
			<input type="hidden" name="userNo" value="${loginUser.userNo}">
				<table>
					<tr>
						<td>기존 비밀번호 입력</td>
						<td><input type="password" id="userPw"></td>
					</tr>
					<tr>
						<td>새 비밀번호 입력</td>
						<td><input type="password" id="newUserPw"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" id="newUserPwChk"></td>
					<tr>
						<td><button type="button" onclick="chgPwBtn()" style="margin-left:30px; backgroung-color:">변경</button></td>
						<td><button type="button" onclick="closePop()" style="margin-left:50px">닫기</button></td>
					</tr>
				</table>
		</form>
	</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
		function closePop(){
			self.close();
		}
	</script>

</body>
</html>