<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main map</title>
<%-- API 불러오는 script --%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/map.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="content">
		<section class="section">
		<div class="page-title">MAP</div>
			<div class="map_wrap">
				<div id="map" style="width: 100%; height: 600px; overflow: hidden;"></div>
				<form onsubmit="searchPlaces(); return false;">
					<div id="searchBox">
						<input type="text" id="keyword" placeholder="지도 검색">
						<button id="searchBtn" onclick="#">
							<img name="img" src="/resources/images/search.svg">
						</button>
						<button id="cancelBtn" type="button" onclick="cancel();">
							<img name="img" src="/resources/images/close.svg">
						</button>
					</div>
				</form>
				<button id="toggleListBtn" type="button" onclick="toggleList()"
					value="1">숨기기!</button>
				<div id="menu_wrap" class="bg_white">
					<div class="option"></div>
					<div id="menu_container">
						<ul id="placesList"></ul>
						<div id="pagination"></div>
					</div>
				</div>

				<div id="category">
					<div id="food" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/food.svg"> <span>음식점</span>
					</div>
					<div id="cafe" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/cafe.svg"> <span>카페</span>
					</div>
					<div id="bed" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/bed.svg"> <span>숙박</span>
					</div>
					<div id="flag" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/flag.svg"> <span>관광지</span>
					</div>
					<div id="store" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/store.svg"> <span>편의점</span>
					</div>
					<div id="pharmacy" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/pharmacy.svg"> <span>약국</span>
					</div>
					<div id="gas" onclick="srchCategory(this);">
						<img name="img" src="/resources/images/gas.svg"> <span>주유소</span>
					</div>
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		// 마커를 담을 배열입니다
		var markers = [];
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			// 지도의 중심좌표
			center : new kakao.maps.LatLng(37.4985356559091, 127.032615540333),
			// 지도의 확대 레벨
			level : 4
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(map);
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

		    var keyword = document.getElementById('keyword').value;

		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }

		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB, {useMapBounds:true}); 
		    $("#menu_wrap").show();
		    $("#toggleListBtn").show();
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);

		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);

		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		        alert('검색 결과가 존재하지 않습니다.');
		        return;

		    } else if (status === kakao.maps.services.Status.ERROR) {

		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {

		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {

		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });

		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });

		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };

		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);

		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;

		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		   // map.setBounds(bounds);
		}
		
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h3>' + places.place_name + '</h3>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }

	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
	</script>

	<script>
	// 취소 버튼을 눌렀을 때
	function cancel(){
		var keyword = document.getElementById('keyword');
		keyword.value = "";
		
		// 마커를 지워주는 함수
		removeMarker();
		// 리스트를 숨겨주는 함수
		$("#menu_wrap").hide();
		$("#toggleListBtn").hide();
		
	}
	
	// 카테고리를 눌렀을 때
	function srchCategory(element){
		// span 내부 텍스트를 input.value로 넣어주고, searchPlaces() 실행
		const spanText = $(element).find("span").text();
		keyword.value = spanText;
		$("#searchBox").show();
		searchPlaces();
	}
	
	function toggleList() {
	    if ($("#toggleListBtn").val() > 0) {
	        $("#toggleListBtn").val("0");
	    	$("#toggleListBtn").text("보기!");
	        $("#menu_wrap").hide();
	        $("#searchBox").hide();
	        $("#toggleListBtn").css("transform", "translateX(-330px)");
	    } else {
	    	$("#toggleListBtn").val("1");
	    	$("#toggleListBtn").text("숨기기!");
	    	$("#menu_wrap").show();
		    $("#searchBox").show();
	        $("#toggleListBtn").css("transform", "translateX(0px)");
	    }
	}
	</script>
</body>
</html>