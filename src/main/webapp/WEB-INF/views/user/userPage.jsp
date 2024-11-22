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

.post-list-wrap {
	width : 1200px;
	margin : 0 auto;
}

.list-content {
	width: 1000px;
	height: 1000px;
}

.list-body {
	display: flex;
	justify-content: space-between;
}

.wrap.wrapOver {
	min-height: 50px;
}

.side-menu a {
	background-color: var(--gray8);
	color: #000;
	display: block;
	padding: 10px;
}

.side-menu-title {
	margin-top: 100px;
	width: 180px;
	padding: 7px 0px;
	text-align: left;
	font-weight: bold;
	font-size: 20px;
	border-bottom: 3px solid var(--main2);
	position: sticky;
}

.list-body-over {
	height : 200px;
	position : sticky;
	top : 80px;

}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="content">
		<section class="section post-list-wrap">
		<div class="list-body">
			<div class="list-body-over">
				<ul class="side-menu-title">
					<li>마이 페이지</li>
				</ul>
				<ul class="list-body-over">
					<li><a
						href="/user/userPageFrm?pOrC=1&page=1&reqPage=1&pageSize=5&userNo=${loginUser.userNo}">작성한게시글확인</a></li>
					<li><a
						href="/user/userPageFrm?pOrC=1&page=2&reqPage=1&pageSize=5&userNo=${loginUser.userNo}">작성한댓글관리</a></li>
					<li><a
						href="/user/userPageFrm?pOrC=1&page=3&reqPage=1&pageSize=5&userNo=${loginUser.userNo}">좋아요누른여행정보</a></li>
					<li><a href="/user/mypageFrm">마이페이지로..</a></li>
				</ul>
			</div>

			<div class="list-content">
				<c:if test="${page eq 2}">
					<section class="section section6">
						<div class="page-title" style="text-align: center;">
							${title}</div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th>번호</th>
									<th>내용</th>
									<th>작성일</th>
								</tr>
								<tbody class="tbody">
									<c:forEach var="pg" items="${pgList}">
										<tr>
											<td class="number">${pg.commentId}</td>
											<td>${pg.commentVal}</td>
											<td>${pg.commentDate}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div>${pageNavi}</div>
						</div>
					</section>
				</c:if>
				<c:if test="${page eq 1}">
					<section class="section section6">
						<div class="page-title" style="text-align: center;">${title}</div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th>번호</th>
									<th>제목 | 내용</th>
									<th>작성일</th>
								</tr>
								<tbody class="tbody">
									<c:forEach var="pg" items="${pgList}">
										<tr>
											<td rowspan="2" class="number">${pg.postNo}</td>
											<td><a
												href="/user/userDetail?page=1&postNo=${pg.postNo}&commentId=&userNo=${pg.userNo}&commentChk=chk&webName=내가 작성한 게시글">${pg.postTitle}</a></td>
											<td rowspan="2">${pg.postDate}</td>
										</tr>
										<tr>
											<td><a href="/admin/list">${pg.postContent}</a></td>
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
						<div class="page-title" style="text-align: center;">${title}</div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th style="width: 10%;">번호</th>
									<th style="width: 50%;">제목</th>
									<th style="width: 20%;">작성일</th>
								</tr>
								<tbody class="tbody">
									<c:forEach var="pg" items="${pgList}">
										<tr>
											<td rowspan="2" class="number">${pg.postNo}</td>
											<td><a
												href="/user/userDetail?page=1&postNo=${pg.postNo}&commentId=&userNo=${pg.userNo}&commentChk=chk&webName=내가 좋아요한 게시글">${pg.postTitle}</a></td>
											<td rowspan="2">${pg.postDate}</td>
										</tr>
										<tr>
											<td>${pg.postContent}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div>${pageNavi}</div>
					</section>
				</c:if>
			</div>
		</div>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		
	</script>
</body>
</html>