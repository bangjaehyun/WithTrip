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
    height : 100%;
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
.comment-info {
    display : flex;
    justify-content: space-between;
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

.cmt-react > img {
    padding-top : 5px;    
}
#commentLike{
    display : inline-block;
    text-align : center;
    align-content: start;
    padding-right : 10px;
}
#commentDislike {
    padding-left : 20px;
    padding-right : 10px;
}
/* #commentDislikeCnt {
    padding-right : 540px;
} */
#commentUserNickname {
    padding-right : 30px;
    color : var(--main2);
    font-weight : bold;
}
#commentDate {
    padding-right : 20px;
}
.updComment {
    justify-content: End;
}
.list-content {
    width: 1000px;
    justify-content: center;
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
#mdfComment {
    padding-right: 10px;
}
#mdfComment:hover {
    color : var(--main3);
}
#delComment:hover {
    color : #f90b00;
}
#thumb {
    padding-top : 3px;
    width : 18px;
    height : 20px;
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section post-view-wrap">
				<div class="page-title">${post.postTypeNm}</div>
				<div class="list-body">
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
					<div class="list-content">
						<table class="tbl post-view">
						<tr>
							<th colspan = "6">
								${post.postTitle}
							</th>
						</tr>
						<tr>
							<th style="width:10%;">작성자</th>
							<td style="width:15%;">${post.user.userNickname}</td>
							<th style="width:10%;">작성일</th>
							<td style="width:15%;">${post.postDate}</td>
							<th style="width:10%;">조회수</th>
							<td style="width:10%;">${post.readCount}</td>
						</tr>
						<tr>
						<th>첨부파일</th>
						<td colspan="6">
							<c:forEach var="file" items="${post.fileList}">
								<a href="javascript:fileDown('${file.fileName}', '${file.filePath}',)">${file.fileName}</a>
							</c:forEach>
						</td>
						</tr>
						<tr>
							<td class="left" colspan="6">
								<div class="postContent">${post.postContent}</div>
							</td>
						</tr>
						<c:if test="${not empty loginUser and loginUser.userNo eq post.user.userNo}">
						<tr>
							<td colspan="6">
								<a onclick='modifyPost(${post.postNo})' class = "btn-primary">수정</a>
								<button class="btn-secondary" onclick="deletePost(${post.postNo})">삭제</button>
							</td>
						</tr>
						</c:if>
						</table>
						<c:if test="${not empty loginUser}">
							<div class="inputCommentBox">
								<form name="insertComment" action="/post/insertComment" method = "post">
									<input type="hidden" name="commentRef" 		value="${post.postNo}">	<%-- 현재 게시글 번호 --%>
									<input type="hidden" name="commentWriter"	value="${loginUser.userNo}"> <%-- 현재 댓글 작성자(로그인한 회원) --%>
									<input type="hidden" name="postTypeCd"		value="${post.postTypeCd}">		<%-- 현재 게시글 분류 --%>
									<input type="hidden" name="commentId"		value="${comment.commentId}">	<%--작성한 댓글PK commentId --%>
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
									<div class="comment-info">
										<div class="cmt-info">
											<span id="commentUserNickname">${comment.user.userNickname}</span>
											<span id="commentDate">${comment.commentDate}</span>
											<span class="cmt-react">										
												<a href='javascript:void(0)' id="commentLike" onclick="commentLike(this,'${comment.commentId}',1);">
													<img src="/resources/images/thumb_up_line.png" id="thumb">	
												</a> 
											</span>
											<span id="commentLikeCnt">${comment.commentLike}</span>
											<span class="cmt-react">
												<a href='javascript:void(0)' id="commentDislike" onclick="commentLike(this, '${comment.commentId}',-1);">
													<img src="/resources/images/thumb_down_line.png" id="thumb">
												</a>
											</span>
											<span id="commentDislikeCnt">${comment.commentDislike}</span>
										</div>
										<%-- 로그인한 회원 아이디 == 현재 댓글을 작성한 아이디 --%>
										<c:if test="${not empty loginUser and loginUser.userNo eq comment.user.userNo}">
											<div class="updComment">
												<a href='javascript:void(0)' id="mdfComment" onclick="mdfComment(this, '${comment.commentId}');">수정</a>
												<a href='javascript:void(0)' id="delComment" onclick="delComment('${comment.commentId}');">삭제</a>
											</div>
										</c:if>
									</div>
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
	//게시글 수정
	function modifyPost(modifyPostNo){
		swal({
			title : "게시글 수정",
			text : "게시글을 수정하시겠습니까?",
			icon : "warning",
			buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm : {
					text : "수정",
					value : true,
					visible : true,
					closeModal : true
				}
			}
		}).then(function(isConfirm){
			if(isConfirm){
				location.href = "/post/modifyFrm?postNo="+ modifyPostNo;
			}
		})
	}
	//게시글 삭제
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
								location.href = "/post/list?reqPage=1&postTypeCd=" + ${post.postTypeCd} + "&postTypeNm=" + ${post.postTypeCd};
							});
						}else{
							swal({
								title : "알림",
								text : '${post.postTypeNm}' + "삭제중 오류가 발생하였습니다.",
								icon : "error"
							}).then(function(){
								location.href = "/post/list?reqPage=1&postTypeCd=" + ${post.postTypeCd} + "&postTypeNm=" + ${post.postTypeCd};
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
	//뒤로가기
	function backward() {
// 		window.history.back();
		location.href = "/post/list?reqPage=1&postTypeCd=${post.postTypeCd}&postTypeNm=${post.postTypeCd}"
	}
	
	///파일 다운로드
	function fileDown(fileName, filePath) {
		location.href = '/post/fileDown?fileName=' + fileName + '&filePath=' + filePath; 
	}
	
	///댓글 삭제
	function delComment(commentId) {
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

				location.href='/post/deleteComment?postNo='+postNo+"&commentId="+commentId;
			}
		});
	}
	
	
	//댓글 수정
	function mdfComment(obj, commentId) {
		//obj			: 수정 a링크 요소 객체
		//commentId 	: 댓글 번호
		let postNo = '${post.postNo}';	//수정완료 후, 상세보기 이동시 필요
		
		//기존 댓글 출력 요소 숨김 처리, 수정할 수있는 수정 입력란 보여주기
		let commentValLi = $(obj).parents('li');
		$(commentValLi).find('div.input-item').show();
		$(commentValLi).find('p.comment-val').hide();
		
		//수정 버튼 클릭 시,
		//기존 '수정' -> '수정완료'
		$(obj).text('수정완료');
		$(obj).attr('onclick', 'mdfCommentComplete(this, "' + commentId + '")');
		
		//기존 '삭제' -> '수정취소'
		$(obj).next().text('수정취소');
		$(obj).next().attr('onclick', 'mdfCommentCancel(this, "' + commentId + '")');
	}
	
	
	//댓글 수정완료
	function mdfCommentComplete (obj, commentId) {
		//obj : '수정완료' a 링크 요소 객체
		
		let form = $('<form>');
		form.attr('action', '/post/updateComment');
		form.attr('method', 'post');
		
		let postNo = '${post.postNo}'; //수정 완료 후, 다시 상세보기로 이동 시 필요
		let postNoEl = $('<input>');
		postNoEl.attr('type', 'text');
		postNoEl.attr('name', 'postNo');
		postNoEl.attr('value', postNo);
		
		//댓글번호
		let commentNoEl = $('<input>');
		commentNoEl.attr('type', 'text');
		commentNoEl.attr('name', 'commentId');
		commentNoEl.attr('value', commentId);
		
		//수정된 댓글 내용
		let commentValEl = $(obj).parents('li').find('div.input-item');
		
		//폼 태그 하위로 전송 파라미터 값 삽입
		form.append(postNoEl.append(commentNoEl).append(commentValEl));
		$('body').append(form);
		form.submit();
	}
	
	//댓글 수정취소
	function mdfCommentCancel (obj, commentId) {
		//obj : '수정취소' a 링크 요소 객체
		let CommentContentLi = $(obj).parents('li');
	
		//수정할 수 있는 입력란 다시 숨기기, 기존 댓글 출력요소 보여주기
		$(commentContentLi).find('div.input-item').hide();
		$(commentContentLi).find('p.comment-Val').show();
		
		///onclick 이벤트도 원래대로 되돌리기
		//'수정취소' -> '삭제'
		$(obj).text('삭제');
		$(obj).attr('onclick', 'delComment("' + commentId + '")');
		
		//'수정완료' -> '수정'
		$(obj).prev().text('수정');
		$(obj).prev().attr('onclick', 'mdfComment(this, "' + commentId + '")');
	}
	
	
	   //댓글 좋아요, 좋아요 취소
	   function commentLike (obj, commentId, like) {
		  if(chkLogin()){
	      $.ajax({
	         url : "/post/updCmtLike",
	         type : "GET",
	         data : {
	            "postNo" : "${post.postNo}",
	            "commentId" : commentId,
	            "userNo" : "${loginUser.userNo}",
	            "like" : like
	            }, 
	            success : function(res) {
		            if(res != "0"){
		               swal({
		                  title : "알림",
		                  text : '${postComment.commentId}' + res,
		                  icon : "success"
		               }).then(function(){
		                  location.href = "/post/view?postNo=${post.postNo}";
		               });
		            }
		            else{
		               swal({
		                  title : "알림",
		                  text : '${postComment.commentId}' + " 댓글 호감도 반영 중 오류가 발생하였습니다.",
		                  icon : "error"
		               }).then(function(){
		                  location.href = "/post/view?postNo=${post.postNo}";
		               });
		            }
		         },
	         error : function() {
	            console.log("ajax 에러 발생");
	         }
	      });
		  }
	   }
	  
	   
	   function chkLogin(){
		   if(${empty loginUser}){
		 		return false;
		   }else{
			   return true;
		   }
	   }
	 
	
</script>
</body>
</html>