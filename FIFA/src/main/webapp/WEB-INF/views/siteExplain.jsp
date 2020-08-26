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