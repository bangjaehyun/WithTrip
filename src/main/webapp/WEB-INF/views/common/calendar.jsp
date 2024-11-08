<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons"
	type="text/css;" />
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
	background: #004CA1;
	flex-direction: column;
}
/*#5 */
.wrapper {
	width: 450px;
	background: #fff;
	border-radius: 10px;
	padding: 15px;
	margin-top: 20px;
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
	width: calc(100%/ 7);
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

.calendar .days li.startDay::before {
	width: 58px;
	border-top-left-radius: 45%;
	border-bottom-left-radius: 45%;
}

.calendar .days li.endDay::before {
	width: 58px;
	border-top-right-radius: 45%;
	border-bottom-right-radius: 45%;
}

.days li:hover::before {
	background: #f2f2f2;
}

.days li.startDay::before {
	background: #bdecff;
}

.days li.endDay::before {
	background: #bdecff;
}

.days li.middle::before {
	background: #bdecff;
}

.days li.middle {
	color: #004CA1;
}

.days li.startDay {
	color: #fff;
}

.days li.endDay {
	color: #fff;
}

.calendar .days li.middle::before {
	width: 58px;
}

.btn-div {
	width: 450px;
	margin-top: 20px;
	text-align: right;
}

.btn-div button {
	width: 100px;
	height: 45px;
	border: 1px solid gray;
	border-radius: 20px;
	font-weight: bold;
}

.btnFail {
	background: white;
}

.btn-div button:hover {
	transform: scale(1.1, 1.1);
	box-shadow: 0px 5px 5px -2px rgba(0, 0, 0, 0.25);
}

.btnSuccess {
	background: #bdecff;
}
</style>
</head>
<body>
	<div class="wrapper">
		<header>
			<div class="nav">
				<button onclick="moveMonth('left')" class="material-icons">
					chevron_left</button>
				<p onclick="moveYear()" class="current-date"></p>
				<button onclick="moveMonth('right')" class="material-icons">
					chevron_right</button>
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
    
    //캘린더 날짜 불러오는 함수
    function renderCalendar (icon){
		  currentDate.innerHTML = currYear + "년 " + months[currMonth];
		  let daysCnt = 0;
		  //이미 생성된 달력이있으면 생성하지 않기위한 조건 
		  if($("#"+currYear + pad(currMonth+1)).length == '0'){
		  	let lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate();
			let firstDayofMonth = new Date(currYear, currMonth, 1).getDay();
			let lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(); 
			let lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate();
			
			let prevYear = currMonth == 0 ? currYear -1 : currYear;
			let prevMonth = pad(currMonth == 0 ? 12 : currMonth);
			let nextYear = currMonth == 11 ? currYear+1 : currYear;
			let nextMonth = pad(currMonth == 11 ? 1 : currMonth+2);
			
			let ulTag = '';
			
			 ulTag += "<ul class='days'>"
			 for (let i = firstDayofMonth; i > 0; i--) {
				 ulTag += '<li onclick="choose(this)" class="inactive" id='+ prevYear + prevMonth + pad(lastDateofLastMonth - i + 1) +'>'+ (lastDateofLastMonth - i + 1) +'</li>';
				 daysCnt++;
			}
			 
			 for (let i = 1; i <= lastDateofMonth; i++) {
				 ulTag += '<li onclick="choose(this)" id="'+ currYear + pad(currMonth+1) +  pad(i) +'">'+i+'</li>';
				 daysCnt++;
				}
			 
			 for (let i = lastDayofMonth; i <= 19; i++) {
				 ulTag += '<li onclick="choose(this)" class="inactive" id="'+ nextYear + nextMonth + pad(i - lastDayofMonth + 1) +'">' + (i - lastDayofMonth + 1) +'</li>';
				 daysCnt++;
				 //총 날짜 개수를 맞추기 위해서 갯수 제한
			     if(daysCnt == 42){
				   break;
					}
			 }
			 
			 ulTag += "</ul>"

			 $('.calendar').append(ulTag);
			 // ul태그에 현재 년월정보 추가 
		     $('.calendar').children().last().attr("id",currYear + "" + pad(currMonth+1));
		     
		  }
			 
		  	//ul태그가 하나 이상 생성되었을경우에만 날짜 이동시 숨기고 보여주기 위함
			 if($('.weeks').nextAll().length > 1){
				 if(icon == "left"){
					 //ul태그중 현재 날짜로 생성된 값이 존재하는지
					 if($("#"+ currYear + pad(currMonth+1)).length == '1'){
						 //존재하면 보여주기
						 $("#"+ (currYear) + pad(currMonth == 11 ? 12 : currMonth+1)).css("display" ,"flex");
					 }
						//이전에 표시되었던 날짜의 ul태그 숨김처리
				 		$("#" + (currMonth == 11 ? currYear+1 : currYear) + pad(currMonth == 11 ? 1 : currMonth+2)).css("display" ,"none");
				 }else{
					//ul태그중 현재 날짜로 생성된 값이 존재하는지
					 if($("#"+currYear + pad(currMonth+1)).length == '1'){
						//존재하면 보여주기
						 $("#"+ (currYear) + pad(currMonth == 0 ? 1 :currMonth+1)).css("display" ,"flex");
					 }
						//이전에 표시되었던 날짜의 ul태그 숨김처리
						 $("#" + (currMonth == 0 ? currYear-1 : currYear) +  pad(currMonth == 0 ? 12 : currMonth)).css("display" ,"none");
				 }
			 }
			 
			 
		
		}
    
    $(document).ready(function(){
    		renderCalendar();
    });
    //날짜 선택을 한번했는지 두번했는지 체크하기 위함
    let chk = 0;
    
    
   	//월 이동
	function moveMonth(icon){
		 currMonth = icon == 'left' ? currMonth - 1 : currMonth + 1;
		 if (currMonth < 0 || currMonth > 11) {
		      date = new Date(currYear, currMonth);
		      currYear = date.getFullYear(); 
		      currMonth = date.getMonth(); 
		    } else {
		      date = new Date();
		    }
		 	
		 	//월이동시 ul태그 그리는용도
		    renderCalendar(icon);
		    
		    
		    //시작 날짜와 마지막 날짜를 체크했을경우
		    if(chk == 2){
		    	//ul태그중 현재 날짜 를 가져오기위함
		    	$('.calendar>ul[class="days"]').map(function(index,item){
		    		if($(item).css("display") == "flex"){
		    			//선택한 시작 날짜와 종료날짜가 선택된 페이지 외에 스타일 적용을 하기 위해서
		    			if($(item).attr("id") != startObj.parent().attr("id") || $(item).attr("id") != endObj.parent().attr("id")){
		    				addNextMonthMarker(icon,$(item).attr("id"));
		    			}
		    		}
		    	});
		    	
		    }
	}
   	
   	//달력에서 이전월 과 다음월의 날짜도 표시해 주기때문에 그 부분을 체크했을경우에도 월이동시 표시해 주기 위함 
	function addNextMonthMarker(icon, choosePage){
   			if(icon =='left'){
   				prevStartObj = startObj.parent().parent().find('#'+ startObj.attr('id').substring(0,6)).find('#'+startObj.attr('id'));
	   			prevEndObj = prevStartObj.parent().find('#'+endObj.attr('id'));
   				//현재 날짜와 시작 날짜가 다른페이지일경우에는 마커를 표시하지 않을려고
   				if(choosePage == startObj.attr('id').substring(0,6)){
	   				
	   				prevStartObj.addClass("startDay");
	   				if(prevEndObj.length != 0){
	   					prevEndObj.addClass("endDay");
	   				}
	   				let nextObj = prevStartObj.next();
	   				while(true){
	   					if(nextObj.get(0) == prevEndObj.get(0)){
	   						break;
	   					}
	   					nextObj.addClass("middle");
	   					
	   					nextObj = nextObj.next();
	   				
	   				}
	   			}   				
   			}else if(icon =='right'){
   				//선택한페이지에서 다음월의 마지막 요소
   				nextEndObj = endObj.parent().parent().find('#'+ endObj.attr('id').substring(0,6)).find('#'+endObj.attr('id'));
   				//선택한페이지에서 다음월의 첫번째 요소
   				nextStartObj = nextEndObj.parent().children().first();
   					//현재 날짜와 종료 날짜가 다른페이지일경우에는 마커를 표시하지 않을려고
   					if(choosePage == endObj.attr('id').substring(0,6)){
   					
	   				
	   				//마지막 요소와 첫번쨰 요소가 같으면 endDay클래스만 추가
	   				if(nextEndObj.get(0) == nextStartObj.get(0)){
	   					nextEndObj.addClass("endDay");
	   					return;
	   				}
	   				//다를경우에는 순회하며 middle클래스룰 전부 추가해준다.
	   				nextEndObj.addClass("endDay");
	   				let prevObj = nextEndObj.prev();
	   				while(true){
	   					prevObj.addClass("middle");
	   					if(prevObj.get(0) == nextStartObj.get(0)){
	   						break;
	   					}
	   					
	   					prevObj = prevObj.prev();
	   				}
	   			}
   			}
   			
   			//날짜 선택시 여러개의 월이 선택됬을경우 전부 순회하며 middle클래스 추가하기위함
   			if(icon =='left' && choosePage >= startObj.attr('id').substring(0,6)){
   				//년월정보에서 시작 날짜에서 1을 더한값
   				startMonth = startDay.substring(0,6);
   				startMonth = startMonth.substring(4,6) == 12 ? (Number(startMonth.substring(0,4))+1) + startMonth.substring(4,6) : startMonth.substring(0,4) + (Number(startMonth.substring(4,6))+1);
   				//마지막 요소의 년월정보
   				endMonth = endDay.substring(0,6);
   				
   				let chkStartMonth = startMonth;
   				let chkEndMonth = endMonth;
   				while(chkStartMonth != chkEndMonth){
   					$('.calendar>ul[class="days"]').map(function(index,ulItem){
   						if($(ulItem).attr('id') == chkStartMonth){
   							$(ulItem).children().map(function(index,liItem){
   								$(liItem).addClass("middle");
   							})
   						}
   					});
   					
   					if(chkStartMonth.substring(4,6) == 12){
   						chkStartMonth =(Number(chkStartMonth.substring(0,4))+1) + "01";
   					}else{
   						chkStartMonth =chkStartMonth.substring(0,4) + pad(Number(chkStartMonth.substring(4,6))+1);
   					}
   					
   				}
   			}
   			
   	}
   	
   	
	let startMonth = 0;
   	let endMonth = 0;
   	let prevEndObj = null;
   	let prevStartObj = null;
   	let nextEndObj = null;
   	let nextStartObj = null;
	let startObj = null;
	let endObj = null;
	let startDay = 0;
	let endDay = 0;
	//선택한 시작 날짜와 종료 날짜 비교하여 css 적용
	function choose(obj){
		if(chk == 0){
			startObj = $(obj);
			startDay = startObj.attr('id');
			startObj.addClass("startDay");
			chk++;
		}else if(chk == 1){
			endObj = $(obj);
			endDay = endObj.attr('id');
			if(startDay >= endDay){
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
			if(nextStartObj != null || nextEndObj != null){
				removeNextMonthMarker();
				nextStartObj = null;
				nextEndObj = null;
			}
			if(prevStartObj != null || prevEndObj != null){
				removeNextMonthMarker();
				prevStartObj = null;
				prevEndObj = null;
			}
			choose(obj);
			
		}
	}

   	
   	function removeNextMonthMarker(){
   		if(nextStartObj != null || nextEndObj != null){
	   		nextEndObj.removeClass("endDay");
	   		let prevObj = nextEndObj.prev();
	   		while(true){
	   			prevObj.removeClass("middle");
					
					if(prevObj.get(0) == nextStartObj.get(0)){
						break;
					}
					
					prevObj = prevObj.prev();
   		}
   		}
   		if(prevStartObj != null || prevEndObj != null){
   			prevStartObj.removeClass("startDay");
   			if(prevEndObj.length != 0){
					prevEndObj.removeClass("endDay");
				}
   	   		let nextObj = prevStartObj.next();
   	   		while(true){
   	   			nextObj.removeClass("middle");
   					
   					if(nextObj.get(0) == prevEndObj.get(0)){
   						break;
   					}
   					
   					nextObj = nextObj.next();
   	   		}
   		}
   		
			while(startMonth != endMonth){
				$('.calendar>ul[class="days"]').map(function(index,ulItem){
					if($(ulItem).attr('id') == startMonth){
						$(ulItem).children().map(function(index,liItem){
							$(liItem).removeClass("middle");
						})
					}
				});
				
				if(startMonth.substring(4,6) == 12){
					startMonth =(Number(startMonth.substring(0,4))+1) + "01";
					}else{
						startMonth =startMonth.substring(0,4) + pad(Number(startMonth.substring(4,6))+1);
					}
			}
			startMonth = 0;
			endMonth = 0;
   	}
   	

   	
	
	//시작 날짜와 종료 날짜의 
	function reMaker(chk){
		if(startDay.substring(0,6) != endDay.substring(0,6)){
			
			let nextObj = startObj.next();
			while(true){
				
				if(chk == true){
					nextObj.addClass("middle");
				}else{
					nextObj.removeClass("middle");	
				}
				
				if(nextObj.get(0) == startObj.parent().children().last().get(0)){
					break;
				}else if(nextObj.get(0) == endObj.get(0)){
					break;
				}
				nextObj = nextObj.next();
			}
			
			if(nextObj.get(0) == endObj.get(0)){
				return;
			}
			
			let prevObj = endObj.prev();
			while(true){
				
				if(chk == true){
					prevObj.addClass("middle");
				}else{
					prevObj.removeClass("middle");	
				}
				
				if(prevObj.get(0) == endObj.parent().children().first().get(0)){
					break;
				}
				
				prevObj = prevObj.prev();
			}
			
		}else{
			let nextObj = startObj.next();
			while(true){
				
				if(chk == true){
					nextObj.addClass("middle");
				}else{
					nextObj.removeClass("middle");	
				}
				
				if(nextObj.get(0) == startObj.parent().children().last().get(0)){
					break;
				}else if(nextObj.get(0) == endObj.get(0)){
					break;
				}
				nextObj = nextObj.next();
			}
		}
		
		
	}
	
	 //부모 요소에 날짜 입력
    function calendarInsert(){
		let days = "";
		
    	days = startDay.substring(0,4)+ "년" + startDay.substring(4,6) + '월' + startDay.substring(6,8) + "일" + "~ " + endDay.substring(0,4)+ "년" + endDay.substring(4,6) + '월' + endDay.substring(6,8) + "일";
    	$(window.opener.document.getElementById("postDay")).val(days);
    	//자식 요소에서 부모 요소에 summernote값 넣기
//     	window.opener.$('#postContent').summernote('insertText', days);
    	
    	//새로운 textarea객체를 하나더 추가하는거 같다.
//     	$(window.opener.document.getElementById("postContent")).summernote("insertText", days);
//     	self.close();
    }
    function pad(d) {
    	return (Number(d) < 10) ? '0' + d.toString() : d.toString();
    	}
    
    </script>

</body>
</html>