<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>With Trip</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>
@media screen and (max-width: 1655px) {
  .list-side {
    display: none;
  }
}
@media screen and (max-width:800px) {
	#pp_num {
	display: none;
	}
}
.post-list-wrap {
	width : 1200px;
	margin : 0 auto;
}

.list-content {
	height : auto;
	width : 1000px;
	padding-left : 90px;
}

.list-side {
	height : 200px;
	position : sticky;
	top : 225px;
	left : 300px;
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
.proposal-brife {
	height : auto;
    justify-content: center;
    align-content: center;
    margin: 10px auto;
}
.proposal_txt {
	justify-items: center;
}
.proposal_txt > h3 {
    color : var(--main2);
    font-size: 23px;
    padding-bottom : 10px;
    text-align: center;
}
.proposal_txt > p {
	justify-items:start;
}
.proposal_process {
	display: flex;
	justify-content: center;
	align-items: center;
	gap : 10px;
}
.proposal_process > #pp_txt {
	width : fit-content;
	height : fit-content;
	margin : 10px;
	padding : 0px 15px 0px 15px;
	background-color: var(--gray7);
	border-radius: 8px;
}
.proposal-intro {
	border-top : 1px solid var(--gray7);
	height : auto;
	padding : 15px 0px 15px 0px;
}
.proposal_info {
	display : flex;
	gap : 30px;
}
.proposal_info > h3 {
	color : var(--gray3);
	padding-bottom: 5px;
}
.proposal_info > div > ul {
	padding-left : 20px;
}
.proposal_info > div > ul > li {
 	list-style-type : disc;
 	font-size : 15px;
}
#pp_num {
	font-size: 30px;
	color:var(--gray6);
}
.proposal-header {
	height : 120px;
	align-content: center;
	justify-content: center;
	justify-items: center;
	position : relative;
}
#proposal-header {
	width : 350px;
}

</style>
</head>
<body>
<div class="wrap">
	<jsp:include page = "/WEB-INF/views/common/header.jsp" />
	<main class="content">
		<section class="section post-list-wrap">
		<div class="list-body">
			<div class="list-side">
				<ul class="side-menu-title">
					<li>고객센터</li>						
				</ul>
				<ul class="side-menu">						
					<li><a href="/post/list?reqPage=1&postTypeCd=1&postTypeNm=1" >공지사항</a></li>                          
                    <li><a href="/post/list?reqPage=1&postTypeCd=3&postTypeNm=3" >FAQ</a></li>
                    <li><a href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4" >1:1 문의</a></li>
                    <li><a href="/post/list?reqPage=1&postTypeCd=5&postTypeNm=5" >사이트 소개</a></li>  
				</ul>
			</div>
			<div class="list-content">
				<div class="proposal-header">			            	
	            	<img src="/resources/images/withTrip_logo_h_04.png" id="proposal-header">
	            	<P></P>
	            </div>
	            <div class="proposal-brife">
					<div class="proposal_txt">
	                <h3>파트너 신청 & 제휴제안 절차</h3>
		                <p>withTrip과 함께하기로 해주셔서 감사합니다.</p>
						<p>제안서 및 계획서 등을 첨부해 with_trip2412@naver.com으로 보내주세요<p>
						<p>제안 내용 및 관련자료는 제휴 검토 목적으로만 이용됩니다.</p>										
					</div>
					<div class="proposal_box">
						<ul class="proposal_process">
							<li id="pp_txt">1. 메일발송 </li>
							<li> > </li>
							<li id="pp_txt">2. 신청 및 제안 내용 검토</li>
							<li> > </li>
							<li id="pp_txt">3. 신청 및 제휴제안 종료</li>
						</ul>
					</div>			
				</div>
				<div class="proposal-intro">
					<div class="proposal_info">
						<div id="pp_num">01</div>
						<div>
						<h3>메일발송</h3>
							<ul>
								<li>담당자와의 면담을 전제로 한 파트너신청 또는 제휴 제안은 지양해 주시기 바랍니다.</li>
								<li>withTrip에서 파트너 신청 및 제휴 제안 내용을 접수하고, 접수가 완료되었음을 제안자의 이메일로 안내해드립니다. </li>
								<li>첨부파일 이상 등의 재등록 요청시에는 제휴제안 내용을 수정 또는 보완해주시기 바랍니다. </li>
								<li>허위 제안 등의 부적절한 메일은 확인 후 스팸처리 및 신고가 이루어지므로 신중하게 메일을 보내주시기 바랍니다. </li>
								<li>제안 내용 및 관련 자료는 파트너 선정 및 제휴 검토 목적으로만 이용됩니다.</li>								
							</ul>
						</div>
					</div>
				</div>
				<div class="proposal-intro">
					<div class="proposal_info">
						<div id="pp_num">02</div>
						<div>
						<h3>신청 및 제안 내용 검토</h3>
						<ul>
							<li>
								접수된 파트너 신청 및 제휴제안 내용은 5일 이내에 처리하는 것을 기본으로 하고있습니다. <br>
								(단, 주요 사안의 경우 시간이 조금 더 소요될 수 있습니다. 양해부탁드립니다.)
							</li>
							<li>담당자가 파트너 신청 및 제휴제안을 검토하는 과정에서 추가자료를 요청하거나 재문의할 수 있습니다.</li>
							<li>30일 이내에 제안자가가 담당자의 자료요청 또는 재문의에 회신을 하지 않는 경우, 해당 신청 및 제휴제안은 종료처리됩니다. </li> 
						</ul>
						</div>
					</div>
				</div>
				<div class="proposal-intro">
					<div class="proposal_info">
						<div id="pp_num">03</div>
						<div>
						<h3>신청 및 제휴제안 종료</h3>
						<ul>
							<li>신청 및 제휴제안 내용의 검토결과는 입력하신 이메일 주소로 발송됩니다.</li>
							<li>파트너 선정 또는 제휴 진행이 결정되면, 담당자가 별도의 절차를 안내하고 해당 건을 종료합니다. </li>
							<li>파트너 선정 또는 제휴 진행 여부에 관계 없이, 신청, 제휴제안 내용 및 관련자료는 30일 후 자동파기 됩니다.</li>
						</ul>
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