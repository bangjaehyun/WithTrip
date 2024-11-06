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
			<form id="userPwChg" action="/user/pwChg" method="post">
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
						<td><button type="button" onclick="chgPwBtn()" style="margin-left:30px;">변경</button></td>
						<td><button type="button" onclick="closePop()" style="margin-left:50px;">닫기</button></td>
					</tr>
				</table>
		</form>
	</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
		function closePop(){
			self.close();
		}
		
			//결과값 true or false저장용 -> 마지막 submit용도
		const checkObj = {
				"userPw" 		: false,
				"newUserPw"		: false,
				"newUserPwChk"  : false
		}
		
		const userPwChk = $('#userPw');
		const newUserPw = $('#newUserPw');
		const newUserPwChk = $('#newUserPwChk');
		const regExp = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
		
		
		function chkPwBtn(){				
			//기존 비밀번호가 같은지
			if(loginUser.userPw == userPwChk.val()){
				checkObj.userPw = true;	
			}else{
				checkObj.userPw = false;
			}
			
			//새로 입력한 비밀번호가 패턴에 일치하는지
			if(regExp.test(newUserPw.val())){
				checkObj.newUserPw = true;
			}else{
				checkObj.newUserPw = false;
			}
			
			//새로 입력한 비밀번호와 비밀번호 체크가 일치하는지
			if(newUserPw.val() == newUserPwChk()){
				checkObj.newUserPwChk = true;
			}else{
				checkObj.newUserPwChk = false;
			}			
			
			let str = "";
			
			//비밀번호 변경할 때 입력이 올바르지 않은 경우
			for(let key in checkObj){
				if(!checkObj[key]){
					switch(key){
						case "userPwChk" 	: str = "기존 비밀번호가 일치하지 않습니다"; 												break;
						case "newUserPw" 	: str = "비밀번호 형식이 일치하지 않습니다. 영어 소문자, 대문자, 숫자, 특수기호를 포함한 8~16자리"; 	break;
						case "newUserPwChk" : str = "새로 입력한 비밀번호와 비밀번호 체크가 일치하지 않습니다"; 								break;
					}
					
					swal({
						title : "알림",
						text : str,
						icon : "error"
					});
					return false;
				}
			}
			
			//똑띠 입력한 경우
			swal({
				title : "알림",
				text : "비밀번호를 변경하시겠습니까?",
				icon : "success",
				buttons : {
					cancel :{
						text : "취소"
						value : false,
						visible : true,
						closeModal : true
					},
					confirm : {
						text : "변경",
						value : false,
						visible : true,
						closeModal : true
					}					
				}
			}).then(function(confirm){
				if(confirm){
					$('#userPwChg').submit();
				}
			});
		}
	</script>
</body>
</html>