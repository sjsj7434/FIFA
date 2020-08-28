<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-176171640-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'UA-176171640-1');
	</script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	
	<!-- Open  Graph -->
	<meta property="og:title" content="피파거시기" />
	<meta property="og:description" content="피파온라인4의 잡다한 정보" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="http://www.vlvk4.com/" />
	<meta property="og:image" content="http://www.vlvk4.com/resources/image/F4.png" />
	<!-- Open  Graph -->
	
	<meta name="description" content="피파온라인4 유저 전적 검색, 선수 정보 비교, 유저 거래기록 조회">
	
	<meta charset="utf-8">
	<title>피파거시기</title>
	<link rel="shortcut icon" type="image/x-icon" href="resources/image/F4.png">
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/js/bootstrap.min.js" integrity="sha384-XEerZL0cuoUbHE4nZReLT7nx9gQrQreJekYhJD9WNWhH8nEW+0c5qq7aIo2Wl30J" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/css/bootstrap.min.css" integrity="sha384-VCmXjywReHh4PwowAiWNagnWcLhlEJLA5buUprzK8rxFgeH0kww/aWY76TfkUoSX" crossorigin="anonymous">
	
    <script type="text/javascript">
	    var dataGlobal = null;
	    var playerGlobal0 = null;
	    var playerGlobal1 = null;
    	
   		function numberFormat(inputNumber) {
    	   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    	}
   		
   		function imageError(data) {
			$(data)[0].src = "resources/image/error.png";
		}
   		
   		function enterPress() {
			userSearchAjax(0);
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
   		
		function userSearchAjax(paging) {
			var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
			var nickNameSearch = document.getElementById('nickNameSearch').value.replace(/ /gi, '');;
			document.getElementById('nickName').value = nickNameSearch;
			var nickName = document.getElementById('nickName').value;
			var matchType = document.getElementById('matchType').value;
			
			var matchtype = document.getElementById('matchtype');
			var offset = document.getElementById('offset');
			var limitSearch = document.getElementById('limitSearch');
			var limit = document.getElementById('limit');
			
			matchtype.value = matchType;
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
				        url:"userMatchSearchAjax",
				        type:'GET',
				        data: queryString,
				        success:function(data){
				        	console.log(data);
				        	dataGlobal = data;

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
					            
					            /* 경기 기록 테이블 - 시작 */
					            if(data.length > 2){
					            	var length = data[2].length;
					            	if(data[2][length-1].findMatchByAccessIdCode == 200){
					            		var htmlMatch = '';
							            for(var i = 0; i < length-1; i++){
							            	if(data[0].accessId == data[3][i].matchInfo[0].accessId){
							            		htmlMatch += '<tr onclick="userMatchClick(' + i + ')" style="cursor:pointer;">';
									            	htmlMatch += "<td>" + data[3][i].matchDate.replace('T', " ") + "</td>";
									            	
									            	if(data[3][i].matchInfo[0].matchDetail.matchResult == '승'){
									            		htmlMatch += "<td style='color: blue;'>" + data[3][i].matchInfo[0].nickname + "</td>";
									            	}
									            	else if(data[3][i].matchInfo[0].matchDetail.matchResult == '무'){
									            		htmlMatch += "<td style='color: black;'>" + data[3][i].matchInfo[0].nickname + "</td>";
									            	}
									            	else{
									            		htmlMatch += "<td style='color: red;'>" + data[3][i].matchInfo[0].nickname + "</td>";
									            	}
									            	
									            	if(data[3][i].matchInfo.length > 1){
									            		htmlMatch += "<td>" + data[3][i].matchInfo[0].shoot.goalTotal + " : " + data[3][i].matchInfo[1].shoot.goalTotal + "</td>";
										        		
									            		if(data[3][i].matchInfo[1].matchDetail.matchResult == '승'){
										            		htmlMatch += "<td style='color: blue;'>" + data[3][i].matchInfo[1].nickname + "</td>";
										            	}
									            		else if(data[3][i].matchInfo[1].matchDetail.matchResult == '무'){
										            		htmlMatch += "<td style='color: black;'>" + data[3][i].matchInfo[1].nickname + "</td>";
										            	}
										            	else{
										            		htmlMatch += "<td style='color: red;'>" + data[3][i].matchInfo[1].nickname + "</td>";
										            	}
									            	}
									            	else{
									            		htmlMatch += "<td>" + data[3][i].matchInfo[0].shoot.goalTotal + " : " + "0" + "</td>";
										        		htmlMatch += "<td>" + "-" + "</td>";
									            	}
									            	
								        		htmlMatch += "</tr>";
						            		}
						            		else{
						            			htmlMatch += '<tr onclick="userMatchClick(' + i + ')" style="cursor:pointer;">';
									            	htmlMatch += "<td>" + data[3][i].matchDate.replace('T', " ") + "</td>";
									            	
									            	if(data[3][i].matchInfo.length > 1){
									            		if(data[3][i].matchInfo[1].matchDetail.matchResult == '승'){
										            		htmlMatch += "<td style='color: blue;'>" + data[3][i].matchInfo[1].nickname + "</td>";
										            	}
									            		else if(data[3][i].matchInfo[1].matchDetail.matchResult == '무'){
										            		htmlMatch += "<td style='color: black;'>" + data[3][i].matchInfo[1].nickname + "</td>";
										            	}
										            	else{
										            		htmlMatch += "<td style='color: red;'>" + data[3][i].matchInfo[1].nickname + "</td>";
										            	}
										            	
										        		htmlMatch += "<td>" + data[3][i].matchInfo[1].shoot.goalTotal + " : " + data[3][i].matchInfo[0].shoot.goalTotal + "</td>";
									            	}
									            	else{
										        		htmlMatch += "<td>" + "-" + "</td>";
										        		htmlMatch += "<td>" + "0" + " : " + data[3][i].matchInfo[0].shoot.goalTotal + "</td>";
									            	}
									            	
									            	if(data[3][i].matchInfo[0].matchDetail.matchResult == '승'){
									            		htmlMatch += "<td style='color: blue;'>" + data[3][i].matchInfo[0].nickname + "</td>";
									            	}
									            	else if(data[3][i].matchInfo[0].matchDetail.matchResult == '무'){
									            		htmlMatch += "<td style='color: black;'>" + data[3][i].matchInfo[0].nickname + "</td>";
									            	}
									            	else{
									            		htmlMatch += "<td style='color: red;'>" + data[3][i].matchInfo[0].nickname + "</td>";
									            	}
									        		
								        		htmlMatch += "</tr>";
						            		}
							            }
							            $("#matchTableTbody").empty();
							            $("#matchTableTbody").append(htmlMatch);
					            	}
					            }
					            else{
					            	var htmlMatch = '';
							            htmlMatch += "<tr>";
							            	htmlMatch += "<td>" + (1) + "</td>";
							        		htmlMatch += "<td>경기 정보가 없습니다</td>";
							        	htmlMatch += "</tr>";
						            $("#matchTableTbody").empty();
						            $("#matchTableTbody").append(htmlMatch);
					            }
					            /* 경기 기록 테이블 - 끝 */
				        	}
				        },
				        error:function(request, status, error){
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
		
		function userMatchClick(i) {
			$("#modalContents").empty();
			
			console.log(dataGlobal[3][i]);
			
			if(dataGlobal[3][i].matchInfo.length == 2){
				playerGlobal0 = dataGlobal[3][i].matchInfo[0].player;
				playerGlobal1 = dataGlobal[3][i].matchInfo[1].player;
			}
			
			if(dataGlobal[3][i].matchInfo.length > 1){
				if(dataGlobal[3][i].matchInfo[0].matchDetail.matchResult == '승'){
					$("#user0Nickname").css("color","blue");
				}
				else if(dataGlobal[3][i].matchInfo[0].matchDetail.matchResult == '패'){
					$("#user0Nickname").css("color","red");
				}
				else{
					$("#user0Nickname").css("color","black");
				}
				$("#user0Nickname").html(dataGlobal[3][i].matchInfo[0].nickname);
				$("#user0Nickname").append(' [' + dataGlobal[3][i].matchInfo[0].matchDetail.matchResult + ']');
				$("#user0Goal").html(dataGlobal[3][i].matchInfo[0].shoot.goalTotal);
				$("#user0Shoot").html(dataGlobal[3][i].matchInfo[0].shoot.shootTotal);
				$("#user0PenaltyKick").html(dataGlobal[3][i].matchInfo[0].shoot.shootPenaltyKick);
				$("#user0EffectiveShoot").html(dataGlobal[3][i].matchInfo[0].shoot.effectiveShootTotal);
				
				if(dataGlobal[3][i].matchInfo[0].pass.passTry == 0){
					$("#user0PassSuccess").html('0 %');
				}
				else{
					$("#user0PassSuccess").html((dataGlobal[3][i].matchInfo[0].pass.passSuccess / dataGlobal[3][i].matchInfo[0].pass.passTry * 100).toFixed(2) + ' %');
				}
				$("#user0CornerKick").html(dataGlobal[3][i].matchInfo[0].matchDetail.cornerKick);
				$("#user0TackleSuccess").html(dataGlobal[3][i].matchInfo[0].defence.tackleSuccess);
				$("#user0Foul").html(dataGlobal[3][i].matchInfo[0].matchDetail.foul);
				$("#user0YellowCards").html(dataGlobal[3][i].matchInfo[0].matchDetail.yellowCards);
				$("#user0RedCards").html(dataGlobal[3][i].matchInfo[0].matchDetail.redCards);
				$("#user0Injury").html(dataGlobal[3][i].matchInfo[0].matchDetail.injury);
				$("#user0Pause").html(dataGlobal[3][i].matchInfo[0].matchDetail.systemPause);
				
				//상대 구분--------------------
				
				if(dataGlobal[3][i].matchInfo[1].matchDetail.matchResult == '승'){
					$("#user1Nickname").css("color","blue");
				}
				else if(dataGlobal[3][i].matchInfo[1].matchDetail.matchResult == '패'){
					$("#user1Nickname").css("color","red");
				}
				else{
					$("#user1Nickname").css("color","black");
				}
				$("#user1Nickname").html(dataGlobal[3][i].matchInfo[1].nickname);
				$("#user1Nickname").append(' [' + dataGlobal[3][i].matchInfo[1].matchDetail.matchResult + ']');
				$("#user1Goal").html(dataGlobal[3][i].matchInfo[1].shoot.goalTotal);
				$("#user1Shoot").html(dataGlobal[3][i].matchInfo[1].shoot.shootTotal);
				$("#user1PenaltyKick").html(dataGlobal[3][i].matchInfo[1].shoot.shootPenaltyKick);
				$("#user1EffectiveShoot").html(dataGlobal[3][i].matchInfo[1].shoot.effectiveShootTotal);
				
				if(dataGlobal[3][i].matchInfo[1].pass.passTry == 0){
					$("#user1PassSuccess").html('0 %');
				}
				else{
					$("#user1PassSuccess").html((dataGlobal[3][i].matchInfo[1].pass.passSuccess / dataGlobal[3][i].matchInfo[1].pass.passTry * 100).toFixed(2) + ' %');
				}
				$("#user1CornerKick").html(dataGlobal[3][i].matchInfo[1].matchDetail.cornerKick);
				$("#user1TackleSuccess").html(dataGlobal[3][i].matchInfo[1].defence.tackleSuccess);
				$("#user1Foul").html(dataGlobal[3][i].matchInfo[1].matchDetail.foul);
				$("#user1YellowCards").html(dataGlobal[3][i].matchInfo[1].matchDetail.yellowCards);
				$("#user1RedCards").html(dataGlobal[3][i].matchInfo[1].matchDetail.redCards);
				$("#user1Injury").html(dataGlobal[3][i].matchInfo[1].matchDetail.injury);
				$("#user1Pause").html(dataGlobal[3][i].matchInfo[1].matchDetail.systemPause);
			}
			else{
				if(dataGlobal[3][i].matchInfo[0].matchDetail.matchResult == '승'){
					$("#user0Nickname").css("color","blue");
				}
				else if(dataGlobal[3][i].matchInfo[0].matchDetail.matchResult == '패'){
					$("#user0Nickname").css("color","red");
				}
				else{
					$("#user0Nickname").css("color","black");
				}
				$("#user0Nickname").html(dataGlobal[3][i].matchInfo[0].nickname);
				$("#user0Nickname").append(' [' + dataGlobal[3][i].matchInfo[0].matchDetail.matchResult + ']');
				$("#user0Goal").html(0);
				$("#user0Shoot").html(0);
				$("#user0PenaltyKick").html(0);
				$("#user0EffectiveShoot").html(0);
				
				$("#user0PassSuccess").html('0 %');
				$("#user0CornerKick").html(0);
				$("#user0TackleSuccess").html(0);
				$("#user0Foul").html(0);
				$("#user0YellowCards").html(0);
				$("#user0RedCards").html(0);
				$("#user0Injury").html(0);
				$("#user0Pause").html(0);
				
				//상대 구분--------------------
				
				$("#user1Nickname").html('');
				$("#user1Nickname").append(' [패]');
				$("#user1Goal").html(0);
				$("#user1Shoot").html(0);
				$("#user1PenaltyKick").html(0);
				$("#user1EffectiveShoot").html(0);
				
				$("#user1PassSuccess").html('0 %');
				$("#user1CornerKick").html(0);
				$("#user1TackleSuccess").html(0);
				$("#user1Foul").html(0);
				$("#user1YellowCards").html(0);
				$("#user1RedCards").html(0);
				$("#user1Injury").html(0);
				$("#user1Pause").html(0);
			}
			
			$("#myModal").modal('show');
		}
		
		function playerInfo() {
			var playerList = {};
			
			for(var index = 0; index < playerGlobal0.length; index++){
				playerList[index] = playerGlobal0[index].spId;
			}
			console.log(playerList);
			
			$.ajax({
				url : "searchPlayerList",
				type : 'POST',
				data : JSON.stringify(playerList),
				dataType : 'json',
				contentType : "application/json;",
				success : function(data){
					console.log(data);
					
					$("#test0").html('');
					$("#test1").html('');
					$("#GK").html('');
					$("#SW").html('');
					$("#RWB").html('');
					$("#RB").html('');
					$("#RCB").html('');
					$("#CB").html('');
					$("#LCM").html('');
					$("#LB").html('');
					$("#LWB").html('');
					$("#RDM").html('');
					$("#CDM").html('');
					$("#LDM").html('');
					$("#RM").html('');
					$("#RCM").html('');
					$("#CM").html('');
					$("#LCM").html('');
					$("#LM").html('');
					$("#RAM").html('');
					$("#CAM").html('');
					$("#LAM").html('');
					$("#RF").html('');
					$("#CF").html('');
					$("#LF").html('');
					$("#RW").html('');
					$("#RS").html('');
					$("#ST").html('');
					$("#LS").html('');
					$("#LW").html('');
					
					if(playerGlobal0 != null){
						for(var index = 0; index < data.length; index++){
							if(playerGlobal0[index].spPosition != 28){
								switch (playerGlobal0[index].spPosition) {
								case 0:
									$("#GK").html(data[index].name);
									break;
								case 1:
									$("#SW").html(data[index].name);
									break;
								case 2:
									$("#RWB").html(data[index].name);
									break;
								case 3:
									$("#RB").html(data[index].name);
									break;
								case 4:
									$("#RCB").html(data[index].name);
									break;
								case 5:
									$("#CB").html(data[index].name);
									break;
								case 6:
									$("#LCB").html(data[index].name);
									break;
								case 7:
									$("#LB").html(data[index].name);
									break;
								case 8:
									$("#LWB").html(data[index].name);
									break;
									
								case 9:
									$("#RDM").html(data[index].name);
									break;
								case 10:
									$("#CDM").html(data[index].name);
									break;
								case 11:
									$("#LDM").html(data[index].name);
									break;
								case 12:
									$("#RM").html(data[index].name);
									break;
								case 13:
									$("#RCM").html(data[index].name);
									break;
								case 14:
									$("#CM").html(data[index].name);
									break;
								case 15:
									$("#LCM").html(data[index].name);
									break;
								case 16:
									$("#LM").html(data[index].name);
									break;
								case 17:
									$("#RAM").html(data[index].name);
									break;
								case 18:
									$("#CAM").html(data[index].name);
									break;
								case 19:
									$("#LAM").html(data[index].name);
									break;
									
								case 20:
									$("#RF").html(data[index].name);
									break;
								case 21:
									$("#CF").html(data[index].name);
									break;
								case 22:
									$("#LF").html(data[index].name);
									break;
								case 23:
									$("#RW").html(data[index].name);
									break;
								case 24:
									$("#RS").html(data[index].name);
									break;
								case 25:
									$("#ST").html(data[index].name);
									break;
								case 26:
									$("#LS").html(data[index].name);
									break;
								case 27:
									$("#LW").html(data[index].name);
									break;
								default:
									break;
								}
								$("#test0").append(
									'<p align="left">' +
										'<img src="'+ data[index].seasonimg +'"/>'+data[index].name +
									'</p>'
								);
							}
							else{
								$("#test1").append(
									'<p align="left"">' +
										'<img src="'+ data[index].seasonimg +'"/>'+data[index].name +
									'</p>'
								);
							}
						}
					}
					$("#div0").html('선발');
					$("#div1").html('후보');
					$("#playerModal").modal('show');
				},
				error : function(error){
					alert(error);
				}				
			})
			//console.log(playerGlobal0);
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
		        <a class="navbar-brand" href="main"><img alt="logo.png" src="resources/image/F4.png" height="35" width="35">피파거시기</a>
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
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="userTradeSearch">거래기록 조회</a>
			            </li>
			            <li class="nav-item active" style="padding-right: 20px;">
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
		    	<h1 style="font-size: 60px;">유저 전적 검색</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<!-- <grammarly-extension style="position: absolute; top: -3.1875px; left: -3.1875px; pointer-events: none;" class="_1KJtL"></grammarly-extension> -->
						<form name="sendForm" id="sendForm" method="POST" onsubmit="return false">
							<div class="form-group" style="text-align: left;">
								<hr class="my-4">
								<p class="lead"><strong>사용법</strong></p>
								<p><strong>닉네임</strong>을 입력하여 유저의 전적을 조회합니다</p>
								<p>전적을<strong>10, 25, 50, 100개</strong>로 표시를 변경할 수 있습니다</p>
								<p><strong>경기 정보를 클릭하면</strong> 상세정보를 볼수 있습니다</p>
								<p style="color: red;"><strong>50~100개의 데이터는 가져오는데 시간이 걸립니다(10초 이내) 다음, 이전 버튼을 마구 누르면 에러가 발생할 수 있습니다</strong></p>
								<p style="color: red;"><strong>일부 데이터는 온전하지 않을 수 있습니다</strong></p>
								<p style="color: red;"><strong>*경기 상세 정보 개발중(2020/08/11~)</strong></p>
							  	<hr class="my-4">
							</div>
							
							<div class="form-group" style="text-align: left;">
								<label for="exampleFormControlInput1">유저 닉네임</label>
								<div class="input-group">
									<input type="text" class="form-control" id="nickNameSearch" name="nickNameSearch" value="허총무" placeholder="닉네임을 입력해주세요" maxlength="50"
								  		onkeypress="if(event.keyCode == 13){enterPress();}" aria-label="Recipient's username" aria-describedby="basic-addon2">
								  	<div class="input-group-append">
								  		<select id="matchType" class="custom-select">
											<option value="50" selected="selected">공식 경기</option>
											<option value="52">감독 모드</option>
										</select>
								    	<button class="btn btn-outline-secondary" type="button" onclick="userSearchAjax(0)">SEARCH!</button>
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
				<input type="hidden" name="matchtype" id="matchtype" value="50">
				<input type="hidden" name="offset" id="offset" value="0">
				<input type="hidden" name="limit" id="limit" value="100">
			</form>
			
			<div class="container">
			  <div class="row">
			    <div class="col align-self-start"> </div>
			    <div class="col align-self-center">
			    	<button type="button" class="btn btn-success" onclick="userSearchAjax(1)"> 이전 </button>
					<button type="button" class="btn btn-success" onclick="userSearchAjax(2)"> 다음 </button>
					<div style="padding-bottom: 20px;"></div>
					<select id="limitSearch" class="custom-select">
						<option value="10" selected="selected">10개 표시</option>
						<option value="25">25개 표시</option>
						<option value="50">50개 표시</option>
						<option value="100">100개 표시</option>
					</select>
			    </div>
			    <div class="col align-self-end"> </div>
			  </div>
			</div>
			
			<div style="padding-left: 300px; padding-right: 300px;">
				<table class="table table-sm table-striped">
					<caption id="sellTable" style="text-align: center; color: black; font-size: large; font-weight: bold; caption-side: top;">경기 전적</caption>
					<caption id="sellTable" style="text-align: center; color: black; font-size: large; font-weight: bold;">경기 전적</caption>
					<thead class="thead-light">
						<tr>
							<th>날짜</th>
							<th>닉네임</th>
							<th>스코어</th>
							<th>닉네임</th>
						</tr>
					</thead>
					<tbody id="matchTableTbody">
					</tbody>
				</table>
			</div>
		</div>
	</main>
	
	<footer class="footer mt-auto py-3" style="background-color: white;">
		<div class="container">
			<div>
				<button type="button" class="btn btn-success" onclick="userSearchAjax(1)"> 이전 </button>
				<button type="button" class="btn btn-success" onclick="userSearchAjax(2)"> 다음 </button>
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
		<div>
			<a href="siteExplain"><span class="text-muted">사이트 설명(Site Explain)</span></a>		
		</div>
	</footer>
	
	<div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="modalTitle">경기 상세 정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<main role="main" class="">
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0Nickname" style="font-size: large; font-weight: bold;"></div>
							<div class="col"></div>
							<div class="col" id="user1Nickname" style="font-size: large; font-weight: bold;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0Goal" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">골</div>
							<div class="col" id="user1Goal" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0Shoot" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">슛</div>
							<div class="col" id="user1Shoot" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0PenaltyKick" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">패널티 킥</div>
							<div class="col" id="user1PenaltyKick" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0EffectiveShoot" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">유효슛</div>
							<div class="col" id="user1EffectiveShoot" style="background-color: #F0EEED;"></div>
						</div>
						
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0PassSuccess" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">패스 성공률</div>
							<div class="col" id="user1PassSuccess" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0CornerKick" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">코너킥</div>
							<div class="col" id="user1CornerKick" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0TackleSuccess" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">태클</div>
							<div class="col" id="user1TackleSuccess" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0Foul" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">파울</div>
							<div class="col" id="user1Foul" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0YellowCards" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">경고</div>
							<div class="col" id="user1YellowCards" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0RedCards" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">퇴장</div>
							<div class="col" id="user1RedCards" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0Injury" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">부상</div>
							<div class="col" id="user1Injury" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="user0Pause" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #BCB7B6;">경기 멈춤</div>
							<div class="col" id="user1Pause" style="background-color: #F0EEED;"></div>
						</div>
						
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" style="background-color: #F0EEED;"><button id="user0Player" onclick="playerInfo()">00000000</button></div>
							<div class="col" style="background-color: #BCB7B6;">선수단 정보</div>
							<div class="col" style="background-color: #F0EEED;"><button id="user1Player" onclick="playerInfo()">11111111</button></div>
						</div>
					</main>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>
		</div>
	</div>
	
	<div class="modal fade bd-example-modal-lg" id="playerModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title">선수단 정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
						<div class="col" id="div0" style="background-color: #F0EEED;"></div>
						<div class="col" style="background-color: #BCB7B6;">구분</div>
						<div class="col" id="div1" style="background-color: #F0EEED;"></div>
					</div>
					
					<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
						<div class="col" id="test0" style="background-color: #F0EEED;"></div>
						<div class="col" style="background-color: #BCB7B6;">선수단</div>
						<div class="col" id="test1" style="background-color: #F0EEED;"></div>
					</div>
					
					<div>
						<hr class='my-4'/>
					</div>
					
					<div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="LS" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="ST" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="RS" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="LW" style="background-color: #F0EEED;">LW</div>
							<div class="col" style="background-color: #F0EEED;"></div>
							<div class="col" id="LF" style="background-color: #F0EEED;"></div>
							<div class="col" id="CF" style="background-color: #F0EEED;"></div>
							<div class="col" id="RF" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #F0EEED;"></div>
							<div class="col" id="RW" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="LAM" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="CAM" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="RAM" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" style="background-color: #F0EEED;"></div>
							<div class="col" id="LM" style="background-color: #F0EEED;"></div>
							<div class="col" id="LCM" style="background-color: #F0EEED;"></div>
							<div class="col" id="CM" style="background-color: #F0EEED;"></div>
							<div class="col" id="RCM" style="background-color: #F0EEED;"></div>
							<div class="col" id="RM" style="background-color: #F0EEED;"></div>
							<div class="col" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" id="LDM" style="background-color: #BCB7B6;"></div>
							<div class="col" id="CDM" style="background-color: #BCB7B6;"></div>
							<div class="col" id="RDM" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
							<div class="col" style="background-color: #BCB7B6;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="LWB" style="background-color: #F0EEED;"></div>
							<div class="col" id="LB" style="background-color: #F0EEED;"></div>
							<div class="col" id="LCB" style="background-color: #F0EEED;"></div>
							<div class="col" id="CB" style="background-color: #F0EEED;"></div>
							<div class="col" id="RCB" style="background-color: #F0EEED;"></div>
							<div class="col" id="RB" style="background-color: #F0EEED;"></div>
							<div class="col" id="RWB" style="background-color: #F0EEED;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="SW" style="background-color: #BCB7B6;"></div>
						</div>
						<div class="row" style="padding-top: 5px; padding-left: 20px; padding-right: 20px;">
							<div class="col" id="GK" style="background-color: #F0EEED;"></div>
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>
		</div>
	</div>
	
</body>
</html>