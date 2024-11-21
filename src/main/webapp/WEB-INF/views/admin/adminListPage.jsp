<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>With Trip</title>
<link rel="apple-touch-icon"
	href="/resources/images/withTrip_favicon.png" />
<link rel="icon" href="/resources/images/withTrip_favicon.png" />
<style>
.list-header {
    padding: 20px 0px;
    text-align: right;
}
.section {
	
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="content">
		
		<section class="section post-list-wrap">
			<div class="page-title" style="text-align: left;"> ${postTypeName} 관리 페이지</div>
			<div class="list-content">
				<div class="list-header">
					<span> 페이지 크기 선택 : </span> <select id="slPgSize"
						onchange="selPgSize()">
						<option>선택</option>
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="20">20</option>
						<option value="40">40</option>
					</select>
				</div>
				<div >
					<table class="tbl">
						<tr class="th">
							<th style="text-align: center;">게시아이디</th>
							<th style="text-align: center;">회원번호</th>
							<th style="text-align: center;">닉네임</th>
							<c:if test="${pOrC eq 1}">
								<th style="text-align: center;">제목</th>
							</c:if>
							<c:if test="${pOrC eq 0}">
								<th style="text-align: center;">내용</th>
							</c:if>
							<th style="text-align: center;">게시일</th>
							<th style="text-align: center;">
								<div style="width: 100%;">
									전체 선택 <input type="checkbox" class="chk" value="selectall"
										onclick="selectAll(this)">
								</div>
							</th>
						</tr>
						<c:if test="${pOrC ne 0}">
							<c:forEach var="pg" items="${pgList}">
								<%--서블릿에서 반환 ArrayList list--%>

								<%--게시글 확인용 페이지로 전환. 해당 페이지에서 삭제 메소드 호출--%>
								<tr>
									<%-- tr공간 클릭 후 상세확인 메소드 필요 --%>
									<%--게시 아이디--%>
									<td class="number" rowspan="2">${pg.postNo}</td>

									<%--회원 번호--%>
									<td rowspan="2">${pg.userNo}</td>
									<%--닉네임--%>
									<td rowspan="2">${pg.userNickName}</td>
									<%--게시물 제목--%>
									<td><a
										href="/admin/adminDetail?pOrC=${pOrC}&userNo=${pg.userNo}&postNo=${pg.postNo}&commentChk=chk&webName=${pg.postTypeNm}">
											${pg.postTitle}</a></td>
									<%--작성일--%>
									<td rowspan="2">${pg.postDate}</td>
									<%-- 선택 태그 --%>
									<td rowspan="2">
										<div class="input-wrap">
											<label> <input type="checkbox" class="chk"
												name="posts">
											</label>
										</div>
									</td>
								</tr>
								<tr>
									<td>${pg.shortenContent}</td>
								</tr>

							</c:forEach>
							<tr>
								<td colspan="6">
									<button class="btn-primary sm" onclick="allSelDel()">선택
										항목 삭제</button>
								</td>
							</tr>
						</c:if>
						<c:if test="${pOrC eq 0}">
							<c:forEach var="pg" items="${pgList}">
								<%--서블릿에서 반환 ArrayList list--%>

								<%--게시글 확인용 페이지로 전환. 해당 페이지에서 삭제 메소드 호출--%>
								<tr>
									<%-- tr공간 클릭 후 상세확인 메소드 필요 --%>
									<%--게시 아이디--%>
									<td style="width: 10%;" class="number">${pg.commentId}</td>

									<%--회원 번호--%>
									<td style="width: 10%;">${pg.userNo}</td>
									<%--닉네임--%>
									<td style="width: 10%;"></td>
									<%--게시물 제목--%>
									<td style="width: 60%;"><a
										href="/admin/adminDetail?pOrC=${pOrC}&userNo=${pg.userNo}&commentId=${pg.commentId}">${pg.commentVal}</a>
									</td>
									<%--작성일--%>
									<td style="width: 10%;">${pg.commentDate}</td>
									<%-- 선택 태그 --%>
									<td style="width: 10%;">
										<div class="input-wrap">
											<label onclick="chkLavel(this)"> <input
												type="checkbox" class="chk" name="posts">
											</label>
										</div>
									</td>
								</tr>

							</c:forEach>
							<tr>
								<td colspan="6">
									<button class="btn-primary sm" onclick="allSelDel()">선택
										항목 삭제</button>
								</td>
							</tr>

						</c:if>
					</table>
					<div id="pageNav">${pageNavi}</div>
				</div>

			</div>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
	
	
	function selPgSize() {
		let pageSize = $("#slPgSize").val();
		pageSize = parseInt(pageSize);
		location.href = "/admin/adminListFrm?pOrC=${pOrC}&reqPage=1&postTypeId=${postTypeId}&postTypeName=${postTypeName}&pageSize=" + pageSize;
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
		let idArr = [];

		$.each(checkBoxes, function (index, item) {
			idArr.push($(item).parents('tr').find('.number').html());
			console.log(idArr);

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
					url: "/admin/adminSelDel",
					type: "GET",
					dataType : "json",
					data: {
						"pOrC": `${pOrC}`,
						"idArr": idArr.join("/")
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
				//location.reload(true);
			}
		});
	}
	</script>
</body>
</html>