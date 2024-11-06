<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="content mypage-container">
		<section class="section mypage-wrap">
			<div class="wrap">
				<div class="page-title">댓글 관리 페이지</div>
				<%--삭제 메소드. 삭제 서블릿으로 반환--%>
				<div style="border: 1px solid black; width: 50%; display: flex">
					<%-- 페이지 div --%>
					<%-- 모든 게시물 관리 버튼 클릭시 해당페이지로 넘어갈것 --%>
					<a href="/admin/adminNtcFrm?reqPage=1">게시물 관리</a>
					<%-- 모든 댓글 관리 버튼 클릭시 해당페이지로 넘어갈것 --%>
					<span>|</span> <a href="/admin/adminCmtMngFrm?reqPage=1">댓글 관리</a>
				</div>
				<%-- 전체 조회, 상세조회, (아이디로 검색) 조회 및 개별 삭제, 선택 삭제, 전체 삭제 --%>
				<div class="">
					<%
					//TODO
					%>
				</div>

				<div id="allPostMng" style="display: block">
					<table class="tbl tbl-hover" style="border: 1px solid black">
						<tr>
							<th style="width: 10%; text-align: left;">댓글아이디</th>
							<th style="width: 10%; text-align: left;">회원번호</th>
							<th style="width: 10%; text-align: left;">닉네임</th>
							<th style="width: 50%; text-align: left;">댓글내용</th>
							<th style="width: 10%; text-align: left;">작성일</th>
							<th style="width: 10%; text-align: left;">
								<div>
									전체 선택 <input type="checkbox" class="chk" value="selectall"
										onclick="selectAll(this)">
								</div>
							</th>

						</tr>
						<c:forEach var="cmt" items="${cmtList}">
							<%--서블릿에서 반환 ArrayList list--%>

							<%--게시글 확인용 페이지로 전환. 해당 페이지에서 삭제 메소드 호출--%>
							<tr>
								<%-- tr공간 클릭 후 상세확인 메소드 필요 --%>
								<%--게시 아이디--%>
								<td style="width: 10%;" class="commentId">${cmt.commentId}</td>

								<%--회원 번호--%>
								<td style="width: 10%;">${cmt.userNo}</td>
								<%--닉네임--%>
								<td style="width: 10%;">${cmt.userNickname}</td>
								<%--게시물 제목--%>
								<td style="width: 60%;">${cmt.commentVal}</td>
								<%--작성일--%>
								<td style="width: 10%;">${cmt.commentDate}</td>
								<%-- 선택 태그 --%>
								<td style="width: 10%;">
									<div class="input-wrap">
										<label onclick="chkLavel(this)"> <input
											type="checkbox" class="chk" name="comments">
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
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
				function chkLavel(obj) {

				}
				function selectAll(selectAll) {
					let checkboxes = document.getElementsByName('comments');

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
					let commentIdArr = [];

					$.each(checkBoxes, function (index, item) {
						commentIdArr.push($(item).parents('tr').find('.commentId').html());
						console.log(commentIdArr);

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
								url: "/admin/allCmtSelDel",
								type: "GET",
								data: {
									"commentIdArr": commentIdArr.join("/")
								},
								success: function (res) {
									console.log(res);
									location.href = "/admin/adminCmtFrm?reqPage=1";
								},
								error: function () {

								}
							});

						}
					});
				}
			</script>
</body>

</html>