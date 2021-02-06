<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		function skillExplain(index, tag) {
			$("#modalTitle").html('<strong>' + $(tag).text() + '</strong>');
			
			switch (index) {
			case 0:
				$("#modalText").html(
						"<p>자바로 구현 - 스프링 프레임워크로 BackEnd 구현</p>" +
						"<p>JavaScript & Bootstrap을 이용하여 디자인 구성</p>" +
						"<p>AWS RDS 서비스를 이용하며, MySQL을 데이터베이스로 사용함</p>" +
						"<p>AWS EC2 서비스를 이용하여 Linux 웹 서버를 사용함</p>" +
						"<p>AWS Route53 서비스를 이용하여 도메인을 연결함</p>" + 
						"<p>접속 시에 세션을 생성하여 방문자 수를 셈</p>" + 
						"<p>비동기 통신은 AJAX를 이용하였음</p>" +
						"<p>정보는 Nexon API에서 제공받음(Data based on NEXON DEVELOPERS)</p>" + 
						
						"<hr class='my-4'/>" +
						
						"<p>Implemented with JAVA - Spring Framework</p>" +
						"<p>Designed using JavaScript & Bootstrap</p>" +
						"<p>MySQL DataBase  using AWS RDS service</p>" +
						"<p>Use AWS EC2 Linux webserver</p>" +
						"<p>Create Session when people access this site and Count</p>" +
						"<p>Use AJAX for asynchronous</p>" +
						"<p>Data based on NEXON DEVELOPERS - Nexon API</p>"
					);
				break;
			case 1:
				$("#modalText").html(
						"<p>Controller에서 JsonArray의 형태로 model을 전달함</p>" +
						"<p>JavaScript를 이용해 동적으로 테이블을 생성하여 화면에 출력</p>" +
						"<p>Table Row 클릭 시 Modal을 띄워 정보를 제공</p>" +
						"<p>offset & limit을 사용하여 pagination 구현</p>" +
						"<p>pagination은 비동기 통신으로 구현</p>" +
						"<p>비동기 통신은 AJAX를 이용하였음</p>"
					);
				break;
			case 2:
				$("#modalText").html(
						"<p>띄어쓰기는 생략하며, 특수문자 입력을 방지</p>" +
						"<p>form 내용을 serialize하여 전달</p>" +
						"<p>BackEnd에서 API를 이용해 검색을 비동기 통신으로 진행하고 JsonArray으로 결과를 전달하여 동적 생성 테이블로 정보 표시</p>" +
						"<p>비동기 통신을 통해 전달 받은 정보를 GoogleChart를 이용해 Modal에 표시</p>" +
						"<p>비동기 통신은 AJAX를 이용하였음</p>"
					);
				break;
			case 3:
				$("#modalText").html(
						"<p>form 내용을 serialize하여 전달</p>" +
						"<p>글 작성을 하면 비동기 통신을 통해 데이터를 전송하여 데이터베이스에 입력</p>" +
						"<p>비동기 통신은 AJAX를 이용하였음</p>"
					);
				break;
			default:
				$("#modalText").html("ErrorOccurred");
				break;
			}
			
			$("#myModal").modal('show');
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
		<div class="container">
			<div class="jumbotron">
		    	<h1 style="font-size: 60px;">사이트 설명(Site Explain)</h1>
				<div style="margin-top:15px;" id="errorFormArea">
					<div class="bd-example">
						<div class="form-group" style="text-align: left;">
							<hr class="my-4">
							
							<p onclick="skillExplain(0, this);" style="cursor:pointer;"><strong>요약 설명(Summary)</strong></p>
							<hr class="my-4">
							<p onclick="skillExplain(1, this);" style="cursor:pointer;"><strong>공지사항(Announcement)</strong></p>
							<hr class="my-4">
							<p onclick="skillExplain(2,this);" style="cursor:pointer;"><strong>대장시즌 찾기(Player Search), 거래기록 조회(Trade history Search), 유저 전적 검색(User Match history Search)</strong></p>
							<hr class="my-4">
							<p onclick="skillExplain(3, this);" style="cursor:pointer;"><strong>오류 신고/건의사항(Error Report)</strong></p>
							
						  	<hr class="my-4">
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<div class="modal" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalTitle"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p id="modalText" align="left"></p>
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