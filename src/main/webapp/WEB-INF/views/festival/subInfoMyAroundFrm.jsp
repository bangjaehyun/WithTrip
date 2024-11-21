<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>With Trip</title>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<style>
.content {
	height: 783px;
}

.subInfo-title {
	font-weight: bold;
	padding: 40px 30px 30px 30px;
	text-align: center;
	text-indent: 30px;
	font-family: ns-b;
	font-size: 25px;
	color: var(--main2);
}

.subInfo-wrap {
	padding: 30px;
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	width: 100%;
}

.subInfo-content {
	width: 100%;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	align-items: center;
}

.subInfo-content div {
	margin: 20px;
}

.image-box {
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	width: 530px;
	height: 300px;
	overflow: hidden;
}

.subInfo-img {
	width: 100%;
	height: auto;
	
}

.map-box {
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	width: 570px;
	height: 300px;
	z-index: 0;
}

.map-box div {
	padding: 0px;
	margin: 0px;
}

.description-box {
	width: 100%;
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

.info-box>table tr {
	border-top: 1px solid #b5b5b5;
}

.outline-box{
	margin : 0px;
	font-size: 25px;
	font-weight: bold;
}

</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section festival-section">
				<div class="subInfo-title">${info.myAroundTitle}</div>
				<div class="subInfo-wrap">
					<div class="subInfo-content">
						<div class="image-box">
							<c:choose>
								<c:when test="${not empty info.myAroundImg}">
									<img class="subInfo-img" src="${info.myAroundImg}" />
								</c:when>
								<c:otherwise>
									<img class="subInfo-img" src="/resources/images/withTrip_logo_v_04.png" />
								</c:otherwise>
							</c:choose>
						</div>
						<div class="map-box" id="map-box"></div>
						<div>
						<div class="outline-box">개요</div>
						<div class="description-box">${info.myAroundContent}</div>
						<div class="info-box">
							<table>
								<c:if test="${not empty info.myAroundZipCode}">
								<tr>
									<th>우편번호</th>
									<td>${info.myAroundZipCode}</td>
								</tr>
								</c:if>
								<c:if test="${not empty info.myAroundHomePage}">
								<tr>
									<th>홈페이지</th>
									<td>${info.myAroundHomePage}</td>
								</tr>
								</c:if>
								<c:if test="${not empty info.myAroundAddr}">
								<tr>
									<th>주소</th>
									<td>${info.myAroundAddr}</td>
								</tr>
								</c:if>
								<c:if test="${not empty info.myAroundTel}">
								<tr>
									<th>문의 및 안내</th>
									<td>${info.myAroundTel}</td>
								</tr>
								</c:if>
								<c:if test="${not empty info.myAroundCloseDay}">
								<tr>
									<th>쉬는날</th>
									<td>${info.myAroundCloseDay}</td>
								</tr>
								</c:if>
								<c:if test="${not empty info.myAroundTime}">
								<tr>
									<th>운영 시간</th>
									<td>${info.myAroundTime}</td>
								</tr>
								</c:if>
								<c:if test="${not empty info.myAroundPaking}">
								<tr>
									<th>주차 정보</th>
									<td>${info.myAroundPaking}</td>
								</tr>
								</c:if>
							</table>
						</div>
						</div>
					</div>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
		var mapContainer = document.getElementById('map-box'), // 지도를 표시할 div
	    	mapOption = { 
	           center: new kakao.maps.LatLng(${info.myAroundLat}, ${info.myAroundLng}), // 지도의 중심좌표
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
	        position:  new kakao.maps.LatLng(${info.myAroundLat}, ${info.myAroundLng}), // 마커를 표시할 위치
	        image : markerImage // 마커 이미지 
		});
	       
	</script>
</body>
</html>