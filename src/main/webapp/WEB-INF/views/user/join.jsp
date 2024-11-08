<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>회원가입</title>
    <style>
    	/* Main container */
main {
    display: flex;
    justify-content: center;
    align-items: center;
    height: calc(100vh - 70px); /* Adjusted for header height */
    background-color: #f0f0f0;
}

/* Form container */
form {
    width: 400px;
    padding: 20px;
    background-color: white;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Headline */
h1 {
    text-align: center;
    font-size: 24px;
    color: #333;
    margin-bottom: 20px;
}

/* Form field labels */
form label {
    font-size: 14px;
    color: #333;
    margin-bottom: 5px;
    display: block;
}

/* ID field and button alignment */
.id {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
}

.id input[type="text"] {
    flex: 1; /* Makes the input take available space */
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: center;
}

/* Phone field alignment */
.phone {
    display: flex;
    gap: 5px;
    margin-bottom: 15px;
}

.phone input[type="text"] {
    width: 30%; /* Each phone input takes a third of the width */
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: center;
}

/* Other form fields */
form input[type="text"],
form input[type="password"] {
    width: calc(100% - 10px);
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 15px;
}

/* Buttons */
input[type="button"] {
    padding: 10px 15px;
    font-size: 14px;
    color: white;
    background-color: cornflowerblue;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type="button"]:hover {
    background-color: cornflowerblue;
}

input[type="button"]:active {
    background-color: cornflowerblue;
}
    	
    </style>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
</head>
<body>
    <main>
	<div>
	
    	<div><h1>회원가입</h1></div>
        
        <form action="/user/join" method="post">
        	
            	<div class="id">
                	<label for="userid">아이디</label>
                    <input type="text" name="id" id="id" placeholder="8~12자리의 영대소문자,숫자만 가능">
                    <input type="button" value="ID 확인" onclick="checkId()" >
                </div>
					
                <div class="password">
                	<label for="userid">비밀번호</label>
                    <input type="password" name="pass" id="pass" placeholder=" 영문,숫자,특수문자(!, @, $, %, ^,&,*)를 포함하여 8~16자리 ">
                </div>   
                    
                <div class="passwordCheck">
                	<label for="userpasswordCheck">비밀번호 확인</label>
                    <input type="password" name="pass2" id="pass2" placeholder=" 영문,숫자,특수문자(!, @, $, %, ^,&,*)를 포함하여 8~16자리 ">
                </div>

                <div class="name">
                	<label for="username">이름</label>
                    <input type="text" name="name" id="name" placeholder="2~20자리의 영 대소문자, 한글만 가능">
                </div>
                    
                <div class="email">
                	<label for="useremail">이메일</label>
					<input type="text" name="email" id="email" >	
				</div>
							
                <div class="phone">
                	<label for="userphone">전화번호</label>
					 <input type="text" id="phone1" class="phone">-<input type="text" id="phone2" class="phone">-<input type="text" id="phone3" class="phone">
				</div>

                <div class="nickname">
                    <label for="usernickname">닉네임</label>
                    <input type="text" id="nickname" placeholder="한글,영소문자,숫자 2~8자리" >
                    <input type="button" value="닉네임 확인" onclick="checkNickname()">
                </div>
				
				<br>
				<div>
					<input type="button" value="회원가입" onclick="allCheck()"></a>
				</div>
			</form>
			<br>
			<br>
		</div>
		<script>
		var checkedId = '';
		var checkedName = '';
		var checkedEmail = '';
		var checkedPhone = '';
		var checkedNickname = '';

		window.onload = function () {
		    idText = document.getElementById('id');
		    passText = document.getElementById('pass');
		    pass2Text = document.getElementById('pass2');
		    nameText = document.getElementById('name');
		    emailText = document.getElementById('email');
		    phone1Text = document.getElementById('phone1');
		    phone2Text = document.getElementById('phone2');
		    phone3Text = document.getElementById('phone3');
		    nicknameText = document.getElementById('nickname');
		};

		// ID 형식 및 중복을 확인하는 기능
		function checkId() {
		    var id = idText.value;
		    var idReg = /^[A-Za-z0-9][A-Za-z0-9]{6,20}$/;
		    if (!idReg.test(id)) {
		        alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
		        checkedId = '';
		        return;
		    }

		    // AJAX로 아이디 중복체크
		    checkIdDuplicate(id).then((isDuplicate) => {
		        if (isDuplicate) {
		            alert("이미 사용 중인 아이디입니다.");
		            checkedId = '';
		        } else {
		            alert(id + "(은)는 사용 할 수 있는 아이디 입니다.");
		            checkedId = id;
		        }
		    });
		}

		
		function checkIdDuplicate(id) {
		    return new Promise((resolve) => {
		       
		        setTimeout(() => {
		            const isDuplicate = false; 
		            resolve(isDuplicate);
		        }, 500);
		    });
		}

		// 비밀번호 유효성 검사
		function checkPass() {
		    var pass = passText.value;
		    var pass2 = pass2Text.value;
		    var passReg = /^[A-Za-z][@$!%*#?&][A-Za-z\d!@#$%^&*]{8,16}$/;
		    if (!passReg.test(pass)) {
		        alert(" 영문,숫자,특수문자(!, @, $, %, ^,&,*)를 포함하여 8~16자리 ");
		        return false;
		    } else if (pass !== pass2) {
		        alert('비밀번호가 일치하지 않습니다.');
		        return false;
		    }
		    return true;
		}

		// 이름 유효성 검사
		function checkName() {
		    var name = nameText.value;
		    var nameReg = /^[가-힣A-Za-z]{2,20}$/;
		    if (!nameReg.test(name)) {
		        alert("올바른 성명을 입력하세요.");
		        checkedName = '';
		        return false;
		    } else {
		        checkedName = name;
		        return true;
		    }
		}

		// 메일 확인 기능
		function checkEmail() {
		    var email = emailText.value;
		    var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		    if (!emailReg.test(email)) {
		        alert("올바른 E-mail주소를 입력하세요.");
		        checkedEmail = '';
		        return false;
		    } else {
		        checkedEmail = email;
		        return true;
		    }
		}

		// 휴대폰번호 유효성 검사
		function checkPhone() {
		    var phone = phone1Text.value + '-' + phone2Text.value + '-' + phone3Text.value;
		    var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/;
		    if (!phoneReg.test(phone)) {
		        alert("올바른 휴대폰번호를 입력하세요.");
		        checkedPhone = '';
		        return false;
		    } else {
		        checkedPhone = phone;
		        return true;
		    }
		}

		// 닉네임 중복체크 및 확인 
		function checkNickname() {
		    var nickname = nicknameText.value;
		    var nicknameReg = /^[a-z가-힣0-9]{2,8}$/;
		    if (!nicknameReg.test(nickname)) {
		        alert("올바른 닉네임을 입력하세요.");
		        checkedNickname = '';
		        return false;
		    }

		    
		    checkNicknameDuplicate(nickname).then((isDuplicate) => {
		        if (isDuplicate) {
		            alert("이미 사용 중인 닉네임입니다.");
		            checkedNickname = '';
		        } else {
		            alert(nickname + "(은)는 사용 할 수 있는 닉네임입니다.");
		            checkedNickname = nickname;
		        }
		    });
		}

		
		function checkNicknameDuplicate(nickname) {
		    return new Promise((resolve) => {
		        
		        setTimeout(() => {
		            const isDuplicate = false; 
		            resolve(isDuplicate);
		        }, 500);
		    });
		}

		// 제출전 필드 확인
		function allCheck() {
		    if (!checkedId) {
		        alert('아이디 확인을 해주세요.');
		        return;
		    }
		    if (!checkPass()) return;
		    if (!checkName()) return;
		    if (!checkEmail()) return;
		    if (!checkPhone()) return;
		    if (!checkedNickname) {
		        alert('닉네임 확인을 해주세요.');
		        return;
		    }

		    alert(
		        '가입 정보\n\n' +
		        '아이디 : ' + checkedId +
		        '\n성명 : ' + checkedName +
		        '\n이메일 : ' + checkedEmail +
		        '\n휴대폰번호 : ' + checkedPhone +
		        '\n닉네임 : ' + checkedNickname +
		        '\n\n가입이 완료되었습니다.'
		    );
		}

		</script>
	</body>
</main>
</html>