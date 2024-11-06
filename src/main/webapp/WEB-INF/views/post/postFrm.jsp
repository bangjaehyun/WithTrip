<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css" />

<style>
.post-main {
	width: 100%;
	max-width: 1400px;
	margin: 110px auto 30px auto;
	flex: 1;
}

.post-main div {
	margin-top: 10px;
}

.lg {
	margin-bottom : 50px;
	font-size: 30px;
	font-weight: bold;
}

.postTitle-wrap {
	width: 100%;
}

.postTitle-wrap>input {
	border: 0px;
	border-bottom: 1px solid lightgray;
	border-radius: 3px;
	height: 50px;
	width: 100%;
	font-size: 40px;
	color: black;
}

.filebox {
	display: flex;
	justify-content: flex-end;
}

.subFileBox{
	text-align: right;
}

.filelabel {
	display : block;
	margin: auto 0;
}

.filelabel>input {
	display: none;
}

.file_name {
	color: rgb(204, 200, 199);
}

.file_btn {
	display: inline-block;
	height: 30px;
	vertical-align: middle;
	align-self: flex-end;
	color: rgb(87, 130, 229);
}

.btn-wrap>button {
	font-size: 16px;
	border-radius: 10px;
	width: 100px;
	height: 45px;
	font-weight: bold;
	border: 1px solid gray;
}

.btn-wrap {
	text-align: right;
}

.btn-cancel {
	background: white;
}

.btn-success {
	background: rgb(189, 236, 255);
}

.div-day{
	display: flex;
	justify-content: space-between;
}

.div-day>input{
	border: none;
	pointer-events : none;
	font-size: 20px;
	font-weight: bold;
	width: 100%;
}

.div-day>button{
	color : white;
	font-size: 16px;
	border-radius: 10px;
	width: 100px;
	height: 45px;
	font-weight: bold;
	border: none;
	background: linear-gradient(to top, #5882FA, #004CA1);
}

.div-day>button:hover{
  transform: scale(1.1,1.1);
  box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
}

.btn-wrap>button:hover{
  transform: scale(1.1,1.1);
  box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
}


</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="post-main">
			<section class="section post-list-wrap">
				<form action="/post/writer" class="tbl post-view" method="post" autocomplete="off" enctype="multipart/form-data">
					<div>
						<p class="Content-title lg">게시글 작성</p>
					</div>
					<div class="div-day">
						<input type="text" id="postDay" onfocus="this.blur()" readonly>
						<button type="button" onclick="openCalendar()">캘린더 열기</button>
					</div>
					<div class="postTitle-wrap">
						<input type="text" name="postTitle" id="postTitle" placeholder="제목">
					</div>
					<div class="filebox">
					<div class="subFileBox">
						<label class="filelabel"> 
						<input type="file" name="uploadFile" onchange="change(this)"> 
						<span class="file_name">첨부 파일</span> 
						<span class="file_btn material-icons">add_circle</span>
						</label>
					</div>
					</div>
					<div class='post-content'>
						<textarea id="postContent" name="postContent"></textarea>
					</div>
				</form>
				<div class="btn-wrap">
					<button class="btn-cancel" onclick="postCancel()">취소</button>
					<button class="btn-success" onclick="postInsert()">등록</button>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<script>
	function openCalendar(){
		let popupWidth = 580;
		let popupHeight = 600;
		
		let top = (window.innerHeight - popupHeight) / 2+ window.screenY;
		let left = (window.innerWidth - popupWidth) / 2+ window.screenX;
		
		window.open("/openCalendar", "calendar", "width="+popupWidth+", height=" + popupHeight + ", top=" + top + ", left=" + left);
	}
	function postCancel(){
// 		$("#postContent").summernote('insertText', '<p>Hello, world</p>')
		let tag = $('<p>');
		tag.html("Gd");
		$('.note-editable').append(tag);
		swal({
			title : "알림",
			text : "게시글 작성을 취소하시겠습니까?",
			icon : "warning",
			buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm :{
					text : "확인",
					value : true,
					visible : true,
					closeModal : true
				}
			}
		}).then(function(isConfrim){
			if(isConfrim){
				<%-- 게시글을 취소했을경우 페이지 이동 --%>
			}
		});
	}
	
	function postInsert(){
		swal({
			title : "알림",
			text : "게시글을 등록 하시겠습니까?",
			icon : "warning",
			buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm :{
					text : "확인",
					value : true,
					visible : true,
					closeModal : true
				}
			}
		}).then(function(isConfrim){
			if(isConfrim){
				$('form').submit();
			}
		});
	}
	
	function change(obj){
				if ($(obj).val().length > 1) {
					var fileName = $(obj).val().split('/').pop().split('\\').pop();
						if($(obj).next().html() == '첨부 파일'){
							$(obj).next().html(fileName);
							$(obj).next().next().html("remove_circle");
							
							let fileLabel = $('<label>');
							fileLabel.attr('class','filelabel');
							
							let file = $('<input>');
							file.attr('type','file');
							<%-- uploadFile의 name을 바꿔주기 위한 자식 갯수 --%>
							let chiledCount = $(obj).parent().parent().children('label').length;
							file.attr('name','uploadFile'+chiledCount);
							file.attr('onchange', 'change(this)');
							let fileNameSpan = $('<span>');
							fileNameSpan.attr('class','file_name');
							fileNameSpan.html("첨부 파일");
							
							let fileBtnSpan = $('<span>');
							fileBtnSpan.attr('class','file_btn material-icons');
							fileBtnSpan.html("add_circle");
							
							<%-- 파일 라벨로 합치기 --%>
							fileLabel.append(file).append(fileNameSpan).append(fileBtnSpan);
							
							<%-- 부모 div마지막 요소로 추가 --%>
							$(obj).parent().parent().append(fileLabel);
						}else{
							$(obj).next().html(fileName);
						}
					
				} else {
					if($(obj).parent().parent().children().length > 1){
						$(obj).parent().remove();
					}else{
						$(obj).next().html("첨부 파일");
						$(obj).next().next().html("add_circle");
					}
				}
			};
		

		$('#postContent').summernote(
				{
					codeviewFilter : false, // 코드 보기 필터 비활성화
					codeviewIframeFilter : false, // 코드 보기 iframe 필터 비활성화
					height : 700, // 에디터 높이
					width : '100%',
					minHeight : null, // 최소 높이
					maxHeight : null, // 최대 높이
					focus : true, // 에디터 로딩 후 포커스 설정
					lang : 'ko-KR', // 언어 설정 (한국어)
					disableDragAndDrop : false,
					tabDisable : true,
					placeholder : '게시글 작성',
					disableResizeEditor : true, // Does not work either
					toolbar : [ [ 'style', [ 'style' ] ], // 글자 스타일 설정 옵션
					[ 'fontsize', [ 'fontsize' ] ], // 글꼴 크기 설정 옵션
					[ 'font', [ 'bold', 'underline', 'clear' ] ], // 글자 굵게, 밑줄, 포맷 제거 옵션
					[ 'color', [ 'color' ] ], // 글자 색상 설정 옵션
					[ 'table', [ 'table' ] ], // 테이블 삽입 옵션
					[ 'para', [ 'ul', 'ol', 'paragraph' ] ], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
					[ 'height', [ 'height' ] ], // 에디터 높이 조절 옵션
					[ 'insert', [ 'picture', 'link', 'video' ] ], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
					[ 'view', [ 'codeview', 'fullscreen', 'help' ] ], // 코드 보기, 전체 화면, 도움말 옵션
					],

					fontSizes : [ '8', '9', '10', '11', '12', '14', '16', '18',
							'20', '22', '24', '28', '30', '36', '50', '72', ], // 글꼴 크기 옵션

					styleTags : [ 'p', // 일반 문단 스타일 옵션
					{
						title : 'Blockquote',
						tag : 'blockquote',
						className : 'blockquote',
						value : 'blockquote',
					}, // 인용구 스타일 옵션
					'pre', // 코드 단락 스타일 옵션
					{
						title : 'code_light',
						tag : 'pre',
						className : 'code_light',
						value : 'pre',
					}, // 밝은 코드 스타일 옵션
					{
						title : 'code_dark',
						tag : 'pre',
						className : 'code_dark',
						value : 'pre',
					}, // 어두운 코드 스타일 옵션
					'h1', 'h2', 'h3', 'h4', 'h5', 'h6', // 제목 스타일 옵션
					],

				});
	</script>
</body>
</html>