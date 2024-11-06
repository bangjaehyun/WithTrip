<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<style>
	.post-list-wrap {
		width : 1200px;
		margin : 0 auto;
	}
	.list-content {
		height : 500px;
		width: 1000px;
		justify-items : center;
		align-items : center; 
	}
	.side-menu-title {
		width : 180px;
		padding : 7px 0px;
		text-align : left;
		font-weight : bold;
		font-size : 20px;
		border-bottom: 3px solid var(--main2);
	}
</style>
</head>
<body>
<div class="wrap">
		<jsp:include page = "/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section post-list-wrap">
			<div class="page-title">${postTypeNm}</div>
			
				<div class="list-whole">
					<div class="list-side">
						<ul class="side-menu-title">
							<li>고객센터</li>						
						</ul>
						<ul class="side-menu">						
							<li><a href="/post/list?reqPage=1&postTypeCd=1&postTypeNm=1" >공지사항</a></li>                          
	                        <li><a href="/post/list?reqPage=1&postTypeCd=3&postTypeNm=3" >FAQ</a></li>
	                        <li><a href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4" >Q&A</a></li>
	                        <li><a href="/post/list?reqPage=1&postTypeCd=5&postTypeNm=5" >사이트 이용안내</a></li>  
						</ul>
					</div>
					<div class="list-content">
						<div class="siteIntro-header">
							<img src="/resources/images/withTrip_logo_h_02.png" width="80%" height="300px">
							<h2>여행을 내곁에</h2>
						</div>
					</div>						
				</div>
			</section>
		</main>
		<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>