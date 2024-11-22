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
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<main class="mainOver">
		
		<div class="page-title">고객 관리 페이지</div>
		<div class="list-body-over">
			<ul class="side-menu-title">
				<li>관리자 페이지</li>
			</ul>
			<ul class="side-menu">
				<li><a href="/admin/adminPageFrm?pOrC=1">관리자페이지</a></li>
				<li><a href="/admin/adminUserMng?reqPage=1&pageSize=10">고객 관리 페이지</a></li>
			</ul>
		</div>
		<div class="list-content">
			<section class="section">
				<div class="list-content">
					<div style="display: flex;">
						<span> 페이지 크기 선택 : </span> <select id="slPgSize"
							onchange="selPgSize()">
							<option>선택</option>
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="40">40</option>
						</select>
					</div>
					<table class="tbl">
						<tr class="th">
							<th>회원번호</th>
							<th>닉네임</th>
							<th>회원 등급</th>
							<th>
								<div>
									전체 선택 <input type="checkbox" class="chk" value="selectall"
										onclick="selectAll(this)">
								</div>
							</th>
							<th>개별 삭제</th>
							<th colspan="2">개별 회원 등급 변경</th>
						</tr>
						<c:forEach var="pg" items="${pgList}">
							<tr>
								<td class="userNo">${pg.user.userNo}</td>
								<td class="userNick">${pg.user.userNickname}</td>
								<td>${pg.user.userType}</td>
								<td>
									<div class="input-wrap">
										<input type="checkbox" class="chk" name="selectChk">
									</div>
								</td>
								<td><button class="btn-primary sm" id="selectDel"
										onclick="selDel(this)">회원삭제</button></td>
								<td><select class="selectUserType">
										<option>선택</option>
										<option value="1">관리자</option>
										<option value="2">파트너</option>
								</select></td>
								<td><button class="btn-primary sm" onclick="updLevel(this)">회원등급변경</button></td>

							</tr>
						</c:forEach>
						<tr>
							<td colspan="6">
								<button class="btn-primary sm" onclick="allSelDel()">선택
									항목 삭제</button>
							</td>
						</tr>
					</table>
					<div id="pageNav">${pageNav}</div>
				</div>
			</section>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
	
	
	function selPgSize() {
		let pageSize = $("#slPgSize").val();
		pageSize = parseInt(pageSize);
		location.href = "/admin/adminUserMng?reqPage=1&pageSize="+pageSize;
	}
	function selectAll(selectAll) {
		let checkboxes = document.getElementsByName('selectChk');

		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		});
	}
	function updLevel(button){
		let userNo = $(button).closest('tr').find('.selectUserType').val();
		let userType = $(button).closest('tr').find('.userNo').html();
		console.log(userType);
		console.log(userNo);
		let nickname = $(button).closest('tr').find('.userNick').html();
		console.log(nickname);
		swal({
			title: "알림",
			text: '사용자 \"'+nickname+'\"님의 등급을 변경하시겠습니까?',
			icon: "warning",
			buttons: {
				cancle: {
					text: "취소",
					value: false,
					visible: true,
					closeModal: true,
				},
				confirm: {
					text: "변경",
					value: true,
					visible: true,
					closeModal: true,
				}
			}

		}).then(function (isConfirm) {
			if (isConfirm) {
				$.ajax({
					url: "/admin/userUpd",
					type: "GET",
					dataType : "json",
					data: {
						"userNo" : userNo,
						"userType": userType
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
	function selDel(button){
		let id = $(button).closest('tr').find('.userNo').html();
		console.log(id);
		
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
					url: "/admin/userDel",
					type: "GET",
					dataType : "json",
					data: {
						"id" : id,
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
			idArr.push($(item).parents('tr').find('.userNo').html());
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
						"pOrC": "2",
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