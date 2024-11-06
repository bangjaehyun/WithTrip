<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>공지사항 관리 페이지</title>
<style>
.ntcPtcDiv {
	border: 1px solid black;
	width: 50%
}

.ntcPtc {
	list-style: none;
}

.ntcPtc li {
	float: left;
}

.dateCalenda:hover {
	
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="content mypage-container">
		<section class="section mypage-wrap">
			<div class="wrap">
				<div class="page-title">공지사항 관리 페이지</div>
				<%--삭제 메소드. 삭제 서블릿으로 반환--%>
				<div style="height: 5%">
					<div style="border: 1px solid black; display: flex">
						<%-- 페이지 div --%>
						<%-- 모든 게시물 관리 버튼 클릭시 해당페이지로 넘어갈것 --%>
						<a href="/admin/adminNtcFrm?reqPage=1">게시물 관리</a>
						<%-- 모든 댓글 관리 버튼 클릭시 해당페이지로 넘어갈것 --%>
						<span>|</span> <a href="/admin/adminCmtFrm?reqPage=1">댓글 관리</a> <span>|</span>
						<div class="toolsDiv"></div>
					</div>
				</div>
				<%-- 전체 조회, 상세조회, (아이디로 검색) 조회 및 개별 삭제, 선택 삭제, 전체 삭제 --%>
				<div style="border: 1px solid black; display: flex;">
					<div style="border: 1px solid black; display: flex; width: 50%;"
						class="">
						<select>
							<option value="0">선택</option>
							<option value="srchById">Id로 검색</option>
							<option value="srchByNickname">닉네임으로 검색</option>
							<!-- sweet alert가동, 달력, 후 조회페이지. -->
						</select>
						<ul class="dateCalenda">
							<%
							//TODO
							%>
							<li><input type="text"> <input type="date">
							</li>
						</ul>
						<button onclick="srchInfo()">검색</button>

					</div>

					<div class="ntcPtcDiv">
						<ul class="ntcPtc">
							<li><a href="/admin/adminFrm?reqPage=1&NtcTp=1">1.공지사항</a></li>
							<li><a href="/admin/adminFrm?reqPage=1&NtcTp=2">2.QnA</a></li>
							<li><a href="/admin/adminFrm?reqPage=1&NtcTp=3">3.게시글</a></li>
							<li><a href="/admin/adminFrm?reqPage=1&NtcTp=4">4.파트너
									작성글</a></li>
						</ul>
					</div>
				</div>
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
						<c:forEach var="ntc" items="${ntcList}">
							<%--서블릿에서 반환 ArrayList list--%>

							<%--게시글 확인용 페이지로 전환. 해당 페이지에서 삭제 메소드 호출--%>
							<tr>
								<%-- tr공간 클릭 후 상세확인 메소드 필요 --%>
								<%--게시 아이디--%>
								<td style="width: 10%;" class="noticeId">${ntc.noticeId}</td>

								<%--회원 번호--%>
								<td style="width: 10%;">${ntc.userNo}</td>
								<%--닉네임--%>
								<td style="width: 10%;">${ntc.userNickname}</td>
								<%--게시물 제목--%>
								<td style="width: 60%;"><a href="/admin/list">${ntc.noticeTitle}</a></td>
								<%--작성일--%>
								<td style="width: 10%;">${ntc.noticeDate}</td>
								<%-- 선택 태그 --%>
								<td style="width: 10%;">
									<div class="input-wrap">
										<label onclick="chkLavel(this)"> <input
											type="checkbox" class="chk" name="notices">
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
		function srchByDate() {
			swal({
				title: "날자로 검색",
				html: "<input id=datepicker>",
				showConfirmButton: false,
				onOpen: function() {
				      $('#datepicker').datetimepicker({});
				  },

				}).then(function(result) {

				});
			}
		
		function selectAll(selectAll) {
					let checkboxes = document.getElementsByName('notices');

					checkboxes.forEach((checkbox) => {
						checkbox.checked = selectAll.checked;
					});
				}
		function allSelDel() {

			let checkBoxes = $('.chk:checked'); //클래스가 chk인 태그 중 checked인 태그 

			if (checkBoxes.length < 1) {
				swal({
					title : "알림",
					text : "선택한 회원이 없습니다",
					icon : "warning",
				});
				return;
			}
			let noticeIdArr = [];

			$.each(checkBoxes, function(index, item) {
				noticeIdArr.push($(item).parents('tr').find('.noticeId').html());
				console.log(noticeIdArr);

			});

			swal({
				title : "알림",
				text : "게시글을 삭제하시겠습니까?",
				icon : "warning",
				buttons : {
					cancle : {
						text : "취소",
						value : "false",
						visible : "true",
						closeModal : "true",
					},
					confirm : {
						text : "삭제",
						value : "true",
						visible : "true",
						closeModal : "true",
					}
				}

			}).then(function(isConfirm) {
				if (isConfirm) {
					$.ajax({
						url : "/admin/allSelDel",
						type : "GET",
						data : {
							"noticeIdArr" : noticeIdArr.join("/")
						},
						success : function(res) {
							console.log(res);
							location.href = "/admin/adminNtcFrm?reqPage=1";
						},
						error : function() {
							console.log("ajax 에러 발생");
							location.href = "/admin/adminNtcFrm?reqPage=1";
						}
					});

				}else{
					location.href = "/admin/adminNtcFrm?reqPage=1";
				}
			});
		}
	</script>
</body>

</html>