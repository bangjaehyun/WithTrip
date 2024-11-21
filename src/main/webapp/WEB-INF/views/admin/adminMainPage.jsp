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
.list-content {
	min-width: 500px;
    max-width: 1420px;
    margin: 0 auto;
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
	width: 180px;
	padding: 7px 0px;
	text-align: left;
	font-weight: bold;
	font-size: 20px;
	border-bottom: 3px solid var(--main2);
	position: sticky;
}

.list-body-over {
	
	width: 100px;
}
.page-title{
	margin-top: 100px;
}
</style>
</head>
<body>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>

		<div class="page-title">관리자 페이지</div>

		<div class="list-body-over">
			<ul class="side-menu-title">
				<li>관리자 페이지</li>
			</ul>
			<ul class="side-menu">
				<li><a href="/admin/adminPageFrm?pOrC=1">관리자페이지</a></li>
				<li><a href="/admin/adminUserMng?reqPage=1&pageSize=10">고객
						관리 페이지</a></li>
			</ul>
		</div>
		<div class="list-content">
			<section class="section section6">
					<div class="list-header">
					댓글
					</div>
					<div class="list-header">
						<a href="/admin/adminListFrm?pOrC=0&reqPage=1&pageSize=5&postTypeId=6&postTypeName=댓글">더보기..</a>
					</div>
					<table class="tbl">
						<tr class="th">
							<th>작성번호</th>
							<th>작성자</th>
							<th>내용</th>
							<th>작성일</th>
						</tr>
						<tbody class="tbody">

						</tbody>
					</table>
			</section>


			<c:forEach var="list" items="${pList}">

				<section class="section section${list.postTypeId}">
					<div>
						${list.postTypeNm}
						<div class="list-header">
							<a
								href="/admin/adminListFrm?pOrC=1&reqPage=1&postTypeId=${list.postTypeId}&postTypeName=${list.postTypeNm}&pageSize=5">더보기..</a>
						</div>
						<div class="list-content">
							<table class="tbl">
								<tr class="th">
									<th>작성번호</th>
									<th>작성자</th>
									<th>제목</th>
									<th>작성일</th>
								</tr>
								<tbody class="tbody">
								</tbody>
							</table>
						</div>
					</div>
				</section>
			</c:forEach>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		function postList() {

			$
					.ajax({
						url : "/admin/adminMain",
						type : "GET",
						dataType : "json",//서블릿에서 응답해주는 데이터 형식
						data : {
							"pOrC" : 1,
							"post" : 1

						},
						success : function(res) {
							$(res)
									.each(
											function(index, item) {
												let html = "";
												console.log(" asdasd"
														+ item.userNickName)
												html += "<tr>";
												html += "<td rowspan='2' class='postId'>"
														+ item.postNo
														+ "<input type='hidden' name='postTypeId' value='"+item.postNo+"'/></td>";
												html += "<td'rowspan='2'>"
														+ item.userNo
														+ "<input type='hidden' name='userNo' value='"+item.userNo+"'/></td> "
												html += "<td rowspan='2'>"
														+ item.userNickName
														+ "</td>"
												html += "<td> "
														+ item.shortenTitle
														+ "</td>";
												html += "<td rowspan='2'>"
														+ item.postDate
														+ "</td>";
												html += "</tr>";
												html += "<tr><td>"
														+ item.shortenContent
														+ "</td></tr>";

												$('.section' + item.postTypeId)
														.find('.tbody').append(
																html);
											});

						},
						error : function() {
							console.log("ajax통신 오류");
						}
					});
		}
		setInterval(function() {
			$('.section').find('.tbody').remove();
			postList();
		}, 1000 * 60 * 10);//10분에 1번
		$(function() {
			postList();
		});

		function commentList() {

			$.ajax({
				url : "/admin/adminMain",
				type : "GET",
				dataType : "json",//서블릿에서 응답해주는 데이터 형식
				data : {
					"pOrC" : 0,
					"comment" : 0
				},
				success : function(res) {
					$(res).each(
							function(index, item) {
								console.log(item);
								let html = "";
								html += "<tr>";
								html += "<td class='postId'>" + item.commentId
										+ "</td>";
								html += "<td>" + item.userNickname + "</td>";
								html += "<td>" + item.shortenContent + "</td>";
								html += "<td>" + item.commentDate + "</td>";
								html += "<tr>";
								$('.section6').find('.tbody').append(html);
							});

				},
				error : function() {
					console.log("ajax통신 오류");
				}
			});
		}
		setInterval(function() {
			$('.section').find('.tbody').remove();
			commentList();
		}, 1000 * 60 * 10);//10분에 1번
		$(function() {
			commentList();
		});
	</script>
</body>
</html>