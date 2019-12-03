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
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
	.board-detail-form, .board-detail-comment{
		margin-top: 50px;
		margin-right: 10px;
		margin-left: 350px;
		text-align: center;
	}
	
	#b-detail-btn{
		margin-left: 150px;
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
				<input type="text" class="form-control" name="title" value="${ b.title }" readonly>
	    	</div>
	  	</div>
	  	<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">작성자 </label>
	    	<div class="col-sm-5">
				<input type="text" class="form-control" name="memberId" value="${ b.nickName }" readonly>
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
				<textarea class="form-control" name="content" cols="20" rows="7" readonly>${ b.content }</textarea>
			</div>
		</div>
		
		<div class="form-group row">
			<label for="" class="col-sm-2 col-form-label">첨부파일</label>
			<c:if test="${ !empty i.originalName }">
				<a href="${ pageContext.servletContext.contextPath }/resources/boardUploadFiles/${ i.changeName }" download="${ i.originalName }">${ i.originalName }</a>
			</c:if>
			<c:if test="${ empty i.originalName }">
				<div class="col-sm-5">
					<input type="text" class="form-control" value="첨부파일이 없습니다." readonly>
	    		</div>
			</c:if>
		</div>
		<br>
		<div class="form-group row">
			<div class="col-sm-5" id="b-detail-btn">
				<c:if test="${ loginUser.id eq b.memberId }">
					<button class="btn btn-secondary btn-lg" onclick="location.href='bdelete.do?id=${ b.id }';">삭제하기</button>
					&nbsp; &nbsp;
					<button class="btn btn-lg btn-primary" onclick="location.href='bupdateView.do?id=${ b.id }';">수정하기</button>
				</c:if>
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
							<td></td>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
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
					
					console.log(data);
					$tbody = $("#commentList tbody");
					$tbody.html("");
					
					$("#commentCount").text("댓글(" + data.length + ")");
					
					if(data.length > 0){
						
						$.each(data, function(index, value){
							console.log(value);
							$tr = $("<tr width='300'></tr>");
							
							$contentTd = $("<td></td>").text(value.content);
							$writerTd = $("<td width='200'></td>").text(value.writer);
							$dateTd = $("<td></td>").text(value.createDate);
							
							$tr.append($contentTd);
							$tr.append($writerTd);
							$tr.append($dateTd);
							
							$tbody.append($tr);
							
						});
						
					}else{
						console.log('else');
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
		
		function deleteComment(id){
			if(confirm("댓글을 삭제하시겠습니까")){
				$.ajax({
					type:"post",
					url:"deleteComment.do",
					data:{"COMMENT_ID":id},
					success:function(){
						alert("댓글이 삭제되었습니다.");
					},
					error:function(){
						alert("댓글 삭제 실패");
					}
				});
			}
		}
		
	</script>
	
	
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>