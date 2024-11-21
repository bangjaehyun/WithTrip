<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="stylesheet" href="/resources/css/park.css" />
<style>
body{
	margin :0px;
	padding : 0px;
}

.logo-wrap {
	width : 480px;
	background-color: #004ca1;
}

.box{
	width : 100%;;
}

.logo-wrap{
	width: 100%;
}

.logo-wrap > img{
	margin-left : 10px;
	width: 150px;
}

.srch-info-wrap{
		height : 230px;
		display : flex;
		justify-content : center;
		align-content: center;
		gap : 20px;
}

.srch-info-wrap > div{
	display : flex;
	justify-content : center;
	height : 50px;
	width : 180px;
	background-color : var(--main2);
	border-radius : 10px;
	border: 1px solid var(--main2);
	margin : auto 0;
}

.srch-info-wrap > div a{
	margin : auto 0;
	color : white;
}


</style>
</head>
<body>
	<div class="box">
		<div class="logocls">
			<div class="logo-wrap">
				<img src="/resources/images/withTrip_logo_08.png">
			</div>
		</div>
		<div class="srch-info-wrap">
			<div class="findId">
				<a  href="javascript:void(0)" onclick="searchInfo('id')">아이디 찾기</a>
			</div>
			<div class="findPw">
				<a  href="javascript:void(0)" onclick="searchInfo('pw')">비밀번호 찾기</a>
			</div>
		</div>
	</div>
	<script>
	function searchInfo(gb){
		let popupWidth = 500;
		let popupHeight = 330;
		
		if(gb == 'pw'){
			popupHeight = 400;
		}
		console.log(popupHeight);
		
		window.resizeTo(popupWidth,popupHeight);
		location.href = "/user/searchInfoFrm?gb=" + gb;
	}
	</script>
</body>
</html>