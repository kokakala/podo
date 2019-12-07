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
		margin-left: 200px;
	}
</style>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<br>
	<h1 align="center">자유게시판</h1>
	<br><br>
	<form action="binsert.do" method="post" enctype="multipart/form-data" class="boardInsertForm" id="boardInsertForm">
		<div class="form-group row">
		
		<%-- <input type="hidden" name="boardId" value="${ b.id }"> --%>
		
			<label for="" class="col-sm-2 col-form-label">제목 </label>
	    	<div class="col-sm-4">
				<input type="text" class="form-control" name="title" placeholder="제목" required>
	    	</div>
	  	</div>
	  	<input type="hidden" name="memberId" value=${ loginUser.id }>
	  	<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">작성일 </label>
	    	<div class="col-sm-4">
				<input type="text" class="form-control" name="createDate" value="${ today }" readonly>
	    	</div>
	  	</div>
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-4">
				<textarea class="form-control" name="content" cols="20" rows="7"></textarea>
			</div>
		</div>
		
		
		<!-- 파일 업로드 하는 부분 -->
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">첨부파일</label>
			<div class="col-sm-4" id="board-file-area">
				<input type="file" id="board-upload-file" name="board-upload-file">
			</div>
		</div>
		
		<br>
		
		<div class="form-group row" id="button">
			<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='blist.do';">취소</button>
			&nbsp; &nbsp; &nbsp;
			<button type="submit" class="btn btn-lg btn-primary">작성하기</button>
		</div>
	</form>
	
	
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