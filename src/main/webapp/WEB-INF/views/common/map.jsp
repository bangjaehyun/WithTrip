<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MAP</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/map.css" />
</head>
<body>
	<div class="map_wrap">
		<div id="map" style="width: 100%; height: 700px; overflow: hidden;"></div>
		<form onsubmit="searchPlaces(); return false;">
			<div id="searchBox">
				<input type="text" id="keyword" placeholder="지도 검색">
				<button id="searchBtn" type="submit">
					<img name="img" src="/resources/images/map_search.svg">
				</button>
				<button id="cancelBtn" type="button" onclick="cancel();">
					<img name="img" src="/resources/images/map_close.svg">
				</button>
			</div>
		</form>
		<button id="toggleListBtn" type="button" onclick="toggleList()"
			value="1"></button>
		<div id="menu_wrap" class="bg_white">
			<div class="option"></div>
			<div id="menu_container">
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
		</div>

		<div id="category">
			<div id="food" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_food.svg"> <span>음식점</span>
			</div>
			<div id="cafe" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_cafe.svg"> <span>카페</span>
			</div>
			<div id="bed" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_bed.svg"> <span>숙박</span>
			</div>
			<div id="flag" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_flag.svg"> <span>관광지</span>
			</div>
			<div id="store" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_store.svg"> <span>편의점</span>
			</div>
			<div id="pharmacy" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_pharmacy.svg"> <span>약국</span>
			</div>
			<div id="gas" onclick="srchCategory(this);">
				<img name="img" src="/resources/images/map_gas.svg"> <span>주유소</span>
			</div>
		</div>
	</div>
	<script src="/resources/js/map.js"></script>
</body>
</html>