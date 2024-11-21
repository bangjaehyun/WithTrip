<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<title>With Trip</title>
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
    border-radius: 8px;
}

h3 {
    color: #333;
    font-size: 1.8em;
    margin-bottom: 20px;
}

table {
    width: 100%;
    margin-bottom: 20px;
    border-spacing: 0;
    border-collapse: collapse;
}

td {
    padding: 10px 0;
    text-align: left;
    font-size: 1em;
}

input[type="text"],
input[type="password"] {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-top: 5px;
    font-size: 0.95em;
}

button {
    width: 100%;
    padding: 10px;
    margin-top: 15px;
    font-size: 1em;
    font-weight: bold;
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
    <div class="popup-container">
    <h3>비밀번호 변경</h3>
    <form action="/user/pwChg" id="pwChk" method="post">
    	<input type="hidden" name="userNo" value="${loginUser.userNo}">
		<input type="hidden" name="userPw" value="${loginUser.userPw}">
        <table>
            <tr>
                <td>기존 비밀번호 입력</td>
            </tr>
            <tr>
                <td><input type="password" id="userPwChk" name="userPwChk"></td>
            </tr>
            <tr>
                <td>새 비밀번호 입력</td>
            </tr>
            <tr>
                <td><input type="password" id="newUserPw" name="newUserPw"></td>
            </tr>
            <tr>
                <td>비밀번호 확인</td>
            </tr>
            <tr>
                <td><input type="password" id="newUserPwChk" name="newUserPwChk"></td>
            </tr>
        </table>
        <button type="button" onclick="chgPwBtn()">변경</button>
        <button type="button" class="cancel" onclick="closeBtn()">닫기</button>
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