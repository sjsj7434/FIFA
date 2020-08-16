<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<meta charset="utf-8">
	<title>유저 검색</title>
	<link rel="shortcut icon" type="image/x-icon" href="resources/image/F4.png">
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/js/bootstrap.min.js" integrity="sha384-XEerZL0cuoUbHE4nZReLT7nx9gQrQreJekYhJD9WNWhH8nEW+0c5qq7aIo2Wl30J" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/css/bootstrap.min.css" integrity="sha384-VCmXjywReHh4PwowAiWNagnWcLhlEJLA5buUprzK8rxFgeH0kww/aWY76TfkUoSX" crossorigin="anonymous">
	
    <script type="text/javascript">
   		function numberFormat(inputNumber) {
    	   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    	}
   		
   		function imageError(data) {
			$(data)[0].src = "resources/image/error.png";
		}
   		
   		function enterPress() {
			userTradeSearchAjax(0);
		}
   		
   		function userDivision(division) {
   			var result = "";
   			
			switch (division) {
				case 800:
					result = '슈퍼챔피언스';
   		    		break;
   		  		case 900:
   		  			result = '챔피언스';
		    		break;
   		  		case 1100:
		    		result = '챌린지';
		    		break;
   		  		case 2000:
		    		result = '월드클래스1';
		    		break;
   			 	case 2100:
		    		result = '월드클래스2';
		    		break;
   			 	case 2200:
		    		result = '월드클래스3';
		    		break;
			 	case 2300:
		    		result = '프로1';
		    		break;
			 	case 2400:
		    		result = '프로2';
		    		break;
   			 	case 2500:
		    		result = '프로3';
		    		break;
   			 	case 2600:
		    		result = '세미프로1';
		    		break;
			 	case 2700:
		    		result = '세미프로2';
		    		break;
			 	case 2800:
		    		result = '세미프로3';
		    		break;
			 	case 2900:
		    		result = '아마추어1';
		    		break;
			 	case 3000:
		    		result = '아마추어2';
		    		break;
   			 	case 3100:
		    		result = '아마추어3';
		    		break;
   		  		default:
   		  			result = '정보 없음';
			}
			return result;
		}
   		
		function userTradeSearchAjax(paging) {
			var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
			var nickNameSearch = document.getElementById('nickNameSearch').value.replace(/ /gi, '');;
			document.getElementById('nickName').value = nickNameSearch;
			var nickName = document.getElementById('nickName').value;
			
			var offset = document.getElementById('offset');
			var limitSearch = document.getElementById('limitSearch');
			var limit = document.getElementById('limit');
			limit.value = limitSearch.value;
			
			if(paging == 0){
				offset.value = 0;
			}
			else if(paging == 1){
				offset.value = parseInt(offset.value) - parseInt(limit.value);
				if(offset.value < 0)
					offset.value = 0;
			}
			else if(paging == 2){
				offset.value = parseInt(offset.value) + parseInt(limit.value);
			}
			else{
				alert('에러 발생');
			}
			
			if(nickName == ''){
				alert('검색할 닉네임을 입력해주세요');
			}
			else{
				if(RegExp.test(nickName)){
					alert('특수문자는 입력할 수 없습니다');
				}
				else{
					var queryString = $("form[name=sendForm]").serialize();
					$.ajax({
				        url:"userTradeSearchAjax",
				        type:'GET',
				        data: queryString,
				        success:function(data){
				        	if(data[0].userFindByNickNameCode != '200'){
				        		alert('정보가 없거나, 비정상적인 호출입니다');
				        	}
				        	else{
				        		/* 유저 정보 테이블 - 시작 */
				        		var length = data[1].length;
				        		if(data[1][length-1].userMaxDivisionCode == 200){
				        			var htmlUser = '';
					        		htmlUser += "<tr>";
					        			htmlUser += "<td>" + data[0].nickname + "</td>";
					        			htmlUser += "<td>" + data[0].level + "</td>";
						        		if(data[1].length == 3){
							        		htmlUser += "<td>" + userDivision(data[1][0].division) + "</td>";
							        		htmlUser += "<td>" + userDivision(data[1][1].division) + "</td>";
						        		}
						        		else if(data[1].length == 2){
						        			if(data[1][0].matchType == 50){
						        				htmlUser += "<td>" + userDivision(data[1][0].division) + "</td>";
							        			htmlUser += "<td>정보 없음</td>";
						        			}
						        			else{
						        				htmlUser += "<td>정보 없음</td>";
						        				htmlUser += "<td>" + userDivision(data[1][0].division) + "</td>";
						        			}
						        		}
						        		else{
						        			htmlUser += "<td>정보 없음</td>";
							        		htmlUser += "<td>정보 없음</td>";
						        		}
						        		htmlUser += "<td>" + data[0].accessId + "</td>";
						        	htmlUser += "</tr>";
					        		$("#userTableTbody").empty();
						            $("#userTableTbody").append(htmlUser);
				        		}
					            /* 유저 정보 테이블 - 끝 */
					            
					            /* 판매 테이블 - 시작 */
					            if(data.length > 2){
					            	var length = data[2].length;
					            	if(data[2][length-1].userSellCode == 200){
					            		var htmlSell = '';
							            for(var i = 0; i < length-1; i++){
								            htmlSell += "<tr>";
								            	htmlSell += "<td>" + (i+1) + "</td>";
								            	if(data[3][i].playerVO == null){
								            		htmlSell += "<td><img src='" + "resources/image/nodata.png" + "' alt='선수 이미지'/> " + "존재하지 않는 선수" + "</td>";
								            	}
								            	else{
								            		htmlSell += "<td style='text-align: left;'><img src='" + data[3][i].playerVO.seasonimg + "' alt='시즌 이미지'/> " + data[3][i].playerVO.name + "</td>";
								            	}
								        		htmlSell += "<td><img src='resources/image/grade/" + data[2][i].grade + ".png'/></td>";
								        		htmlSell += "<td style='text-align: right;'>" + numberFormat(data[2][i].value); + "</td>";
								        		htmlSell += "<td style='text-align: right;'>" + data[2][i].tradeDate.replace('T', " ") + "</td>";
								        	htmlSell += "</tr>";
							            }
							            $("#sellTableTbody").empty();
							            $("#sellTableTbody").append(htmlSell);
					            	}
					            }
					            else{
					            	var htmlSell = '';
							            htmlSell += "<tr>";
							            	htmlSell += "<td>" + (1) + "</td>";
							        		htmlSell += "<td>판매 정보가 없습니다</td>";
							        	htmlSell += "</tr>";
						            $("#sellTableTbody").empty();
						            $("#sellTableTbody").append(htmlSell);
					            }
					            /* 판매 테이블 - 끝 */
					            
					            /* 구매 테이블 - 시작 */
					            if(data.length > 4){
					            	var length = data[4].length;
					            	if(data[4][length-1].userBuyCode == 200){
					            		var htmlBuy = '';
										for(var i = 0; i < length-1; i++){
								            htmlBuy += "<tr>";
								            	htmlBuy += "<td>" + (i+1) + "</td>";
								            	if(data[5][i].playerVO == null){
								            		 htmlBuy += "<td><img src='" + "resources/image/nodata.png" + "' alt='선수 이미지'/> " + "존재하지 않는 선수" + "</td>";
								            	}
								            	else{
								            		htmlBuy += "<td style='text-align: left;'><img src='" + data[5][i].playerVO.seasonimg + "' alt='시즌 이미지'/> " + data[5][i].playerVO.name + "</td>";
								            	}
									            htmlBuy += "<td><img src='resources/image/grade/" + data[4][i].grade + ".png'/></td>";
									            htmlBuy += "<td style='text-align: right;'>" + numberFormat(data[4][i].value); + "</td>";
									            htmlBuy += "<td style='text-align: right;'>" + data[4][i].tradeDate.replace('T', " ") + "</td>";
								        	htmlBuy += "</tr>";
							            }
										$("#buyTableTbody").empty();
							            $("#buyTableTbody").append(htmlBuy);
					            	}
					            }
					            else{
					            	var htmlBuy = '';
						            htmlBuy += "<tr>";
						            	htmlBuy += "<td>" + (1) + "</td>";
							            htmlBuy += "<td>구매 정보가 없습니다</td>";
						        	htmlBuy += "</tr>";
									$("#buyTableTbody").empty();
						            $("#buyTableTbody").append(htmlBuy);
					            }
					            /* 구매 테이블 - 끝 */
				        	}
				        },
				        error:function(request, status, error){
				        	/* alert("응답코드:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); */
				        	if(request.status == 500){
				        		alert("응답코드:"+request.status+"\n내용:"+"넥슨 서버 내부 에러");
				        	}
				        	else{
				        		alert("응답코드:"+request.status+"\n내용:"+"에러가 발생했습니다")
				        	}
				        }
				    });
				}
			}
		}
	</script>
	<style>
		main > .container {
		  padding: 60px 15px 0;
		}
		
		.footer {
		  background-color: #f5f5f5;
		}
		
		.footer > .container {
		  padding-right: 15px;
		  padding-left: 15px;
		}
	</style>
</head>
<body class="d-flex flex-column h-100" style="text-align: center;">
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	      	<div class="container">
		        <a class="navbar-brand" href="#"><img alt="logo.png" src="resources/image/F4.png" height="35" width="35">FO4</a>
		        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="false" aria-label="Toggle navigation">
		          	<span class="navbar-toggler-icon"></span>
		        </button>
		        <div class="collapse navbar-collapse" id="navbarsExample07">
		          	<ul class="navbar-nav mr-auto">
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="announcement">공지사항</a>
			            </li>
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="playerSearch">대장시즌 찾기</a>
			            </li>
			            <li class="nav-item active" style="padding-right: 20px;">
			              	<a class="nav-link" href="userTradeSearch">거래기록 조회</a>
			            </li>
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="userMatchSearch">유저 전적 검색</a>
			            </li>
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="errorReport">오류 신고/건의사항</a>
			            </li>
		          	</ul>
		        </div>
	      	</div>
		</nav>
	</header>
	
	<main role="main" class=""><!-- flex-shrink-0 -->
		<div class="container">
			<div class="jumbotron">
		    	<h1 style="font-size: 60px;">거래기록 조회</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<form name="sendForm" id="sendForm" method="POST" onsubmit="return false">
							<div class="form-group" style="text-align: left;">
								<hr class="my-4">
								<p class="lead"><strong>사용법</strong></p>
								<p><strong>닉네임</strong>을 입력하여 유저의 거래 기록을 조회합니다</p>
								<p>이전, 다음 버튼을 이용하여 페이지를 넘길 수 있고 <strong>10, 25, 50, 100개</strong> 표시를 변경할 수 있습니다</p>
								<p><strong>사재기 장사꾼</strong>으로 의심이 간다면 확인해보세요!</p>
								<p style="color: red;"><strong>일부 선수는 더 이상 존재하지 않아 "존재하지 않는 선수"로 출력 됩니다</strong></p>
								<p style="color: red;"><strong>데이터는 Nexon의 시스템에서 가져오므로 "거래날짜"가 동일하게 나올 수 있습니다</strong></p>
							  	<hr class="my-4">
							</div>
							<input type="hidden" name="post_writer" id="post_writer">
							<div class="form-group" style="text-align: left;">
								<label for="exampleFormControlInput1">유저 닉네임</label>
								<div class="input-group mb-3">
								  <input type="text" class="form-control" id="nickNameSearch" name="nickNameSearch" value="" placeholder="닉네임을 입력해주세요" maxlength="50" onkeypress="if(event.keyCode == 13){enterPress();}" aria-label="Recipient's username" aria-describedby="basic-addon2">
								  	<div class="input-group-append">
								    	<button class="btn btn-outline-secondary" type="button" onclick="userTradeSearchAjax(0)">조회</button>
									</div>
								</div>
							</div>
							
							<table class="table">
								<thead>
								    <tr>
								    	<th>닉네임</th>
										<th>레벨</th>
										<th>공식경기 최고등급</th>
										<th>감독모드 최고등급</th>
										<th>AccessId</th>
								    </tr>
								</thead>
								<tbody id="userTableTbody">
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div>
			<form name="sendForm" method="GET">
				<input type="hidden" name="nickName" id="nickName" value="">
				<input type="hidden" name="offset" id="offset" value="0">
				<input type="hidden" name="limit" id="limit" value="10">
			</form>
			
			<div class="container">
			  <div class="row">
			    <div class="col align-self-start"> </div>
			    <div class="col align-self-center">
			    	<button type="button" class="btn btn-success" onclick="userTradeSearchAjax(1)"> 이전 </button>
					<button type="button" class="btn btn-success" onclick="userTradeSearchAjax(2)"> 다음 </button>
					<div style="padding-bottom: 20px;"></div>
					<select id="limitSearch" class="custom-select">
						<option value="10">10개 표시</option>
						<option value="25">25개 표시</option>
						<option value="50" selected="selected">50개 표시</option>
						<option value="100">100개 표시</option>
					</select>
			    </div>
			    <div class="col align-self-end"> </div>
			  </div>
			</div>
			
			<div style="width:47%; float:left; padding-left: 25px;">
				<table class="table table-sm table-striped">
					<caption id="sellTable" style="text-align: center; color: black; font-size: large; font-weight: bold; caption-side: top;">판매기록</caption>
					<caption id="sellTable" style="text-align: center; color: black; font-size: large; font-weight: bold;">판매기록</caption>
					<thead class="thead-light">
						<tr>
							<th>번호</th>
							<th style="display: none;">이미지</th>
							<th>이름</th>
							<th>강화등급</th>
							<th style="text-align: right;">가치(BP)</th>
							<th style="text-align: right;">거래날짜</th>
						</tr>
					</thead>
					<tbody id="sellTableTbody">
					</tbody>
				</table>
			</div>
			
			<div style="width:47%; float:right; padding-right: 25px;">
				<table id="buyTable" class="table table-sm table-striped">
					<caption style="text-align: center; color: black; font-size: large; font-weight: bold; caption-side: top;">구매기록</caption>
					<caption style="text-align: center; color: black; font-size: large; font-weight: bold;">구매기록</caption>
					<thead class="thead-light">
						<tr>
							<th>번호</th>
							<th style="display: none;">이미지</th>
							<th>이름</th>
							<th>강화등급</th>
							<th style="text-align: right;">가치(BP)</th>
							<th style="text-align: right;">거래날짜</th>
						</tr>
					</thead>
					<tbody id="buyTableTbody">
					</tbody>
				</table>
			</div>
		</div>
	</main>
	
	<footer class="footer mt-auto py-3" style="background-color: white;">
		<div class="container">
			<div>
				<button type="button" class="btn btn-success" onclick="userTradeSearchAjax(1)"> 이전 </button>
				<button type="button" class="btn btn-success" onclick="userTradeSearchAjax(2)"> 다음 </button>
			</div>
		</div>
	</footer>
	
	<footer class="footer mt-auto py-3">
		<div class="container">
			<span class="text-muted">FIFA ONLINE 4 (Data based on NEXON DEVELOPERS)</span>
		</div>
		<div class="container">
			<span class="text-muted">TOTAL : ${countAllVisitors}명</span>
			<span class="text-muted"> & </span>
			<span class="text-muted">TODAY : ${countTodayVisitors}명</span>
		</div>
	</footer>
	
	<div class="modal" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">WARNING!</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>제목, 내용을 입력해주세요</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>