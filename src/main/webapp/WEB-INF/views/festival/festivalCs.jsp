<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css;" />
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>
@media screen and (max-width: 1500px) {
  .list-side {
    display: none;
  }
}
.post-list-wrap {
	width : 1400px;
	margin : 0 auto;
}
.list-content {
	width: 1400px;
	height : 800px;
	justify-content: center;
	padding-right : 20px;
	/*justify-items : center;
	align-items : center;
	align-content : center;*/
}
.list-side {
	height : 200px;
	position : sticky;
	top : 225px;
	left : 100px;
}
.side-menu-title {
	width : 180px;
	padding : 7px 0px;
	text-align : left;
	font-weight : bold;
	font-size : 20px;
	border-bottom: 3px solid var(--main2);
}

#arrow_outward {
	width: 17px;
	height: 17px;
}
.siteNotice {
	justify-content: center;
	align-content: cetner;
}
.siteNotice > * {
	font-size : 14px;
}
	
</style>
</head>
<body>
<div class="wrap">
		<jsp:include page = "/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="post-list-wrap">
			<div class="page-title"></div>
			
				<div class="list-body">
					<div class="list-side">
						<ul class="side-menu-title">
							<li>고객센터</li>						
						</ul>
						<ul class="side-menu">						
							<li><a href="/festival/cityPage" >도시</a></li>                          
	                        <li><a href="/festival/temaPageFrm?pageNo=1&temaName=C0112"" >테마</a></li>
	                        <li><a href='javascript:void(0)' onclick="myAround()" >내주변 관광</a></li>
	                        <li><a href="/festival/mainPage?searchType=1" >축제</a></li>  
						</ul>
					</div>		
			        <div class="list-content">
			            <div class="siteIntro-header">			            	
			            	<img src="/resources/images/withTrip_logo_v_04.png" id="siteIntro-header">
			                <h4>여행을 내곁에</h4>
			                <p></p>
			            </div>
			            <div class="siteIntro-txt">
			                <h3>추천여행</h3>
			                <p>나에게 맞는 여행은 무엇일까? 어디로 떠나야할지 고민이라면 도시, 다양한 테마와 내주변 추천 여행 정보를 확인해 보세요. </p>
			            </div>
			            <div class="siteIntro-body">
			                <div class="siteInfoFlipCard">
			                    <div class="flip-card-inner">
			                        <div class="flip-card-front">
			                            <h4>도시</h4>
			                            <img src="/resources/images/city_Seoul_02.jpg" class="flipCardImg">
			                        </div>
			                        <div class="flip-card-back">
			                            <div class="flip-card-back-title">
			                                <h4>도시</h4>
			                            </div>
			                            <div class="flip-card-back-body">
			                                <p>서울부터 부산, 제주도까지</p>
			                                <p>우리나라 주요도시의</p>
			                                <p>관광명소, 맛집 등을 소개합니다</p>
			                            </div>
			                            <div class="flip-card-back-bottom">
			                                <a href="/festival/cityPage">바로가기
			                               		<img src="/resources/images/arrow_outward_black.png" id="arrow_outward">
			                               	</a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="siteInfoFlipCard">
			                    <div class="flip-card-inner">
			                        <div class="flip-card-front">
			                            <h4>테마</h4>		
			                            <img src="/resources/images/theme_01.jpg" class="flipCardImg">
			                        </div>
			                        <div class="flip-card-back">
			                            <div class="flip-card-back-title">
			                                <h4>테마</h4>
			                            </div>
			                            <div class="flip-card-back-body">
			                                <p>가족여행, 커플여행, 힐링 여행부터</p>
			                                <p>식도락 여행, 액티비티 여행 등</p>
			                                <p>다양한 테마의 여행정보를 확인하고</p>
			                                <p>특별한 나만의 여행을 계획해보세요</p>
			                            </div>
			                            <div class="flip-card-back-bottom">
			                                <a href="/festival/temaPageFrm?pageNo=1&temaName=C0112"">바로가기
			                                	<img src="/resources/images/arrow_outward_black.png" id="arrow_outward">
			                                </a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                 <div class="siteInfoFlipCard">
			                    <div class="flip-card-inner">
			                        <div class="flip-card-front">
			                            <h4>축제</h4>
			                            <img src="/resources/images/myAround.png" class="flipCardImg">
			                        </div>
			                        <div class="flip-card-back">
			                            <div class="flip-card-back-title">
			                                <h4>내주변 관광정보</h4>
			                            </div>
			                            <div class="flip-card-back-body">
			                                <p>상징적인 관광명소까지 가까운 곳</p>
			                                <p>먼 곳에서 놀라운 경험을 발견하고</p>
			                                <p>다음 여행을 계획하세요.</p>
			                            </div>
			                            <div class="flip-card-back-bottom">
			                                <a href='javascript:void(0)' onclick="myAround()">바로가기
			                                	<img src="/resources/images/arrow_outward_black.png" id="arrow_outward">
			                                </a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="siteInfoFlipCard">
			                    <div class="flip-card-inner">
			                        <div class="flip-card-front">
			                            <h4>축제</h4>
			                            <img src="/resources/images/festival.jpg" class="flipCardImg">
			                        </div>
			                        <div class="flip-card-back">
			                            <div class="flip-card-back-title">
			                                <h4>축제</h4>
			                            </div>
			                            <div class="flip-card-back-body">
			                                <p>전국 방방곡곡에서 열리는</p>
			                                <p>축제 정보를 소개합니다.</p>
			                                <p>전국의 다채로운 축제와 함께</p>
			                                <p>행복하고 즐거운 여행 되세요!</p>
			                            </div>
			                            <div class="flip-card-back-bottom">
			                                <a href='/festival/mainPage?searchType=1'>바로가기
			                                	<img src="/resources/images/arrow_outward_black.png" id="arrow_outward">
			                                </a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
				</div>
			</section>
		</main>
	</div>
	<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
	<script>
	function myAround(){
	       navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError);
	       }
	   
	   
	   function onGeoSuccess(position) {
	        const lat = position.coords.latitude; // 위도
	        const lon = position.coords.longitude; // 경도
	        console.log(lat);
	        console.log(lon);
	        location.href = "/festival/myAroundFrm?lat="+ lat + "&lon=" + lon + "&page=1";
	        
	    }

	    function onGeoError() {
	        msg("알림", "위치를 허용을 차단하였습니다. 브라우저 설정에서 변경하여 주시기 바랍니다.", "warning");
	    }
	</script>
</body>
</html>