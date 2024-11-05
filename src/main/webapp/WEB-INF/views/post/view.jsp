<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<style>
	.post-view-wrap{
		width : 1200px;
		margin : 0 auto;
	}
	.postContent {
		min-height : 300px;
	}
	.comment-write {
		overflow : hidden;
	}
	.comment-write textarea[name=commentContent] {
		width : 1000px;
		height : 100px;
		margin-right : 10px; 
	}
	.comment-write li {
		float : left;
	}
	.inputCommentBox {
		margin-bottom: 20px;
	}
	.comment-write button {
		width : 150px;
		height : 130px;
		font-size :  20px;
	}
	.commentBox ul {
		margin-bottom : 15px;
		border-bottom : solid 1px var(--gray5);
	}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section notice-view-wrap">
				<div class="page-title">${post.postTypeNm}</div>
				<table class="tbl post-view">
					<tr>
						<th colspan = "4">
							${post.postTitle}
						</th>
					</tr>
					<tr>
						<th style="width:20%;">작성자</th>
						<td style="width:20%;">${post.userNo}</td>
						<th style="width:15%;">작성일</th>
						<td style="width:15%;">${post.postDate}</td>
					</tr>
					<tr>
						<td class="left" colspan="4">
							<div class="postContent">${post.postContent}</div>
						</td>
					</tr>
				</table>
				</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>