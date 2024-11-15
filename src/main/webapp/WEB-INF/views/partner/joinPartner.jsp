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
</style>
</head>
<body>
<div class="wrap">
	<jsp:include page = "/WEB-INF/views/common/header.jsp" />
	<main class="content">
	<section class="section">
	
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
				<p>withTrip과 함께하기로 해주셔서 감사합니다.</p>
				<p>파트너 신청 어떻게하면 좋지</p>
			</div>
		</div>
	</section>
	</main>
	
	<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>