<%@page import="kr.or.iei.user.model.vo.ApiInfo"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	//API 요청 시, 각 클라이언트 식별값";
	String clientId = ApiInfo.nClientId;
	
	//인코딩 : URL 정보(문자)가 원하는 형태로 요청되지 않을 수 있으므로 UTF-8이라는 인코딩 방식으로 변환하여 요청
	String redirectURI = URLEncoder.encode("http://localhost:80/user/naverLoginFrm", "UTF-8");
	
	//Random 클래스 -> SecureRandom을 사용 하는 이유 : Random은 의사 난수(내부 알고리즘을 통해, 만들어낸 임의의 난수)
	SecureRandom random = new SecureRandom();
	
	String state = new BigInteger(130, random).toString();
			
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	apiURL += "&client_id=" + clientId;
	apiURL += "&redirect_uri=" + redirectURI;
	apiURL += "&state=" + state;
	session.setAttribute("state", state);
%>
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
                
                    <a href="<%=apiURL%>">
                    <button type="button" id="naverLogin"><img src="/resources/images/Naver_Icon.png">
                    </button>
                    </a>
                
            </div>
        </div>
    </div>
<script>
	function kakaoLoginBtn(){
		let popupWidth = 500;
		let popupHeight = 800;
		
		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;
		
		
		window.open("/user/kakaoLoginFrm", "kakaoLogin", "width="+popupWidth+", top="+top+", height="+popupHeight+", left="+left);
	}
</script>
</body>
</html>