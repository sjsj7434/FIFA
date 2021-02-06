<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>siteBottom</title>

	<style>
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
<body>
	<footer class="footer mt-auto py-3">
		<div class="container">
			<span class="text-muted">FIFA ONLINE 4 (Data based on NEXON DEVELOPERS)</span>
		</div>
		<div class="container">
			<span class="text-muted">TOTAL : ${countAllVisitors}명</span>
			<span class="text-muted"> &amp; </span>
			<span class="text-muted">TODAY : ${countTodayVisitors}명</span>
		</div>
		<div class="container">
			<a href="siteExplain"><span class="text-muted">사이트 설명(Site Explain)</span></a>		
		</div>
	</footer>
</body>
</html>