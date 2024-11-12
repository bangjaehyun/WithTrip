<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WithTrip - 회원가입</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>



        
        
     
        




.join-container {
	
		width: 500px;
        max-width: 1400px;
        margin: 40px auto;
        flex: 1;
        border: 1px solid #d6d6d6;
        border-radius: 15px;
        position : relative;
        top : 100px;
        height: 700px;
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

.box.int_id {
    padding-right: 110px;
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

#btnJoin {
	width: 360px;
    padding: 10px;
    border : 1px solid white;
    border-radius: 10px;
    font-size: 16px;
    color: white;
    background-color : #004ca1;
    cursor: pointer;
}
#btnJoin:hover {
background-color :  #90cbfb;
}

#id {
	
	margin-bottom: 15px;
    width: 350px;
    
    font-size: 16px;
	border: 1px solid #d6d6d6;
}

#pswd1 {
	margin-bottom: 15px;
    width: 350px;
    
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#pswd2 {
	margin-bottom: 15px;
    width: 350px;
    
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#name{
	margin-bottom: 15px;
    width: 350px;
    
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#email {
	margin-bottom: 15px;
    width: 350px;
    
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#phoneNo {
	margin-bottom: 15px;
    width: 350px;
    
    font-size: 16px;
	border: 1px solid #d6d6d6;
}
#nickname {
	margin-bottom: 15px;
    width: 350px;
    
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
top: 110px;
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
                    <span class="box int_id">
                        <input type="text" id="id" class="int" maxlength="20">
                       <!-- <button type="button" id="nicknameDuplChkBtn" class="btn-primary">중복체크</button>  --> 
                    </span>
                    <span class="error_next_box"></span>
                </div>


                <!-- 비번 -->
                <div class= op>
                    <div class="join_title"><label for="pswd1">비밀번호</label>
                     </div>
                    <span class="box int_pass">
                        <input type="password" id="pswd1" class="int" maxlength="20"> <!-- type="password"으로 변경 -->
                        <span id="alertTxt">사용불가</span>
                    </span>
                    <span class="error_next_box"></span>
               
                </div>

                <!-- 비번확인 -->
                <div class= op>
                    <div class="join_title"><label for="pswd2">비밀번호 재확인</label>
                    </div>
                    <span class="box int_pass_check">
                        <input type="password" id="pswd2" class="int" maxlength="20"> <!-- type="password"으로 변경 -->
                    </span>
                    <span class="error_next_box"></span>
                </div>
                

                <!-- 이름 -->
                <div class= op>
                    <div class="join_title"><label for="name">이름</label>
                    </div>
                    <span class="box int_name">
                        <input type="text" id="name" class="int" maxlength="20">
                    </span>
                    <span class="error_next_box"></span>
                </div>
                

                <!-- 이메일 -->
                <div class= op>
                    <div class="join_title"><label for="email">본인확인 이메일</label>
                    </div>
                    <span class="box int_email">
                        <input type="email" id="email" class="int" maxlength="100">
                    </span>
                    <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
                </div>
                

                <!-- 휴대전화 -->
                <div class= op>
                    <div class="join_title"><label for="phoneNo">휴대전화</label>
                    </div>
                    <span class="box int_mobile">
                        <input type="tel" id="phoneNo" class="int" maxlength="16" placeholder="전화번호를 입력하세요.">
                    </span>
                    <span class="error_next_box"></span>
                </div>
                

                <!-- 닉네임 -->
                <div class= op>
                    <div class="join_title">
                        <label for="nickname">닉네임</label>
                     </div>
                    <span class="box int_nickname">
                        <input type="text" id="nickname" class="int" maxlength="20">
                  	<!-- <button type="button" id="nicknameDuplChkBtn" class="btn-primary">중복체크</button>  --> 
                      </span>
                    <span class="error_next_box"></span>
                </div>
               
                

                <!-- 회원가입 -->
                <div class="btn_area">
                    <button type="button" id="btnJoin">
                       가입하기
                    </button>
                </div>
			</form>
			</section>
			</main>
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div> 

        
        <script>
            /* 변수 선언 */
var id = document.querySelector('#id');
var pw1 = document.querySelector('#pswd1');
var pwMsg = document.querySelector('#alertTxt');
var pw2 = document.querySelector('#pswd2');
var userName = document.querySelector('#name');
var email = document.querySelector('#email');
var phoneNo = document.querySelector('#phoneNo');
var nickname = document.querySelector('#nickname');
var error = document.querySelectorAll('.error_next_box');
//var checkIdBtn = document.querySelector('#checkIdBtn'); // 아이디 중복 확인 버튼
//var checkNicknameBtn = document.querySelector('#checkNicknameBtn'); // 닉네임 중복 확인 버튼

/* 이벤트 핸들러 연결 */
id.addEventListener("focusout", checkId);
pw1.addEventListener("focusout", checkPw);
pw2.addEventListener("focusout", comparePw);
userName.addEventListener("focusout", checkName);
email.addEventListener("focusout", isEmailCorrect);
phoneNo.addEventListener("focusout", checkPhoneNum);
nickname.addEventListener("focusout", checkNickname);
//checkIdBtn.addEventListener("click", checkIdDuplicate); // 아이디 중복 확인 버튼 이벤트 연결
//checkNicknameBtn.addEventListener("click", checkNicknameDuplicate); // 닉네임 중복 확인 버튼 이벤트 연결

/* 콜백 함수 */

// 아이디 유효성 검사
function checkId() {
    var idPattern = /^[A-Za-z0-9_-]{5,20}$/;
    if(id.value === "") {
        error[0].innerHTML = "필수 정보입니다.";
        error[0].style.display = "block";
    } else if(!idPattern.test(id.value)) {
        error[0].innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
        error[0].style.display = "block";
    } else {
        error[0].innerHTML = "확인되었습니다.";
        error[0].style.color = "#0067a3";
        error[0].style.display = "block";
    }
}

// 비밀번호 유효성 검사
function checkPw() {
    var pwPattern = /^[a-zA-Z0-9~!@#$%^&*]{8,16}$/;
    if(pw1.value === "") {
        error[1].innerHTML = "필수 정보입니다.";
        error[1].style.display = "block";
    } else if(!pwPattern.test(pw1.value)) {
        error[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자(!,@,#,$,%,^,&,*)를 사용하세요.";
        pwMsg.innerHTML = "형식과 일치하지 않습니다.";
        error[1].style.display = "block";
        pwMsg.style.display = "block";
    } else {
        error[1].style.display = "none";
        pwMsg.innerHTML = "확인되었습니다.";
        pwMsg.style.display = "block";
        pwMsg.style.color = "#03c75a";
    }
}

// 비밀번호 재확인 검사
function comparePw() {
    if(pw2.value === pw1.value && pw2.value != "") {
        error[2].style.display = "none";
    } else {
        error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[2].style.display = "block";
    }
    if(pw2.value === "") {
        error[2].innerHTML = "필수 정보입니다.";
        error[2].style.display = "block";
    }
}

// 이름 유효성 검사
function checkName() {
    var namePattern = /^[가-힣A-Za-z]{2,20}$/;
    if(userName.value === "") {
        error[3].innerHTML = "필수 정보입니다.";
        error[3].style.display = "block";
    } else if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
        error[3].innerHTML = "2~20자리의 한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[3].style.display = "block";
    } else {
        error[3].style.display = "none";
    }
}

// 이메일 유효성 검사
function isEmailCorrect() {
    var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
    if(email.value === "") {
        error[4].innerHTML = "필수 정보입니다.";
        error[4].style.display = "block"; 
    } else if(!emailPattern.test(email.value)) {
        error[4].style.display = "block";
    } else {
        error[4].style.display = "none"; 
    }
}

// 전화번호 유효성 검사
function checkPhoneNum() {
    var isPhoneNum = /^(01[01679])([0-9]{3,4})([0-9]{4})$/;
    if(phoneNo.value === "") {
        error[5].innerHTML = "필수 정보입니다.";
        error[5].style.display = "block";
    } else if(!isPhoneNum.test(phoneNo.value)) {
        error[5].innerHTML = "형식에 맞지 않는 번호입니다.";
        error[5].style.display = "block";
    } else {
        error[5].style.display = "none";
    }
}


function checkNickname(){
    var nicknamePattern = /^[a-z가-힣0-9]{2,8}$/;
    if(nickname.value === "") {
        error[6].innerHTML = "필수 정보입니다.";
        error[6].style.display = "block";
    } else if(!nicknamePattern.test(nickname.value)) {
        error[6].style.display = "block";
    } else {
        error[6].style.display = "none";
    }
}


//아이디 중복 확인
function checkIdDuplicate() {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/check-id", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var response = JSON.parse(xhr.responseText);
            if (response.exists) {  // 중복 아이디일 때
                error[0].innerHTML = "이미 사용 중인 아이디입니다.";
                error[0].style.color = "red";
                error[0].style.display = "block";
            } else {  // 사용 가능한 아이디일 때
                error[0].innerHTML = "사용 가능한 아이디입니다.";
                error[0].style.color = "green";
                error[0].style.display = "block";
            }
        }
    };
    xhr.send(JSON.stringify({ id: id.value }));
}

// 닉네임 중복 확인
function checkNicknameDuplicate() {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/check-nickname", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var response = JSON.parse(xhr.responseText);
            if (response.exists) {  // 중복 닉네임일 때
                error[7].innerHTML = "이미 사용 중인 닉네임입니다.";
                error[7].style.color = "red";
                error[7].style.display = "block";
            } else {  // 사용 가능한 닉네임일 때
                error[7].innerHTML = "사용 가능한 닉네임입니다.";
                error[7].style.color = "green";
                error[7].style.display = "block";
            }
        }
    };
    xhr.send(JSON.stringify({ nickname: nickname.value }));
}
 
 
//가입하기 버튼 선택
 var joinBtn = document.querySelector('#btnJoin');

 // 클릭 이벤트 핸들러 추가
 joinBtn.addEventListener("click", function() {
     // 입력 검증 함수 실행
     checkId();
     checkPw();
     comparePw();
     checkName();
     isEmailCorrect();
     checkPhoneNum();
     checkNickname();
     
     console.log("!");
     
     // 입력값 검증 결과 확인
     var hasError = Array.from(document.querySelectorAll('.error_next_box')).some(function(item) {
         return item.style.display === "block";
     });

     if (!hasError) {
         // 모든 필드가 유효하다면, 서버에 Ajax 요청
         submitForm();
     } else {
         swal("모든 필드를 올바르게 입력해주세요.");
     }
 });

 
 
 
 
 
 // 서버에 회원가입 데이터를 Ajax로 전송하는 함수
 function submitForm() {
     // 폼 데이터 수집
     var formData = {
         id: document.querySelector('#id').value,
         password: document.querySelector('#pswd1').value,
         name: document.querySelector('#name').value,
         email: document.querySelector('#email').value,
         phoneNo: document.querySelector('#phoneNo').value,
         nickname: document.querySelector('#nickname').value
     };

     // Ajax 요청
     var xhr = new XMLHttpRequest();
     xhr.open("POST", "/user/join", true);
     xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

     xhr.onreadystatechange = function () {
         if (xhr.readyState === XMLHttpRequest.DONE) {
             if (xhr.status === 200) {
                 var response = JSON.parse(xhr.responseText);
                 if (response.success) {
                     swal("회원가입이 완료되었습니다.");
                     window.location.href = "#";  // 회원가입 완료 후 이동할 페이지
                 } else {
                	 swal("회원가입에 실패했습니다. 다시 시도해주세요.");
                 }
             } else {
            	 swal("서버 요청 중 오류가 발생했습니다.");
             }
         }
     };

     xhr.send(JSON.stringify(formData));
 }
 
 
 
        </script>
        
    </body>
</html>
