<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<style>
.content-body{
	min-width: 500px;
	max-width: 1400px;
	
}
.wrapOver{
	margin-top: 20px auto;
}
.side-menu{
	margin-top: 40px auto;
	width: 200px;
}
</style>
</head>
<body>
	<div class="wrapOver">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
	</div>
	<main class="content-body">
			<div class="side-menu">
				<ul>
					<li><a href="/user/userPageFrm?page=1&pOrC=1">작성한게시글확인</a></li>
					<li><a href="/user/userPageFrm?page=2&pOrC=2">작성한댓글관리</a></li>
					<li><a href="/user/userPageFrm?page=3&pOrC=1">좋아요누른여행정보</a></li>
					<li><a href="/user/mypageFrm">마이페이지로..</a></li>
				</ul>
			</div>
			<c:if test="${page eq 2}">
				<section class="section section6">
					<div class="page-title" style="text-align: left;">
						내가 작성한 댓글
						<div class="list-header">
							<a href="/user/userListFrm?pOrC=0&postTypeId=6&postTypeName=댓글">더보기..</a>
						</div>
						<div class="list-header"></div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th style="width: 10%;">번호</th>
									<th style="width: 50%;">제목</th>
									<th style="width: 20%;">작성자</th>
									<th style="width: 20%;">작성일</th>
								</tr>
								<tbody class="tbody">
									<c:if test="${pOrC eq 1}">
										<c:forEach var="pg" items="${pgList}">
											<tr>
												<td style="width: 10%;" class="number">${pg.commentId}</td>
												<td style="width: 10%;">${pg.userNo}</td>
												<td style="width: 10%;"> </td>
												<td style="width: 60%;"><a href="/admin/list">${pg.commentVal}</a> </td>
												<td style="width: 10%;">${pg.commentDate}</td>
												<td style="width: 10%;">
													<div class="input-wrap">
														<label onclick="chkLavel(this)"> <input type="checkbox" class="chk" name="posts"> </label>
													</div>
												</td>
											</tr>
										</c:forEach>	
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</section>
			</c:if>
			<c:if test="${page eq 1}">
				<section class="section section6">
					<div class="page-title" style="text-align: center;">
						내가 ${title1}한 게시글</div>
						<div class="list-header">
							<a href="/user/userListFrm?pOrC=0&postTypeId=6&postTypeName=댓글">더보기..</a>
						</div>
						<div class="list-header"></div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th style="width: 10%;">번호</th>
									<th style="width: 50%;">제목</th>
									<th style="width: 20%;">작성자</th>
									<th style="width: 20%;">작성일</th>
								</tr>
								<tbody class="tbody">
									<c:if test="${pOrC eq 1}">
										<c:forEach var="pg" items="${pgList}">
											<tr>
												<td style="width: 10%;" class="number">${pg.commentId}</td>
												<td style="width: 10%;">${pg.userNo}</td>
												<td style="width: 10%;"> </td>
												<td style="width: 60%;"><a href="/admin/list">${pg.commentVal}</a> </td>
												<td style="width: 10%;">${pg.commentDate}</td>
												<td style="width: 10%;">
													<div class="input-wrap">
														<label onclick="chkLavel(this)"> <input type="checkbox" class="chk" name="posts"> </label>
													</div>
												</td>
											</tr>
										</c:forEach>	
									</c:if>
								</tbody>
							</table>
						</div>
				</section>
			</c:if>
			<c:if test="${page eq 3}">
				<section class="section section6">
					<div class="page-title" style="text-align: left;">
						내가 ${title2}한 게시글</div>
						<div class="list-header">
							<a href="/user/userListFrm?pOrC=0&postTypeId=6&postTypeName=댓글">더보기..</a>
						</div>
						<div class="list-header"></div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th style="width: 10%;">번호</th>
									<th style="width: 50%;">제목</th>
									<th style="width: 20%;">작성자</th>
									<th style="width: 20%;">작성일</th>
								</tr>
								<tbody class="tbody">
									<c:if test="${pOrC eq 1}">
										<c:forEach var="pg" items="${pgList}">
											<tr>
												<td style="width: 10%;" class="number">${pg.commentId}</td>
												<td style="width: 10%;">${pg.userNo}</td>
												<td style="width: 10%;"> </td>
												<td style="width: 60%;"><a href="/admin/list">${pg.commentVal}</a> </td>
												<td style="width: 10%;">${pg.commentDate}</td>
												<td style="width: 10%;">
													<div class="input-wrap">
														<label onclick="chkLavel(this)"> <input type="checkbox" class="chk" name="posts"> </label>
													</div>
												</td>
											</tr>
										</c:forEach>	
									</c:if>
								</tbody>
							</table>
						</div>
				</section>
			</c:if>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		function commentList() {
			$.ajax({
						url : "/user/userMain",
						type : "GET",
						dataType : "json",//서블릿에서 응답해주는 데이터 형식
						data : {
							"page" : `${page}`

						},
						success : function(res) {
							$(res)
									.each(
											function(index, item) {
												console.log(item.postTypeId);
												let html = "";
												html += "<tr>";
												html += "<td style='width: 10%;' class='postId'>"
														+ item.commentNo
														+ "</td>";
												html += "<td style='width: 10%;'>"
														+ item.userNo
														+ "</td> "
												html += "<td style='width: 10%;'>"
														+ item.userNickName
														+ "</td>"
												html += "<td><a href='/admin/adminDetails>"
														+ item.commentContent
														+ "</td>";
												html += "<td>"
														+ item.commentDate
														+ "</td>";

												$('.section6').find('.tbl')
														.append(html);
											});

						},
						error : function() {
							console.log("ajax통신 오류");
						}
					});
		}
		setInterval(function() {
			commentList();
		}, 1000 * 60 * 10);//10분에 1번
		$(function() {
			commentList();
		});
		function postList() {
			
			$.ajax({
				url : "/user/userMain",
				type : "GET",
				dataType : "json",//서블릿에서 응답해주는 데이터 형식
				data : {
					"page" : `${page}`

				},
				success : function(res) {
					$(res).each(
									function(index, item) {
										console.log(item.postTypeId);
										let html = "";
										html += "<tr>";
										html += "<td style='width: 10%; ' rowspan='2' class='postId'>"
												+ item.postNo + "</td>";
										html += "<td style='width: 10%;' rowspan='2'>"
												+ item.userNo
												+ "</td> "
										html += "<td style='width: 10%;' rowspan='2'>"
												+ item.userNickName
												+ "</td>"
										html += "<td><a href='/admin/adminDetailFrm?pOrC=${pOrC}&reqPage=1&postNo="
												+ item.postNo
												+ "'>"
												+ item.postTitle
												+ "</td>";
										html += "<td>" + item.postDate
												+ "</td>";
										html += "</tr>";
										html += "<tr><td>"
												+ item.postContent
												+ "</td></tr>";

										$('.section' + item.postTypeId)
												.find('.tbl').append(
														html);
									});

				},
				error : function() {
					console.log("ajax통신 오류");
				}
			});
}
setInterval(function() {
	postList();
}, 1000 * 60 * 10);//10분에 1번
$(function() {
	postList();
});
	</script>
</body>
</html>