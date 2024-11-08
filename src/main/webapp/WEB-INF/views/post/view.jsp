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
	.list-content {
		height : 500px;
		width: 1000px;
	}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section notice-view-wrap">
				<div class="page-title">${post.postTypeNm}</div>
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
						<a href=""></a>
					</div>				
				</div>
				</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>