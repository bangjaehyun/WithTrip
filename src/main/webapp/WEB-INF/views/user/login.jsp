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
<title>WithTrip</title>

<style>
/* 전체 레이아웃을 중앙 정렬 */
.wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 20px;
    height: 100%;
    background-color: #f5f5f5;
    position: relative;
    left:450px;
}

.login-container {
    width: 350px;
    padding: 50px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 제목 스타일 */
.page-title {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}

/* 입력 폼 스타일 */
.input-wrap {
    margin-bottom: 15px;
}

.input-title label {
    font-size: 14px;
    color: #555;
}

.input-item input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    color: #333;
    box-sizing: border-box;
}

/* 로그인 버튼 스타일 */
.login-button-box {
    text-align: center;
    margin-top: 15px;
}

.btn-primary {
    width: 100%;
    padding: 10px;
    background-color: #e0e0e0;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    color: #333;
    cursor: pointer;
}

.btn-primary:hover {
    background-color: #d0d0d0;
}

/* 아이디 저장 체크박스 스타일 */
.input-wrap input[type="checkbox"] {
    margin-right: 5px;
}

.input-wrap label {
    font-size: 14px;
    color: #555;
}

/* 회원가입, 아이디/비밀번호 찾기 링크 */
.user-link-box {
    text-align: center;
    margin-top: 15px;
    font-size: 14px;
}

.user-link-box a {
    color: #555;
    text-decoration: none;
    margin: 0 5px;
}

.user-link-box a:hover {
    color: #333;
}

/* 소셜 로그인 섹션 스타일 */
.social-login {
    text-align: center;
    margin-top: 20px;
}

.social-login h6 {
    font-size: 14px;
    color: #555;
    margin-bottom: 10px;
}

.social-login-icon {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.social-login-icon button {
    background-color: transparent;
    border: none;
    cursor: pointer;
}

.social-login-icon img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
}

</style>
</head>
<body>
	<jsp:include page ="/WEB-INF/views/common/header.jsp" />
	<div class="wrap">
        <main class="content login-container">
            <section class="section login-wrap">
                <div class="page-title">로그인</div>
                <form action="/user/login" method="post" autocomplete="off" onsubmit="return loginValidate()">
                <div class="input-wrap">
                    <div class="input-title">
                        <label for="loginId">아이디</label>
                    </div>
                    <div class="input-item">
                    
                        <input type="text" id="loginId" name="loginId" value="${cookie.saveId.value}">
                    </div>
                </div>
                <div class="input-wrap">
                    <div class="input-title">
                        <label for="loginPw">비밀번호</label>
                    </div>
                    <div class="input-item">
                        <input type="password" id="loginPw" name="loginPw">
                    </div>
                </div>
                <div class="input-wrap">
                <c:if test="${empty cookie.saveId.value }">
                    <input type="checkbox" name="saveId" id="saveId" value="chk">					
                </c:if>
                <c:if test="${!empty cookie.saveId.value }">
                    <input type="checkbox" name="saveId" id="saveId" value="chk" checked>					
                </c:if>
                    <label for="saveId">아이디 저장</label>
                </div>
                                
                <div class="login-button-box">
                    <button type="submit" class="btn-primary lg" onclick="loginBtn()"> 로그인</button>
                </div>
                <div class="user-link-box">
                    <a href="/user/joinFrm">회원가입</a> |
                    <a href="#">아이디 찾기</a> |
                    <a href="#">비밀번호 찾기</a>
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
<script>
	function kakaoLoginBtn(){
		let popupWidth = 500;
		let popupHeight = 800;
		
		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;
		
		
		window.open("/user/kakaoLoginFrm", "kakaoLogin", "width="+popupWidth+", top="+top+", height="+popupHeight+", left="+left);
	}
	
	
	
	
	// JavaScript 코드
		window.onload = function () {
	    const loginIdInput = document.getElementById('loginId');
	    const loginPwInput = document.getElementById('loginPw');
	    const saveIdChkbox = document.getElementById('saveIdChkbox');

	    // 페이지 로드 시, 저장된 아이디가 있다면 표시
	    if (localStorage.getItem('savedLoginId')) {
	        loginIdInput.value = localStorage.getItem('savedLoginId');
	        saveIdChkbox.checked = true;
	    }

	    // 로그인 버튼 클릭 이벤트
	    document.querySelector(".login-button-box>button").onclick = function() {
	        loginBtn();
	    };
	};

	// 로그인 버튼 클릭 시 호출되는 함수
	
		function loginBtn() {
	    const loginId = document.getElementById('loginId').value;
	    const loginPw = document.getElementById('loginPw').value;
	    const saveId = document.getElementById('saveId').checked;

	    // 아이디와 비밀번호 입력 확인
	    if (loginId == '') {
	        swal('아이디를 입력해주세요.');
	        return;
	    }
	    if (loginPw == '') {
	        swal('비밀번호를 입력해주세요.');
	        return;
	    }
	    
	    $('form').submit();
	}

	/*
	// 카카오 로그인 버튼 클릭 시 호출되는 함수 (추가적인 구현 필요)
	function kakaoLoginBtn() {
	    alert('카카오 로그인 기능은 현재 준비 중입니다.');
	}
	*/
	
</script>
</form>
</section>
</main>
</div>
</body>
</html>