<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>With Trip</title>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<style>
.map-wrap{
	position: relative;
	display: flex;
	z-index: 0;
}
#map{
	width: 1550px;
	height: 720px;
	position: absolute;
	z-index: 1;
}

#confirmBtn{
	width : 50px;
	height : 30px;
	top : 10px;
	right : 20px;
	position: absolute;
	z-index: 2;
}

</style>
</head>
<body>
	<div id="map-wrap">
	<div id="map"></div>
	<button id="confirmBtn" onclick="confrim()">
				<div id="confirmTxt">확인</div>
			</button>
	</div>
</body>
<script>
let lat = ${lat};
let lon = ${lon};

$(document).ready(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(${lat}, ${lon}), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	//지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	// 지도 중심좌표에 마커를 생성합니다 
	position: map.getCenter() 
	}); 
	//지도에 마커를 표시합니다
	marker.setMap(map);

	//지도에 클릭 이벤트를 등록합니다
	//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        

	// 클릭한 위도, 경도 정보를 가져옵니다 
	var latlng = mouseEvent.latLng; 

	// 마커 위치를 클릭한 위치로 옮깁니다
	marker.setPosition(latlng);

	lat = latlng.getLat();
	lon = latlng.getLng();
	});
});

//부모객체에 위도 경도 넘겨서 페이지 리로드 시키기 위함
function confrim(){
	window.opener.pageReLoad(lat,lon);
	self.close(); 
}

</script>
</html>