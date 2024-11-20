<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>with trip</title>
<style>
.content {
	margin-left: 20%;
	margin-right: 20%;
	width: 60%;
}

.tbl {
	width: 250px;
	height: 250px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<main class="content">
		<section class="section">
			<div style="display: flex; justify-content: space-between;">
				<%-- 전체 조회, 상세조회, (아이디로 검색) 조회 및 개별 삭제, 선택 삭제, 전체 삭제 --%>
				<div style="display: flex;">
					<span> 페이지 크기 선택 : </span> <select id="slPgSize" onchange="selPgSize()">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="20">20</option>
						<option value="40">40</option>
					</select>
				</div>
			</div>

			<div class="page-title" style="text-align: left;">
				${postTypeName}</div>
			<div class="list-content">
				<table class="tbl">
					<tr class="th">

						<th style="width: 10%; text-align: left;">게시아이디</th>
						<th style="width: 10%; text-align: left;">회원번호</th>
						<th style="width: 10%; text-align: left;">닉네임</th>
						<th style="width: 50%; text-align: left;">제목</th>
						<th style="width: 10%; text-align: left;">게시일</th>
						<th style="width: 10%; text-align: left;">
							<div style="width: 100%;">
								전체 선택 <input type="checkbox" class="chk" value="selectall" onclick="selectAll(this)">
							</div>
						</th>
					</tr>
					<c:forEach var="list" items="${pList}">
						<tbody id="tbody">
						</tbody>
					</c:forEach>
				</table>
				<div id="pageNavi">
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		function srchInfo(){
			postList();
		}
		function selPgSize(){
			postList();
		}
		
		function postList() {
			if(${pOrC==1}){
				$('.section').find('#tbody').remove();
				let pageSize = $('#slPgSize').val();
				let srchMtd = $('#selSrchMtd').val();
				let inptVal = $('#inputTextVal').val();
				console.log(inptVal);
						$.ajax({
							url : "/user/userList",
							type : "GET",
							dataType : "json",//서블릿에서 응답해주는 데이터 형식
							data : {
								"pOrC" : `${pOrC}`,
								"postTypeId" : `${postTypeId}`,
								"postTypeName" : `${postTypeName}`,
								"reqPage" : "1",
								"pageSize" : pageSize,
								"srchMtd" : srchMtd,
								"inptVal" : inptVal
							},
							success : function(res) {
								$(res).each(
										function(index, item) {
											let html = "";
											html += "<tr>";
											html += "<td style='width: 10%; ' rowspan='2' class='postId'>"
												+ item.postNo + "</td>";
											html += "<td style='width: 10%;' rowspan='2'>"
												+ item.userNo
												+ "</td> "
											html += "<td style='width: 10%;' rowspan='2'>"
												+ item.userNickName
												+ "</td>"
											html += "<td><a href='/admin/adminDetail?pOrC=1&postTypeId="+item.postTypeId+"&postTypeName="+item.postTypeName+"&userNo="
												+ item.userNo+ "&postNo=" + item.postNo + "'>" +item.postTitle+ "</td>";
											html += "<td>" + item.postDate
												+ "</td>";
											html += "<td><input type='checkbox' id='allSelDel' name='post'></td>";
											html += "</tr>";
											html += "<tr><td>"
												+ item.postContent
												+ "</td></tr>";

											$('.section').find('#tbody').append(html);
											});
							
							},
							error : function() {
								console.log("ajax통신 오류");
							}
						});
			}
			setInterval(function() {
				postList();
				pagination();
			}, 1000 * 60 * 10);//10분에 1번
			$(function() {
				postList();
				pagination();
			});
			}else{
				$('.section').find('#tbody').remove();
				let pageSize = $('#slPgSize').val();
				let srchMtd = $('#selSrchMtd').val();
				let inptVal = $('#inputTextVal').val();
				console.log(inptVal);
						$.ajax({
							url : "/user/userList",
							type : "GET",
							dataType : "json",//서블릿에서 응답해주는 데이터 형식
							data : {
								"pOrC" : `${pOrC}`,
								"postTypeId" : `${postTypeId}`,
								"postTypeName" : `${postTypeName}`,
								"reqPage" : "1",
								"pageSize" : pageSize,
								"srchMtd" : srchMtd,
								"inptVal" : inptVal
							},
							success : function(res) {
								$(res).each(
										function(index, item) {
											let html = "";
											html += "<tr>";
											html += "<td style='width: 10%; ' rowspan='2' class='postId'>"
												+ item.commentId + "</td>";
											html += "<td style='width: 10%;' rowspan='2'>"
												+ item.userNo
												+ "</td> "
											html += "<td style='width: 10%;' rowspan='2'>"
												+ item.userNickName
												+ "</td>"
											html += "<td><a href='/admin/adminDetail?pOrC=1&userNo=" + item.userNo+ "&cmtId=" + item.commentId+ "'>" +item.commentContent+ "</td>";
											html += "<td>" + item.postDate
												+ "</td>";
											html += "<td><input type='checkbox' id='allSelDel' name='post'></td>";
											html += "</tr>";
											html += "<tr><td>"
												+ item.postContent
												+ "</td></tr>";

											$('.section').find('#tbody').append(html);
											});
							
							},
							error : function() {
								console.log("ajax통신 오류");
							}
						});
			}
			setInterval(function() {
				postList();
				pagination();
			}, 1000 * 60 * 10);//10분에 1번
			$(function() {
				postList();
				pagination();
			});	
			}
		
		function pagination(){
			let pageSize = $('#slPgSize').val();
			let srchMtd = $('#selSrchMtd').val();
			let inptVal = $('#inputTextVal').val();
			
			console.log(srchMtd);
			$.ajax({
				url : "/user/userPageNavi",
				type : "GET",
				dataType : "json",//서블릿에서 응답해주는 데이터 형식
				data : {
					"pOrC" : `${pOrC}`,
					"postTypeId" : `${postTypeId}`,
					"postTypeName" : `${postTypeName}`,
					"reqPage" : "1",
					"pageSize" : pageSize,
					"srchMtd" : srchMtd,
					"inptVal" : inptVal
				},
				success : function(res) {
					$(res) .each(
						function(index, item) {
								$('.section').find('#pageNavi').append(item);
						});
				},
				error : function() {
					console.log("ajax통신 오류");
				}
			});
		}
		function selectAll(selectAll) {
			let checkboxes = document.getElementsByName('posts');

			checkboxes.forEach((checkbox) => {
				checkbox.checked = selectAll.checked;
			});
		}
		function allSelDel() {

			let checkBoxes = $('.chk:checked'); //클래스가 chk인 태그 중 checked인 태그 

			if (checkBoxes.length < 1) {
				swal({
					title: "알림",
					text: "선택한 회원이 없습니다",
					icon: "warning",
				});
				return;
			}
			let postNoArr = [];

			$.each(checkBoxes, function (index, item) {
				postNoArr.push($(item).parents('tr').find('.postNo').html());
				console.log(postNoArr);

			});

			swal({
				title: "알림",
				text: "게시글을 삭제하시겠습니까?",
				icon: "warning",
				buttons: {
					cancle: {
						text: "취소",
						value: false,
						visible: true,
						closeModal: true,
					},
					confirm: {
						text: "삭제",
						value: true,
						visible: true,
						closeModal: true,
					}
				}

			}).then(function (isConfirm) {
				if (isConfirm) {
					$.ajax({
						url: "/user/userSelDel",
						type: "GET",
						data: {
							"postNoArr": postNoArr.join("/")
						},
						success: function (res) {
							location.reload(true);
						},
						error: function () {
							console.log("ajax 에러 발생");
							location.reload(true);
						}
					});

				} else {
					console.log("취소");
					location.reload(true);
				}
			});
		}
	</script>
</body>
</html>