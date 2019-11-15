<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
	<head>
		<title>Home</title>
	</head>
	<body>
		<form method="post" action="skFilm.do">
			<input type="text" name="keyword">
			<button type="submit">검색</button>
		</form>
		<a href="film.do">영화탭</a>
	</body>
</html>
