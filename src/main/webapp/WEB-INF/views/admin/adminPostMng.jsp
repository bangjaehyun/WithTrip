<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>공지사항 관리 페이지</title>
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

.list-left-pannel {
	width : 10%;
	height: 200px;
	position: sticky;
	top: 80px;
}

.list-content {
	/*  height : 500px;*/
	width: 1000px;
	padding-right: 140px;
	padding-left: 20px;
}
.main-body{
	width: 60%;
	padding-left: 20%;
	padding-right: 20%;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="" name="selPgSize" />
	</jsp:include>
	<main class="content mypage-container">

		<div class="list-left-pannel">
			<ul class="side-menu">
				<li><a href="/admin/adminFrm?reqPage=1&postTypeId=1&postTypeName=공지사항&pageSize=5">1.공지사항</a></li>
				<li><a href="/admin/adminFrm?reqPage=1&postTypeId=2&postTypeName=파트너작성글&pageSize=5">2.사용자 여행정보</a></li>
				<li><a href="/admin/adminFrm?reqPage=1&postTypeId=3&postTypeName=게시글&pageSize=5">3.파트너 여행정보</a></li>
				<li><a href="/admin/adminFrm?reqPage=1&postTypeId=4&postTypeName=QnA&pageSize=5">4.QnA</a></li>
				<li><a href="/">5.사이트 이용안내.</a></li>
			</ul>
		</div>
		<div class="main-body">
			<div class="page-title">${pstTypeName} 관리 페이지</div>
			<%--삭제 메소드. 삭제 서블릿으로 반환--%>
			<div style="height: 5%">
				<div style="display: flex">
					<%-- 페이지 div --%>
					<%-- 모든 게시물 관리 버튼 클릭시 해당페이지로 넘어갈것 --%>
					<a href="/admin/adminFrm?reqPage=1&postTypeId=1&postTypeName=공지사항&pageSize=5">게시물 관리</a>
					<%-- 모든 댓글 관리 버튼 클릭시 해당페이지로 넘어갈것 --%>
					<span>|</span> <a href="/admin/adminCmtFrm?reqPage=1">댓글 관리</a>
				</div>
			</div>
			<div style="display: flex; justify-content: space-between;">
				<%-- 전체 조회, 상세조회, (아이디로 검색) 조회 및 개별 삭제, 선택 삭제, 전체 삭제 --%>
				<div>
					<select>
						<option value="">선택</option>
						<option value="srchById">Id로 검색</option>
						<option value="srchByNickname">닉네임으로 검색</option>
						<!-- sweet alert가동, 달력, 후 조회페이지. -->
					</select> 
					<input type="text">
					<button onclick="srchInfo()">검색</button>
					<input type="date" id="" onchange="dateHandler()">

				</div>
				<div>
				<span> 페이지 크기 선택 : </span>
					<select id="slPgSize" onchange="selPgSize()">
						<option value="">선택</option>
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="20">20</option>
						<option value="40">40</option>
					</select>
				</div>
			</div>
			<%--==================================================이동예정==================================================
							--%>


			<%--==================================================List============================================================
								--%>
			<div id="allPostMng" style="display: block">
				<table class="tbl tbl-hover" style="border: 1px solid black">
					<tr>
						<th style="width: 10%; text-align: left;">게시아이디</th>
						<th style="width: 10%; text-align: left;">회원번호</th>
						<th style="width: 10%; text-align: left;">닉네임</th>
						<th style="width: 30%; text-align: left;">제목</th>
						<th style="width: 20%; text-align: left;">게시일</th>
						<th style="width: 20%; text-align: left;">
							<div style="width: 100%;">
								전체 선택 <input type="checkbox" class="chk" value="selectall"
									onclick="selectAll(this)">
							</div>
						</th>

					</tr>
					<c:forEach var="pg" items="${pgList}">
						<%--서블릿에서 반환 ArrayList list--%>

						<%--게시글 확인용 페이지로 전환. 해당 페이지에서 삭제 메소드 호출--%>
						<tr>
							<%-- tr공간 클릭 후 상세확인 메소드 필요 --%>
							<%--게시 아이디--%>
							<td style="width: 10%;" class="postId">${pg.postNo}</td>

							<%--회원 번호--%>
							<td style="width: 10%;">${pg.userNo}</td>
							<%--닉네임--%>
							<td style="width: 10%;">${pg.userNickname}</td>
							<%--게시물 제목--%>
							<td style="width: 60%;"><a href="/admin/list">${pg.postTitle}</a>
							</td>
							<%--작성일--%>
							<td style="width: 10%;">${pg.postDate}</td>
							<%-- 선택 태그 --%>
							<td style="width: 10%;">
								<div class="input-wrap">
									<label onclick="chkLavel(this)"> <input type="checkbox"
										class="chk" name="posts">
									</label>
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
			<div id="pageNavi" style="margin-top: 20px;">${pageNavi}</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
				function chkLavel(obj) {

				}
				function dateHandler() {
					let dtId = $("#dt").val()
					console.log(dtId);
				}

				function selPgSize() {

					let pageSize = $("#slPgSize").val();
					//let pageSize = getElementsById('slPgSize');
					console.log(pageSize);
					location.href = "/admin/adminFrm?reqPage=1&postTypeId=1&postTypeName=공지사항&pageSize=" + pageSize;


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
							text: "선택한 회원이 없습니다",
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
								value: "false",
								visible: "true",
								closeModal: "true",
							},
							confirm: {
								text: "삭제",
								value: "true",
								visible: "true",
								closeModal: "true",
							}
						}

					}).then(function (isConfirm) {
						if (isConfirm) {
							$.ajax({
								url: "/admin/allPstSelDel",
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