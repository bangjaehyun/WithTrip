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
	.post-list-wrap {
		width : 1200px;
		margin : 0 auto;
	}
	.list-content {
		height : 500px;
		width: 1000px;
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
</style>

</head>
<body>
	<div class="wrap">
		<jsp:include page = "/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section post-list-wrap">
			<div class="page-title" style="<c:if test='${postTypeId eq 2}'>text-indent : 0px</c:if>">${postTypeNm}</div>
			<%-- <c:if test="${not empty loginMember}"> --%>
				<div class="list-header">
					<%-- <a class="btn-point" id="write-btn" href='/post/writeFrm?postTypeid=${postTypeid}&postTypeNm=${postTypeNm}'>${postTypeNm } 작성</a>--%>
					<c:if test="${not empty loginUser}">
						<a class="btn-point" id="write-btn" href='/post/editorWriteFrm?postTypeId=${postTypeId}&postTypeNm=${postTypeNm}'>${postTypeNm} 작성</a>
					</c:if>					
				</div>			
			<%-- </c:if> --%>
	
				<div class="list-body">
					<c:if test="${postTypeId ne 2}">
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
					</c:if>
					<div  class="list-content" style="<c:if test='${postTypeId eq 2}'>width:1800px;</c:if>">
						<table class="tbl hover">
							<tr>
								<th style="width:10%;">번호</th>
								<th style="width:35%;">제목</th>
								<th style="width:15%;">작성자</th>
								<th style="width:20%;">작성일</th>
								<th style="width:10%;">조회수</th>
							</tr>
							<c:forEach var="post" items="${postList}">
							<tr>
								<td>${post.postNo}</td>
								
								<%-- <c:choose>
		                              <c:when test="${postTypeId eq 2}">
		                                 <td><a href='/post/trip?postNo=${post.postNo}'>${post.postTitle}</a></td>
		                              </c:when>
		                              <c:otherwise>
		                                 <td><a href='/post/view?postNo=${post.postNo}'>${post.postTitle}</a></td>
		                              </c:otherwise>
		                        </c:choose>   --%>
								
								<c:choose>
										<c:when test="${postTypeId eq 2}">
											<td><a href='/post/trip?postNo=${post.postNo}'>${post.postTitle}</a></td>
										</c:when>
										<c:when test="${postTypeId eq 4}">
											<c:if test="${empty loginUser}">
												<td>작성자만 확인 가능합니다</td>
											</c:if>
											<c:if test="${not empty loginUser and loginUser.userNo != post.user.userNo and loginUser.userNo ne '2024110916180004'}">
												<td>작성자만 확인 가능합니다</td>
											</c:if>
											
											<c:if test="${not empty loginUser and loginUser.userNo == post.user.userNo}">
												<td><a href='/post/view?postNo=${post.postNo}'>${post.postTitle}</a></td>
											</c:if>
											<c:if test="${not empty loginUser and loginUser.userNo eq '2024110916180004'}">
												<td><a href='/post/view?postNo=${post.postNo}'>${post.postTitle}</a></td>
											</c:if>
										</c:when>
										<c:otherwise>			
											<td><a href='/post/view?postNo=${post.postNo}'>${post.postTitle}</a></td>
										</c:otherwise>
								</c:choose>
								<td>${post.user.userNickname}</td>
								<td>${post.postDate}</td>
								<td>${post.readCount}</td>
							</tr>
							</c:forEach>
						</table>
						<div id="pageNavi" style="<c:if test='${postTypeId eq 2}'>padding-right : 0px;</c:if>">
							${pageNavi}
						</div>	
					</div>						
				</div>
			</section>
		</main>
		<jsp:include page = "/WEB-INF/views/common/footer.jsp" />
	</div>
	
<script>
window.onpageshow = function(event) {
	if(event.persisted) {
		document.location.reload();
	}
}
</script>
</body>
</html>