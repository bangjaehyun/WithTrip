<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<title>추가 정보 입력</title>
<style>
/* 레이아웃 틀 */
html {
    height: 100%;
}

body {
    margin: 0;
    height: 80%;
    background: #f5f6f7;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

#wrapper {
    position: relative;
    top : 10%;
    height: 50px;
}

#content {
   position: absolute;
    left: 50%;
    transform: translate(-50%);
    width: 460px;
    padding: 30px;
    border: 1px solid #333; /* 테두리 두께 조정 */
    background-color: #ffffff;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    border-radius: 8px; /* 모서리 둥글게 */
}


/* 입력폼 */

input:focus {
    outline: none;
}

h4 {
	text-align : center;
	font-size : 30px;
	
}

h3 {
    margin: 19px 0 8px;
    font-size: 14px;
    font-weight: 700;
}


.box {
    display: block;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: relative;
}

.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
}

input {
    font-family: Dotum,'돋움',Helvetica,sans-serif;    
}

.box.int_id {
    padding-right: 110px;
}

.box.int_pass {
    padding-right: 40px;
}

.box.int_pass_check {
    padding-right: 40px;
}

select {
    width: 100%;
    height: 29px;
    font-size: 15px;
    background: #fff 100% 50% no-repeat;
    background-size: 20px 8px;
    display: inline-block;
    text-align: start;
    border: none;
    cursor: default;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

/* 에러메세지 */

.error_next_box {
    margin-top: 9px;
    font-size: 12px;
    color: red;    
    display: none;
}

#alertTxt {
    position: absolute;
    top: 19px;
    right: 38px;
    font-size: 12px;
    color: red;
    display: none;
}



/*
#checkNicknameBtn {
    padding: 10px 15px;
    font-size: 14px;
    color: #fff;
    background-color: cornflowerblue;
    border: none;
    cursor: pointer;
}
*/



#btnJoin {
    width: 100%;
    padding: 21px 0 17px;
    border: 0;
    cursor: pointer;
    color: #fff;
    background-color: #90cbfb;
    font-size: 20px;
    font-weight: 400;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}
</style>
</head>
<body>
	<jsp:include page ="/WEB-INF/views/common/myPageHeader.jsp" />
        <div id="wrapper">        
            <div id="content">
					<h4>네이버 추가 정보 입력</h4>
                <form action="/user/naverAddInfo" method="post" id="naverAddInfo">
                
                <input type="hidden" name="userName" value="${loginUser.userName}">
                <input type="hidden" name="userEmail" value="${loginUser.userEmail}">
                <input type="hidden" name="userPhone" value="${loginUser.userPhone}">
                <div>
                    <h3 class="join_title">
                        <label for="id">아이디</label>
                    </h3>
                    <span class="box int_id">
                        <input type="text" id="id" class="int" maxlength="20">
                       <button type="button" id="nicknameDuplChkBtn" class="btn-primary">중복체크</button>
                    </span>
                    <span class="error_next_box"></span>
                </div>
                <div>
                    <h3 class="join_title">
                        <label for="nickname" id="nickname">닉네임</label>
                    </h3>
                    <span class="box int_nickname">
                        <input type="text" id="userNickname" name="userNickname" class="int" maxlength="20">
                  		<button type="button" id="nicknameChk" class="btn-primary">중복체크</button>
-                      </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- 회원가입 -->
                <div class="btn_area">
                    <button type="button" id="btnJoin" onclick="naverAddInfoBtn()">
                        <span>가입하기</span>
                    </button>
                </div>
			</form>
            </div> 
        </div>
<script>
//개인정보(닉네임 중복체크, 비밀번호) 번경 + 전화번호 변경
	const checkInfo = {
    			"userNickname" : false,
    			"userNicknameChk" : false,
    	}
    	
    	const regExp =  /^[a-z가-힣0-9]{2,8}$/;
    	
    	$('#nicknameChk').on('click', function(){
    		const nicknameValue = $('#userNickname').val();
    		
    		if(!regExp.test(nicknameValue)){
    			msg('알림', '영문 소문자, 한글, 숫자 포함 2~8글자로 입력해주세요', 'error');
    			return;
    		}else{
    			checkInfo.userNickname = true;
    		}
    			$.ajax({
    				url : "/chkNickname",
    				data : {"userNickname" : nicknameValue},
    				type : "GET",
    				success : function(res){
	    				if(res == 0){
	    					msg('알림', '사용 가능한 닉네임입니다', 'success');
		    				checkInfo.userNicknameChk = true; 				    					
	    				}else{
		    				msg('알림', '중복된 닉네임이 존재합니다', 'error');
		    				checkInfo.userNicknameChk = false;    						    					
	    				}	    				
    				},
    				error : function(){
    					console.log("ajax : 닉네임 중복체크 오류");
    				}
    			});   			
    	});

	function naverAddInfoBtn(){
		$('#naverAddInfo').submit();
	}
</script>
</body>
</html>