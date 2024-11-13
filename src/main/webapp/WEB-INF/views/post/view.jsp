<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
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
	.comment-write textarea[name=commentVal] {
		width : 800px;
		height : 30px;
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
		height : 60px;
		font-size :  20px;
	}
	.commentBox ul {
		margin-bottom : 15px;
		border-bottom : solid 1px var(--gray5);
	}
	.list-content {
		width: 1000px;
		height : 2000px;
		justify-content: center;
		padding-right : 20px;
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
							<td style="width:20%;">${post.user.userNickname}</td>
							<th style="width:15%;">작성일</th>
							<td style="width:15%;">${post.postDate}</td>
						</tr>
						<tr>
						<th>첨부파일</th>
						<td colspan="4">
							<c:forEach var="file" items="${post.fileList}">
								<a href="javascript:fileDown('${file.fileName}', '${file.filePath}',)">${file.fileName}</a>
							</c:forEach>
						</td>
						</tr>
						<tr>
							<td class="left" colspan="4">
								<div class="postContent">${post.postContent}</div>
							</td>
						</tr>
						<c:if test="${not empty loginUser and loginUser.userNo eq post.user.userNo}">
						<%-- 아직 구현 못함. 로그인한 아이디와 게시글작성 아이디 일치여부에 따라 수정삭제 버튼이 나타나야하는데 안나옴--%>
						<tr>
							<td colspan="4">
								<a href='/post/updateFrm?postNo=${post.postNo}' class = "btn-primary">수정</a>
								<button class="btn-secondary" onclick="deletePost(${Post.postNo})">삭제</button>
							</td>
						</tr>
						</c:if>
						</table>
						<c:if test="${not empty loginUser}">
							<div class="inputCommentBox">
								<form name="insertComment" action="/post/insertComment" method = "post">
									<input type="hidden" name="commentRef" 		value="${post.postNo}">	<%-- 현재 게시글 번호 --%>
									<input type="hidden" name="commentWriter"	value="${loginUser.userNo}"> <%-- 현재 댓글 작성자(로그인한 회원) --%>
									<%-- <input type="hidden" name="commentVal"		value="${comment.commentVal}">	현재 작성한 댓글내용 --%>
									<ul class="comment-write">
										<li>
											<div class="input-item">
												<textarea name="commentVal"></textarea>
											</div>
										</li>
										<li>
											<button type="submit" class="btn-primary">등록</button>
										</li>
									</ul>
								</form>
							</div>
						</c:if>
						<div class="commentBox">
						<c:forEach var="comment" items="${post.commentList}">
							<ul class="posting-comment">
								<li>
									<span class="material-icons">account_box</span>
								</li> 
								<li>
									<p class="comment-info">
										<span>${comment.commentWriter}</span>
										<span>${comment.commentDate}</span>
										<%-- 로그인한 회원 아이디 == 현재 댓글을 작성한 아이디 --%>
										<c:if test="${not empty loginUser and loginUser.userNo eq comment.userNo}">
											<a href='javascript:void(0)' onclick="mdfComment(this, '${comment.userNo}');">수정</a>
											<a href='javascript:void(0)' onclick="delComment('${comment.userNo}');">삭제</a>
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
						<input type=button value="목록으로 돌아가기" onclick="backward()" id="backWardBtn">
					</div>				
				</div>
				</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	//뒤로가기
	function backward() {
		history.go(-1);
	}
	
	///파일 다운로드
	function fileDown(fileName, filePath) {
		location.href = '/post/fileDown?fileName=' + fileName + '&filePath=' + filePath; 
	}
	
	///댓글 삭제
	function delComment(commentNo) {
		swal ({
			title : "삭제",
			text : "댓글을 삭제하시겠습니까?",
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
				let postNo = '${post.postNo}';	//서블릿에서 등록한 post의 postNo	 (댓글삭제후 상세보기로 이동할때 필요한 파라미터)
				//console.log(postNo);
				location.href='/post/deleteComment?postNo='+postNo+"&commentId="+commentId;
			}
		});
	}
	
	
	//댓글 수정
	function mdfComment(obj, commentNo) {
		//obj			: 수정 a링크 요소 객체
		//commentNo 	: 댓글 번호
		let noticeNo = '${post.postNo}';	//수정완료 후, 상세보기 이동시 필요
		
		//기존 댓글 출력 요소 숨김 처리, 수정할 수있는 수정 입력란 보여주기
		let commentValLi = $(obj).parents('li');
		$(commentValLi).find('div.input-item').show();
		$(commentValLi).find('p.comment-val').hide();
		
		//수정 버튼 클릭 시,
		//기존 '수정' -> '수정완료'
		$(obj).text('수정완료');
		$(obj).attr('onclick', 'mdfCommentComplete(this, "' + commentNo + '")');
		
		//기존 '삭제' -> '수정취소'
		$(obj).next().text('수정취소');
		$(obj).next().attr('onclick', 'mdfCommentCancel(this, "' + commentNo + '")');
	}
	
	
	//댓글 수정완료
	function mdfCommentComplete (obj, commentNo) {
		//obj : '수정완료' a 링크 요소 객체
		
		let form = $('<form>');
		form.attr('action', '/post/updateComment');
		form.attr('method', 'post');
		
		let postNo = '${post.postNo}'; //수정 완료 후, 다시 상세보기로 이동 시 필요
		let noticeNoEl = $('<input>');
		postNoEl.attr('type', 'text');
		postNoEl.attr('name', 'postNo');
		postNoEl.attr('value', postNo);
		
		//댓글번호
		let commentNoEl = $('<input>');
		commentNoEl.attr('type', 'text');
		commentNoEl.attr('name', 'postNo');
		commentNoEl.attr('value', postNo);
		
		//수정된 댓글 내용
		let commentValEl = $(obj).parents('li').find('div.input-item');
		
		//폼 태그 하위로 전송 파라미터 값 삽입
		form.append(postNoEl.append(commentNoEl).append(commentValEl));
		$('body').append(form);
		form.submit();
	}
	
	//댓글 수정취소
	function mdfCommentCancel (obj, commentNo) {
		//obj : '수정취소' a 링크 요소 객체
		let CommentContentLi = $(obj).parents('li');
	
		//수정할 수 있는 입력란 다시 숨기기, 기존 댓글 출력요소 보여주기
		$(commentContentLi).find('div.input-item').hide();
		$(commentContentLi).find('p.comment-Val').show();
		
		///onclick 이벤트도 원래대로 되돌리기
		//'수정취소' -> '삭제'
		$(obj).text('삭제');
		$(obj).attr('onclick', 'delComment("' + commentNo + '")');
		
		//'수정완료' -> '수정'
		$(obj).prev().text('수정');
		$(obj).prev().attr('onclick', 'mdfComment(this, "' + commentNo + '")');
	}
</script>
</body>
</html>