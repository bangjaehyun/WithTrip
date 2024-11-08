<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like Frm</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/map.css" />
<style>
.content {
	positon: relative;
	display: flex;
	width: 1430px;
}

#map_window {
	padding: 0;
	margin: 0;
	width: 1200px;
	height: 700px;
}

#like_wrap {
	position: absolute;
	height: 690px;
	width: 220px;
	padding: 5px;
	left: 1208px;
	z-index: 2;
	font-size: 12px;
	display: inline-block;
	border: 1px solid black;
	border-radius: 10px;
}
</style>
</head>
<body>
	<main class="content">
		<div id="map_window">
			<jsp:include page="/WEB-INF/views/common/map.jsp" />
		</div>
		<div id="like_wrap">
			<div id="like_container">
				<ul id="likeList"></ul>
			</div>
		</div>
	</main>

	<script>
		
	</script>
</body>
</html>