<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css;" />
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>
	.post-list-wrap {
		width : 1200px;
		margin : 0 auto;
	}
	.list-content {
		width: 1000px;
		height : 2000px;
		justify-content: center;
		padding-right : 20px;
		/*justify-items : center;
		align-items : center;
		align-content : center;*/
	}
	.list-side {
		height : 200px;
		position : sticky;
		top : 80px;
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
							<li><a href="/post/list?reqPage=1&postTypeCd=1&postTypeNm=1" >공지사항</a></li>                          
	                        <li><a href="/post/list?reqPage=1&postTypeCd=3&postTypeNm=3" >FAQ</a></li>
	                        <li><a href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4" >Q&A</a></li>
	                        <li><a href="/post/list?reqPage=1&postTypeCd=5&postTypeNm=5" >사이트 소개</a></li>  
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
			                <p>나에게 맞는 여행은 무엇일까? 어디로 떠나야할지 고민이라면 도시, 다양한 테마와 계절별 추천 여행 정보를 확인해 보세요. </p>
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
			                                <a href="#">바로가기
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
			                            <img src="/resources/images/landscape_01.jpg" class="flipCardImg">
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
			                                <a href="#">바로가기
			                                	<img src="/resources/images/arrow_outward_black.png" id="arrow_outward">
			                                </a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="siteInfoFlipCard">
			                    <div class="flip-card-inner">
			                        <div class="flip-card-front">
			                            <h4>계절</h4>
			                            <img src="/resources/images/landscape_01.jpg" class="flipCardImg">
			                        </div>
			                        <div class="flip-card-back">
			                            <div class="flip-card-back-title">
			                                <h4>계절</h4>
			                            </div>
			                            <div class="flip-card-back-body">
			                                <p>활기찬 봄, 햇살이 눈부신 여름,</p>
			                                <p>다채로운 가을</p>
			                                <p>그리고 깨끗한 겨울까지</p>
			                                <p>계절별로 여행지를 추천받아보세요</p>
			                            </div>
			                            <div class="flip-card-back-bottom">
			                                <a href="#">바로가기
			                                	<img src="/resources/images/arrow_outward_black.png" id="arrow_outward">
			                                </a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="siteIntro-txt">
			                <h3>이달의 축제</h3>
			                <p>매달 새로운 축제와 이벤트를 발견하고, 특별한 여행을 계획할 수 있습니다.</p>
			                <p>오늘은 어떤 축제가 열리고 있을까요? 이번에는 어떤 이벤트에 참여해볼까요?</p>
			            </div>
		                <div class="siteInfoCard">
							<div class="site-card-inner">
								<div class="site-card">
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=0">1월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=1">2월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=2">3월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=3">4월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=4">5월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=5">6월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=6">7월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=7">8월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=8">9월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=9">10월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=10">11월</a></div>
										<div class="move-monthly-trip"><a href="/festival/mainPage?searchType=1&month=11">12월</a></div>
								</div>
		                 	</div>
		                </div>
			            <div class="siteIntro-txt">
			               <h3>우리의 여행</h3>
			               <p>어떤 여행을 다녀오셨나요? 다른 사람들은 어떤 여행을 보내고 왔을까요?</p>
			               <p>내가 다녀온 여행을 남기고, 다른사람들의 여행정보도 확인해보세요.</p>
			               <p>다음여행은 더 새로운 여행이 될거에요!</p>
			            </div>
			               <div class="siteInfoCard">
				               <div class="link-box">
					               <a href="#" class="link-box-btn">우리의 여행 바로가기
		                           		<img src="/resources/images/arrow_outward_white.png" id="arrow_outward">
		                           </a>			               
				               </div>
			               </div>
			            <div class="siteIntro-txt">
			               <h3>MAP</h3>
			               <p>어디로 떠나 볼까요? 그곳에는 어떤 경험이 기다리고 있을까요?</p>
			               <p>다음 여행지에 대한 정보를 찾아보세요!</p>
			            </div>
			               <div class="siteInfoCard">
				               <div class="link-box">
					               <a href="/spot/mainMap" class="link-box-btn">MAP 바로가기
		                           		<img src="/resources/images/arrow_outward_white.png" id="arrow_outward">
		                           </a>			               
				               </div>
				           </div>
			            <div class="siteIntro-txt">
			               <h3>고객센터</h3>
			               <p>사이트 이용에 불편하신 점이 있으시다면 편하게 말씀해주세요!</p>
			               <p>이용자 여러분의 의견을 수용해 항상 노력하는 withTrip이 되겠습니다.</p>
			            </div>
			               <div class="siteInfoCard">
				               <div class="link-box-cs">
				               	   <a href="/post/CS" class="link-box-btn">고객센터 바로가기 
		                           		<img src="/resources/images/arrow_outward_white.png" id="arrow_outward">
		                           </a>
					               <a href="/post/list?reqPage=1&postTypeCd=1&postTypeNm=1" class="link-box-btn">공지사항 바로가기 
		                           		<img src="/resources/images/arrow_outward_white.png" id="arrow_outward">
		                           </a>
		                           <a href="/post/list?reqPage=1&postTypeCd=3&postTypeNm=3" class="link-box-btn">자주 물어보는 질문 바로가기 
		                           		<img src="/resources/images/arrow_outward_white.png" id="arrow_outward">
		                           </a>
		                           <a href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4" class="link-box-btn">Q&A 바로가기 
		                           		<img src="/resources/images/arrow_outward_white.png" id="arrow_outward">
		                           </a>          
				               </div>
			               </div>
			               <div class="siteNotice">				               
				               <p>withTrip의 대부분의 서비스는 회원가입이 필요하지 않지만</p>
				               <p><b>우리의 여행</b>과 <b>1:1문의</b> 작성은 <b>회원가입 후 로그인을 하셔야 가능합니다.</b></p>
				               <p>withTrip에 가입해보세요. 더 많은 여행이 한 걸음 더 가까워 질거에요!</p>
			               </div>
   					</div>
				</div>
			</section>
		</main>
	</div>
	<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
</body>
</html>