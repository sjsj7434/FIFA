<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {'packages':['corechart', 'bar']});
	</script>
    <script type="text/javascript">
	    function imageError(data) {
			$(data)[0].src = "resources/image/error.png";
		}
	    
		function graphAjaxButton() {			
			var queryString = $("form[name=sendForm]").serialize();
	
			$.ajax({
		        url:"graphAjax",
		        type:'GET',
		        data: queryString,
		        success:function(data){
		        	if(data[0] == '선수선택'){
		        		alert('선수를 선택해주세요');
		        	}
		        	else if(data[0] == '비정상호출'){
		        		alert('정보가 없거나, 비정상적인 호출입니다');
		        	}
		        	else{
		        		let arrayForData = [
		        			['선수이름', '블록(개)', '태클(개)', '패스성공률(%)', '슛(개)', '유효슛(개)', '골(개)', '어시스트(개)']
		        		];
		        		for(var index = 0; index < data.length; index++){
		        			arrayForData.push(
		        				[
		        					data[index].playerName + ' ' + data[index].playerClassname.split('(')[0] + '(' + data[index].status.matchCount + '경기 뜀)',
		        					data[index].status.block,
		        					data[index].status.tackle,
		        					data[index].status.passSuccess/data[index].status.passTry,
		        					data[index].status.shoot,
		        					data[index].status.effectiveShoot,
		        					data[index].status.goal,
		        					data[index].status.assist
		        				]
		        			);
		        		};
		        		
		        		var chartData = google.visualization.arrayToDataTable(arrayForData);
	
						var options = {
							bars : 'horizontal',
							height : data.length * 200,
							chart: {
						    	title: '20경기 선수 통계',
						    	subtitle: 'TOP 10000'
						  	},
						  	crosshair: { trigger: 'both' },   // Display crosshairs.
						    tooltip: { trigger: 'selection' } // Display tooltips on selection.
						};
						var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
						
						chart.draw(chartData, options);
						
						window.addEventListener('resize', function() { chart.draw(chartData, options); }, false); //화면 크기에 따라 그래프 크기 변경
						$("#myModal").modal('show');
						setTimeout(() => {
							window.dispatchEvent(new Event('resize'));
						}, 150);
					}
				},
				error : function(request, status, error) {
					if (request.status == 500) {
						alert("응답코드:" + request.status + "\n내용:" + "넥슨 서버 내부 에러");
					}
					else {
						alert("응답코드:" + request.status + "\n내용:" + "에러가 발생했습니다")
					}
				}
			});
		}
		
		function resizeGraph() {
			window.dispatchEvent(new Event('resize'));
		}
		
		function searchPlayer() {
			document.getElementById("loading").innerHTML = "정보를 불러오고 있습니다...";
			$("#playerTableTbody").empty();
			
			var RegExp = /[ \{\}\[\]\/?,;:|\)*~`!^\_+┼<>@\#$%&\'\"\\\(\=]/gi;
			var playerName = document.getElementById('playerName').value.replace(/ /gi, '');;

			if (playerName == '') {
				alert('검색할 선수 이름을 입력해주세요');
				document.getElementById("loading").innerHTML = "검색할 선수 이름을 입력해주세요";
			} 
			else {
				if (RegExp.test(playerName)) {
					alert('특수문자는 입력할 수 없습니다');
					document.getElementById("loading").innerHTML = "특수문자는 입력할 수 없습니다";
				}
				else {
					$.ajax({
						url : "searchPlayer",
						type : 'POST',
						data : {
							playerName : document.getElementById("playerName").value,
							searchWhere : window.location.pathname,
							userIp : ip()//jsgetip.appspot.com, siteTop에서 로딩
						},
						success : function(data) {
							if(data[0].length === 0){
								document.getElementById("loading").innerHTML = "정보가 없거나, 비정상적인 호출입니다";
							}
							else{
								var bucket = 0;
								var html = '';
								for (var index = 0; index < data[0].length; index++) {
									html += '<tr id="'+ data[0][index].id +'">';
									html += '<td style="text-align: center; display: none;">' + (index + 1) + '</td>';
									html += '<td style="text-align: left;"><img src="'+data[0][index].seasonimg+'" alt="시즌 이미지" />' + data[0][index].name + '</td>';
									html += '<td style="text-align: left;">' + data[0][index].id + '</td>';

									if ($("#selectedPlayerTableTbody").children().length == 0) {
										html += '<td style="display: block; text-align: left;"><button type="button" class="btn btn-success" onclick="playerAdd(this)">추가</button></td>';
										html += '<td style="display: none; text-align: left;"><button type="button" class="btn btn-outline-success" disabled>추가</button></td>';
									} else if ($("#selectedPlayerTableTbody").children().length > 0) {
										for (var i = 0; i < $("#selectedPlayerTableTbody").children().length; i++) {
											if ($('#selectedPlayerTableTbody tr:eq(' + i + ')>td:eq(3)') .text() == (data[0][index].id)) {
												html += '<td style="display: none; text-align: left;"><button type="button" class="btn btn-success" onclick="playerAdd(this)">추가</button></td>';
												html += '<td style="display: block; text-align: left;"><button type="button" class="btn btn-outline-success" disabled>추가</button></td>';
												bucket++;
												break;
											}
										}
										if (bucket == 0) {
											html += '<td style="display: block; text-align: left;"><button type="button" class="btn btn-success" onclick="playerAdd(this)">추가</button></td>';
											html += '<td style="display: none; text-align: left;"><button type="button" class="btn btn-outline-success" disabled>추가</button></td>';
										} else {
											bucket = 0;
										}
									}
									html += '<td style="display: none;">' + data[0][index].seasonimg + '</td>';
									/*  html += '<td style="text-align: center;"><img src="'+data[0][index].playerActionShotImage+'" onerror="imageError(this)" alt="선수 이미지" /></td>'; */
									html += '</tr>';
								}
								$("#playerTableTbody").empty();
								$("#playerTableTbody").append(html);
								
								document.getElementById("loading").innerHTML = "";	
							}
						},
						error : function(request, status, error) {
							if (request.status == 500) {
								document.getElementById("loading").innerHTML = "응답코드:" + request.status + "\n내용:" + "넥슨 서버 내부 에러";
							} else {
								document.getElementById("loading").innerHTML = "응답코드:" + request.status + "\n내용:" + "에러가 발생했습니다";
							}
						}
					});
				}
			}
		}

		function playerAdd(data) {
			var tr = $(data).parent().parent();
			var td = tr.children();

			if (td.eq(3).css('display') == 'block') {
				td.eq(3).css('display', 'none');
				td.eq(4).css('display', 'block');
				var length = $("#selectedPlayerTableTbody")
						.children().length
				var html = '';
				html += '<tr>';
				html += '<td style="text-align: left;"><img src="'
						+ td.eq(5).text() + '" alt="시즌 이미지" />'
						+ td.eq(1).text() + '</td>';
				html += '<td style="text-align: left;">'
						+ td.eq(2).text() + '</td>';
				html += '<td style="text-align: left;"><button type="button" class="btn btn-danger" onclick="selectedPlayerTableDelete(this)">삭제</button></td>';
				html += '<td style="display: none;">'
						+ tr.attr('id') + '</td>';
				html += '<td style="display: none;"><input type="hidden" name="players" value="'
						+ td.eq(2).text() + '"/></td>';
				html += '</tr>';
				$("#selectedPlayerTableTbody").append(html);

				$("#numberOfPlayers").empty();
				$("#numberOfPlayers").append(
						"조회할 선수 : " + (length + 1) + "명");
			}
		}

		function selectedPlayerTableDelete(data) {
			var tr = $(data).parent().parent();
			var td = tr.children();
			var length = $("#selectedPlayerTableTbody").children().length

			tr.remove();

			$("#" + td.eq(3).text()).children().eq(3).css(
					'display', 'block');
			$("#" + td.eq(3).text()).children().eq(4).css(
					'display', 'none');

			$("#numberOfPlayers").empty();
			$("#numberOfPlayers").append("조회할 선수 : " + (length - 1) + "명");
		}

		function selectedPlayerTableClean() {
			if (confirm("정말 비우시겠습니까?")) {
				var tr = $("#selectedPlayerTableTbody").children();
				var td = tr.children();
				var length = $("#selectedPlayerTableTbody").children().length;
				
				for (var i = 0; i < length; i++) {
					var deletedRow = tr.eq(i).children().eq(3).text();
					$("#" + deletedRow).children().eq(3).css('display', 'block');
					$("#" + deletedRow).children().eq(4).css('display', 'none');
				}
				
				$("#selectedPlayerTableTbody").empty();
				$("#numberOfPlayers").empty();
				$("#numberOfPlayers").append("조회할 선수 : " + 0 + "명");
			}
		}

		function enterPress() {
			searchPlayer();
		}
	</script>
	
	<style>
		main > .container {
		  padding: 60px 15px;
		}
	</style>
</head>
<body class="d-flex flex-column h-100" style="text-align: center;">
	<main role="main" class=""><!-- flex-shrink-0 -->
		<div class="container">
			<div class="container"><!--  -->
				<div class="jumbotron">
			    	<h1 style="font-size: 60px;">대장시즌 찾기</h1>
					<div style="margin-top:15px;" id="errorFormArea">
						<div class="form-group" style="text-align: left;">
							<div class="form-group" style="text-align: left;">
								<hr class="my-4">
								<p class="lead"><strong>사용법</strong></p>
								<p><strong>TOP 10,000 랭커</strong>의 특정 선수 데이터를 조회할 수 있습니다 (최근 20경기)</p>
								<p><strong>선수 이름</strong>을 입력하여 검색하면 오른쪽 하단에 선수 목록이 뜨게 됩니다</p>
								<p>오른쪽 하단에 선수 목록에서 <strong>"추가"</strong> 버튼을 누르게 되면 왼쪽 하단 목록에 조회할 선수로 등록 됩니다</p>
								<p><strong>공식, 감독 경기와 포지션</strong>을 선택하여 선수 데이터를 조회할 수 있습니다</p>
								<p>데이터 조회는 <strong>"그래프 생성"</strong> 버튼을 누르면 왼쪽 하단에 세로 형태의 그래프가 생성됩니다</p>
								<p>왼쪽 하단에 선수를 등록시키고, 다른 선수를 검색하여 더 추가할 수 있습니다 <strong>(예- 메시 추가 후, 호날두 추가 가능)</strong></p>
								<p style="color: red;"><strong>그래프의 패스 성공률은 1.0 이 100% 입니다, 모든 선수의 데이터가 20경기는 아닙니다</strong></p>
							  	<hr class="my-4">
							</div>
						</div>
						<div class="bd-example">
							<form name="sendForm" id="sendForm" method="POST" onsubmit="return false">
								<input type="hidden" name="post_writer" id="post_writer">
								<div class="form-group" style="text-align: left;">
									<label for="exampleFormControlInput1">선수 이름</label>
									<div class="input-group mb-3">
									  <input type="text" class="form-control" name="playerName" id="playerName" placeholder="선수 이름을 입력하세요" value="" maxlength="50" onkeypress="if(event.keyCode == 13){enterPress();}" aria-label="Recipient's username" aria-describedby="basic-addon2">
									  	<div class="input-group-append">
									    	<button class="btn btn-outline-secondary" type="button" onclick="searchPlayer()">검색</button>
										</div>
									</div>
								</div>
								<div class="form-row">
								    <div class="form-group col-sm-2">
								      <label for="matchType">경기 구분</label>
								      <select id="matchType" name="matchType" class="form-control">
											<option value="50">공식경기</option>
											<option value="52">감독모드</option>
										</select>
								    </div>
								    <div class="form-group col-sm-2">
								      <label for="position">선수 포지션</label>
								      <select id="position" name="position" class="form-control">
										<option value="0">GK</option>
										
										<option value="1">SW</option>
										<option value="2">RWB</option>
										<option value="3">RB</option>
										<option value="4">RCB</option>
										<option value="5">CB</option>
										<option value="6">LCB</option>
										<option value="7">LB</option>
										<option value="8">LWB</option>
										
										<option value="9">RDM</option>
										<option value="10">CDM</option>
										<option value="11">LDM</option>
										<option value="12">RM</option>
										<option value="13">RCM</option>
										<option value="14">CM</option>
										<option value="15">LCM</option>
										<option value="16">LM</option>
										<option value="17">RAM</option>
										<option value="18">CAM</option>
										<option value="19">LAM</option>
										
										<option value="20">RF</option>
										<option value="21">CF</option>
										<option value="22">LF</option>
										<option value="23">RW</option>
										<option value="24">RS</option>
										<option value="25">ST</option>
										<option value="26">LS</option>
										<option value="27">LW</option>
										
										<option value="28">SUB</option>
									</select>
								    </div>
								    <div class="form-group col-sm-2">
								      <label for="graphButton">데이터 조회</label>
								      <button type="button" class="btn btn-primary" name="graphButton" onclick="graphAjaxButton()">그래프 생성</button>
								    </div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="loading" class="col align-self-center" style="font-size: 20px;"></div>

		<form name="sendForm" onsubmit="return false">
			<div class="row" style="width:48%; padding-left: 150px;">
				<div class="col">
					<button type="button" style="width: 100%" class="btn btn-danger" onclick="selectedPlayerTableClean(this)">목록 비우기</button>
				</div>
				<div class="col">
				</div>
				<div class="col">
				</div>
			</div>
			<div style="width:48%; float:left; padding-left: 150px;">
				<table class="table table-sm table-striped">
					<caption id="numberOfPlayers" style="font-size: large; font-weight: bold; caption-side: top;">조회할 선수 : 0명</caption>
					<thead>
						<tr>
							<th valign="middle">이름</th>
							<th valign="middle">고유 번호</th>
							<th valign="middle">삭제</th>
						</tr>
					</thead>
					<tbody id="selectedPlayerTableTbody">
					</tbody>
				</table>
			</div>
			
			<div style="width:48%; float:right; padding-right: 150px;">
				<table id="playerTable" class="table table-sm table-striped">
					<caption style="font-size: large; font-weight: bold; caption-side: top;">검색 결과</caption>
					<thead>
						<tr>
							<th>이름</th>
							<th>고유 번호</th>
							<th>추가</th>
						</tr>
					</thead>
					<tbody id="playerTableTbody">
					</tbody>
				</table>
			</div>
		</form>
	</main>

	<div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">그래프</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<p>그래프에 표시되지 않는 선수는 데이터가 없는 경우입니다</p>
					<p>그래프가 잘린다면 <strong>"그래프 조정"</strong> 버튼을 눌러주세요</p>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="resizeGraph()">그래프 조정</button>
				</div>
				
				<div class="modal-body">
					<div id="columnchart_material"></div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="resizeGraph()">그래프 조정</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
