<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
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
	
	<!-- google adsense -->
	<script data-ad-client="ca-pub-4183410804231720" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
	<!-- google adsense -->
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/js/bootstrap.min.js" integrity="sha384-XEerZL0cuoUbHE4nZReLT7nx9gQrQreJekYhJD9WNWhH8nEW+0c5qq7aIo2Wl30J" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.1/css/bootstrap.min.css" integrity="sha384-VCmXjywReHh4PwowAiWNagnWcLhlEJLA5buUprzK8rxFgeH0kww/aWY76TfkUoSX" crossorigin="anonymous">
	
	<meta name="description" content="피파온라인4 유저 전적 검색, 선수 정보 비교, 유저 거래기록 조회">
	<link rel="shortcut icon" type="image/x-icon" href="resources/image/F4.png">
	<meta charset="UTF-8">
	<title>피파 거시기</title>
</head>
<body>
	<div id="content">
		<tiles:insertAttribute name="content"/>
	</div>
</body>
</html>