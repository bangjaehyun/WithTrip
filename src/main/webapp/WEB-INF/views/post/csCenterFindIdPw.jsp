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
	background-color: #004ca1;
}

.logo-wrap {
	width : 480px;
}

.box{
	width : 100%;;
}

.logo-wrap{
	text-align : center;
	width: 100%;
}

.logo-wrap > img{
	width: 200px;
}

.srch-info-wrap{
		height : 100px;
		display : flex;
		justify-content : center;
		gap : 20px;
}

.srch-info-wrap > a{
	align-content : center;
	text-align : center;
	height : 40px;
	width : 180px;
	background-color : white;
	border-radius : 10px;
	margin : auto 0;
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
				<a class="findId" href="javascript:void(0)" onclick="searchInfo('id')">아이디 찾기</a>
				<a class="findPw"  href="javascript:void(0)" onclick="searchInfo('pw')">비밀번호 찾기</a>
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