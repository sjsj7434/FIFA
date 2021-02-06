<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
		  padding: 60px 15px;
		}
	</style>
</head>
<body class="d-flex flex-column h-100">	
	<main role="main" class="flex-shrink-0">
		<div class="container">
			<div class="jumbotron">
		    	<h1 style="font-size: 60px; text-align: center;">공지사항</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<form name="sendForm" id="sendForm" method="POST">
							<input type="hidden" name="offset" id="offset" value="${offset}">
							<input type="hidden" name="post_id" id="post_id" value="">

							<table class="table">
								<colgroup>
									<col width="10%"/>
									<col width="65%"/>
									<col width="25%"/>
								</colgroup>
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