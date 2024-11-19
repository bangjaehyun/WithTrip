<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>
.post-list-wrap {
	width : 1200px;
	margin : 0 auto;
}

.list-content {
	height : 500px;
	width : 1000px;
	padding-right : 190px;
	padding-left : 60px;
}
.list-header {
	padding : 20px 0px;
	text-align : right;
}
.list-content-body {
	height : 500px;
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
	position:sticky;
}
.proposal > * {
	justify-content: center;
}
.proposal_process {
	display: flex;
	justify-content: center;
	align-items: center;
	gap : 20px;
}
.proposal_process > #pp_txt {
	width : fit-content;
	height : fit-content;
	padding : 0px 15px 0px 15px;
	background-color: var(--gray7);
	border-radius: 8px;
}
.proposal_txt {
	height : 80px;
}
</style>
</head>
<body>
<div class="wrap">
	<jsp:include page = "/WEB-INF/views/common/header.jsp" />
	<main class="content">
		<section class="section post-list-wrap">
		<div class="page-title">파트너 신청 & 제휴 제안</div>
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
	            	<img src="/resources/images/withTrip_logo_h_04.png" id="siteIntro-header">
	                <h4>여행을 내곁에</h4>
	                <p>withTrip과 함께하기로 해주셔서 감사합니다.</p>
	            </div>
	            <div class="siteIntro-txt">
	                <h3>파트너 신청 & 제휴제안 절차</h3>
	                 <div class="siteInfoCard">
		                 <div class="site-card-inner">
							<div class="proposal_txt">
								<p>제안서 및 계획서 등을 첨부해 with_trip2412@naver.com으로 보내주세요<p>
								<p>제안 내용 및 관련자료는 제휴 검토 목적으로만 이용됩니다.</p>										
							</div>
							<div class="proposal_box">
								<ul class="proposal_process">
									<li id="pp_txt"> 1. 메일발송 </li>
									<li> > </li>
									<li id="pp_txt"> 2. 제안 내용 검토 </li>
									<li> > </li>
									<li id="pp_txt"> 3. 제휴제안 종료 </li>
								</ul>
							</div>
							<div class="proposal_txt">
								<h4>메일발송</h4>
									<ul>
										<li>담당자와의 면담을 전제로 한 제휴제안은 지양해 주시기 바랍니다.</li>
										<li>withTrip에서 파트너 신청 및 제휴제안 내용을 접수하고, 접수가 완료되었음을 제안자의 이메일로 안내해드립니다. </li>
										<li>첨부파일 이상 등의 재등록 요청시에는 제휴제안 내용을 수정 또는 보완해주시기 바랍니다. </li>
										<li>허위 제안 등의 부적절한 메일은 확인 후 스팸처리 및 신고가 이루어지므로 신중하게 메일을 보내주시기 바랍니다. </li>
										<li>제안 내용 및 관련 자료는 파트너 선정 및 제휴 검토 목적으로만 이용됩니다.</li>								
									</ul>
							</div>
							<div class="proposal_txt">
								<h4>제안 내용 검토</h4>
								<ul>
									<li>접수된 파트너 신청 및 제휴제안 내용은 5일 이내에 처리하는 것을 기본으로 하고있습니다. </li>
									<li>(단, 주요 사안의 경우 시간이 조금 더 소요될 수 있습니다. 양해부탁드립니다.) </li>
									<li>담당자가 파트너 신청 </li>
								</ul>
							</div>
	                 	</div>
	                 </div>
	            </div>
			</div>
		</div>
	</section>
	</main>
	
	<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>