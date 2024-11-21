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
.trip-content{
	width: 100%;
    border: 1px solid gray;
    min-height: 300px;
}
.pstPtcDiv {
	border: 1px solid black;
	width: 50%
}

.pstPtc {
	list-style: none;
}

.pstPtc li {
	float: left;
}

.list-left-pannel {
	width: 10%;
	height: 200px;
	position: sticky;
	top: 80px;
}

.list-content {
	/*  height : 500px;*/
	width: 1000px;
	padding-right: 140px;
	padding-left: 20px;
}

.main-body {
	width: 60%;
	padding-left: 20%;
	padding-right: 20%;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="" name="selPgSize" />
	</jsp:include>
	<main class="content mypage-container">

		<div class="list-left-pannel">
			<ul class="side-menu">
				<li><a
					href="/admin/adminFrm?reqPage=1&postTypeId=1&postTypeName=공지사항&pageSize=5">1.공지사항</a></li>
				<li><a
					href="/admin/adminFrm?reqPage=1&postTypeId=2&postTypeName=파트너작성글&pageSize=5">2.사용자
						여행정보</a></li>
				<li><a
					href="/admin/adminFrm?reqPage=1&postTypeId=3&postTypeName=게시글&pageSize=5">3.파트너
						여행정보</a></li>
				<li><a
					href="/admin/adminFrm?reqPage=1&postTypeId=4&postTypeName=QnA&pageSize=5">4.QnA</a></li>
				<li><a href="/">5.사이트 이용안내.</a></li>
			</ul>
		</div>
		<div class="main-body">
			<div class="page-title">${pstTypeName}관리 페이지</div>
			<div id="pageNavi" style="margin-top: 20px;">${pageNavi}</div>
			<main class="trip-main">
			<section class="section">
				<div class="trip-wrap">
					<div class="trip-title">
						<h1>${post.postTitle}</h1>
					</div>
					<div class="trip-user">
						<span class="name-title">작성자</span> <span>:</span> <span class="tirp-name">${post.user.userNickname}</span>
					</div>
					<div>
						<span>작성일</span> <span>:</span> <span class="trip-date">${post.postDate}</span>
					</div>
					<c:if test="${not empty post.tripDate}">
						<div>
							<div>
								<span>여행일자</span> <span>:</span> <span class="trip-date">${post.tripDate}</span>
							</div>
						</div>
					</c:if>
					<c:if test="${not empty post.tagList}">
						<div class="div-tag">
							<ul class="ul-tag">
							</ul>
						</div>
					</c:if>
					<div class="filebox-wrap">
							<div class="filebox">
							</div>
						</div>
					<div class="div-map">
						<div id="map"></div>
					</div>
					<div class="trip-content">${post.postContent}</div>
				</div>
					<button class="btn-secondary" onclick="deletePost(${post.postNo})">삭제</button>
					
					
					
						<div class="commentBox">
						<c:forEach var="comment" items="${post.commentList}">
							<ul class="posting-comment">
								<li>
									<span class="material-icons">account_box</span>
								</li> 
								<li>
									<p class="comment-info">
										<span id="commentUserNickname">${comment.user.userNickname}</span>
										<span>${comment.commentDate}</span>
										<%-- 로그인한 회원 아이디 == 현재 댓글을 작성한 아이디 --%>
										<c:if test="${not empty loginUser and loginUser.userNo eq comment.user.userNo}">
											<a href='javascript:void(0)' id="delComment" onclick="delComment('${comment.commentId}');">삭제</a>
										</c:if>
									</p>
									<p class="comment-content">
										${comment.commentVal}
									</p>
									<div class="input-item" style="display:none;">
										<textarea name="commentVal">${comment.commentVal}</textarea>
									</div>
								</li>
							</ul>
						</c:forEach>
						</div>
			</section>
		</main>


		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>

				function deletePost(delPostNo){
					swal ({
						title : "삭제",
						text : "게시글을 삭제하시겠습니까?",
						icon : "warning",
						buttons : {
							cancel : {
								text : "취소",
								value : false,
								visible : true,
								closeModal : true
							},
							confirm : {
								text : "삭제",
								value : true,
								visible : true,
								closeModal : true
							}
						}
					}).then(function (isConfirm) {
						if(isConfirm) {
							$.ajax({
								url : "/post/delete",
								type : "GET",
								data : {
									"postNo" : delPostNo
									}, 
								success : function(res) {
									if(res == "1"){
										swal({
											title : "알림",
											text : '${post.postTypeNm}' + " 삭제가 완료 되었습니다.",
											icon : "success"
										}).then(function(){
											location.href = "/admin/adminList?reqPage=1&pOrC=1postTypeId=" + ${post.postTypeCd} + "&postTypeNm=" + ${post.postTypeCd};
										});
									}else{
										swal({
											title : "알림",
											text : '${post.postTypeNm}' + "삭제중 오류가 발생하였습니다.",
											icon : "error"
										}).then(function(){
											location.href = "/admin/adminList?reqPage=1&pOrC=1postTypeId=" + ${post.postTypeCd} + "&postTypeNm=" + ${post.postTypeCd};
										});
									}
								},
								error : function() {
									console.log("ajax 에러 발생");
								}
							});
						}
					});
				}
			</script>
</body>

</html>