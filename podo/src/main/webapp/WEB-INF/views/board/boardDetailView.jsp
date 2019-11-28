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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
	.board-detail-form, .board-detail-comment{
		margin-top: 50px;
		margin-right: 10px;
		margin-left: 400px;
		text-align: center;
	}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<br>
	
	<h1 align="center">게시판</h1>
	
	<br>
	
	<div class="board-detail-form">
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">제목 </label>
	    	<div class="col-sm-5">
				<input type="text" class="form-control" name="title" value="${ b.title }" required>
	    	</div>
	  	</div>
	  	<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">작성자 </label>
	    	<div class="col-sm-5">
				<input type="text" class="form-control" name="memberId" value="${ loginUser.id }" readonly>
	    	</div>
	  	</div>
	  	<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">작성일 </label>
	    	<div class="col-sm-5">
				<input type="text" class="form-control" name="createDate" value="${ today }" readonly>
	    	</div>
	  	</div>
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-5">
				<textarea class="form-control" name="content" cols="20" rows="7">${ b.content }</textarea>
			</div>
		</div>
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">첨부파일</label>
			<div class="col-sm-5" id="board-file-area">
				<input type="file" id="board-upload-file" name="board-upload-file">
			</div>
		</div>
		<br>
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-5" id="">
				<button>취소</button>
				&nbsp; &nbsp;
				<button>등록</button>
			</div>
		</div>
	</div>
	
	<br><br>
	<hr>

	<!-- 댓글 -->
	<div class="board-detail-comment">
	
		<!-- 목록 -->
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-5">
				<table align="center" id="commentList">
					<thead>
						<tr>
							<td colspan="3"><b id="commentCount"></b></td>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		
		<br>
		
		<!-- 댓글 입력 -->		
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">댓글</label>
			<div class="col-sm-5">
				<table align="center">
					<tr>
						<td><textarea cols="55" rows="5" id="c-content"></textarea></td>
						<td><button id="commentBtn">등록</button></td>
					</tr>
				</table>
			</div>
		</div>
	
	</div>


	<script>
		$(function(){
			getCommentList();
			
			setInterval(function(){
				getCommentList();
			}, 60000);
			
			
			$("#commentBtn").on("click", function(){
				
				var content = $("#c-content").val();
				var boardId = ${b.id};
				var writer = "${loginUser.id}";
				
				$.ajax({
					url:"commentInsert.do",
					data:{content:content,
						  boardId:boardId,
						  writer:writer
					},
					success:function(data){
						if(data == "success"){
							console.log(data);
							getCommentList();
							$("#c-content").val("");
						}else{
							alert("댓글 작성 실패");
						}
					},error:function(){
						console.log("ajax 통신 실패");
					}
				});
			});			
		});
		
		
		function getCommentList(){
			$.ajax({
				url:"commentList.do",
				data:{id:${b.id}},
				dataType:"json",
				success:function(data){
					$tbody = $("#commentList tbody");
					$tbody.html("");
					
					$("#commentCount").text("댓글(" + data.length + ")");
					
					if(data.length > 0){
						$.each(data, function(index, value){
							$tr = $("<tr></tr>");
							
							$writerTd = $("<td width='200'></td>").text(value.writer);
							$contentTd = $("<td></td>").text(value.content);
							$dateTd = $("<td></td>").text(value.createDate);
							
							$tr.append($writerTd);
							$tr.append($contentTd);
							$tr.append($dateTd);
							
							$tbody.append($tr);
							
						});
						
					}else{
						
						$tr = $("<tr></tr>");
						
						$contentTd = $("<td colspan='3'></td>").text("등록된 댓글이 없습니다.");
						$tr.append($contentTd);
						
						$tbody.append($tr);
						
					}
					
				},
				error:function(){
					console.log("ajax 통신 실패");
				}
			})
		}
	</script>
	
	
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>