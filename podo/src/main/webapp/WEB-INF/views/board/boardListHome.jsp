<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table{
		background: lightgray;
		text-align: center;
	}
	table <a{
		text-decoration: none;
		color: black;
	}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<div class="blist-header">
		<h1 align="center" style="color: blueviolet;">자유게시판</h1>
	</div>
	
	<br>
	<br>
	
	<table align="center" cellspacing="0" width="800">
		<tr>
			<th>No.</th>
			<th width="300">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${ list }" var="b">
			<tr>
				<td>${ b.id }</td>
				<td>
						<a href="#">${ b.title }</a>

				</td>
				<td>${ b.memberId }</td>
				<td>${ b.createDate }</td>
				<td>${ b.viewCount }</td>
			</tr>
		</c:forEach>
		
		
	</table>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>