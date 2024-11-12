<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<link rel="stylesheet" href="/resources/css/mypage.css" />
<title>withTrip myPage</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container">
		<div class="sidebar">
	        <ul>
				<li><a href="/views/mypage.jsp">회원정보수정</a></li>
	            <li><a href="#">작성한게시글확인</a></li>
	            <li><a href="#">작성한댓글관리</a></li>
	            <li><a href="#">좋아요누른여행정보</a></li>
	            <li><a href="#" onclick="delUserBtn()">회원탈퇴</a></li>
	        </ul>
        </div>
    	<div class="mypage-content">
    			<h2>회원정보수정</h2>

	        <form action="/user/updateInfo" method="post" id="updInfo">
	        <input type="hidden" value="${loginUser.userType}" name="userType">
	        	<table>
	        		<tr>
		            	<td>회원번호</td>
		            	<td><input type="text" value="${loginUser.userNo}" name="userNo" readonly></td>
		            </tr>
		            <tr>
		            	<td>아이디</td>
		            	<td><input type="text" value="${loginUser.userId}" readonly></td>
		            </tr>
		            <c:choose>
    				<c:when test="${loginUser.userType} eq 5">
			            <tr>
			            	<td>비밀번호</td>
			            	<td><button onclick="pwChgBtn()">비밀번호 변경</button></td>
			            </tr>
		            </c:when>
		            </c:choose>	
		            <tr>
		            	<td>이름</td>
		            	<td><input type="text" value="${loginUser.userName}" readonly></td>
		            </tr>
		            <tr>
		            	<td>닉네임</td>
			            <td>
				            <div class="nickname-group">
					            <input type="text" value="${loginUser.userNickname}" id="userNickname" name="userNickname">
					            <button type="button" class="check-button" id="nicknameChk">중복체크</button>
				            </div>
			            </td>
		            </tr>
		            <tr>
		            	<td>이메일</td>
		            	<td><input type="text" value="${loginUser.userEmail}" name="userEmail" readonly></td>
		            </tr>
		            <tr>
		            	<td>전화번호</td>
		            	<td><input type="text" value="${loginUser.userPhone}" name="userPhone"></td>
		            </tr>
		            </table>
		            <div class="button-group">
		            	<button type="button" onclick="window.location.reload()">취소</button>
		            	<button onclick="updInfoBtn()">수정</button>
		            </div>
		        </form>
		    </div>
	    </div>
    <script>  

    	//비밀번호 변경 팝업
    	function pwChgBtn(){
    		let popupWidth = 600;
    		let popupHeight = 300;
    		
    		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
    		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;
    		
    		
    		window.open("/user/pwChgFrm",  "userPwChg", "width="+popupWidth+", top="+top+", height="+popupHeight+", left="+left);
    	}
    	
    	//유저 삭제 팝업
    	function delUserBtn(){		
    		let popupWidth = 550;
    		let popupHeight = 350;
    		
    		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
    		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;
    		
    		window.open("/user/delUserFrm", "delUser","width="+popupWidth+", top="+top+", height="+popupHeight+", left="+left);
    	}
    	
    	//개인정보(닉네임 중복체크, 비밀번호) 번경 + 전화번호 변경
    	const checkInfo = {
    			"userNickname" : false,
    			"userNicknameChk" : false,
    	}
    	
    	const regExp =  /^[a-z가-힣0-9]{2,8}$/;
    	
    	$('#nicknameChk').on('click', function(){
    		const nicknameValue = $('#userNickname').val();
    		
    		if(!regExp.test(nicknameValue)){
    			msg('알림', '영문 소문자, 한글, 숫자 포함 2~8글자로 입력해주세요', 'error');
    			return;
    		}else{
    			checkInfo.userNickname = true;
    		}
    			$.ajax({
    				url : "/chkNickname",
    				data : {"userNickname" : nicknameValue},
    				type : "GET",
    				success : function(res){
	    				if(res == 0){
	    					msg('알림', '사용 가능한 닉네임입니다', 'success');
		    				checkInfo.userNicknameChk = true; 				    					
	    				}else{
		    				msg('알림', '중복된 닉네임이 존재합니다', 'error');
		    				checkInfo.userNicknameChk = false;    						    					
	    				}	    				
    				},
    				error : function(){
    					console.log("ajax : 닉네임 중복체크 오류");
    				}
    			});   			
    	});
    	
    	function updInfoBtn(){
    		swal({
				title : "알림",
				text : "개인정보를 수정하시겠습니까?",
				icon : "error",
				buttons : {
					cancel : {
						text : "취소",
						value : false,
						visible : true,
						closeModal : true
					},
					confirm : {
						text : "변경",
						value : true,
						visible : true,
						closeModal : true
					}
				}
			}).then(function(isConfirm){
				if(isConfirm){
					$('#updInfo').submit();
				}
			});
		}
    </script>
</body>
</html>