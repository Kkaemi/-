<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글목록</title>
<style type="text/css">
body, html {
    height: 100%;
}

</style>
<!-- CSS 파일 -->
<link rel="stylesheet" href="/FoodFighter/resources/css/event/normalize.css">
<link rel="stylesheet" href="/FoodFighter/resources/css/event/sidenav.css">
<link rel="stylesheet" href="/FoodFighter/resources/css/event/headerCss.css">
<link rel="stylesheet" href="/FoodFighter/resources/css/event/eventBoardList.css">

<!-- JS 파일 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> <!-- 부트스트랩 CSS  -->
<script type="text/javascript" src ="/FoodFighter/resources/js/event/eventHeaderJS.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> <!-- 부트스트랩 JS -->
</head>
<body>
<!-- 헤더 -->
<!--================ Header ================-->
<div id="header-container">
	<div class="hamberger pull-left" onclick="myFunction(this)">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
    </div>
  <a class="header-logo" href="/FoodFighter/">로고 자리</a>
      <ul id="header-menu">
	      <li class="header-items">
	  		<img src="/FoodFighter/resources/img/community/mainImg/search.png" class="header_searchIcon" width="30" height="30" align="center"> 
	   		<input type="text" class="header_searchInput" placeholder="&emsp;&emsp;식당 또는 음식 검색" value="" autocomplete="on" maxlength="50" >
	      </li>
	      <li class="header-items">
	         <a class="header-link" href="/FoodFighter/">Home</a>
	      </li>
	      <li class="header-items">
	         <a class="header-link" href="/FoodFighter/review/reviewNonSearchList">리뷰 리스트</a>
	      </li>
	      <li class="header-items">
	        <a class="header-link" href="/FoodFighter/community/communityMain">커뮤니티</a>
	      </li>
	      <li class="header-items">
	        <a class="header-link" href="/FoodFighter/event/eventList">이벤트</a>
	      </li>
	      
	      <li class="nav-item">
           <c:if test="${sessionScope.memId == null}">
            <a class="nav-link js-scroll" href="/FoodFighter/login/loginForm">로그인</a>   
            </c:if>	       
          <!--   <img src="/FoodFighter/resources/img/member.png" class="header_searchIcon" width="30" height="30" align="center"> -->
         
         	<c:if test="${memId != null}">
			 <a class="nav-link js-scroll" href="/FoodFighter/login/logout">로그아웃</a>
			 </form>		
			</c:if>    
          </li>
          
	       <li class="header-items">
	       <a class="header-link" href="communityMain.jsp"><img src="/FoodFighter/resources/img/member.png" class="header_searchIcon" width="30" height="30" align="center"></a>
    	 </li>
   	</ul>
</div>

<style type="text/css">
.subjectA:link {color: black; text-decoration: none;}
.subjectA:visited {color: black; text-decoration: none;}
.subjectA:hover {color: green; text-decoration: underline;}
.subjectA:active {color: black; text-decoration: none;}
</style>

<!-- 본문 -->
<form id="eventBoardListForm" method="get" action="/FoodFighter/event/eventadminDelete.do">
<input type="hidden" id="pg" value="${pg }">
<input type="hidden" name="pg" value="1">
<div style = "clear: both;"></div>
<div class="container" style="margin-top : 95px;">
	<div class="page-header">
    	<h2 class="text-center">이벤트 게시글</h2>      
  		<p class="text-center"></p>      
  	</div>
</div>
<div class="page-body">
  <table class="table table-hover" id = "eventBoard">
  	<colgroup id ="colgroup">
  		<col width = "60">
  		<col width = "*">
  		<col width = "110">
  		<col width = "75">
  		<col width = "60">
  	</colgroup>
    <thead>
    
       <tr> 
      	<c:if test="${memberDTO.nickname == '관리자'}">
      		<th scope = "col" class ="text-center" id="admin">선택</th>	
      	</c:if> 
      	<th scope = "col" class="text-center">NO</th>
		<th scope = "col" class="text-center">제목</th>
		<th scope = "col" class="text-center">작성자</th>
		<th scope = "col" class="text-center">작성일</th>
		<th scope = "col" class="text-center">조회수</th>
      </tr>
    </thead>
    <tbody>
      <%-- <tr>
      <c:if test="${memberDTO.nickname == '관리자'}">
      	<td class ="adminDelete">
      		<div class = "tb-center"><input type ="checkbox" class = "select" value="선택삭제"></div>
      	</td>
      	</c:if>
      </tr> --%>
    </tbody>
  </table>

	<div class = "content-wrapper">
		<div id="eventPagingDiv" class="paging a"style="width:650px; align: left;"></div>
		
		<div class = "list-search" style=" align: center;">
		<fieldset>
		<select name = "where" id="where" >
			<option value = "subject">제목</option>
			<option value = "content">본문</option>
		</select>
		
		<input type = "search" placeholder = "검색어를 입력해주세요" name="inp" id ="inp" value="${requestScope.inp }"><!-- 검색어 입력 경고 (모달) -->
		<input type = "button" value = "검색" class = "plain-btn" id = "searchBtn">
		
		</div>
		<div class = "listBtnBox">	
		 <c:if test="${memberDTO.nickname == '관리자'}">
			<a href ="/FoodFighter/event/eventWriteForm">
				<span class = "plain-btn">글쓰기</span></a>
		</c:if> 	
		</div>
		</fieldset>
		</div>
	</div>
	</form>

<!--================  Footer ================-->
<div id="footer-container">
 <p class="copyright" style="text-align:left;">
     ㈜ 푸드파이터<br>서울 서초구 강남대로 459(백암빌딩) 202호<br>대표이사: FOODFIGHTER<br>사업자 등록번호: 2020-020-22222 
       <br>고객센터: 0507-1414-9601<br><br>
        <strong>HOME | 리뷰리스트 | 커뮤니티 | 이벤트</strong><br><br>
       &copy; Copyright <strong>foodFighter</strong>. All Rights Reserved
             Designed by foodFighter
 </p>
</div>
<script type="text/javascript">
window.onload = function() {
	if ("${where}" == "subject" || "${where}" == "content") {
		document.getElementById("where").value = "${where}";
	}
}
function eventPaging(pg) {
	var inp = document.getElementById("inp").value;
	if (inp == "") {
		location.href = "eventList?pg=" + pg;
	} else {
		//location.href="getBoardSearch?pg="+pg+"&searchOption=${searchOption}&keyword="+encodeURIComponent("${keyword}");
		$('input[name=pg]').val(pg);
		$('#searchBtn').trigger('click', 'continue');
	}
} 
//리스트	
 $(document).ready(function(){
	$.ajax({
		type : 'get',
		url : '/FoodFighter/event/eventBoardList',
		data: 'pg='+$('#pg').val(),
		dataType: 'json',
		success : function(data){
			//alert(JSON.stringify(data));
			//<td id = "adminDelete">
			$.each(data.list, function(index, items){
				$('<tr/>').append($('<td/>',{}).addClass('adminDelete').append($('<div class = "tb-center"><input type ="checkbox" class = "select" value="선택삭제"></div>',{})))
							.append($('<td/>',{align: 'center' ,text: items.seq_event}))
							.append($('<td/>',{}).append($('<a/>',{id: 'subjectA',href: '#',align: 'center',text: items.subject})))
							.append($('<td/>',{align: 'center',text: items.nickname}))
							.append($('<td/>',{align: 'center', text: items.logtime}))
							.append($('<td/>',{align: 'center',text: items.hit}))
							.appendTo($('#eventBoard'));  
				
				       
			}); //each
			
			//페이징 처리
			$('#eventPagingDiv').html(data.eventPaging.pagingHTML);
			
			//로그인 여부 & 작성한 글 확인
			 $('#eventBoard').on('click', '#subjectA', function(){
				//alert($(this).prop('tagName'));
				
				/* if(data.memId == null){
					alert('먼저 로그인 하세요.');
					
				}else{ */
				let seq_event = ($(this).parent().prev().text()); //$(this).attr('class');
				let pg = data.pg;
				location.href = '/FoodFighter/event/eventView?seq_event='+seq_event+'&pg='+pg;
				
				//}
			});
			 $('.adminDelete').css('display', 'none');
			 if('${memberDTO.nickname}' == '관리자'){
					$('.adminDelete').show();
					let col = document.createElement('col');
					col.setAttribute('width', '45');
					let colgroup = $('#colgroup');
					colgroup.prepend(col);
					$('#admin').show();	
					$('<tr class = "admin"/>').append($('<td id = "allCheck"/>',{
					}).append($('<input type = "checkbox" id = "all"/>',{
					}))).append($('<td/>',{
						align: 'center',
						colspan : 4
					})).append($('<td/>',{
						align: 'center'
					}).append($('<input type = "button" value ="삭제" class = "plain-btn" id = "deleteBtn" />'),{
					})).prependTo($('thead')); 
					
				} 
		},
		error: function(err){
			console.log(err);
		}
	}); //ajax
});

//검색
$('#searchBtn').click(function(event, str){
	if(str != 'continue') $('input[name=pg]').val(1);
	if($('#inp').val() == ''){
		alert('검색어를 입력하세요');
		$('#inp').focus();	
	}else{
		$.ajax({
			type : 'get',
			url : '/FoodFighter/event/getEventSearch',
			data: {'pg': $('input[name=pg]').val(),
				   'where': $('#where').val(),
				   'inp': $('#inp').val()},
			dataType: 'json',
			success : function(data){
				//alert(JSON.stringify(data));
				
				$('#eventBoard tr:gt(0)').remove(); 
					
				$.each(data.list, function(index, items){
					$('<tr/>').append($('<td/>',{
						align: 'center',
						text: items.seq_event
					})).append($('<td/>',{
						}).append($('<a/>',{
							id: 'subjectA',
							href: '#',
							align: 'center',
							text: items.subject,
							class: items.seq_event+''
					}))
					).append($('<td/>',{
						align: 'center',
						text: items.id
					})).append($('<td/>',{
						align: 'center',
						text: items.logtime
					})).append($('<td/>',{
						align: 'center',
						text: items.hit
					})).appendTo($('#eventBoard'));         
				}); //each
				
				//페이징 처리
				$('#eventPagingDiv').html(data.eventPaging.pagingHTML);
				
				$('#eventBoard').on('click', '#subjectA', function(){
					
					let seq_event = ($(this).parent().prev().text()); //$(this).attr('class');
					let pg = data.pg;
					location.href = '/FoodFighter/event/eventView?seq_event='+seq_event+'&pg='+pg;
					
				}); 
			
			},
			error: function(err){
				console.log(err);
			}
		});
	}
});

$(document).on('click', '#all', function(){
	let select = $('.select');
	
	let all = $(this).is(":checked");
	
	if(all) {
		select.prop('checked', true);
	}else  {
		select.prop('checked', false);
	}
}); 

$(document).on('click', '.select', function(){
	let select = $(this).is(":checked");
	let all = $('#all');
	if(select == select.length){
		all.prop('checked', true);
	}else {
		all.prop('checked', false);
	}
});

/* //전체 선택/해제
$('#allCheck').click(function(){
	if($('#all').prop('checked'))
		$('input[name=check]').prop('checked', true);
	else
		$('input[name=check]').prop('checked', false);
});
*/
//선택 삭제
$(document).on('click', '#deleteBtn', function(){
	let count = $('input[name=check]:checked').length;
	
	if(count==0)
		alert("삭제할 항목을 선택하세요");
	else
		if(confirm("정말로 삭제하시겠습니까")){
			//$('#eventBoardListForm').submit();
		}
}); 


</script>
</body>
</html>