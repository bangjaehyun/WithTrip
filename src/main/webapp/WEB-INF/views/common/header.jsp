<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/default.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css;" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>


<header class="header">   
   <div class="fixedMenu">
            <div class="logo"><a href="#"><img src="/resources/images/withTrip_logo3.png" width="100%" height="107px"></a></div>
            <nav class="nav">
                <ul class="recommend">
                    <li><a href="#">추천 여행</a>
                    	<ul class="sub-menu">
                            <li><a href="#">도시</a></li>
                            <li><a href="#">테마</a></li>
                            <li><a href="#">계절</a></li>
                        </ul>
                    </li>
                    <li><a href="#">이달의 여행</a>
                    	 <ul class="sub-menu">
                            <li><a href="#">테마</a></li>
                            <li><a href="#">계절</a></li>
                        </ul>
                    </li>
	                <li><a href="#">고객센터</a>
	                	<ul class="sub-menu">
                            <li><a href="#">사이트 이용안내</a></li>
                            <li><a href="#">공지사항</a></li>
                            <li><a href="#">FAQ</a></li>
                            <li><a href="#">Q&A</a></li>
                        </ul>
	                </li>
                </ul>
            </nav>
            <ul class="user-menu">
					 <c:choose>
					 <c:when test="${empty sessionScope.loginMember}">
					         <li><a href="#">로그인</a></li>
					         <li><a href="#">회원가입</a></li>
					 </c:when>
					 <c:otherwise>
					         <li><a href="#">마이페이지</a></li>
					         <li><a href="#">로그아웃</a></li>
					     </ul>
					 </c:otherwise>
					 </c:choose>
					
                    <ul class="sub-menu" >
                        <li><a href="#">사이트 이용 안내</a></li>
                        <li><a href="#">공지사항</a></li>
                        <li><a href="#">Q & A</a></li>
                    </ul>
                   
            </ul>
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
</header>
