<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WithTrip</title>
<link rel="apple-touch-icon" href="/resources/images/withTrip_favicon.png"/>
<link rel="icon" href="/resources/images/withTrip_favicon.png"/>
<style>
.festival-box {
	display: flex;
	list-style: none;
}

.festival-title{
   display: flex;
   justify-content :space-between;   
   margin: 20px;
}
.festival-title > span {
   font-size: 22px;
   font-weight: bold;
}
.festival-title > a {
   padding-top : 10px;
}




.festival-box>li{
	width: 24%;
	position: relative;
    margin-right: 1.3%;
    margin-bottom: 30px;
    border: 1px solid #ddd;
    text-align: center;
    border-radius: 5px;
    overflow: hidden;
    box-sizing: border-box;
    transition: .2s;
    unicode-bidi: isolate;
    vertical-align : top;
}


.festival-tag>span {
	position: relative;
	display: block;
	width: 100%;
	height: 210px;
	background-color: #f2f2f2;
	overflow: hidden;
}

.festival-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.festival-name {
    display: block;
	padding: 10px;
	white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}


</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		
		<main class="content">
			<div class="festival-title">
				<span>이달의 축제</span>
				<a href="#"><span>더보기...</span></a>
			</div>
			<ul class="festival-box">
				<c:forEach var="festival" items="${festivalList}" end="3">
					<li>
						<a href="/festival/subInfo?festivalId=${festival.festivalId}&festivalType=${festival.festivalType}" class="festival-tag"> 
							<span>
								<img class="festival-img" src="${festival.festivalImage}"></img>
							</span> 
							<strong class="festival-name">${festival.festivalTitle}</strong>
						</a>
					</li>
				</c:forEach>
			</ul>
		</main>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	
</body>
</html>

