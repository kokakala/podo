<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date"/>
<fmt:formatDate var="today" value="${ today }" pattern="yyyy-MM-dd"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.boardInsertForm{
		text-align: center;
		margin-left: 500px;
	}
	#button{
		margin-left: 150px;
	}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<br>
	<h1 align="center">자유게시판</h1>
	<br><br>
	<form action="bupdate.do" method="post" enctype="multipart/form-data" class="boardInsertForm">
	
	  	<input type="hidden" name="memberId" value=${ loginUser.id }>
	  	<input type="hidden" name="id" value=${ b.id }>
		<input type="hidden" name="id" value="${ i.id }">
		<input type="hidden" name="path" value="${ i.path }">
		<input type="hidden" name="originalName" value="${ i.originalName }">
		<input type="hidden" name="changeName" value="${ i.changeName }">
		<!-- <input type="hidden" name="type" value="${ i.type }"> -->
		<input type="hidden" name="boardId" value="${ b.id }">
		
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">제목 </label>
	    	<div class="col-sm-4">
				<input type="text" class="form-control" name="title" value="${ b.title }" required>
	    	</div>
	  	</div>
	  	<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">작성일 </label>
	    	<div class="col-sm-4">
				<input type="text" class="form-control" name="createDate" value="${ today }" readonly>
	    	</div>
	  	</div>
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-4">
				<textarea class="form-control" name="content" cols="20" rows="7">${ b.content }</textarea>
			</div>
		</div>
		
		<!-- 파일 -->
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">첨부파일</label>
			<input type="file" name="board-upload-file">
			<c:if test="${ !empty i.originalName }">
				<a href="${ pageContext.servletContext.contextPath }/resources/buploadFiles/${ i.changeName }" download="${ i.originalName }">${ i.originalName }</a>
			</c:if>
		</div>
		
		<br>
		
		<div class="form-group row" id="button">
			<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='blist.do';">취소</button>
			&nbsp; &nbsp; &nbsp;
			<button type="submit" class="btn btn-lg btn-primary">수정완료</button>
		</div>
	</form>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>