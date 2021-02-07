<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
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
   			let result = "";
   			
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
			document.getElementById("loading").innerHTML = "정보를 불러오고 있습니다...";
			$("#sellTableTbody").empty();
			$("#buyTableTbody").empty();
			
			const sendForm = document.getElementById("sendForm");
			let RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
			
			let nickNameCheck = sendForm.nickName.value.replace(/ /gi, '');
			
			let offset = sendForm.offset;
			let limit = sendForm.limit;
			
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
				document.getElementById("loading").innerHTML = "에러 발생...";
				alert('에러 발생');
			}
			
			if(nickNameCheck == ''){
				document.getElementById("loading").innerHTML = "검색할 닉네임을 입력해주세요";
				alert('검색할 닉네임을 입력해주세요');
			}
			else{
				if(RegExp.test(nickNameCheck)){
					document.getElementById("loading").innerHTML = "특수문자는 입력할 수 없습니다";
					alert('특수문자는 입력할 수 없습니다');
				}
				else{
					$.ajax({
				        url:"userTradeSearchAjax",
				        type:'GET',
				        data: {
			        		nickName : sendForm.nickName.value,
			        		offset : sendForm.offset.value,
			        		limit : sendForm.limit.value,
			        		searchWhere : window.location.pathname,
							userIp : ip()//jsgetip.appspot.com, siteTop에서 로딩
				        },
				        success:function(data){
				        	if(data.length === 0 || data[0].userFindByNickNameCode != '200'){
				        		document.getElementById("loading").innerHTML = "정보가 없거나, 비정상적인 호출입니다";
				        	}
				        	else{
				        		/* 유저 정보 테이블 - 시작 */
				        		let length = data[1].length;
				        		if(data[1][length-1].userMaxDivisionCode == 200){
				        			let htmlUser = '';
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
					            	let length = data[2].length;
					            	if(data[2][length-1].userSellCode == 200){
					            		let htmlSell = '';
							            for(let i = 0; i < length-1; i++){
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
					            	let htmlSell = '';
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
					            	let length = data[4].length;
					            	if(data[4][length-1].userBuyCode == 200){
					            		let htmlBuy = '';
										for(let i = 0; i < length-1; i++){
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
					            	let htmlBuy = '';
						            htmlBuy += "<tr>";
						            	htmlBuy += "<td>" + (1) + "</td>";
							            htmlBuy += "<td>구매 정보가 없습니다</td>";
						        	htmlBuy += "</tr>";
									$("#buyTableTbody").empty();
						            $("#buyTableTbody").append(htmlBuy);
					            }
					            /* 구매 테이블 - 끝 */
					            
					            document.getElementById("loading").innerHTML = "";
				        	}
				        },
				        error:function(request, status, error){
				        	if(request.status == 500){
				        		document.getElementById("loading").innerHTML = "응답코드:"+request.status+"\n내용:"+"넥슨 서버 내부 에러";
				        	}
				        	else{
				        		document.getElementById("loading").innerHTML = "응답코드:"+request.status+"\n내용:"+"에러가 발생했습니다";
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
			bottom: 0;
			width: 100%;
			height: 100px;
			position: relative;
			text-align: center;"
		}
		
		.footer > .container {
		  padding-right: 15px;
		  padding-left: 15px;
		}
	</style>
</head>
<body class="d-flex flex-column h-100" style="text-align: center;">
	<main role="main" class=""><!-- flex-shrink-0 -->
		<div class="container">
			<div class="jumbotron">
		    	<h1 style="font-size: 60px;">거래기록 조회</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<form name="sendForm" id="sendForm" method="POST" onsubmit="return false">
							<input type="hidden" name="offset" id="offset" value="0">
							
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
							
							<div class="form-group" style="text-align: left;">
								<label for="exampleFormControlInput1">유저 닉네임</label>
								<div class="input-group">
									<input style="width:60%" type="text" class="form-control" id="nickName" name="nickName" value="" placeholder="닉네임을 입력해주세요" maxlength="50"
								  		onkeypress="if(event.keyCode == 13){enterPress();}" aria-label="Recipient's username" aria-describedby="basic-addon2"/>
								  	<select name="limit" id="limit" class="custom-select">
											<option value="10">10개 표시</option>
											<option value="25" selected="selected">25개 표시</option>
											<option value="50">50개 표시</option>
											<option value="100">100개 표시</option>
										</select>
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
			<div class="container">
				<div class="row">
					<div class="col align-self-start"></div>
					<div class="col align-self-center">
						<button type="button" class="btn btn-success"
							onclick="userTradeSearchAjax(1)">이전</button>
						<button type="button" class="btn btn-success"
							onclick="userTradeSearchAjax(2)">다음</button>
						<div style="padding-bottom: 20px;"></div>
					</div>
					<div class="col align-self-end"></div>
				</div>
			</div>
			
			<div style="width: 100%; float: right; margin: 10px;">
				<div class="container">
					<div class="row">
						<div class="col align-self-start"></div>
						<div id="loading" class="col align-self-center" style="font-size: 20px;"></div>
						<div class="col align-self-end"></div>
					</div>
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
		
		<div style="width: 100%; float: right;">
			<div class="container">
				<div class="row">
					<div class="col align-self-start"></div>
					<div class="col align-self-center">
						<button type="button" class="btn btn-success" onclick="userTradeSearchAjax(1)">이전</button>
						<button type="button" class="btn btn-success" onclick="userTradeSearchAjax(2)">다음</button>
						<div style="padding-bottom: 20px;"></div>
					</div>
					<div class="col align-self-end"></div>
				</div>
			</div>
		</div>
	</main>
	
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