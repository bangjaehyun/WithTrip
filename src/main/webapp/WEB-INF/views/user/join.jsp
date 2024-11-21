<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>With Trip</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>




#idDuplChkBtn {
  border : 1px solid white;
  border-radius: 10px;
  color: white;
  cursor: pointer; 
  font-size: 14px;
  padding: 9px 10px;
  background-color : #004ca1;
}
#idDuplChkBtn:hover {
background-color :  #90cbfb;
}

#nicknameChk {
  border : 1px solid white;
  border-radius: 10px;
  color: white;
  cursor: pointer; 
  font-size: 14px;
  padding: 9px 10px;
  background-color : #004ca1;
}

#nicknameChk:hover {
background-color :  #90cbfb;
}

.join-container {
	width: 550px;
    max-width: 1400px;
    margin: 40px auto;
    flex: 1;
    border: 1px solid #d6d6d6;
    border-radius: 15px;
    position : relative;
    top : 30px;
    height: 800px;
    background-color : white;
}


.joingo {
	font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
    width: 500px;
    color: #004ca1;
    position : relative;
    top : 40px;
    left : 35px;
}

#joinfm {
	position: relative;
	top : 30px;
}

.error_next_box {
    margin-top: -10px;
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



.box.int_pass {
    padding-right: 40px;
}

.box.int_pass_check {
    padding-right: 40px;
}

.btn_area {
	text-align: center;
    margin-top: 15px;
}

.btnJoin {
	width: 360px;
    padding: 10px;
    border : 1px solid white;
    border-radius: 10px;
    font-size: 16px;
    color: white;
    background-color : #004ca1;
    cursor: pointer;
}
.btnJoin:hover {
background-color :  #90cbfb;
}

p{
margin-bottom : 10px;
}

#userId {
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}

#userPw {
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#userPw2 {
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#userName{
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#userEmail {
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#userPhone {
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#userNickname {
    width: 350px;
    height : 30px;
    font-size: 16px;
	border: 1px solid #d6d6d6;
}

.op {
position : relative;
left : 70px;

}

div#wrapper {
height : 900px;
background-color: #efefef;
}
.footer{
position : relative;

}



</style>
    </head>
    <body>
        <jsp:include page ="/WEB-INF/views/common/header.jsp" />
        <div id="wrapper">
            <main class="section join-wrap">
            	<section class="join-container">
				<div class="joingo">회원가입 </div>
                <form action="/user/join" method="post" id="joinfm">
                <div class= op>
                    <div class="join_title">
                        <label for="id">아이디</label>
                    </div>
                    <div class="box int_id">
                        <input type="text" id="userId" name="userId" class="int" maxlength="20">
                    	<button type="button" id="idDuplChkBtn" class="btn-primary">중복체크</button>
                    </div>
                    <p id="idMessage" class="input-msg"></p>                  
                    <div class="error_next_box"></div>
                </div>


                <!-- 비번 -->
                <div class= op>
                    <div class="join_title"><label for="pswd1">비밀번호</label>
                     </div>
                    <div class="box int_pass">
                        <input type="password" id="userPw" name= "userPw" class="int" maxlength="20"> <!-- type="password"으로 변경 -->
                        <span id="alertTxt">사용불가</span>
                    </div>
                    <p id="pwMessage" class="input-msg"></p> 
                    <div class="error_next_box"></div>
               
                </div>

                <!-- 비번확인 -->
                <div class= op>
                    <div class="join_title"><label for="pswd2">비밀번호 재확인</label>
                    </div>
                    <div class="box int_pass_check">
                        <input type="password" id="userPw2" name="userPw2" class="int" maxlength="20"> <!-- type="password"으로 변경 -->
                    </div>
                    <p id="pw2Message" class="input-msg"></p> 
                    <div class="error_next_box"></div>
                </div>
                

                <!-- 이름 -->
                <div class= op>
                    <div class="join_title"><label for="name">이름</label>
                    </div>
                    <div class="box int_name">
                        <input type="text" id="userName" name="userName" class="int" maxlength="20">
                    </div>
                    <p id="nameMessage" class="input-msg"></p> 
                    <div class="error_next_box"></div>
                </div>
                

                <!-- 이메일 -->
                <div class= op>
                    <div class="join_title"><label for="email">본인확인 이메일</label>
                    </div>
                    <div class="box int_email">
                        <input type="email" id="userEmail" name="userEmail" class="int" maxlength="100">
                    </div>
                    <p id="emailMessage" class="input-msg"></p> 
                    <div class="error_next_box">이메일 주소를 다시 확인해주세요.</div>
                </div>
                

                <!-- 휴대전화 -->
                <div class= op>
                    <div class="join_title"><label for="phoneNo">휴대전화</label>
                    </div>
                    <div class="box int_mobile">
                        <input type="tel" id="userPhone" name="userPhone" class="int" maxlength="16" >
                    </div>
                    <p id="phoneMessage" class="input-msg"></p> 
                    <div class="error_next_box"></div>
                </div>
                

                <!-- 닉네임 -->
                <div class= op>
                    <div class="join_title">
                        <label for="nickname">닉네임</label>
                     </div>
                    <div class="box int_nickname">
                        <input type="text" id="userNickname" name="userNickname" class="int" maxlength="20">
                        <button type="button" id="nicknameChk" class="btn-primary">중복체크</button>
                      </div>
                      <p id="nicknameMessage" class="input-msg"></p>                    
                    <div class="error_next_box"></div>
                </div>
               
                

                <!-- 회원가입 -->
                <div class="btn_area">
                    <button type="submit" class="btnJoin">
                       가입하기
                    </button>
                </div>
			</form>
			</section>
			</main>
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div> 

        
<script>

	//submit 동작 시, 아래 객체 모든 속성에 대해 값이 true인지 검사 (유효성 검사 결과 저장할 객체)
	const checkObj = {
			"userId"					: false,
			"idDuplChkBtn"  			: false,
			"userPw"					: false,
			"userPw2"					: false,
			"userName"					: false,
			"userEmail"					: false,
			"userPhone"					: false,
			"userNickname"				: false,	
			"nicknameChk" 				: false
	};
 
	const userId = $("#userId");
	const idMessage = $("#idMessage");
 	//한글자 입력할때마다 동작
	userId.on('input', function() {
		checkObj.idDuplChkBtn = false;  //아이디를 수정하면 중복체크 다시 하게 false
		
		idMessage.removeClass('valid');
		idMessage.removeClass('invalid');
		
		const regExp = /^[A-Za-z0-9_-]{5,20}$/;
		if(regExp.test($(this).val())) {
			idMessage.html("아이디 중복체크를 해주세요.");
			idMessage.addClass('valid');
			idMessage.css("color", "red");
			checkObj.userId = true;
		}else{
			idMessage.html("영대소문자,특수문자(_-),숫자 포함 5~20자리");
			idMessage.addClass('invalid');
			idMessage.css("color", "red");
			checkObj.userId = false;
		}
	});
 	
 	
 	//아이디 중복체크
 	$('#idDuplChkBtn').on('click', function() {
 		if(!checkObj.userId) {
 			msg("알림", "유효한 아이디를 입력한 후, 중복체크를 진행하세요.", "error");
			return false;
 		}
 		
 		$.ajax({
			url : "/idDuplChk",
			data : {"userId" : userId.val()},
			type : "GET",
			success : function(res){
				//console.log(res);
				if(res == 0) {
					//중복된 아이디가 없음 == 회원가입 가능
					idMessage.html("사용가능한 아이디 입니다.");
					idMessage.css("color","green");
					msg("알림", "사용가능한 아이디 입니다.", "success");
					checkObj.idDuplChk = true;
				} else {
					msg("알림", "중복된 아이디가 존재합니다.", "warning");
					checkObj.idDuplChk = false;	//아이디 중복체크 결과 저장
				}
			},
			error : function(){
				console.log("ajax 오류 발생");
			}
		});
	});
 	
 	
 	const userPw = $("#userPw");	
	const pwMessage = $("#pwMessage");	
	
	userPw.on('input', function() {
		
				
		pwMessage.removeClass('valid');
		pwMessage.removeClass('invalid');
		
		const regExp = /^[a-zA-Z0-9~!@#$%^&*]{8,16}$/;
		
		if(regExp.test($(this).val())){
			checkObj.userPw = true;
			//비밀번호 값이 정규표현식 패턴에 만족할 때, 비밀번호 확인 입력값이, 입력되었는지를 조건식에 작성
			if($(userPw2).val().length < 1) {
				//비밀번호는 정상입력한 상태 && 비밀번호 확인값은 입력되지 않은 상태
				pwMessage.html("");
				pwMessage.addClass("valid");
				
			} else {
				//비밀번호 정상 입력 && 비밀번호 확인값도 입력된 상태
				checkPw();
			}
			pwMessage.html("사용가능한 비밀번호입니다.");
			pwMessage.addClass("valid");
			pwMessage.css("color", "green");
		} else {
			pwMessage.html("비밀번호 형식이 유효하지 않습니다.");
			pwMessage.addClass("invalid");
			pwMessage.css("color", "red");
			checkObj.userPw = false;
		}
	
	});
 	
	const userPw2 = $('#userPw2');
	const pw2Message = $('#pw2Message');
	userPw2.on('input', checkPw);	//아래 작성한 이벤트 핸들러 함수를 이벤트와 연결
	
	//이벤트핸들러 함수
	function checkPw() {
		//비밀번호와 비밀번호 확인 값 결과 표시할 p태그 공용 사용
		pw2Message.removeClass('valid');
		pw2Message.removeClass('invalid');
		
		if(userPw2.val() == userPw.val()) {
			//비밀번호값 == 비밀번호 확인 값
			pw2Message.addClass('valid');
			pw2Message.html("비밀번호가 일치합니다.");
			pw2Message.css("color", "green");
			checkObj.userPw2 = true;
		} else {
			pw2Message.addClass('invalid');
			pw2Message.html("비밀번호가 일치하지 않습니다.");
			pw2Message.css("color", "red");
			checkObj.userPw2 = false;
		}
	};
	
 	//이름 유효성 검사
	const userName = $('#userName');
	const nameMessage = $('#nameMessage');
	
	userName.on('input', function() {
		nameMessage.removeClass('valid');
		nameMessage.removeClass('invalid');
	
		const regExp = /^[가-힣A-Za-z]{2,20}$/;
		
		if(regExp.test($(this).val())) {
			nameMessage.addClass('valid');
			nameMessage.html("");
			nameMessage.css("color", "green");
			checkObj.userName = true;
		}else {
			nameMessage.addClass('invalid');
			nameMessage.html("이름 형식이 유효하지 않습니다.");
			nameMessage.css("color", "red");
			checkObj.userName = false;
			
		}
	});
	
	//이메일 유효성 검사
	const userEmail = $('#userEmail');
	const emailMessage = $('#emailMessage');
	
	userEmail.on('input', function() {
		emailMessage.removeClass('valid');
		emailMessage.removeClass('invalid');
		
		const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{3}$/;
		
		if(regExp.test($(this).val())) {
			emailMessage.addClass('valid');
			emailMessage.html("확인되었습니다.");
			emailMessage.css("color", "green");
			checkObj.userEmail = true;
		}else {
			emailMessage.addClass('invalid');
			emailMessage.html("이메일 형식이 유효하지 않습니다.");
			emailMessage.css("color", "red");
			checkObj.userEmail = false;
		}
	});
	
	
	//전화번호 유효성 검사
	const userPhone = $('#userPhone');
	const phoneMessage =$('#phoneMessage');
	
	userPhone.on('input', function() {
		phoneMessage.removeClass('valid');
		phoneMessage.removeClass('invalid');
		
		const regExp = /^(01[01679])([0-9]{3,4})([0-9]{4})$/;
		
		if(regExp.test($(this).val())) {
			phoneMessage.addClass('valid');
			phoneMessage.html(" ");
			checkObj.userPhone = true;
		} else {
			phoneMessage.addClass('invalid');
			phoneMessage.html("전화번호 형식이 유효하지 않습니다.");
			phoneMessage.css("color", "red")
			checkObj.userPhone = false;
		}
	});
	
	
	//닉네임 유효성 검사
	const userNickname = $('#userNickname');
	const nicknameMessage = $('#nicknameMessage');
	
	userNickname.on('input', function() {
		nicknameMessage.removeClass('valid');
		nicknameMessage.removeClass('invalid');
		
		const regExp = /^[a-z가-힣0-9]{2,8}$/;
		
		if(regExp.test($(this).val())) {
			nicknameMessage.addClass('valid');
			nicknameMessage.html("닉네임 중복체크를 해주세요.");
			nicknameMessage.css("color","red");
			checkObj.userNickname = true;
		}else{
			nicknameMessage.addClass('invalid');
			nicknameMessage.html("닉네임 형식이 유효하지 않습니다.");
			nicknameMessage.css("color","red");
			checkObj.userNickname = false;
		}
	});
	
	
	//닉네임 중복체크
 	$('#nicknameChk').on('click', function() {
 		if(!checkObj.userNickname) {
 			msg("알림", "유효한 닉네임을 입력한 후, 중복체크를 진행하세요.", "error");
			return false;
 		}
 		
 		$.ajax({
			url : "/chkNickname",
			data : {"userNickname" : userNickname.val()},
			type : "GET",
			success : function(res){
				//console.log(res);
				if(res == 0) {
					//중복된 닉네임이 없음 == 회원가입 가능
					msg("알림", "사용가능한 닉네임 입니다.", "success");
					nicknameMessage.html("사용가능한 닉네임 입니다.");
					nicknameMessage.css("color","green");
					checkObj.userNickname = true;
				} else {
					msg("알림", "중복된 닉네임이 존재합니다.", "warning");
					checkObj.userNickname = false;	//닉네임 중복체크 결과 저장
				}
			},
			error : function(){
				console.log("ajax 오류 발생");
			}
		});
	});
	
	
 	function joinValidate() {
		//입력값들이 전부다 입력되었는지 확인하고 상태에 따라 submit을 할지말지 정해야함
		//각 입력값마다 boolean 형태로 객체를 만들어주고 정상입력이 아닐땐 false로
		
		let str = "";
		
		for(let key in checkObj) {
		
			
			
			//console.log('key : ' + checkObj[key]);
			/*
			각 입력값의 유효성 검사 결과를 저장하고 있는 객체의, 현재 값이 false일 때
			*/
			if(!checkObj[key]) {	
				switch(key) {
					case "userId"				: str = "아이디 형식"; 					break;
					case "idDuplChk"			: str = "아이디 중복 체크를 진행하세요"; 		break;
					case "userPw"				: str = "비밀번호 형식";					break;
					case "userPw2"				: str = "비밀번호 확인 형식";				break;
					case "userName"				: str = "이름 형식";						break;
					case "userEmail"			: str = "이메일 형식";						break;
					case "userPhone"			: str = "전화번호 형식";					break;
					case "userNickname"			: str = "닉네임 형식";						break;
				}
			
			if(key != "idDuplChk") {
				str += "이 유효하지 않습니다.";
			}
				
				//하나의 함수지만 객체 형태로 전달
				msg("회원가입 실패", str, "warning");
				
				return false;	//submit을 막아주기 위함				
			}
			
			if(key != "nicknameChk") {
				str += "이 유효하지 않습니다.";
			}
			
				msg("회원가입 실패", str, "warning");
				
				return false;
		}
				
		//전부 정상적으로 입력했을 때 -> 정상 submit이 동작하게끔
		return true;
	};
	

	
	
	
	
	
	
        </script>
        
    </body>
</html>
