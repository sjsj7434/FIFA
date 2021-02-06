<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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