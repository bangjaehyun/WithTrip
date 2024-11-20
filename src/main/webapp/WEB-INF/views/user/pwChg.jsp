<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<title>비밀번호 변경</title>
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
	<jsp:include page="/WEB-INF/views/common/myPageHeader.jsp" />
	<div class="wrap">
			<form action="/user/pwChg" id="pwChk" method="post">
			<input type="hidden" name="userNo" value="${loginUser.userNo}">
			<input type="hidden" name="userPw" value="${loginUser.userPw}">
				<table>
					<tr>
						<td>기존 비밀번호 입력</td>
						<td><input type="password" id="userPwChk" name="userPwChk"></td>
					</tr>
					<tr>
						<td>새 비밀번호 입력</td>
						<td><input type="password" id="newUserPw" name="newUserPw"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" id="newUserPwChk" name="newUserPwChk"></td>

				</table>
				<button type="button" onclick="chgPwBtn()" style="margin-left:30px;">변경</button>
				<button type="button" onclick="closeBtn()" style="margin-left:50px;">닫기</button>
			</form>
	</div>
	
	<script>
    function closeBtn() {
        window.self.close();
    }

    function chgPwBtn() {
        swal({
            title: "알림",
            text: "비밀번호를 변경하시겠습니까?",
            icon: "success",
            buttons: {
                cancel: {
                    text: "취소",
                    value: false,
                    visible: true,
                    closeModal: true
                },
                confirm: {
                    text: "변경",
                    value: true,
                    visible: true,
                    closeModal: true
                }
            }
        }).then(function(isConfirm) {
            if (isConfirm) {
                $.ajax({
                    url: "/user/pwChg",
                    type: "POST",
                    data: {
                        "userNo": "${loginUser.userNo}",
                        "userPw": "${loginUser.userPw}",
                        "userPwChk": $('#userPwChk').val(),
                        "newUserPw": $('#newUserPw').val(),
                        "newUserPwChk": $('#newUserPwChk').val()
                    },
                    success: function(res) {
                        if (res == "0") {
                            msg('알림', '비밀번호가 변경되었습니다. 다시 로그인해주세요', 'success');
                            window.self.close();
                            window.opener.location.href = "/";
                        } else if (res == "1") {
                            msg('알림', '기존 비밀번호가 일치하지 않습니다', 'error');
                        } else if (res == "2") {
                            msg('알림', '새로 입력한 비밀번호가 일치하지 않습니다', 'error');
                        } else if (res == "3") {
                            msg('알림', '비밀번호 변경 중 오류가 발생했습니다', 'error');
                        }
                    },
                    error: function() {
                        console.log("비밀번호 변경에서 ajax 오류");
                    }
                });
            }
        });
    }
</script>
</body>
</html>