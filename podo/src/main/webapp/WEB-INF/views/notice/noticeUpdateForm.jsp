<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<title>게시글 수정하기</title>
	</head>
<body>
	
	<div class="container">
		<form action="nupdate.do" method="post" enctype="multipart/form-data" class="noticeInsertForm">
		
	  	<input type="hidden" name="id" value=${ notice.id }>
	  	<input type="hidden" name="adminId" value=${ loginUser.id }>
		<input type="hidden" name="imageName" value="${ notice.imageName }">
			
			<div class="form-group row">
				<label for="" class="col-3 col-form-label">제목</label>
		    	<div class="col-9">
					<input type="text" class="form-control" name="title" value="${ notice.title }" required>
		    	</div>
		  	</div>
		  	<div class="form-group row">
				<label for="" class="col-3 col-form-label">최종수정일</label>
		    	<div class="col-9">
					<input type="text" class="form-control" name="createDate" value="${ notice.modifyDate }" readonly>
		    	</div>
		  	</div>
			<div class="form-group row">
				<label for="" class="col-3 col-form-label">내용</label>
				<div class="col-9">
					<textarea class="form-control" name="content" cols="20" rows="7">${ notice.content }</textarea>
				</div>
			</div>
			
			<!-- 파일 -->
			<div class="form-group row">
				<label for="" class="col-sm-2 col-form-label">첨부파일</label>
				<input type="file" name="notice-upload-file">
				<c:if test="${ !empty notice.imageName }">
					<a href="${ pageContext.servletContext.contextPath }/resources/nuploadFiles/${ notice.imageName }" download="${ notice.imageName }">${ notice.imageName }</a>
				</c:if>
			</div>
			
			<br>
			
			<div class="form-group row" id="button">
				<div class="btn-group mx-auto">
					<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='blist.do';">취소</button>
					<button type="submit" class="btn btn-lg btn-primary">수정완료</button>
				</div>
			</div>
		</form>
	</div>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>