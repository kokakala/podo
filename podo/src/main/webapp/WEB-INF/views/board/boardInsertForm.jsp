<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date"/>
<fmt:formatDate var="today" value="${ today }" pattern="yyyy-MM-dd"/>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
	<body>
		<div class="container">
<!-- 			<form action="binsert.do" method="post" enctype="multipart/form-data"> -->
			<form action="binsert.do" method="post">
				
		  	<input type="hidden" name="memberId" value=${ loginUser.id }>
				
				<div class="comment-form">
					<div class="form-group row">
						<label for="" class="col-md-4 col-form-label">제목 </label>
			    	<div class="col-md-8">
							<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요." required>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group row">
						<label for="" class="col-md-4 col-form-label">작성일 </label>
			    	<div class="col-md-8">
							<input type="text" class="form-control" name="createDate" value="${ today }" readonly>
			    	</div>
			  	</div>
				</div>
			  	
		  	
		  	<div class="comment-form">
					<div class="form-group row">
						<label for="" class="col-md-4 col-form-label">내용</label>
						<div class="col-md-8">
							<textarea class="form-control" name="content" placeholder="내용을 입력해주세요."></textarea>
						</div>
					</div>
		  	</div>
				
				<div class="form-group row">
					<label for="" class="col-md-4 col-form-label">첨부파일</label>
					<div class="col-md-8" id="board-file-area">
						<input type="file" id="board-upload-file" name="board-upload-file">
					</div>
				</div>
				 
				<div class="btn-group d-flex justify-content-end" id="button">
					<button type="button" class="btn button" onclick="location.href='blist.do';">취소</button>
					<button type="submit" class="btn button">작성하기</button>
				</div>
				
			</form>
		</div>
		
		
		<div id="summernote">
		</div>
		
		
	    <script>
	      $('#summernote').summernote({
	        placeholder: 'Hello stand alone ui',
	        tabsize: 2,
	        height: 100
	      });
	    </script>
		
		<jsp:include page="../common/footer.jsp"/>
		
	</body>
</html>