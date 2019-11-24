<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<br>
	
	<h1>게시판</h1>
	
	
	<button onclick="location.href='/download.board.do?imageId=${ b.imageId }';">다운로드</button>
	
	
	
		
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>