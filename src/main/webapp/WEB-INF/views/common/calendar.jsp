<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" type="text/css;" />
<style>
	 /*#2 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
 
 /*#3 */
.material-icons {
  /* button 요소에 기본적으로 설정되는 스타일 속성 초기화 */
  border: none;
  outline: none;
  background-color: transparent;
  padding: 0;
  cursor: pointer;
}
 
 /*#4 */
body {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  background: #008aff;
  flex-direction: column;
}
	/*#5 */
.wrapper {
  width: 450px;
  background: #fff;
  border-radius: 10px;
  padding: 25px;
}
 
/*#6*/
.wrapper .nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 30px;
}

.wrapper .nav .current-date {
  font-size: 24px;
  font-weight: 600;
}
.wrapper .nav button {
  width: 38px;
  height: 38px;
  font-size: 30px;
  color: #878787;
}
/*#7*/
.calendar ul {
  display: flex;
  list-style: none;
  flex-wrap: wrap;
  text-align: center;
}
.calendar .weeks li {
  font-weight: 500;
}
.calendar .days {
  margin-bottom: 20px;
}
.calendar ul li {
  /*#8*/
  width: calc(100% / 7);
  /*#9*/
  position: relative;
}
.calendar .days li {
  /*#10*/
  z-index: 1;
  margin-top: 30px;
  cursor: pointer;
}
 
/*#11*/
.days li.inactive {
  color: #aaa;
}


.days li.startDay {
  color: #fff;
}
.days li.endDay {
  color: #fff;
}

.calendar .days li::before {
  position: absolute;
  content: '';
  height: 40px;
  width: 40px;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: -1;
}

.calendar .days li.startDay::before{
	width: 58px;
	border-top-left-radius: 45%;
	border-bottom-left-radius: 45%;
}

.calendar .days li.endDay::before{
	width: 58px;
	border-top-right-radius: 45%;
	border-bottom-right-radius: 45%;
}

.days li:hover::before {
  background: #f2f2f2;
}
.days li.startDay::before {
  background: #008aff;
}
.days li.endDay::before {
  background: #008aff;
}

.days li.medle::before {
  background: #008aff;
}
.days li.medle {
  color: #fff;
}

.calendar .days li.medle::before{
	width: 58px;
}

.btn-div{
	width : 450px;
	margin-top: 20px;
	text-align: right;
}

.btn-div button{
	width: 100px;
	height: 45px;
	border: 1px solid gray;
	border-radius: 10px;
	font-weight: bold;
}

.btnFail{
	background: white;
}

.btn-div button:hover{
  transform: scale(1.1,1.1);
  box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
}

.btnSuccess{
	background: rgb(189, 236, 255);
}

</style>
</head>
<body>
<div class="wrapper">
    <header>
        <div class="nav">
          <button onclick="moveDay('left')" class="material-icons"> chevron_left </button>
          <p class="current-date"></p>
          <button onclick="moveDay('right')" class="material-icons"> chevron_right </span>
        </div>
      </header>
      <div class="calendar">
        <ul class="weeks">
          <li>일</li>
          <li>월</li>
          <li>화</li>
          <li>수</li>
          <li>목</li>
          <li>금</li>
          <li>토</li>
        </ul>
        <ul class="days">
         
        </ul>
      </div>
      
    </div>
    <div class="btn-div">
    	<button class="btnFail" onclick="calendarClose()">취소</button>
      	<button class="btnSuccess" onclick="calendarInsert()">확인</button>
      </div>
    <script>
   
    
    //캘린더 종료
    function calendarClose(){
    	self.close();
    }
    //오늘 날짜
    let date = new Date();
    //현재 년도
    let currYear = date.getFullYear();
    //현재 월
    let currMonth = date.getMonth();
    //년월 뿌려줄 요소
    const currentDate = document.querySelector('.current-date');
    //월 정보
    const months = [
		  '1월',
		  '2월',
		  '3월',
		  '4월',
		  '5월',
		  '6월',
		  '7월',
		  '8월',
		  '9월',
		  '10월',
		  '11월',
		  '12월',
		];
    //일을 추가할 div
    const daysTag = document.querySelector('.days');
    
    //캘린더 날짜 불러오는 함수
    function renderCalendar (){
		  currentDate.innerHTML = currYear + "년 " + months[currMonth];

		  	let lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate();
			let firstDayofMonth = new Date(currYear, currMonth, 1).getDay();
			let lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(); 
			let lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate();
			
			let liTag = '';
			
			 
			 for (let i = firstDayofMonth; i > 0; i--) {
			    liTag += '<li class="inactive">'+ (lastDateofLastMonth - i + 1) +'</li>';
			}
			 
			 for (let i = 1; i <= lastDateofMonth; i++) {
			 		liTag += '<li onclick="choose(this)">'+i+'</li>';
				}
			 
			 if(lastDayofMonth != 0){
				 for (let i = lastDayofMonth; i <= 12; i++) {
			    		liTag += '<li class="inactive">' + (i - lastDayofMonth + 1) +'</li>';
			 	 }
				
			 }else{
			 	for (let i = lastDayofMonth; i < 6; i++) {
			    		liTag += '<li class="inactive">' + (i - lastDayofMonth + 1) +'</li>';
			 		}
			 }
			 
			 daysTag.innerHTML = liTag;
		}
    
    $(document).ready(function(){
    		
    		renderCalendar();
    });
    
    let chk = 0;
    
    
   	//월 이동
	function moveDay(icon){
		 currMonth = icon == 'left' ? currMonth - 1 : currMonth + 1;
		 if (currMonth < 0 || currMonth > 11) {
		      date = new Date(currYear, currMonth);
		      currYear = date.getFullYear(); 
		      currMonth = date.getMonth(); 
		    } else {
		      date = new Date();
		    }
		    renderCalendar();
	}
	
	let startObj;
	let endObj;
	//선택한 시작 날짜와 종료 날짜 비교하여 css 적용
	function choose(obj){
		if(chk == 0){
			startObj = $(obj);
			startObj.addClass("startDay");
			chk++;
		}else if(chk == 1){
			endObj = $(obj);
			
			let startNum = Number(startObj.html());
			let endNum = Number(endObj.html());
			
			if(startNum > endNum){
				startObj.removeClass("startDay");
				chk = 0;
				choose(obj);
			}else{
				endObj.addClass("endDay");
				chk++;
				reMaker(true);
			}
		}else{
			endObj.removeClass("endDay");
			startObj.removeClass("startDay");
			chk = 0;
			reMaker(false);
			choose(obj);
		}
		
		
	}
	
	//시작 날짜와 종료 날짜의 
	function reMaker(chk){
		
		let chkObj = startObj.next();
		
		while(true){
			
			if(chkObj.get(0) === endObj.get(0)){
				break;
			}
			
			if(chk == true){
				chkObj.addClass("medle");
			}else{
				chkObj.removeClass("medle");	
			}
			
			chkObj = chkObj.next();
			
		}
		
	}
	
	 //부모 요소에 날짜 입력
    function calendarInsert(){
		days = currYear + "년 " + months[currMonth] + startObj.html() + "일 ~ " + currYear + "년 " + months[currMonth] + endObj.html() + "일";
    	$(window.opener.document.getElementById("noticeDay")).val(days);
    	//자식 요소에서 부모 요소에 summernote값 넣기
//     	window.opener.$('#noticeContent').summernote('insertText', days);
    	
    	//새로운 textarea객체를 하나더 추가하는거 같다.
//     	$(window.opener.document.getElementById("noticeContent")).summernote("insertText", days);
    	self.close();
    }
    
    </script>
    
</body>
</html>