<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css;" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/park.css" />
<script src="/resources/js/sweetalert.min.js"></script>
<style>
.fixedMenu .logo img {
   float: left; /* 이미지를 왼쪽으로 배치 */
   display: block; /* 레이아웃을 명확히 하기 위해 추가 */
   width: 100%; /* 필요 시 여백 조정 */
   position: relative; /* 다른 요소와 겹치는 문제 해결 */
}

.fixedMenu{
	justify-content: center;
}

</style>

<header class="header">   
   <div class="fixedMenu">
      <div class="logo">
      	<img src="/resources/images/withTrip_logo_h_03.png" width="100%" height="74px">
      </div>
   </div>
</header>

<script>
   //자주사용하는 함수 header에 선언 -> 다른 jsp에서 script에 작성하지 않아도 됨
   function msg(title, text, icon) {
      swal({
         title : title,
         text : text,
         icon : icon
      });
   }
   </script>
