<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>포도포도</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<link rel="icon" href="<c:url value="/resources/bootstrap/img/favicon.png"/>" type="image/png">
		<link href="https://fonts.googleapis.com/css?family=Montserrat:700,900" rel="stylesheet">
		<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/error.css"/>">
	</head>
	<body>
		<div id="notfound">
			<div class="notfound">
				<div class="notfound-status">
					<h1><c:out value="${ error.ERROR_CODE }"/></h1>
					<h2>${ error.MESSAGE }</h2>
				</div>
				<a href="home.do">Homepage</a>
			</div>
		</div>
	</body>
</html>