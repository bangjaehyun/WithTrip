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
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f8f8;
        margin: 0;
    }

    #wrapper {
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    h4 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 18px;
    }

    .join_title {
        font-size: 14px;
        margin-bottom: 5px;
    }

    .box {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .int {
        width: calc(100% - 90px);
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .btn-primary {
        padding: 8px;
        background-color: #007bff;
        border: none;
        color: #fff;
        border-radius: 4px;
        cursor: pointer;
        margin-left: 8px;
    }

    .btn-primary:hover {
        background-color: #0056b3;
    }

    .btn_area button {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        border: none;
        color: #fff;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }

    .btn_area button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
	<jsp:include page ="/WEB-INF/views/common/myPageHeader.jsp" />
        <div id="wrapper">        
            <div id="content">
					<h4>네이버 추가 정보 입력</h4>
                <form action="/user/naverAddInfo" method="post" autocomplete="off" onsubmit="return joinValidate()">
                
                <input type="hidden" name="userName" value="${loginUser.userName}">
                <input type="hidden" name="userEmail" value="${loginUser.userEmail}">
                <input type="hidden" name="userPhone" value="${loginUser.userPhone}">
                <div>
                    <h3 class="join_title">
                        <label for="id">아이디</label>
                    </h3>
                    <span class="box int_id">
                        <input type="text" id="userId" name="userId" class="int" maxlength="20">
                       <button type="button" id="idChk" class="btn-primary">중복체크</button>
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
                    <button type="submit">회원가입</button>
                </div>
			</form>
            </div> 
        </div>
<script>
//개인정보(닉네임 중복체크, 비밀번호) 번경 + 전화번호 변경
	const checkInfo = {
		"id" : false,
		"idChk" : false,
   		"userNickname" : false,
   		"userNicknameChk" : false
   	}
   	
   	const regExpId = /^[a-zA-Z_]{6,10}$/;
   	const regExpNickname =  /^[a-z가-힣0-9]{2,8}$/;
   	
   	$('#idChk').on('click', function(){
   		const idVal = $('#userId').val();
   		
   		if(!regExpId.test(idVal)){
   			msg('알림', '영문 대소문자 _ 포함 6~20글자로 입력해주세요', 'error');
   			return;
   		}else{
   			checkInfo.id = true;
   		}
   		
   		$.ajax({
   			url : "/chkId",
   			data : {"userId" : idVal},
   			type : "GET",
   			success : function(res){
   				if(res == 0){
   					msg('알림', '사용 가능한 Id입니다', 'success');
   					checkInfo.idChk = true;
   				}else{
   					msg('알림', '중복된 Id입니다', 'error');
   					checkInfo.idChk = false;
   				}
   			},
   			error : function(){
   				console.log('id 중복체크 ajax 오류');
   			}
   		});
   	});
   	
   	$('#nicknameChk').on('click', function(){
   		const nicknameValue = $('#userNickname').val();
   		
   		if(!regExpNickname.test(nicknameValue)){
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

	function joinValidate(){
		let str = "";
		
		for(let key in checkInfo){
			if(!checkInfo[key]){
				switch(key){
					case "idChk" : str = "아이디 중복체크를 해주세요"; break;
					case "userNicknameChk" : str = "닉네임 중복체크를 해주세요"; break;
				}
				msg('알림', str, "error");
				return false;
			}
		}
		return true;
	}
</script>
</body>
</html>