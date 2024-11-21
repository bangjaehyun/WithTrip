<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>
	@media screen and (max-width: 1400px) {
	  .list-side {
	    display: none;
	  }
	}
	.post-list-wrap {
		width : 1200px;
		margin : 0 auto;
	}
	.list-content {
		height : 500px;
		width : 1000px;
		padding-right : 150px;
		padding-left : 150px;
	}
	.list-header {
		padding : 20px 0px;
		text-align : right;
		text-align: right;
		margin-bottom: 10px;
	}
	.list-content-body {
		height : 500px;
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
	.section {
		margin-bottom: 20px;
	}
	.list-header>a:hover {
		text-decoration : underline;
	}
	.page-title {
		color : var(--main2);
		text-indent: 20px;
	}
	
	.cs-content {
		height : 30px;
		display: flex;
		justify-content: center;
		align-content: center;
		flex-wrap: wrap;
		gap : 8px;
	}
	.cs-conTxt {
		font-size : 13px;
		padding-left : 300px;
		justify-content: space-between;
	}
	.cs-conList {
		display : flex;
		height : 50px;
		width : 300px;
		line-height : 36px;
		background-color : var(--main2);
		border-radius : 8px;
		border: 1px solid var(--main2);
		justify-content : center;
		align-content: center;
		justify-items:center;
	}
	.cs-conList:hover {
		font-weight: bolder;
	}
	.cs-conList {	
		color : var(--gray8);
		padding-top : 10px;
		font-size: 17px;
	}
	.cs-content-header {
		height : 300px;
		align-content: center;
		justify-content: center;
		justify-items: center;
		position : relative;
		margin-bottom : 80px;
	}
	#direct-arrow{
		padding-top : 6px;
		width: 25px;
		height: 25px;
	}
</style>
</head>
<body>
<div class="wrap">
		<jsp:include page = "/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section post-list-wrap">
			<div class="page-title">고객센터</div>
			
	
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
						<div class="cs-content-header">
							<img src="/resources/images/withTrip_logo_h_04.png" id="siteIntro-header">
			                <h4>여행을 내곁에, withTrip입니다. 무엇을 도와드릴까요?</h4>
						</div>

						<div class="cs-content">
							<a class="cs-conList" href="javascript:void(0)" onclick="openFind()">ID / 비밀번호 찾기 <img
								id="direct-arrow"
								src="/resources/images/arrow_outward_white.png">
							</a> 
							<a class="cs-conList"
								href="/post/list?reqPage=1&postTypeCd=1&postTypeNm=1">공지사항
								바로가기 <img id="direct-arrow"
								src="/resources/images/arrow_outward_white.png">
							</a> <a class="cs-conList" href="/user/joinFrm">회원가입 <img
								id="direct-arrow"
								src="/resources/images/arrow_outward_white.png">
							</a> <a class="cs-conList"
								href="/post/list?reqPage=1&postTypeCd=3&postTypeNm=3">자주 묻는
								질문 바로가기 <img id="direct-arrow"
								src="/resources/images/arrow_outward_white.png">
							</a> <a class="cs-conList" href="/cs/joinPartner">파트너 신청 <img
								id="direct-arrow"
								src="/resources/images/arrow_outward_white.png">
							</a> <a class="cs-conList"
								href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4">1:1문의
								바로가기 <img id="direct-arrow"
								src="/resources/images/arrow_outward_white.png">
							</a>
							<div class="cs-conTxt">
								<p></p>
								<p>1:1문의 작성은 로그인을 하셔야 가능합니다.</p>
							</div>
						</div>
					</div>						
				</div>
			</section>
		</main>
		<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	function openFind(){
		let popupWidth = 500;
		let popupHeight = 200;
		
		let top = (window.innerHeight - popupHeight) /2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;
		
		window.open("/csCenter/findIdPw", "openFind", "width=" + popupWidth +", height=" + popupHeight + ", top="+top+", left=" + left);
	}
	</script>
</body>
</html>