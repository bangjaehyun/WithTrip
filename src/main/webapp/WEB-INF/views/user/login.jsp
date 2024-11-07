<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" href="/resources/css/loginPage.css"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="wrap-login">
        <h3>로그인</h3>
        <form action="#" method="post">
            <label for="loginId">아이디</label>
            <input type="text" id="loginId" name="loginId"><br>
            <label for="loginPw">비밀번호</label>
            <input type="password" id="loginPw" name="loginPw">
            <input type="button" onclick="loginBtn()" value="로그인">
        </form>
        <div class="item">
            <div id="saveIdBox">
                <input type="checkbox" id="saveIdChkbox">
                <label for="saveId" id="saveId">아이디 저장</label>
            </div>
            <div id="info">
                <a href="#">회원가입</a> &nbsp; | &nbsp;
                <a href="#">정보찾기</a>
            </div>
        </div>
        <div class="social-login">
            <h6>소셜계정으로 로그인</h6>
            <div class="social-login-icon">
                <button type="button" onclick="kakaoLoginBtn()" id="kakaoLogin">
                    <img src="/resources/images/KakaoTalk_Icon_fix.png">
                </button>
                <button type="button" onclick="naverLoginBtn()" id="naverLogin">
                    <img src="/resources/images/Naver_Icon.png">
                </button>
            </div>
        </div>
    </div>
<script>
	
</script>
</body>
</html>