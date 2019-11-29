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
	
	<h3 align="center">
		총 게시글 개수 : ${ pi.listCount } 페이지 : ${ pi.currentPage } / ${ pi.maxPage }
		<button onclick="location.href='binsertForm.do';">작성하기</button>
	</h3>
	
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
					<a href="bdetail.do?id=${ b.id }">${ b.title }</a>					
				</td>
				<td>${ b.nickName }</td>
				<td>${ b.createDate }</td>
				<td>${ b.viewCount }</td>
			</tr>
		</c:forEach>
		
		
		<!-- 페이징 처리 -->
		
		<tr align="center" >
			<td colspan="6">
				<!-- [이전] -->
				<c:if test="${ pi.currentPage eq 1 }">
					[이전]
				</c:if>
				<c:if test="${ pi.currentPage ne 1 }">
					<c:url value="blist.do" var="before">
						<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
					</c:url>
					<a href="${ before }">[이전]</a>
				</c:if>
				
				<!-- [페이지] -->
				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					<c:if test="${ p eq pi.currentPage }">
						<font color="blueviolet" size="4">[${ p }]</font>
					</c:if>
					<c:if test="${ p ne pi.currentPage }">
						<c:url value="blist.do" var="page">
							<c:param name="currentPage" value="${ p }"/>
						</c:url>
						<a href="${ page }"> ${ p } </a>
					</c:if>
				</c:forEach>
				
				<!-- [다음] -->
				<c:if test="${ pi.currentPage eq pi.maxPage }">
					[다음]
				</c:if>
				<c:if test="${ pi.currentPage ne pi.maxPage }">
					<c:url value="blist.do" var="after">
						<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
					</c:url>
					<a href="${ after }"> [다음] </a>
				</c:if>
			</td>
		</tr>
	</table>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>