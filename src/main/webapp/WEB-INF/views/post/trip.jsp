<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<style>
.trip-main {
	width: 100%;
	min-height : 800px;
	height : auto;
	max-width: 1400px;
	margin: 80px auto 30px auto;
	flex: 1;
	
}

.trip-content {
	width: 1400px;
}

.trip-title {
	font-size: 24px;
}

.trip-user {
	display: flex;
	width: 1000px;
	gap: 15px;
}

.name-title {
	/* 	background-color: rgba(0, 76, 161, 0.3); */
	/* 	width: 100px; */
	
}

.trip-content>span {
	font-size: 20px;
	}

.div-map>div{
 	width: 100%;
	height: 400px;
	margin-top: 10px;
	margin-bottom: 10px;
	z-index: 0;
}

.trip-content{
	width : 100%;
 	border : 1px solid gray;
	min-height: 300px;
}

.sub-data{
	display: flex;
	justify-content: space-between;
}

.filebox-wrap{
	display: flex;
	justify-content: flex-end;
}

.filebox {
	text-align: right;
}

#file{
	display: block;
}

.ul-tag{
	display: flex;
	gap : 20px;
	height : 60px;
	text-align: center;
}



.addTag{
	text-decoration: none;
	font-size: 20px;
	margin : auto 0;
	width : 100px;
	border-radius: 30px;
	background-color : #bbafdf;
	color: white;
	
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

#commentDate {
    padding-right : 20px;
}
.updComment {
    justify-content: End;
}

#commentUserNickname {
    padding-right : 30px;
    color : var(--main2);
    font-weight : bold;
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

.comment-write {
    overflow : hidden;
}
.comment-write textarea[name=commentVal] {
    width : 1165px;
    height : 30px;
    margin-right : 10px; 
}
.comment-write li {
    float : left;
}
.inputCommentBox {
    margin-bottom: 20px;
}

.bottom-warp{
  	display: flex; 
  	justify-content: flex-end;
    align-items: center;
 }
.btn-div{
	margin: 0 auto;
}
.heart-div{
	display : flex;
	justify-content : flex-end;
	width: 100px;
	height: 50px;
	align-items: center;
}
.heart-div>a{
	width: 40px;
	height: 40px;
}

#heart>img{
	width: 100%;
	object-fit:cover;
}

</style>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="trip-main">
			<section class="section">
				<div class="trip-wrap">
					<div class="trip-title">
						<h1>${post.postTitle}</h1>
					</div>
					<div class="trip-user">
						<span class="name-title">작성자</span> <span>:</span> <span
							class="tirp-name">${post.user.userNickname}</span>
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
					<div class="bottom-warp">
					<c:if test="${not empty loginUser and loginUser.userNo eq post.user.userNo}">
						<div class="btn-div">
							<a onclick='modifyPost(${post.postNo})' class = "btn-primary">수정</a>
							<button class="btn-secondary" onclick="deletePost(${post.postNo})">삭제</button>
						</div>
						</c:if>
						<div class="heart-div">
							<span>${post.likeCount }</span> 
							<a href='javascript:void(0)' id="heart" onclick="postLike(this);">
								<c:choose>
									<c:when test="${userLike eq 1}">
										<img src="/resources/images/heart.png">
									</c:when>
									<c:otherwise>
										<img src="/resources/images/heart_none.png">
									</c:otherwise>
								</c:choose>
							</a>
						</div>
					</div>
					
					<c:if test="${not empty loginUser}">
							<div class="inputCommentBox">
								<form name="insertComment" action="/post/insertComment?trip=true" method = "post">
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
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script>
	//좋아요 버튼 클릭
	function postLike(){
		 if(chkLogin()){
		      $.ajax({
		         url : "/post/postLike",
		         type : "GET",
		         data : {
		            "postNo" : "${post.postNo}",
		            "userNo" : "${loginUser.userNo}",
		            }, 
		         success : function(res) {
		            if(res != "-1"){
		            	location.href = "/post/trip?postNo=${post.postNo}";
		            }
		            else{
		               swal({
		                  title : "알림",
		                  text : '${postComment.commentId}' + "호감도 반영 중 오류가 발생하였습니다.",
		                  icon : "error"
		               }).then(function(){
		            	   location.href = "/post/trip?postNo=${post.postNo}";
		               });
		            }
		         },
		         error : function() {
		            console.log("ajax 에러 발생");
		         }
		      });
			  }
	}
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
	
	$(document).ready(function(){
		let list = [];
		$(${spotList}).each(function(index, item){
			let obj = {
				"place_name" : item.spotName,
				"address_name" : item.spotAddr,
				"x" : item.spotLat,
				"y" : item.spotLng,
				"id" : item.kakaoMapId,
				"phone" : item.spotPhone
				}
			list.push(obj);
		});
		
		if(list.length < 1){
			$('#map').css("display", "none");
		}else{
			loadMap(list);
		}
		
		$(${post.tagList}).each(function(index, item){
			let tag = $('<a>');
			tag.attr('class','addTag');
			tag.html(item);
			$('.ul-tag').append(tag);
			console.log(item);
		});
		
		$(${fileList}).each(function(index, item){
			addFileList(item,index);
		});
		
		
		
	});
	
	function addFileList(item,index){
			let fileName = item.fileName;
			let file = $('<a>');
			file.attr('href', "javascript:fileDown("+ "'"+ item.fileName+ "'," + "'"+ item.filePath + "'"+",)");
			file.attr('id', "file");
			let fileNameSpan = $('<span>');
			fileNameSpan.html(fileName);
			let fileBtnSpan = $('<span>');
			fileBtnSpan.attr('class','file_btn material-icons');
			fileBtnSpan.html("remove_circle");
			file.append(fileNameSpan).append(fileBtnSpan);
			$('.filebox').prepend(file);
	}
	
	
	///파일 다운로드
	function fileDown(fileName, filePath) {
		location.href = '/post/fileDown?fileName=' + fileName + '&filePath=' + filePath; 
	}
	
	
	function loadMap(list) {
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	    mapOption = { 
	        center: new kakao.maps.LatLng(list[0].y, list[0].x), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		//마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
		for (var i = 0; i < list.length; i ++) {
	    
	    	// 마커 이미지의 이미지 크기 입니다
	    	var imageSize = new kakao.maps.Size(24, 35); 
	    
	    	// 마커 이미지를 생성합니다    
	    	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    	// 마커를 생성합니다
	    	var marker = new kakao.maps.Marker({
	        	map: map, // 마커를 표시할 지도
	        	position:  new kakao.maps.LatLng(list[i].y, list[i].x), // 마커를 표시할 위치
		        title : list[i].place_name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        	image : markerImage // 마커 이미지 
	    	});
	    
	    	var infowindow = new kakao.maps.InfoWindow({
	        	content: list[i].place_name // 인포윈도우에 표시할 내용
	    	});
	    
	    	kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    	kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}       
	}
	
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
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

				location.href='/post/deleteComment?postNo='+postNo+"&commentId="+commentId + "&trip=true";
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
		form.attr('action', '/post/updateComment?trip=true');
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
	                  location.href = "/post/trip?postNo=${post.postNo}";
	               });
	            }
	            else{
	               swal({
	                  title : "알림",
	                  text : '${postComment.commentId}' + " 댓글 호감도 반영 중 오류가 발생하였습니다.",
	                  icon : "error"
	               }).then(function(){
	                  location.href = "/post/trip?postNo=${post.postNo}";
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