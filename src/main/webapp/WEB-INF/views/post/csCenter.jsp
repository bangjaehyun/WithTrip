<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		/*  height : 500px;*/
		width : 1000px;
		padding-right : 140px;
		padding-left : 20px;
	}
	.list-header {
		padding : 20px 0px;
		text-align : right;
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
	
	.section {
		margin-bottom: 20px;
	}
	.list-header {
		text-align: right;
		color : red;
		margin-bottom: 10px;
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
		justify-content: space-around;
		align-content: center;
	}
	.cs-conList {
		display : flex;
		height : 40px;
		width : 250px;
		line-height : 25px;
		background-color : var(--main2);
		border-radius : 8px;
		border: 1px solid var(--main2);
		justify-content : center;
		align-content: center;
		justify-items:center; 
	}
	.cs-conList > h3 {	
		color : var(--gray8);
		padding-top : 5px;
	}
	.cs-content-header {
		height : 300px;
		align-content: center;
		justify-content: center;
		justify-items: center;
		position : relative;
	}
	#direct-arrow{
		padding-top : 5px;
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
	                        <li><a href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4" >Q&A</a></li>
	                        <li><a href="/post/list?reqPage=1&postTypeCd=5&postTypeNm=5" >사이트 소개</a></li>  
						</ul>
					</div>
					<div class="list-content">
						<div class="cs-content-header">
							<img src="/resources/images/withTrip_logo_h_04.png" id="siteIntro-header">
			                <h4>여행을 내곁에, withTrip입니다. 무엇을 도와드릴까요?</h4>
						</div>
						<div class="cs-content">
							<div class="cs-conList">
								<h3>1:1 문의 작성하러 가기</h3>
								<img id="direct-arrow" src="/resources/images/arrow_outward_white.png" style="width: 28px; height: 28px;">
								<c:choose>
								<c:when test="${empty sessionScope.loginMember}">
												
								</c:when>
								<c:otherwise>
									
								</c:otherwise>
								</c:choose>					
							</div>
							<div class="cs-conList">
								<h3>ID / 비밀번호 찾기</h3>
								<img id="direct-arrow" src="/resources/images/arrow_outward_white.png" style="width: 28px; height: 28px;">							
							</div>
							<div class="cs-conList">
								<h3>파트너 신청</h3>
								<img id="direct-arrow" src="/resources/images/arrow_outward_white.png" style="width: 28px; height: 28px;">
							</div>
						</div>
						
						<%-- 공지사항, 자주묻는 질문, Q&A의 게시글을 5개씩 보이게 하고 싶었는데 값은 넘어오는데 테이블 tr태그 아래에 추가가 안됨, 추후 확인 후 삭제 or 수정 예정  --%>
						<c:forEach  var="post" items="${postList}">	
							<section class="section type${post.postTypeCd}">
								<div class="page-title" style="text-align:left;">${post.postTypeNm}
									<div class="list-header">
										<a href='/post/list?reqPage=1&postTypeCd=${post.postTypeCd}&postTypeNm=${post.postTypeNm}'>더보기...</a>
									</div>
									<div class="list-content">
										<table class="tbl hover">
											<tr class="th">
												<th style="width:10%;">번호</th>
												<th style="width:30%;">제목</th>
												<th style="width:20%;">작성자</th>
												<th style="width:20%;">작성일</th>
											</tr>
										</table>
									</div>
								</div>
							</section>
						</c:forEach>
					</div>						
				</div>
			</section>
		</main>
		<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	//게시글 종류별 리스트 조회
	function postList() {
		$.ajax ({
			url : "/post/index",
			type : "GET",
			dataType : "json",	//서블릿에서 응답해주는 데이터의 형식	
			success : function(res){
				console.log(res);
				$(res).each(function(index, item) {
					let html = "";
					html += "<tr>";
					html += "<td>" + item.postTypeCd + "</td>";
					html += "<td><a href='post/view?postNo="+item.postNo+"'>"+item.postTitle+"</a></td>";
					html += "<td>"+item.userNo+"</td>";
					html += "<td>"+item.postDate+"</td>";
					html += "</tr>";
					console.log(html);
					$('.section.type' + item.postTypeCd).append(html);
				});
			},
			error : function() {
				console.log("ajax 통신 오류");				
			}
		});
	}
	
	setInterval(function() {
		postList(); 
	}, 1000*60*10);	//10분에 1번씩
	$(function () {
		postList();
	});
	</script>
</body>
</html>