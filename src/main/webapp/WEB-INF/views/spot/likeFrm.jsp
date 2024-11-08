<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like Frm</title>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ded6a823694c477130258746c1c95cf&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/map.css" />
<style>
.content {
   positon: relative;
   display: flex;
   width: 1430px;
}

#map_window {
   padding: 0;
   margin: 0;
   width: 1200px;
   height: 700px;
}

#like_wrap {
   position: absolute;
   height: 690px;
   width: 220px;
   left: 1208px;
   z-index: 2;
   font-size: 12px;
   display: inline-block;
   border: 1px solid black;
   border-radius: 10px;
}

#like_container::-webkit-scrollbar {
   width: 10px;
}

#like_container::-webkit-scrollbar-thumb {
   background: rgba(051, 051, 051, 0.7);
   border-radius: 10px;
}

#like_container::-webkit-scrollbar-track {
   background: rgba(255, 255, 255, 0.0);
}

#like_container {
   height: 630px;
   overflow-y: auto;
}

#likeList li {
   list-style: none;
}

#likeList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}

#likeList .item span {
   display: block;
   margin-top: 4px;
}

#likeList .item h5, #likeList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

/* #likeList .item .info { */
/*    padding: 10px 0 10px 50px; */
/* } */

#likeList .info .gray {
   color: #8a8a8a;
}

#likeList .info .jibun {
   padding-left: 26px;
   background:
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
      no-repeat;
}

#likeList .info .tel {
   color: #009900;
}

#likeList .item .markerbg {
   float: left;
   position: absolute;
   width: 36px;
   height: 37px;
/*     margin: 10px 0 0 10px; */
   background:
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
      no-repeat;
}

#likeList .item .marker_1 {
   background-position: 0 -10px;
}

#likeList .item .marker_2 {
   background-position: 0 -56px;
}

#likeList .item .marker_3 {
   background-position: 0 -102px
}

#likeList .item .marker_4 {
   background-position: 0 -148px;
}

#likeList .item .marker_5 {
   background-position: 0 -194px;
}

#likeList .item .marker_6 {
   background-position: 0 -240px;
}

#likeList .item .marker_7 {
   background-position: 0 -286px;
}

#likeList .item .marker_8 {
   background-position: 0 -332px;
}

#likeList .item .marker_9 {
   background-position: 0 -378px;
}

#likeList .item .marker_10 {
   background-position: 0 -423px;
}

#likeList .item .marker_11 {
   background-position: 0 -470px;
}

#likeList .item .marker_12 {
   background-position: 0 -516px;
}

#likeList .item .marker_13 {
   background-position: 0 -562px;
}

#likeList .item .marker_14 {
   background-position: 0 -608px;
}

#likeList .item .marker_15 {
   background-position: 0 -654px;
}
</style>
</head>
<body>
   <main class="content">
      <div id="map_window">
         <jsp:include page="/WEB-INF/views/common/map.jsp">
            <jsp:param name="val02" value="두번째값}" />
         </jsp:include>
      </div>
      <div id="like_wrap">
         <div id="like_container">
            <ul id="likeList"></ul>
         </div>
      </div>
   </main>

   <script>
      let ArrayList = [];

      function listAdd(list) {

         console.log(ArrayList)
         let Tag = getListItem(ArrayList.length, list);
         let buttonEl = '<button onclick="listRemove(this)">' + "삭제"
               + '</button>';
         console.log(Tag);
         $(Tag).append(buttonEl);
         $("#likeList").append(Tag);

         ArrayList.push(list);
      }

      function listRemove(obj) {
//          $(obj).parent().remove();
         
         $(window.opener).list = ArrayList;
         self.close();
      }
      
      function conFrim(){
         window.opener.list = ArrayList;
         self.colse();
      }
   </script>
   
</body>
</html>