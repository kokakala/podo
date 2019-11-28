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

		<h1 align="center">${ b.id } 번 게시글 수정하기</h1>
	<br>
	
	<form action="bupdate.do" method="post" enctype="multipart/form-data">
		<table align="center">
			<input type="hidden" name="id" value="${ b.id }">
			<input type="hidden" name="originalFileName" value="${ b.originalFileName }">
			<input type="hidden" name="renameFileName" value="${ b.renameFileName }">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="${ b.title }"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" value="${ b.writer }" readonly></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="50" rows="7" name="content">${ b.content }</textarea></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<input type="file" name="reloadFile">
					<c:if test="${ !empty b.originalFileName }">
						<a href="${ pageContext.servletContext.contextPath }/resources/buploadFiles/${b.renameFileName}" download="${ b.originalFileName }">${ b.originalFileName }</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">수정하기</button> 
					<button type="button" onclick="location.href='blist.do';">목록으로</button>
				</td>
			</tr>
		</table>
	</form>


</body>
</html>