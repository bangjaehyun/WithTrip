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
main {
	display: grid;
	grid-template-columns: 200px auto;
	max-width: 1400px;
	margin: 0 auto 3rem;
	grid-column-gap: 2rem;
}
.page-title {
	grid-column: 1 / 3;
	margin-top: 100px;
}
.list-content {
	min-width: 500px;
	max-width: 1420px;
	margin: 0;
}
.list-header {
	display: inline-block;
	float: left;
	font-weight: bold;
	font-size: 1.25rem;
}
.list-header:nth-child(2n) {
	float: right;
}
a {
	color: var(--main2);
}
section.section {
	border-left: 2px solid var(--main2);
}
a:hover {
	text-decoration: underline;
}
section.section6 {
	padding-top: 0;
}

.tbl {
	padding-top: 10px;
}

.wrap.wrapOver {
	min-height: 50px;
}
.side-menu a {
	background-color: var(--gray8);
	color: #000;
	display: block;
	padding: 10px 10px 0 10px;
}

.side-menu-title {
	width: 180px;
	padding: 7px 0px;
	text-align: left;
	font-weight: bold;
	font-size: 20px;
	border-bottom: 3px solid var(--main2);
	position: sticky;
}

.list-body-over {
	position: sticky;
	top: 80px;
	bottom: 80px;
	align-self: start;
	grid-column: 1;
	min-width: 200px;
	margin: 0 1rem;
}





tr th td {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="mainOver">

		<div class="page-title">${postTypeName} 관리 페이지</div>
		<div class="list-body-over">
			<ul class="side-menu-title">
				<li>게시물 관리 페이지</li>
			</ul>
			<ul class="side-menu">
				<li><a href="/admin/adminListFrm?pOrC=0&reqPage=1&pageSize=5&postTypeId=6&postTypeName=댓글">댓글 관리 페이지</a></li>
				<li><a href="/admin/adminListFrm?pOrC=1&reqPage=1&postTypeId=1&postTypeName=공지사항&pageSize=5">공지사항 관리 페이지</a></li>
				<li><a href="/admin/adminListFrm?pOrC=1&reqPage=1&postTypeId=2&postTypeName=여행정보&pageSize=5">여행정보 관리 페이지</a></li>
				<li><a href="/admin/adminListFrm?pOrC=1&reqPage=1&postTypeId=3&postTypeName=FAQ&pageSize=5">FAQ 관리 페이지</a></li>
				<li><a href="/admin/adminListFrm?pOrC=1&reqPage=1&postTypeId=4&postTypeName=QnA&pageSize=5">QnA 관리 페이지</a></li>
			</ul>
		</div>

		<div class="list-content">
			<section class="section">
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
				<div>
					<table class="tbl">
						<tr class="th">
							<th>게시아이디</th>
							<th >회원번호</th>
							<th >닉네임</th>
							<c:if test="${pOrC eq 1}">
								<th >제목</th>
							</c:if>
							<c:if test="${pOrC eq 0}">
								<th >내용</th>
							</c:if>
							<th >게시일</th>
							<th >
								<div>
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
									<td  class="number">${pg.commentId}</td>

									<%--회원 번호--%>
									<td >${pg.userNo}</td>
									<%--닉네임--%>
									<td ></td>
									<%--게시물 제목--%>
									<td><a
										href="/admin/adminDetail?pOrC=${pOrC}&userNo=${pg.userNo}&commentId=${pg.commentId}">${pg.commentVal}</a>
									</td>
									<%--작성일--%>
									<td >${pg.commentDate}</td>
									<%-- 선택 태그 --%>
									<td >
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

			</section>
		</div>
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