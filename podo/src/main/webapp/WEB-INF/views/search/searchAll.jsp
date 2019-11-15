<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			
			#search-film-result {
				border-collapse: collapse;
			}
			
			#search-film-result td,
			#search-film-result tr {
				text-align: center;
				border: 1px solid;
			}
			
		</style>
	</head>
	<body>
		<h1>영화</h1>
		<table id="search-film-result">
			<tr>
				<th colspan="2">제목</th>
				<th>감독</th>
				<th>개봉연도</th>
				<th>국가</th>
				<th>장르</th>
			</tr>
			<c:forEach items="${ list }" var="f">
				<tr>
					<td>${ f.titleKor }</td>
					<td>${ f.titleEng }</td>
					<td>${ f.director }</td>
					<td>${ f.releaseYear }</td>
					<td>${ f.productionCountry }</td>
					<td>${ f.genre }</td>
				</tr>
			</c:forEach>
		</table>
		<h1>리뷰</h1>
		<table id="search-review-result">
		
		</table>
		<h1>자유게시판</h1>
		<table id="search-board-result">
		
		</table>
	</body>
</html>