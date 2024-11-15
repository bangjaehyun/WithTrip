<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip - Festival Info</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<style>
.content {
	height: 783px;
}

.subInfo_title {
	font-weight: bold;
	padding: 40px 30px 30px 30px;
	text-align: center;
	text-indent: 30px;
	font-family: ns-b;
	font-size: 25px;
	color: var(--main2);
}

.subInfo_wrap {
	padding: 30px;
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	width: 1200px;
	margin: 0 auto;
}

.subInfo_content {
	width: 100%;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	align-items: center;
}

.subInfo_content div {
	margin: 20px;
}

.image_box {
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	background: url(${info.festivalImg}) no-repeat;
	background-size: cover;
	background-position: center;
	width: 600px;
	height: 300px;
}

.map_box {
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	width: 500px;
	height: 300px;
}

.map_box div {
	padding: 0px;
	margin: 0px;
}

.description_box {
	width: 600px;
}

tr {
	height: 30px;
}

th {
	background: #dbdbdb;
	width: 120px;
}

td {
	width: 380px;
	border-bottom: 1px solid #b5b5b5;
	font-size: 14px;
}

.info_box>table tr {
	border-top: 1px solid #b5b5b5;
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section festival_section">
				<div class="subInfo_title">축제 정보</div>
				<div class="subInfo_wrap">
					<div class="subInfo_content">
						<div class="image_box"></div>
						<div class="map_box" id="map_box"></div>
						<div class="info_box">
							<table>
								<tr>
									<th>이름</th>
									<td>${info.festivalTitle}</td>
								</tr>
								<tr>
									<th>행사일</th>
									<td>${info.festivalStartDay}~${info.festivalEndDay}</td>
								</tr>
								<tr>
									<th>공연시간</th>
									<td>${info.festivalTime}</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>${info.festivalTel}</td>
								</tr>
								<tr>
									<th>홈페이지</th>
									<td>${info.festivalHomepage}</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>${info.festivalAddr}</td>
								</tr>
							</table>
						</div>
						<div class="description_box">${info.festivalContent}</div>
					</div>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
		
		var mapContainer = document.getElementById('map_box'), // 지도를 표시할 div
	    	mapOption = { 
	           center: new kakao.maps.LatLng(${info.festivalLat}, ${info.festivalLng}), // 지도의 중심좌표
	           level: 4 // 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35); 
		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		
		// 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	    	map: map, // 마커를 표시할 지도
	        position:  new kakao.maps.LatLng(${info.festivalLat}, ${info.festivalLng}), // 마커를 표시할 위치
	        image : markerImage // 마커 이미지 
		});
	       
	</script>
</body>
</html>