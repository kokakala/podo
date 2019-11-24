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
	
	
		<h1 align="center">상세보기</h1>
	<br>
	
	<table align="center">
		<tr>
			<td colspan="2" align="center">${ f.id }번 글 상세보기</td>
		</tr>
		<tr>
			<td>제목(국문)</td>
			<td>${ f.titleKor }</td>		
		<tr>
		<tr>
			<td>제목(영문)</td>
			<td>${ f.titleEng }</td>		
		<tr>
		<tr>
			<td>감독</td>
			<td>${ f.director }</td>		
		<tr>
		<tr>
			<td>제작년도</td>
			<td>${ f.releaseYear }</td>		
		<tr>
		<tr>
			<td>제작국가</td>
			<td>${ f.productionCountry }</td>		
		<tr>
		<tr>
			<td>개봉상태</td>
			<td>${ f.productionStatus }</td>		
		<tr>
		<tr>
			<td>장르</td>
			<td>${ f.genre }</td>		
		<tr>
		
		
		
			<td colspan="2" align="center">
					<a href="fupdateView.do?id=${ f.id }">수정하기</a>
					<a href="fdelete.do?id=${ f.id }">삭제하기</a>
			</td>
		</tr>
	</table>
	<jsp:include page="../common/footer.jsp"/>
	
</body>
</html>