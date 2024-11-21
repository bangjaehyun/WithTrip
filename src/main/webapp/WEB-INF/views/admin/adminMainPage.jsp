<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
.title {
	padding: 12px 25px;
	font-size: 16px;
	border-radius: 25px;
	margin: 0 auto;
	text-align: center
}

.wrap.wrapOver {
	min-height: 50px;
	min-width: 500px;
}
/*
.grid-container {
	display: grid;
	gap: 5px;
	padding: 10px;
	height:
}

.grid-item {
	background-color: rgba(255, 255, 255, 0.8);
	text-align: center;
	padding: 20px;
	font-size: 30px;
}

.section6 {
	grid-column: 2;
	grid-row: 1;
}

.section2 {
	grid-column: 1;
	grid-row: 1;
}
*/
.tbl {
	width: 250px;
	height: 250px;
}
</style>
</head>
<body>
	<div class="wrap wrapOver">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
	</div>
	<main>
		<div class="grid-container">
			<div class="page-title title" style="text-align: left;">관리자 페이지
			</div>
			<ul>
				<li><a href="/admin/adminPageFrm?pOrC=1">관리자페이지</a></li>
				<li><a href="/admin/adminUserMng?reqPage=1&pageSize=10">고객 관리 페이지</a></li>
			</ul>
			<div class="list-header">
			</div>
				<section class="section section6">
					<form action="/admin/adminList" id="view6" method="post">
						<div class="page-title" style="text-align: left;">
							댓글
							<div class="list-header">
								<a
									href="/admin/adminListFrm?pOrC=0&reqPage=1&pageSize=5&postTypeId=6&postTypeName=댓글">더보기..</a>
							</div>
							<div class="list-header"></div>
							<div class="list-content">
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
							</div>
						</div>
					</form>
				</section>
				<c:forEach var="list" items="${pList}">
					<form action="/admin/adminList" id="view${postTypeId}"
						method="post">

						<section class="section section${list.postTypeId}">
							<div class="page-title" style="text-align: left;">
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
					</form>
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