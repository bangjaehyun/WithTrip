<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<style>

.logo1 {
 	background-color : #004ca1;
 	margin-bottom : 10px;
}

.logocls {	 
	 margin-top : -10px;
	 margin-left : -10px;
	 margin-right : -10px;
	 	
	 text-align: center;
}
.page-title {
	font-size:30px;
	margin-bottom: 10px;	
}
.input-title {
	font-size:20px;
	text-align: center;
}
.input-item {
	margin-bottom : 5px;
	text-align: center;
}
.btn-wrap{
	text-align: center;
	
}
#userEmail {
	width : 200px;
}
#userId {
	width : 200px;
}
.input-wrap {
	height : 50px;
}
[class^="btn-"].md {
  	padding: 5px 10px;
  	font-size: 14px; 
}
.input-item1 {
	height : 20px;
	text-align : center;
}
.btn-wrap {
	margin-top : 10px;
}
.btn-primary {
	width: 100px;
	border: none;
	background-color : #004ca1;
	border-radius: 4px;
	color: white;
	cursor: pointer;
}

</style>
</head>
<body>
	<div class="wrap">
		<main class="content srch-Info-container">
			<section class="section">
				<div class= "logocls">
					<div class="logo1"><a href="/"><img src="/resources/images/withTrip_logo_08.png" width="200px" height="70px"></a></div>
				</div>
				
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
							<div class="input-item1">
								<input type="text" id="userId" name="userId">
							</div>
						</div>
					</c:if>

					<div class="btn-wrap">
						<div>
							<button type="button" onclick="srchInfo('${gb}')"
								class="btn-primary md">찾기</button>
						
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
			let link = ''; //서블릿 URL
			let param = {}; //전송 데이터

			if (userEmail.val().length < 1) {
				msg('알림', '이메일이 입력되지 않았습니다.', 'warning');
				return;
			}

			param.userEmail = userEmail.val();

			if (gb == 'id') {
				link = '/user/srchInfoId';

			} else if (gb == 'pw') {
				link = '/user/srchInfoPw';
				param.userEmail = userEmail.val();

				let userId = $('#userId'); ///비밀번호 찾기의 경우 아이디 입력이 필요함

				if (userId.val().length < 1) {
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

					if (gb == 'id') {
						if (res == '') {
							msg('알림', '일치하는 회원이 존재하지 않습니다.', 'warning',
									'closeFn()');
						} else {
							msg('알림', '아이디 찾기 결과 : ' + res, 'success',
									'closeFn()');
						}
					} else if (gb == 'pw') {
						console.log(res);

						if (res == "0") {
							msg('알림', '생성된 임시 비밀번호가 입력하신 이메일로 전송되었습니다.','success', 'closeFn()');
						} else if (res == "1") {
							msg('알림', '비밀번호 찾기 중, 오류가 발생했습니다.', 'warning');		//오류발생!!!!
						} else if (res == "2") {
							msg('알림', '입력하신 정보와 일치하는 회원 정보가 존재하지 않습니다.','warning');
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
			swal({
				title : title,
				text : text,
				icon : icon
			}).then(function() {
				if (callback != null && callback != '') {
					eval(callback);
				}
			});
		}
	</script>

</body>
</html>