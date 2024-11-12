<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>내가 작성한 댓글</title>
<style>
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
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="content mypage-container">
		<div class="wrap">
			<div class="page-title">내가 작성한 댓글</div>
			<div style="border: 1px solid black; display: flex;">
				
			</div>


			<%--==================================================List============================================================
								--%>
			<div id="allPostMng" style="display: block">
				<table class="tbl tbl-hover" style="border: 1px solid black">
					<tr>
						<th style="width: 10%; text-align: left;">검색
							<select>
								<option>제목으로 검색</option>
								<option>장소로 검색</option><%--삭제가능성 있음 --%><%//TODO %>
							</select>
						</th>	
						
						<th style="width: 50%; text-align: left;">
						검색 <input type="text" id="srchData" value="" style="width:100%">
						</th>
						
						<th style="width: 10%; text-align: left;">
						 <button id="srchBttn" onclick="srchInfo()">입력</button> </th>
						
						<th style="width: 10%; text-align: left;">
						달력 <input type="date"/> </th>
						
						<th style="width: 10%; text-align: left;">
							페이지 크기
							<select id="slPgSize" onchange="selPgSize()">
								<option value="5" selected>5</option>
								<option value="10">10</option>
								<option value="20">20</option>
								<option value="40">40</option>
							</select>
						</th>
						<th style="width: 10%; text-align: left;">
						<button onclick="delSelMyPost()">선택삭제</button> </th>
						
					</tr>
					<tr>
						<th style="width: 10%; text-align: left;">게시아이디</th>
						<th style="width: 60%; text-align: left;" colspan='3'>제목</th>
						<th style="width: 10%; text-align: left;">게시일</th>
						<th style="width: 10%; text-align: left;" colspan='2'>
							<div style="width: 100%;">
								전체 선택 <input type="checkbox" class="chk" value="selectall"
									onclick="selectAll(this)">
							</div>
						</th>
						

					</tr>
					<c:forEach var="myCmtList" items="${myCmtList}">

						<tr>
							<td style="width: 10%;" class="postId">${myCmtList.commentNo}</td>
							<td style="width: 60%;"><a href="/">${myCmtList.commentContent}</a>
							</td>
							<td style="width: 10%;">${myCmtList.commentDate}</td>
							<td style="width: 10%;">
								<div class="input-wrap">
									<label onclick="chkLavel(this)"> <input type="checkbox"
										class="chk" name="posts">
									</label>
								</div>
							</td>
							<td style="width: 10%;">
								<div class="input-wrap">
									<button onclick="mdfyMyPost()">수정하기</button>
								</div>
							</td>
						</tr>

					</c:forEach>
					<tr>
						<td colspan="4">
							<button class="btn-primary sm" onclick="allSelDel()">선택
								항목 삭제</button>
						</td>
					</tr>
				</table>
			</div>
			<div id="pageNavi" style="margin-top: 20px;">${myPostNavi}</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>	
				<%//TODO%>
				function srchInfo() {
					let srchInptData = $("#srchData").val();
					let pageSize = $("#slPgSize").val();
					console.log(srchInptData);
					 $("#srchBttn").on("click", function() {
						 //location.href = window.location+"&srchContent="+srchInptData;
						 location.href = "/user/myPageMyPost?reqPage=1&postTypeId=2&postTypeName=내가 작성한 여행 일지&pageSize="+pageSize+"&srchContent="+srchInptData;
					 });
					
				}

				function selPgSize() {

					let pageSize = $("#slPgSize").val();
					//let pageSize = getElementsById('slPgSize');
					console.log(pageSize);
					location.href = "/user/myPageMyPost?reqPage=1&postTypeId=2&postTypeName=내가 작성한 여행 일지&pageSize=" + pageSize;


				}
				function srchByDate() {
					swal({
						title: "날짜로 검색",
						html: "<input id=datepicker>",
						showConfirmButton: false,
						onOpen: function () {
							$('#datepicker').datetimepicker({});
						},

					}).then(function (result) {

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
							text: "선택한 게시글이 없습니다",
							icon: "warning",
						});
						return;
					}
					let postIdArr = [];

					$.each(checkBoxes, function (index, item) {
						postIdArr.push($(item).parents('tr').find('.postId').html());
						console.log(postIdArr);

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
								url: "/user/allPostSelDel",
								type: "GET",
								data: {
									"postIdArr": postIdArr.join("/")
								},
								success: function (res) {
									console.log(res);
									console.log("success");
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