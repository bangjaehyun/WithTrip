<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/park.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css;" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>


<header class="header">   
   <div class="fixedMenu">
            <div class="logo"><a href="/"><img src="/resources/images/withTrip_logo_h_01.png" width="100%" height="60px"></a></div>
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
                            <li><a href="#">축제</a></li>
                        </ul>
                    </li>
                   <li><a href="/spot/mainMap">MAP</a></li>
                   <li><a href="/post/CS">고객센터</a>
                      <ul class="sub-menu">
                            <li><a href="/post/list?reqPage=1&postTypeCd=1&postTypeNm=1">공지사항</a></li>                          
                            <li><a href="/post/list?reqPage=1&postTypeCd=3&postTypeNm=3">FAQ</a></li>
                            <li><a href="/post/list?reqPage=1&postTypeCd=4&postTypeNm=4">Q&A</a></li>
                            <li><a href="/post/list?reqPage=1&postTypeCd=5&postTypeNm=5">사이트 소개</a></li>                      
                      </ul>
                   </li>
                   
                </ul>
            </nav>
            <ul class="user-menu">
                <c:choose>
                <c:when test="${empty sessionScope.loginMember}">
                        <li><a href="#">로그인</a></li> <span> | </span>
                        <li><a href="#">회원가입</a></li>
                </c:when>
                <c:otherwise>
                        <li><a href="#">로그아웃</a></li>
                        <li><a href="#">마이페이지</a></li> <span> | </span>
                </c:otherwise>
                </c:choose>
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

