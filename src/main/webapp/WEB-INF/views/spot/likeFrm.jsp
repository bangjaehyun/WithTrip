<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like Frm</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/map.css" />
<style>
.content {
	positon: relative;
	display: flex;
	width: 1430px;
}

#map_window {
	padding: 0;
	margin: 0;
	width: 1200px;
	height: 700px;
}

#like_wrap {
	position: absolute;
	height: 700px;
	width: 300px;
	left: 1208px;
	z-index: 2;
	font-size: 12px;
	display: inline-block;
	border: 1px solid black;
	border-radius: 10px;
}

#like_container::-webkit-scrollbar {
	width: 10px;
}

#like_container::-webkit-scrollbar-thumb {
	background: rgba(051, 051, 051, 0.7);
	border-radius: 10px;
}

#like_container::-webkit-scrollbar-track {
	background: rgba(255, 255, 255, 0.0);
}

#like_container {
	height: 700px;
	overflow-y: auto;
}

#likeList {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

#likeList li {
	list-style: none;
}

#likeList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#likeList .item span {
	display: block;
	margin-top: 4px;
}

#likeList .item h5, #likeList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#likeList .item .info {
	padding: 10px 0px 10px 50px;
}

#likeList .info .gray {
	color: #8a8a8a;
}

#likeList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#likeList .info .tel {
	color: #009900;
}

#likeList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background: url(/resources/images/map_star_fill.svg) no-repeat;
}

#confirmBtn {
	position: absolute;
	z-index: 2;
	top: 15px;
	right: 30px;
	cursor: pointer;
	width: 50px;
	height: 35px;
	background-color: white;
	border-radius: 25px;
	border: 1px solid #909090;
	justify-content: center;
}
</style>
</head>
<body>
	<main class="content">
		<div id="map_window">
			<jsp:include page="/WEB-INF/views/common/map.jsp">
				<jsp:param name="val02" value="두번째값}" />
			</jsp:include>
		</div>
		<div id="like_wrap">
			<div id="like_container">
				<ul id="likeList"></ul>
			</div>
		</div>
	</main>

	<script>
		var ArrayList = [];
		
		function listAdd(place) {
			// ArrayList가 비어있지 않을 때
			if(ArrayList.length != 0){
				var set = new Set(ArrayList);
				
				if(set.has(place)){
					alert("중복 장소가 존재합니다.");
				}else{
					let Tag = getListItem(ArrayList.length, place);
					let buttonEl = '<button onclick="listRemove(this)">' + "삭제"
							+ '</button>';
					
					$(Tag).append(buttonEl);
					$("#likeList").append(Tag);
					ArrayList.push(place);

					set = new Set(ArrayList);
				}
			}else{
			// ArrayList가 비어있을 때 (아무것도 등록하지 않았을 때)
			let Tag = getListItem(ArrayList.length, place);
			let buttonEl = '<button onclick="listRemove(this)">' + "삭제"
					+ '</button>';
			
			$(Tag).append(buttonEl);
			$("#likeList").append(Tag);
			ArrayList.push(place);
			
			set = new Set(ArrayList);
			}
		}

		function listRemove(obj) {
			let srchName = $(obj).parent().find('h3').text();
			ffList = ArrayList.filter(param => param.place_name != srchName);
			ArrayList = ffList;
			$(obj).parent().remove();
		}

		function confrim() {
			var result = confirm("저장하시겠습니까?")
			if(result){
			window.opener.list = ArrayList;
			self.close();
			}
		}
		
	</script>

</body>
</html>