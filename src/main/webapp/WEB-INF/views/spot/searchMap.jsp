<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.search_map_wrap {
	height: 300px;
	display: flex;
	justify-content: center;
	align-items: center;
	background: url(/resources/images/search_back.jpg) no-repeat;
	
	background-size: 100% 550px;
}

.search_map_box {
	width: 540px;
	height: 100px;
	padding: 30px;
	position: relative;
	border-radius: 5px;
	background: rgba(28, 28, 28, 0.4);
}

.input_box {
	position: absolute;
	outline: none;
	border: none;
	width: 100%;
	height: 50px;
	font-size: 18px;
	border-radius: 2px;
	outline: none;
}

.srch_list {
	float: left;
}

.srch_a {
	cursor: pointer;
}

.go_map {
	background: url(/resources/images/map_search.svg) no-repeat;
	position: absolute;
	width: 24px;
	height: 24px;
	top: 13px;
	right: 15px;
	border: none;
	outline: none;
	cursor: pointer;
}

.srch_list, .srch_a, .go_map {
	font-size: 14px;
	color: white;
}

.srch_a:hover {
	text-decoration: underline;
}

.go_map:hover {
	text-decoration: underline;
}

.input_wrap {
	position: relative;
	width: 540px;
	height: 50px;
}

.line {
	position: absolute;
	width: 2px;
	height: 24px;
	background-color: gray;
	margin: 0 10px;
	top: 13px;
	right: 40px;
}

.input_img {
	background: url(/resources/images/map_search.svg) no-repeat;
	position: absolute;
	width: 24px;
	height: 24px;
	top: 13px;
	right: 15px;
	border-left: 1px solid black;
}
</style>
</head>
<body>
	<div class="search_map_wrap">
		<div class="search_map_box">
			<div class="input_wrap">
				<input class="input_box" id="input_box" type="text"
					placeholder="지역명, 장소명으로 검색"
					onKeyPress="if (event.keyCode==13){srchMap();}">
				<div class="line"></div>
				<button class="go_map" onClick="srchMap();"></button>
			</div>
			<div class="srch_list">
				추천 검색어 : <a class="srch_a" onClick="setSrch(this);">강남</a>, <a
					class="srch_a" onClick="setSrch(this);">부산</a>, <a class="srch_a"
					onClick="setSrch(this);">보노보노</a>
			</div>
		</div>
	</div>
	<script>
		function srchMap() {
			var srchVal = $('#input_box').val();

			if (srchVal.length != 0) {
				location.href = "/spot/mainMap?srchVal=" + srchVal;
			} else {
				alert("검색어를 입력해주세요.");
			}

			$('#input_box').val("");
		}

		function setSrch(e) {
			var srchTxt = $(e).text();
			$('#input_box').val(srchTxt);

			srchMap();
			$('#input_box').val("");
		}
	</script>
</body>
</html>