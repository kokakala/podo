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
		<form action="binsert.do" method="post" enctype="multipart/form-data">
		
	  	<input type="hidden" name="memberId" value=${ loginUser.id }>
			<%-- <input type="hidden" name="boardId" value="${ b.id }"> --%>
			
			<div class="form-group row">
				<label for="" class="col-md-4 col-form-label">제목 </label>
	    	<div class="col-md-8">
					<input type="text" class="form-control" name="title" placeholder="제목" required>
	    	</div>
	  	</div>
		  	
	  	<div class="form-group row">
				<label for="" class="col-md-4 col-form-label">작성일 </label>
	    	<div class="col-md-8">
					<input type="text" class="form-control" name="createDate" value="${ today }" readonly>
	    	</div>
	  	</div>
	  	
			<div class="form-group row">
				<label for="" class="col-md-4 col-form-label">내용</label>
				<div class="col-md-8">
					<textarea class="form-control" name="content" cols="20" rows="7"></textarea>
				</div>
			</div>
			
			
			<!-- 파일 업로드 하는 부분 -->
			<div class="form-group row">
				<label for="" class="col-md-4 col-form-label">첨부파일</label>
				<div class="col-md-8" id="board-file-area">
					<input type="file" id="board-upload-file" name="board-upload-file">
				</div>
			</div>
			
			<div class="btn-group row" id="button">
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