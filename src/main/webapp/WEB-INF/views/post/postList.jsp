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
		height : 500px;
		width: 1000px;
	}
	.list-header {
		padding : 15px 0px;
		text-align : right;
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
			<%-- <c:if test="${not empty loginMember}"> --%>
				<div class="list-header">
					<%-- <a class="btn-point" id="write-btn" href='/post/writeFrm?postTypeid=${postTypeid}&postTypeNm=${postTypeNm}'>${postTypeNm } 작성</a>--%>
					<a class="btn-point" id="write-btn" href='/post/editorWriteFrm?postTypeId=${postTypeId}&postTypeNm=${postTypeNm}'>${postTypeNm} 작성</a>					
				</div>			
			<%-- </c:if> --%>
	
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
						<table class="tbl hover">
							<tr>
								<th style="width:10%;">번호</th>
								<th style="width:45%;">제목</th>
								<th style="width:15%;">작성자</th>
								<th style="width:20%;">작성일</th>
							</tr>
							<c:forEach var="post" items="${postList}">
							<tr>
								<td>${post.postNo }</td>
								<td><a href='/post/view?postNo=${post.postNo}'>${post.postTitle}</a></td>
								<td>${post.userNo}</td>
								<td>${post.postDate}</td>
							</tr>
							</c:forEach>
						</table>
						<div id="pageNavi">
							${pageNavi }
						</div>	
					</div>						
				</div>
			</section>
		</main>
		<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>