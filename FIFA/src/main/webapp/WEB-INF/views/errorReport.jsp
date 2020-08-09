<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<meta charset="utf-8">
	<title>오류 신고</title>
	<link rel="shortcut icon" type="image/x-icon" href="resources/image/F4.png">
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/js/bootstrap.min.js" integrity="sha384-XEerZL0cuoUbHE4nZReLT7nx9gQrQreJekYhJD9WNWhH8nEW+0c5qq7aIo2Wl30J" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/css/bootstrap.min.css" integrity="sha384-VCmXjywReHh4PwowAiWNagnWcLhlEJLA5buUprzK8rxFgeH0kww/aWY76TfkUoSX" crossorigin="anonymous">
	
	<script type="text/javascript" src="http://jsgetip.appspot.com/?getip"></script>
    <script type="text/javascript">
   		function numberFormat(inputNumber) {
    	   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    	}
   		
   		function imageError(data) {
			$(data)[0].src = "resources/image/error.png";
		}
   		
   		function postWrite() {
   			var post_title = document.getElementById("post_title").value;
   			var post_contents = document.getElementById("post_contents").value;
   			var post_writer = document.getElementById("post_writer");
   			var IP = getip();
   			post_writer.value = IP;
   			
   			if(post_title == ''){
   				$('#myModal').modal('show');
   				return;
   			}
   			if(post_contents == ''){
   				$('#myModal').modal('show');
   				return;
   			}

   			var formData = $("#sendForm").serialize();
   			$.ajax({
   				url:"errorReportWrite",
   				type:"POST",
   				data:formData,
   				success:function(data){
   					var html = "<h2 style='margin-top:15px; margin-bottom:15px;'>의견 감사합니다.</h2>";
   		   			var area = $("#errorFormArea");
   		   			area.empty();
   		   			area.append(html);
   				},
   				error:function(errorThrown){
   					var html = "<h2 style='margin-top:15px; margin-bottom:15px;'>제출 실패하였습니다.</h2>";
   		   			var area = $("#errorFormArea");
   		   			area.empty();
   		   			area.append(html);
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
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="userTradeSearch">거래기록 조회</a>
			            </li>
			            <li class="nav-item" style="padding-right: 20px;">
			              	<a class="nav-link" href="userMatchSearch">유저 전적 검색</a>
			            </li>
			            <li class="nav-item active" style="padding-right: 20px;">
			              	<a class="nav-link" href="errorReport">오류 신고/건의사항</a>
			            </li>
		          	</ul>
		        </div>
	      	</div>
		</nav>
	</header>
	
	<main role="main" class=""><!-- flex-shrink-0 -->
		<div class="container"><!--  -->
			<div class="jumbotron">
		    	<h1 style="font-size: 60px;">오류 신고/건의사항</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<grammarly-extension style="position: absolute; top: -3.1875px; left: -3.1875px; pointer-events: none;" class="_1KJtL"></grammarly-extension>
						<form name="sendForm" id="sendForm" method="POST" onsubmit="return false">
							<input type="hidden" name="post_writer" id="post_writer">
							<div class="form-group" style="text-align: left;">
								<label for="exampleFormControlInput1">제목</label>
								<input type="text" class="form-control" id="post_title" name="post_title" placeholder="제목을 입력해주세요" maxlength="100">
							</div>
							<div class="form-group" style="text-align: left;">
								<label for="exampleFormControlTextarea1">내용</label>
								<textarea class="form-control" name="post_contents" id="post_contents" rows="5" spellcheck="false" placeholder="내용을 입력해주세요" maxlength="1000"></textarea>
							</div>
						</form>
					</div>
					<a class="btn btn-lg btn-primary" href="javascript:postWrite();" role="button">제출하기</a>
				</div>
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