
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip - Festival Main</title>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.festival-title {
	font-weight: bold;
	padding: 40px 30px 30px 30px;
	text-align: center;
	text-indent: 30px;
	font-family: ns-b;
	font-size: 25px;
	color: var(--main2);
}

.festival-wrap {
	padding: 30px;
	width: 1200px;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.festival-box {
	border-radius: 10px;
	box-shadow: 1px 1px 5px 1px;
	margin: 15px;
	width: 265px;
	height: 200px;
	display: block;
	cursor: pointer;
}

.festival-img-box {
	width: 100%;
	height: 150px;
	overflow: hidden;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.festival-img {
	width: 100%;
	height: auto%;
}

.name-box {
	text-align: center;
	height: 50px;
}

.festival-name {
	display: block;
	padding: 10px;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}

button {
	border: none;
	outline: none;
	box-shadow: 1px 1px 3px -1px;
	border-radius: 10px;
	cursor: pointer;
	width: 50px;
	height: 25px;
	background: #e3e3e3;
	color: black;
}

.search-box {
	display: flex;
	justify-content: center;
}

.search-box th {
	height: 50px;
	width: 80px;
}

#search-type1 {
	background: #004ca1;
	color: white;
}

#pagination {
	display: flex;
	justify-content: center;
}

#pagination li {
	text-align: center;
	width: 60px;
}

#pagination .active-page {
	background: #004ca1;
	color: white;
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<section class="section">
				<div class="festival-title">이달의 축제</div>
				<div class="search-box">
					<table>
						<tr>
							<th>검색 기준</th>
							<td><input id="searchType" type="hidden"
								value="${searchType}">
								<button type="button" id="search-type1" onClick="chgTypeDate();">기간</button>
								<button type="button" id="search-type2"
									onClick="chgTypeKeyword();">검색어</button></td>
						</tr>
						<tr>
							<th rowspan="2">지역</th>
							<td><input id="areaCode" type="hidden">
								<button type="button" onClick="selectArea();">전국</button>
								<button type="button" onClick="selectArea(1);">서울</button>
								<button type="button" onClick="selectArea(2);">인천</button>
								<button type="button" onClick="selectArea(3);">대전</button>
								<button type="button" onClick="selectArea(4);">대구</button>
								<button type="button" onClick="selectArea(5);">광주</button>
								<button type="button" onClick="selectArea(6);">부산</button>
								<button type="button" onClick="selectArea(7);">울산</button>
								<button type="button" onClick="selectArea(8);">세종</button></td>
						</tr>
						<tr>
							<td>
								<button type="button" onClick="selectArea(31);">경기</button>
								<button type="button" onClick="selectArea(32);">강원</button>
								<button type="button" onClick="selectArea(33);">충북</button>
								<button type="button" onClick="selectArea(34);">충남</button>
								<button type="button" onClick="selectArea(35);">경북</button>
								<button type="button" onClick="selectArea(36);">경남</button>
								<button type="button" onClick="selectArea(37);">전북</button>
								<button type="button" onClick="selectArea(38);">전남</button>
								<button type="button" onClick="selectArea(39);">제주</button>
							</td>
						</tr>
						<tr id="search-input">
							<th>행사 기간</th>
							<td><input type='date' id='startIn' value='${toDay}'>~<input
								type='date' id='endIn' value='${lastDay}'>
								<button onClick='dateBtn();' type="button">검색</button></td>
						</tr>
					</table>
				</div>
				<div class="festival-wrap">
					<c:forEach var="festival" items="${list}" end="11">
						<div class="festival-box"
							onClick="location.href ='/festival/subInfo?festivalId=${festival.festivalId}&festivalType=${festival.festivalType}'">
							<div class="festival-img-box">
								<img class="festival-img"
									src="${not empty festival.festivalImage ? festival.festivalImage : '/resources/images/withTrip_logo_v_04.png'}" />
							</div>
							<div class="name-box">
								<strong class="festival-name">${festival.festivalTitle}</strong>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="page-list">
					<ul id="pagination">
					</ul>
				</div>
			</section>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
		function re(list){
			// 버튼클릭 시 내부 리스트를 새로 그려줄 함수
			$('.festival-wrap').empty();
			list.forEach(festival => {
			    let festivalBox = $('<div class="festival-box">').on('click', function () {
			        location.href = '/festival/subInfo?festivalId='+festival.festivalId + '&festivalType='+festival.festivalType;
			    });
	
			    let imgSrc = festival.festivalImage && festival.festivalImage.trim() !== "" 
			        ? festival.festivalImage 
			        : "/resources/images/withTrip_logo_v_04.png";
	
			    let imgBox = $('<div class="festival-img-box">')
			        .append('<img class="festival-img" src="' + imgSrc + '" />');
	
			    let nameBox = $('<div class="name-box">')
			        .append('<strong class="festival-name">'+festival.festivalTitle+'</strong>');
	
			    festivalBox.append(imgBox).append(nameBox);
			    $(".festival-wrap").append(festivalBox);
			});
		}
		</script>
	<script>
		$(document).ready(function () {
        	updateButtonStyles();
    	});		
		
		function updateButtonStyles() {
	        // 모든 지역 버튼 초기화
	        $("button").css({
	            "background": "#e3e3e3",
	            "color": "black"
	        });

	        let areaCode = $('#areaCode').val();

	        // 지역 버튼 강조
	        if (!areaCode) {
	            $("button:contains('전국')").css({
	                "background": "#004ca1",
	                "color": "white"
	            });
	        } else {
	            $("button").each(function () {
	                if ($(this).text() == getAreaName(areaCode)) {
	                    $(this).css({
	                        "background": "#004ca1",
	                        "color": "white"
	                    });
	                }
	            });
	        }

	        // 페이지 버튼 스타일 초기화
	        $("#pagination button").css({
	            "background": "#e3e3e3",
	            "color": "black"
	        });

	        // 현재 페이지 버튼 강조
	        $("#pageBtn_" + pageNo).css({
	            "background": "#004ca1",
	            "color": "white"
	        });
	    }
		
			// 검색방법을 표현하기 위한 함수
			let searchType = "${searchType}";
			
			// 페이지를 불러올 때, 페이징 하기위한 내용
			let pageNo = "${list[0].festivalPageNo}"
			let total = "${list[0].festivalTotalCount}";
			let pageItems = 12;
	
			// 전체 페이지 수 계산 (전체갯수 / 보여질 갯수)
			let totalPages = Math.ceil(total / pageItems);
			// 보여줄 페이지 갯수
			let loadPages = 10;
			// 시작 페이지
			let startPage = Math.floor((pageNo - 1) / loadPages) * loadPages + 1;
			// 끝 페이지
			let endPage = Math.floor(((pageNo - 1) / loadPages) + 1) * loadPages;
	
			
			createBtn();
			function createBtn(list){
				
				if(list != null){
				total = list[0].festivalTotalCount;
	            totalPages = Math.ceil(total / pageItems);
	            pageNo = list[0].festivalPageNo;
	            startPage = Math.floor((pageNo - 1) / loadPages) * loadPages + 1;
	    		endPage = Math.floor(((pageNo - 1) / loadPages) + 1) * loadPages;
				} 
				
				// 이전 버튼
				if (pageNo > 1) {
		            $("#pagination").append(
		                "<li><button onClick='prev();'>이전</button></li>"
		            );
		        } else {
		            $("#pagination").append(
		                "<li><button disabled>이전</button></li>"
		            );
		        }
				
				// 페이지 목록
				// 전체 페이지 수가 마지막 페이지 보다 작을 경우
				if (totalPages < endPage) {
					endPage = totalPages;
				}
				for (let i = startPage; i < endPage + 1; i++) {
					let activeClass = i == pageNo ? "active-page" : "";
		            $("#pagination").append(
		            	"<li><button id='pageBtn_" + i + "' class='" + activeClass + "' onClick='selectPage(" + i + ");'>" + i + "</button></li>"
		            );
		        }
				
				// 다음 버튼
		        if (pageNo < totalPages) {
		            $("#pagination").append(
		                "<li><button onClick='next();'>다음</button></li>"
		            );
		        } else {
		            $("#pagination").append(
		                "<li><button disabled>다음</button></li>"
		            );
		        }
		        updateButtonStyles();
			}
			
	
	
			// 이전 버튼 클릭 시, 실행 할 함수
			function prev() {
				 if (pageNo > 1) { 
				        pageNo--;
				        chgPages(pageNo);
				    }
			}
			// 다음 버튼 클릭 시, 실행 할 함수
			function next() {
				if (pageNo < totalPages) {
			        	pageNo++;
			        	chgPages(pageNo);
			    }
			}
	
			function chgTypeDate() {
				searchType = 1;
				$('#searchType').val(searchType);
				$('#search-type1').css("background", "#004ca1");
				$('#search-type1').css("color", "white");
				$('#search-type2').css("background", "#e3e3e3");
				$('#search-type2').css("color", "black");
				$("#search-input").empty();
				$("#search-input").append("<th>행사 기간</th>");
				$("#search-input")
						.append(
								"<td><input type='date' id='startIn' value='${toDay}'>~<input type='date' id='endIn' value='${lastDay}'> <button onClick='dateBtn();' type='button'>검색</button></td>");
			}
			function chgTypeKeyword() {
				searchType = 2;
				$('#searchType').val(searchType);
				$('#search-type2').css("background", "#004ca1");
				$('#search-type2').css("color", "white");
				$('#search-type1').css("background", "#e3e3e3");
				$('#search-type1').css("color", "black");
				$("#search-input").empty();
				$("#search-input").append("<th>검색어</th>");
				$("#search-input")
						.append(
								"<td><input id='keywordIn' type='text'> <button onClick='keywordBtn();' type='button'>검색</button></td>");
			}
	
			// 지역 코드 선택시 실행 할 함수
			function selectArea(num) {
				$('#areaCode').val(num);
				updateButtonStyles();
			}
			
			function selectPage(page) {
		        pageNo = page; // 선택한 페이지 번호를 업데이트
		        chgPages(pageNo); // 페이지 데이터 갱신
		    }
	
			
			// 이전 또는 다음 버튼 클릭 시
			function chgPages(page) {
			    let toDay = null;
			    let lastDay = null;
			    let keyword = null;
	
			    if (searchType < 2) {
		            toDay = $('#startIn').val()?.replaceAll("-", "");
		            lastDay = $('#endIn').val()?.replaceAll("-", "");
		            if (!toDay) {
		                alert("시작일을 입력해주세요.");
		                return;
		            }
			    } else if (searchType > 1) {
		            keyword = $('#keywordIn').val();
		            if (!keyword || keyword.trim().length < 1) {
		                alert("검색어를 입력해주세요.");
		                return;
		            }
		        }
	
			    let areaCode = $('#areaCode').val();
	
			    $.ajax({
		            url: "/festival/selectPage",
		            method: "GET",
		            data: {
		                "searchType": searchType,
		                "toDay": toDay,
		                "lastDay": lastDay,
		                "keyword": keyword,
		                "areaCode": areaCode,
		                "selectPage": page
		            },
		            success: function (jsonStr) {
		                if (jsonStr && jsonStr.length !== 0) {
		                    list = jsonStr;
		                    re(list);

		                    $("#pagination").empty();
		                    createBtn(list);
		                } else {
		                    alert("검색 결과가 없습니다.");
		                    return;
		                }
		            },
			        error: function (jqXHR, textStatus, errorThrown) {
			            console.log("AJAX 요청 실패:", textStatus, errorThrown);
			            console.log("상태 코드:", jqXHR.status);
			            console.log("응답 텍스트:", jqXHR.responseText);
			        }
			    });
			}
			
			function getAreaName(code) {
		        const areaMap = {
		            "1": "서울",
		            "2": "인천",
		            "3": "대전",
		            "4": "대구",
		            "5": "광주",
		            "6": "부산",
		            "7": "울산",
		            "8": "세종",
		            "31": "경기",
		            "32": "강원",
		            "33": "충북",
		            "34": "충남",
		            "35": "경북",
		            "36": "경남",
		            "37": "전북",
		            "38": "전남",
		            "39": "제주"
		        };
		        return areaMap[code] || "전국";
		    }
			
			// 기간으로 검색을 할 시
			function dateBtn() {
				let selectPage = "1";
				let toDay = $('#startIn').val().replaceAll("-", "");
				let lastDay = $('#endIn').val().replaceAll("-", "");
				let areaCode = $('#areaCode').val();
				
				if(toDay.length == ""){
					alert("시작일을 입력해주세요.");
				}else{
					
				$.ajax({
					url : "/festival/selectPage",
					method : "GET",
					data : {
						"searchType": searchType,
				        "toDay": toDay,
				        "lastDay": lastDay,
				        "areaCode": areaCode,
				        "selectPage": selectPage
					},
					success : function(jsonStr) {
						if (jsonStr && jsonStr.length !== 0) {
							list = jsonStr;
							re(list);
							
							$("#pagination").empty(); 
			                createBtn(list);
						} else {
							alert("검색 결과가 없습니다.");
				            return;
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
				        console.log("AJAX 요청 실패:", textStatus, errorThrown);
				        console.log("상태 코드:", jqXHR.status); // HTTP 상태 코드
				        console.log("응답 텍스트:", jqXHR.responseText); // 서버 오류 메시지
					}
				});
				}
			}
			
			// 키워드로 검색을 할 시
			function keywordBtn() {
				let selectPage = "1";
				let keyword = $('#keywordIn').val();
				let areaCode = $('#areaCode').val();
				
				if(keyword.length < 1){
					alert("검색어를 입력해주세요.");
				}else{
					
				$.ajax({
					url : "/festival/selectPage",
					method : "GET",
					data : {
						"searchType": searchType,
				        "keyword": keyword,
				        "areaCode": areaCode,
				        "selectPage": selectPage
					},
					success : function(jsonStr) {
						if (jsonStr && jsonStr.length !== 0) {
							list = jsonStr;
							re(list);
							
							$("#pagination").empty(); 
			                createBtn(list);
						} else {
							alert("검색 결과가 없습니다.");
				            return;
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
				        console.log("AJAX 요청 실패:", textStatus, errorThrown);
				        console.log("상태 코드:", jqXHR.status); // HTTP 상태 코드
				        console.log("응답 텍스트:", jqXHR.responseText); // 서버 오류 메시지
					}
				});
				}
			}
			
		</script>
</body>
</html>
