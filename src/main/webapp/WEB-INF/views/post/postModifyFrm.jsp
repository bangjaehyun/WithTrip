<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css" />
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<style>
.post-main {
	width: 100%;
	max-width: 1400px;
	margin: 80px auto 30px auto;
	flex: 1;
}

.post-main div {
	margin-top: 10px;
}

.lg {
	margin-bottom : 20px;
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

.div-subFun div{
	display: flex;
	justify-content: space-between;
}

.div-map>.map-wrap{
	width: 100%;
}

.div-day>input{
	border: none;
	pointer-events : none;
	font-size: 20px;
	font-weight: bold;
	width: 100%;
}

.div-subFun button{
	color : white;
	font-size: 16px;
	border-radius: 10px;
	width: 100px;
	height: 45px;
	font-weight: bold;
	border: none;
	background: linear-gradient(to top, #5882FA, #004CA1);
}


body button:hover{
  transform: scale(1.1,1.1);
  box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
}

#map {
	width: 95%;
	height: 500px;
}


#map>div>div{
	z-index: 0;
	line-height: 5px;
}

.ul-tag{
display: flex;
justify-content : center;
border-radius: 30px;
height: 50px;
width: 600px;
gap : 20px;
background-color: #e2d9fc;
text-align: center;

}

.ul-tag li{
	text-decoration: none;
	font-size: 20px;
	margin : auto 0;
	width : 100px;
	border-radius: 30px;
	cursor: pointer;
}

.ul-tag li:hover{
	background-color : #bbafdf;
	color: white;
}

.addTag{
	background-color : #bbafdf;
	color: white;
}


</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="post-main">
			<section class="section post-list-wrap">
				<form action="/post/writer" id="post-view" method="post" autocomplete="off" enctype="multipart/form-data">
					<input type="hidden" name="postNo" value="${post.postNo}"/>
					<div>
						<p class="Content-title lg">${post.postTypeNm} 수정</p>
					</div>
					<c:if test="${post.postTypeCd eq 1}">
						<div class="div-subFun">
							<div class="div-map">
								<div class="map-wrap">
									<div id="map"></div>
								</div>
								<button type="button" onclick="openMap()">지도 열기</button>
							</div>
							<div class="div-day">
								<input type="text" id="tripDate" name="tripDate" onfocus="this.blur()" readonly>
								<button type="button" onclick="openCalendar()">캘린더 열기</button>
							</div>
							<div class="div-tag">
								<ul class="ul-tag">
									<li onclick="tagClick(this)">#아이들과</li>
									<li onclick="tagClick(this)">#혼자</li>
									<li onclick="tagClick(this)">#커플</li>
									<li onclick="tagClick(this)">#우정</li>
									<li onclick="tagClick(this)">#부모님과</li>
								</ul>
							</div>
						</div>
					</c:if>
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
					<button class="btn-success" onclick="postModify()">수정</button>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<script>
	function postModify(){
		$("input[id*=note-dialog]").remove();
		
		var form = $('#post-view')[0];
		var formData = new FormData(form);
		formData.append("mapList", JSON.stringify(mapList));
		
		tagList = [];
		 $('.addTag').each(function(index,item){
			 tagList.push($(this).text());
		});
		 
		if(tagList.length > 0){
			formData.append("tagList", JSON.stringify(tagList));
		}
		
		if(removeFileList.length > 0){
			formData.append("removeFileList", JSON.stringify(removeFileList));
		}
		
		swal({
			title : "알림",
			text : "수정을 완료하시겠습니까?",
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
				$.ajax({
					url : "/post/modify",
					type : "POST",
					enctype:'multipart/form-data',
					data : formData, 
					processData:false,
					contentType:false,
					cache:false,
					success : function(res) {
						if(res == "1"){
							swal({
								title : "알림",
								text : "${postTypeNm}" + " 수정이 완료 되었습니다.",
								icon : "success"
							}).then(function(){
								location.href = "/post/view?postNo="+ ${post.postNo};
								
							});
						}else{
							swal({
								title : "알림",
								text :  "${postTypeNm}" + "수정중 오류가 발생하였습니다.",
								icon : "error"
							}).then(function(){
								location.href = "/post/view?postNo="+ ${post.postNo};
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
	
	//제거된 파일 리스트 관리할 리스트
	let removeFileList = [];
	
	//맵에 정보를 담을 리스트
	let maplist = null;
	
	//파일을 담을 리스트
	let fileList = [];
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
		
		maplist = list;
		if(maplist.length < 1){
			$('#map').css("display", "none");
		}else{
			firstAddMap(maplist);
		}
		
		$(${fileList}).each(function(index, item){
			fileList.push(item);
		});
		
		if(fileList.length > 0){
			addFileList(fileList);
		}
		
		$('#postContent').summernote('code', '${post.postContent}');
		$('#postTitle').val("${post.postTitle}");
		$('#tripDate').val("${post.tripDate}");
		
		$(${post.tagList}).each(function(index, item){
			$('.ul-tag>li:contains('+item+')').addClass("addTag");
		});
		
	});
	
	//태그내용 선택했을경우 색상 변경하려는 함수
	function tagClick(obj){
		if($(obj).attr('class') == "addTag"){
			$(obj).removeClass("addTag");
		}else{
			$(obj).addClass("addTag");
		}
	}
	
	function addFileList(list){
		list.map(function(item,index){
			console.log(item);
			let fileName = item.fileName;
			
			let fileLabel = $('<label>');
			fileLabel.attr('class','filelabel');
			let file = $('<input>');
			file.attr('type','text');
			file.attr('name', item.fileNo);
			file.attr('id', item.filePath);
			file.attr('onclick', 'onDelete(this)');
			let fileNameSpan = $('<span>');
			fileNameSpan.attr('class','file_name');
			fileNameSpan.html(fileName);
			let fileBtnSpan = $('<span>');
			fileBtnSpan.attr('class','file_btn material-icons');
			fileBtnSpan.html("remove_circle");
			
			fileLabel.append(file).append(fileNameSpan).append(fileBtnSpan);
			$('.subFileBox').prepend(fileLabel);
		});
		
	}
	
	function onDelete(obj){
		swal({
			title : "알림",
			text : "등록된 파일을 제거하시겠습니까?",
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
				let removeFile = {"fileName" : $(obj).attr('id'), "fileNo" : $(obj).attr('name')};
				removeFileList.push(removeFile);
				$(obj).parent().remove();
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
	
	function firstAddMap(list) {
		console.log(list);
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
	    	mapList = list;
		}       
	}
	
	
	function addMap(list) {
		if(maplist != null){
			$('#map').empty();
		}
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	    mapOption = { 
	        center: new kakao.maps.LatLng(list[0].y, list[0].x), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		

		// 마커 이미지의 이미지 주소입니다
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
	    	mapList = list;
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
	function calMapList(){
		return mapList;
	}
	
	function openMap(){
		let popupWidth = 1550;
		let popupHeight = 720;
		
		let top = (window.innerHeight - popupHeight) / 2+ window.screenY;
		let left = (window.innerWidth - popupWidth) / 2+ window.screenX;
		window.open("/spot/likeFrm" , "map", "width="+popupWidth+", height=" + popupHeight + ", top=" + top + ", left=" + left)
	}
	function openCalendar(){
		let popupWidth = 580;
		let popupHeight = 600;
		
		let top = (window.innerHeight - popupHeight) / 2+ window.screenY;
		let left = (window.innerWidth - popupWidth) / 2+ window.screenX;
		
		window.open("/openCalendar", "calendar", "width="+popupWidth+", height=" + popupHeight + ", top=" + top + ", left=" + left);
	}
	
	$('#postContent').summernote(
			{
				codeviewFilter : false, // 코드 보기 필터 비활성화
				codeviewIframeFilter : true, // 코드 보기 iframe 필터 비활성화
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
				
				callbacks : {                                                    
					onImageUpload : function(files, editor, welEditable) {   
		                // 다중 이미지 처리를 위해 for문을 사용했습니다.
						for (var i = 0; i < files.length; i++) {
							uploadImage(files[i], this);
						}
					}
// 					onMediaDelete : function($target) {

// 		         	}
				}

			});
	
	
	</script>
</body>
</html>