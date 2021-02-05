<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	
	<!-- google adsense -->
	<script data-ad-client="ca-pub-4183410804231720" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
	<!-- google adsense -->
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
			userSearchAjax(0);
		}
   		
		function pagination(page) {
			drawPagination(page);
			
			var id = Number(page)+Number(1);
			$("#pageButton"+id).addClass("active");
			//removeClass()
			$("#offset").val(page*10);
			var form = $("#sendForm").serialize();
			$.ajax({
				url:"announcementPagination",
				data:form,
				type:"POST",
				success:function(announcementList){
					var html = "";
					for(index in announcementList) {
						html += "<tr id='" + announcementList[index].post_id + "' onclick='announcementPostClick(" + announcementList[index].post_id + ")' style='cursor:pointer;'>";
							html += "<td>";
								html += Number(index) + Number(1) + Number($("#offset").val());
							html += "</td>";
							html += "<td>";
								html += announcementList[index].post_title;
							html += "</td>";
							html += "<td>";
								html += announcementList[index].post_write_date;
							html += "</td>";
						html += "</tr>";
					}
					
					$(userTableTbody).html(html);
				},
				error:function(exception){
					alert(exception);
				}
			});
		}
		
		function previousNextPage(offset) {
			$("#offset").val(offset);
			$("#sendForm").attr("action", "announcement");
			$("#sendForm").submit();
		}
		
		function announcementPostClick(postId) {
			$("#post_id").val(postId);
			var form = $("#sendForm").serialize();
			$.ajax({
				url:"announcementPostView",
				data:form,
				type:"POST",
				success:function(data){
					$('#modalTitle').html(data.post_title);
					$('#modalWriteDate').html('작성일 : ' + data.post_write_date);
					$('#modalContents').html(data.post_contents);
					$('#myModal').modal('show');
				},
				error:function(error){
					$('#modalTitle').html("에러가 발생했습니다");
					$('#myModal').modal('show');
				}
			});
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
		          		<li class="nav-item active" style="padding-right: 20px;">
			              	<a class="nav-link" href="announcement">공지사항</a>
			            </li>
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="playerSearch">대장시즌 찾기</a>
			            </li>
			            <li class="nav-item" style="padding-right: 20px;">
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
		    	<h1 style="font-size: 60px;">공지사항</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<form name="sendForm" id="sendForm" method="POST">
							<input type="hidden" name="offset" id="offset" value="${offset}">
							<input type="hidden" name="post_id" id="post_id" value="">

							<table class="table">
								<thead>
								    <tr>
								    	<th>번호</th>
										<th>제목</th>
										<th>작성일</th>
								    </tr>
								</thead>
								<tbody id="userTableTbody">
									<c:forEach items="${announcementList}" var="item" varStatus="status">
										<tr id="${item.post_id}" onclick="announcementPostClick(${item.post_id})" style="cursor:pointer;">
											<td>${status.count + offset}</td>
											<td>${item.post_title}</td>
											<td>${item.post_write_date}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</form>
					</div>
				</div>
				
				<nav id="paginationNav" aria-label="Page navigation example" style="padding-top: 20px;">
					<script type="text/javascript">
						drawPagination(0);
						
						function drawPagination(initValue) {
							var html = "";
							var off = $("#offset").val();
							var index = 0;
							
							html +="<ul class='pagination justify-content-center'>";
								if(${pagination < 11}){
									html +="<li class='page-item disabled'>";
										html +="<a class='page-link' aria-label='Previous'><span aria-hidden='true'>&laquo;</span>";
										html +="</a>";
									html +="</li>";
								}
								else{
									if((off-100) < 0){
										html +="<li class='page-item disabled'>";
											html +="<a class='page-link' aria-label='Previous'><span aria-hidden='true'>&laquo;</span>";
											html +="</a>";
										html +="</li>";
									}
									else{
										var backOffset = (parseInt(off/100) - 1)*100;
										html +="<li class='page-item'>";
											html +="<a class='page-link' aria-label='Previous' href='javascript:previousNextPage(" + backOffset + ")'><span aria-hidden='true'>&laquo;</span>";
											html +="</a>";
										html +="</li>";
									}
								}
								
								for(index = ${offset/10}; index < ${pagination}; index++){
									if(initValue == 0){
										if(index == ${offset/10}){
											html +="<li class='page-item active' id='pageButton" + (index+1) + "'>";
												html +="<a class='page-link' href='javascript:pagination(" + index + ")'>" + (index+1) + "</a>";
											html +="</li>";
										}
										else{
											html +="<li class='page-item' id='pageButton" + (index+1) + "'>";
												html +="<a class='page-link' href='javascript:pagination(" + index + ")'>" + (index+1) + "</a>";
											html +="</li>";
										}
									}
									else{
										if(initValue == index){
											html +="<li class='page-item active' id='pageButton" + (index+1) + "'>";
												html +="<a class='page-link' href='javascript:pagination(" + index + ")'>" + (index+1) + "</a>";
											html +="</li>";
										}
										else{
											html +="<li class='page-item' id='pageButton" + (index+1) + "'>";
												html +="<a class='page-link' href='javascript:pagination(" + index + ")'>" + (index+1) + "</a>";
											html +="</li>";
										}
									}
									
									off = (index + 1)*10;
									if(index == ${offset/10 + 9}){
										break;
									}
								}
								
								if(index == ${pagination}){
									html +="<li class='page-item disabled'>";
										html +="<a class='page-link' aria-label='Next'><span aria-hidden='true'>&raquo;</span>";
										html +="</a>";
									html +="</li>";
								}
								else{
									html +="<li class='page-item'>";
										html +="<a class='page-link' aria-label='Next' href='javascript:previousNextPage(" + off + ")'><span aria-hidden='true'>&raquo;</span>";
										html +="</a>";
									html +="</li>";
								}
							html +="</ul>";
							
							$("#paginationNav").html(html);
						}
					</script>
				</nav>
				
			</div>
		</div>
	</main>
	
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
					<h5 class="modal-title" id="modalTitle"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<p id="modalWriteDate" style="text-align: right;"></p>
					<hr>
					<p id="modalContents" style="text-align: left;"></p>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
				
			</div>
		</div>
	</div>
	
</body>
</html>