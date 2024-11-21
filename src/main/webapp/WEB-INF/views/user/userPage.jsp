<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>With Trip</title>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<style>
.content {
	margin-left: 25%;
	margin-right: 25%;
	width: 50%;
}

.section {
	min-width: 500px;
	max-width: 1400px;
}

.wrapOver {
	margin-top: 20px auto;
}

.side-menu {
	margin-top: 40px auto;
	width: 200px;
}
</style>
</head>
<body>
	<div class="wrapOver">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
	</div>
	<main class="content contentOver">
		<div class="side-menu">
			<ul>
				<li><a href="/user/userPageFrm?pOrC=1&page=1&reqPage=1&pageSize=5&userNo=${loginUser.userNo}">작성한게시글확인</a></li>
				<li><a href="/user/userPageFrm?pOrC=1&page=2&reqPage=1&pageSize=5&userNo=${loginUser.userNo}">작성한댓글관리</a></li>
				<li><a href="/user/user/userPageFrm?pOrC=1&page=3&reqPage=1&pageSize=5&userNo=${loginUser.userNo}">좋아요누른여행정보</a></li>
				<li><a href="/user/mypageFrm">마이페이지로..</a></li>
			</ul>
		</div>
		<c:if test="${page eq 2}">
			<section class="section section6">
				<div class="page-title" style="text-align: left;">
					${title}
					<div class="list-header"></div>
					<div class="list-content">
						<table class="tbl">
							<tr class="th">
								<th>번호</th>
								<th>내용</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
							<tbody class="tbody">
								<c:forEach var="pg" items="${pgList}">
									<tr>
										<td class="number">${pg.commentId}</td>
										<td>${pg.userNo}</td>
										<td><a href="/user/userDetil">${pg.commentVal}</a></td>
										<td>${pg.commentDate}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div>${pageNavi}</div>
			</section>
		</c:if>
		<c:if test="${page eq 1}">
			<section class="section section6">
				<div class="page-title" style="text-align: center;">${title}</div>
				<div class="list-content">
					<table class="tbl">
						<tr class="th">
							<th>번호</th>
							<th>제목</th>
							<th>제목 | 내용</th>
							<th>작성일</th>
							<th>선택</th>
						</tr>
						<tbody class="tbody">
							<c:forEach var="pg" items="${pgList}">
								<tr>
									<td rowspan="2" class="number">${pg.postNo}</td>
									<td rowspan="2">${pg.userNo}</td>
									<td><a href="/user/userDetil">${pg.postTitle}</a></td>
									<td rowspan="2">${pg.postDate}</td>
								</tr>
								<tr>
									<td><a href="/admin/list">${pg.shortenContent}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div>${pageNavi}</div>
				</div>
			</section>
		</c:if>
		<c:if test="${page eq 3}">
			<section class="section section6">
				<div class="page-title" style="text-align: left;">${title}</div>
				<div class="list-content">
					<table class="tbl">
						<tr class="th">
							<th style="width: 10%;">번호</th>
							<th style="width: 50%;">제목</th>
							<th style="width: 20%;">작성자</th>
							<th style="width: 20%;">작성일</th>
						</tr>
						<tbody class="tbody">
							<c:forEach var="pg" items="${pgList}">
								<tr>
									<td class="number">${pg.postNo}</td>
									<td style="width: 10%;">${pg.userNo}</td>
									<td></td>
									<td><a href="/admin/list">${pg.commentVal}</a></td>
									<td>${pg.commentDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div>${pageNavi}</div>
			</section>
		</c:if>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		
	</script>
</body>
</html>