<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resource/js/sweetalert.min.js"></script>
<style>

section.section {
  padding: 20px;
  border-radius: 10px; 
  background-color: var(--gray8);
}

[class^="btn-"] { 
  cursor: pointer; 
  font-size: 14px;
  padding: 9px 20px;
  border: none;
  border-radius: 5px;
  font-family: ns-b;
}

.btn-primary {
  border: 1px solid var(--main3);
  background-color: var(--main3);
  color: var(--gray8);
}

.btn-primary:hover {
  background-color: rgba(101, 146, 254, 0.9);
}

[class^="btn-"].md {
  padding: 7px 15px;
  font-size: 14px;
  border-radius: 20px;
}

.wrap {
	min-width :  400px;
	min-height :  300px;
}
.srch-Info-container {
	display : flex;
	align-items : center;
}
.srch-info-wrap {
	width : 80%; 
}
.section {
	width : 400px;
	margin : 0 auto;
}
.btn-wrap {
	display : flex;
	align-itmes :  center;
	justify-content : center;
	gap : 10px;
}

</style>
</head>
<body>
	<div class="wrap">
		<main class="content srch-Info-container">
			<section class="section">
				<div class="srch-info-wrap">
					<c:if test="${gb eq 'id'}">
						<div class="page-title">아이디 찾기</div>
					</c:if>
					<c:if test="${gb eq 'pw'}">
						<div class="page-title">비밀번호 찾기</div>
					</c:if>
					
						<div class="input-wrap">
							<div class="input-title">
								<label class="input-title">이메일 입력</label>
							</div>
							<div class="input-item">
								<input type="email" id="userEmail" name="userEmail">
							</div>
						</div>
						<c:if test="${gb eq 'pw'}">
						<div class="input-wrap">
							<div class="input-title">
								<label for="userId">아이디 입력</label>
							</div>
							<div class="input-item">
								<input type="text" id="userId" name="userId">
							</div>
						</div>
						</c:if>
						
						<div class="btn-wrap">
							<div>
								<button type="button" onclick="srchInfo('${gb}')" class="btn-primary md">찾기</button>
							</div>
							<div>
								<button type="button" onclick="closeFn()" class="btn-primary md">닫기</button>
							</div>
						</div>
				</div>
			</section>
		</main>
	</div>
	<script>
	function srchInfo(gb) {
		let userEmail = $('#userEmail');
		let link = '';	//서블릿 URL
		let param = {};	//전송 데이터
		
		if(userEmail.val().length < 1) {
			msg('알림', '이메일이 입력되지 않았습니다.', 'warning');
			return;
		}

		param.userEmail = userEmail.val();
		
		if(gb == 'id') {
			link = '/user/srchInfoId';
			
		} else if (gb == 'pw') {
			link = '/user/srchInfoPw';
			param.userEmail = userEmail.val();
			
			let userId = $('#userId');	///비밀번호 찾기의 경우 아이디 입력이 필요함
			
			if(userId.val().length < 1) {
				msg('알림', '아이디가 입력되지 않았습니다.', 'warning');
				return;
			}
			param.userId = userId.val();
		} else {
			msg('알림', '구분값이 입력되지 않았습니다.', 'warning');
			return;
		}
		
		$.ajax({
			url : link,
			data : param,
			type : "GET",
			success : function(res) {
				
				if(gb == 'id') {				
					if(res == '') {
						msg ('알림', '일치하는 회원이 존재하지 않습니다.', 'warning', 'closeFn()');
					} else {
						msg ('알림', '아이디 찾기 결과 : ' + res, 'success', 'closeFn()');
					}
				} else if(gb == 'pw'){
					console.log(res);
					
					if (res == "0") {
						msg('알림', '생성된 임시 비밀번호가 입력하신 이메일로 전송되었습니다.', 'success', 'closeFn()');
					} else if (res == "1") {
						msg('알림', '비밀번호 찾기 중, 오류가 발생했습니다.', 'warning');
					} else if (res == "2") {
						msg('알림', '입력하신 정보와 일치하는 회원 정보가 존재하지 않습니다.', 'warning');
					}
				}
				
			},
			error : function() {
				console.log('ajax 오류');
			}
		});
		
	}
	function closeFn() {
		self.close();
	}
	function msg(title, text, icon, callback) {
		swal ({
			title : title,
			text : text,
			icon : icon
		}).then(function () {
			if(callback != null && callback != ''){
				eval(callback);
			}
		});
	}
	</script>
	
</body>
</html>