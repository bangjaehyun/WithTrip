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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.festival-title {
	font-weight: bold;
	padding: 40px 30px 30px 30px;
	text-align: center;
	text-indent: 30px;
	font-family: ns-b;
	font-size: 25px;
	color: var(--main2);
}

.festival-wrap {
	padding: 30px;
	width: 1200px;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.festival-box {
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	margin: 15px;
	width: 265px;
	height: 200px;
	display: block;
	cursor: pointer;
}

.festival-img-box {
	width: 100%;
	height: 150px;
	overflow: hidden;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.festival-img {
	width: 100%;
	height: auto%;
}

.name-box {
	text-align: center;
	height: 50px;
}

.festival-name {
	display: block;
	padding: 10px;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}

#pagination button {
	border: none;
	outline: none;
	box-shadow: 1px 1px 3px -1px;
	border-radius: 10px;
	cursor: pointer;
	width: 50px;
	height: 25px;
	background: #e3e3e3;
	color: black;
}

#pagination {
	display: flex;
	justify-content: center;
}

#pagination li {
	text-align: center;
	width: 60px;
}

#pagination .active-page {
	background: #004ca1;
	color: white;
}

.mapOpen{
	color : white;
	font-size: 16px;
	border-radius: 10px;
	width: 100px;
	height: 45px;
	font-weight: bold;
	border: none;
	background: linear-gradient(to top, #5882FA, #004CA1);
}

body button:hover{
  transform: scale(1.1,1.1);
  box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
}

.map-box{
	padding-left: 100px;
	padding-right: 100px;
	text-align: right;
}

</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<section class="section">
				<div class="festival-title">내주변 관광정보</div>
				<div class="map-box">
					<button type="button" class="mapOpen" onclick="openMap()">지도 열기</button>
				</div>
				<div class="festival-wrap">
					<c:forEach var="festival" items="${list}" end="11">
						<c:choose>
						<c:when test='${not empty festival.festivalType and festival.festivalType eq "15"}'>
							<div class="festival-box" onClick="location.href ='/festival/subInfo?festivalId=${festival.festivalId}&festivalType=${festival.festivalType}'">
							<div class="festival-img-box">
								<img class="festival-img"
									src="${not empty festival.festivalImage ? festival.festivalImage : '/resources/images/withTrip_logo_v_04.png'}" />
							</div>
							<div class="name-box">
								<strong class="festival-name">${festival.festivalTitle}</strong>
							</div>
						</div>
						</c:when>
						<c:otherwise>
							<div class="festival-box" onClick="location.href ='/festival/subInfoType?festivalId=${festival.festivalId}&festivalType=${festival.festivalType}'">
							<div class="festival-img-box">
								<img class="festival-img"
									src="${not empty festival.festivalImage ? festival.festivalImage : '/resources/images/withTrip_logo_v_04.png'}" />
							</div>
							<div class="name-box">
								<strong class="festival-name">${festival.festivalTitle}</strong>
							</div>
							</div>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>
				</div>
				<div class="page-list">
					<ul id="pagination">
					</ul>
				</div>
			</section>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	const loadPages = 10;
	const itemCount = 12;
	
	$(document).ready(function(){
		createBtn();
	});
	
	function createBtn(){
		total = ${totalCount};
        totalPages = Math.ceil(total / itemCount);
        pageNo = ${pageNo};
        startPage = Math.floor((pageNo - 1) / loadPages) * loadPages + 1;
		endPage = Math.floor(((pageNo - 1) / loadPages) + 1) * loadPages;
		
		
		// 이전 버튼
		if (pageNo > 1) {
            $("#pagination").append(
                "<li><button onClick='prev();'>이전</button></li>"
            );
        } else {
            $("#pagination").append(
                "<li><button disabled>이전</button></li>"
            );
        }
		
		// 페이지 목록
		// 전체 페이지 수가 마지막 페이지 보다 작을 경우
		if (totalPages < endPage) {
			endPage = totalPages;
		}
		for (let i = startPage; i < endPage + 1; i++) {
			let activeClass = i == pageNo ? "active-page" : "";
            $("#pagination").append(
            	"<li><button id='pageBtn_" + i + "' class='" + activeClass + "' onClick='selectPage(" + i + ");'>" + i + "</button></li>"
            );
        }
		
		// 다음 버튼
        if (pageNo < totalPages) {
            $("#pagination").append(
                "<li><button onClick='next();'>다음</button></li>"
            );
        } else {
            $("#pagination").append(
                "<li><button disabled>다음</button></li>"
            );
        }
        updateButtonStyles();
	}
	
	function updateButtonStyles() {
        // 모든 지역 버튼 초기화
        $("#pagination button").css({
            "background": "#e3e3e3",
            "color": "black"
        });

        let areaCode = $('#areaCode').val();

        // 지역 버튼 강조
        if (!areaCode) {
            $("button:contains('전국')").css({
                "background": "#004ca1",
                "color": "white"
            });
        } else {
            $("button").each(function () {
                if ($(this).text() == getAreaName(areaCode)) {
                    $(this).css({
                        "background": "#004ca1",
                        "color": "white"
                    });
                }
            });
        }

        // 페이지 버튼 스타일 초기화
        $("#pagination button").css({
            "background": "#e3e3e3",
            "color": "black"
        });

        // 현재 페이지 버튼 강조
        $("#pageBtn_" + pageNo).css({
            "background": "#004ca1",
            "color": "white"
        });
    }
	
	// 이전 버튼 클릭 시, 실행 할 함수
	function prev() {
		 if (pageNo > 1) { 
		        pageNo--;
		        chgPages(pageNo);
		    }
	}
	// 다음 버튼 클릭 시, 실행 할 함수
	function next() {
		if (pageNo < totalPages) {
	        	pageNo++;
	        	chgPages(pageNo);
	    }
	}
	
	function selectPage(page) {
        pageNo = page; // 선택한 페이지 번호를 업데이트
        chgPages(pageNo); // 페이지 데이터 갱신
    }

	
	// 이전 또는 다음 버튼 클릭 시
	function chgPages(page) {
		location.href = "/festival/myAroundFrm?lat="+ ${lat} + "&lon=" + ${lon} + "&page="+page;
	}
	
	//지도 버튼 가져오기
	function openMap(){
		let popupWidth = 1550;
		let popupHeight = 720;
		
		let top = (window.innerHeight - popupHeight) / 2+ window.screenY;
		let left = (window.innerWidth - popupWidth) / 2+ window.screenX;
		window.open("/festival/openMap?lat="+${lat}+ "&lon="+ ${lon}  , "map", "width="+popupWidth+", height=" + popupHeight + ", top=" + top + ", left=" + left)
	}
	
	//자식객체에서 호출하여 현재 페이지 리로드
	function pageReLoad(lat, lon){
		location.href = "/festival/myAroundFrm?lat="+ lat + "&lon=" + lon + "&page=1";
	}
	
	
	
	
	</script>
</body>
</html>