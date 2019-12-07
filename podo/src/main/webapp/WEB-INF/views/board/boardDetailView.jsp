<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <jsp:useBean id="today" class="java.util.Date"/> --%>
<%-- <fmt:formatDate var="today" value="${ today }" pattern="yyyy-MM-dd"/> --%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			#board-image {
				cursor: pointer;
			}
			
			
		</style>
	</head>
	<body>
		
		<!--================ Start Blog Post Area =================-->
		<div class="container" id="container">
			<div class="col-lg-12" id="contain">
				<div class="main_blog_details" id="div">
					<c:if test="${ !empty board.imageName }">
						<a href="${ pageContext.servletContext.contextPath }/resources/boardUploadFiles/${ board.imageName }" download="${ board.imageName}"
							 id="download-image" style="display: none;">${ board.imageName}</a>
						<div class="row">
							<img id="board-image" class="mx-auto my-5" src="${ pageContext.servletContext.contextPath }/resources/boardUploadFiles/${ board.imageName }" style="width: 400px;">
						</div>
					</c:if>
					<a 	href="#"><h4>${ board.title }</h4></a>
					<div class="user_details">
						<div class="float-left">
							<a href="#" id=>신고하기</a>
						</div>
						<div class="float-right mt-sm-0 mt-3">
							<div class="media">
								<div class="media-body">
									<h5>${ board.nickName }</h5>
									<p>${ board.modifyDate }</p>
								</div>
								<div class="d-flex">
									<!-- 프로필 이미지 -->
									<img width="42" height="42" src="img/blog/user-img.png" alt="">
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<p>${ board.content }</p>
					</div>

					
					<div class="news_d_footer flex-column flex-sm-row">
						<a class="justify-content-sm-center ml-sm-auto mt-sm-0 mt-2" href="#">
						<span class="align-middle mr-2"><i class="ti-themify-favicon"></i></span>COMMENTS</a>
						<!-- <a href="#"><span class="align-middle mr-2"><i class="ti-heart"></i></span>LIKE</a> -->
						<!-- <div class="news_socail ml-sm-auto mt-sm-0 mt-2">
							<a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
								class="fab fa-twitter"></i></a> <a href="#"><i
								class="fab fa-dribbble"></i></a> <a href="#"><i
								class="fab fa-behance"></i></a>
						</div> -->
					</div>
				</div>

				<!-- ><div class="navigation-area">
					<div class="row">
						<div
							class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
							<div class="thumb">
								<a href="#"><img class="img-fluid" src="img/blog/prev.jpg"
									alt=""></a>
							</div>
							<div class="arrow">
								<a href="#"><span class="lnr text-white lnr-arrow-left"></span></a>
							</div>
							<div class="detials">
								<p>Prev Post</p>
								<a href="#"><h4>A Discount Toner</h4></a>
							</div>
						</div>
						<div
							class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
							<div class="detials">
								<p>Next Post</p>
								<a href="#"><h4>Cartridge Is Better</h4></a>
							</div>
							<div class="arrow">
								<a href="#"><span class="lnr text-white lnr-arrow-right"></span></a>
							</div>
							<div class="thumb">
								<a href="#"><img class="img-fluid" src="img/blog/next.jpg"
									alt=""></a>
							</div>
						</div>
					</div>
				</div>
				-->
				
				<!-- 댓글 -->
				
				<!-- 댓글 list -->
				<div class="comments-area" id="comment-area">
				<div class="news_d_footer flex-column flex-sm-row">
				<a class="justify-content-sm-center ml-sm-auto mt-sm-0 mt-3" href="#">
						<span class="align-middle mr-2"><i class="ti-themify-favicon"></i></span>COMMENTS</a>
				</div>
					
					<div class="comment-list">
						<!-- <div class="single-comment justify-content-between d-flex">
							<div class="user justify-content-between d-flex">
								<div class="thumb">
									<img src="img/blog/c1.jpg" alt="">
								</div>
								
								<div class="desc">
									<h5>
										<a href="#">작성자</a>
									</h5>
									<p class="date">작성일</p>
									<p class="comment" id="c-content">작성 내용</p>
								</div>
							</div>
							<div class="reply-btn">
								<a href="" class="btn-reply text-uppercase" id="">수정</a>
								<a href="" class="btn-reply text-uppercase" id="">삭제</a>
							</div>
						</div> -->
						
						
						<!-- 수정폼 -->
					<!-- <div class="comment-list left-padding" id="c-modify-form">
						<div class="single-comment justify-content-between d-flex">
							<div class="user justify-content-between d-flex">
								<div class="thumb">
									<img src="img/blog/c2.jpg" alt="">
								</div>
								<div class="desc">
									<h5>
										<a href="#">작성자</a>
									</h5>
									<p class="date">댓글 수정 날짜</p>
									<p class="comment">댓글 수정</p>
								</div>
							</div>
							<div class="reply-btn">
								<a href="" class="btn-reply text-uppercase">완료</a>
							</div>
						</div>
					</div> -->
					</div>
					
				</div>
				
				
				<!-- 댓글 작성 -->				
				<div class="comment-form">
					<h4>COMMENT</h4>
						<div class="form-group">
						<textarea id="c-content" class="form-control mb-10 c-content" rows="5" name="message" placeholder="댓글을 입력하세요."
						onfocus="this.placeholder = ''" onblur="this.placeholder = '댓글을 입력하세요.'" required=""></textarea>
						</div>
						<button class="button submit_btn" id="comment-btn">작성</button>
				</div>
				
			</div>
		</div>
		<!--================ End Blog Post Area =================-->
				
		
				
		<div class="form-group row">
			<div class="btn-group btn-group-lg mx-auto" role="group" aria-label="...">
				<c:if test="${ loginUser.id eq board.memberId }">
					<a class="button submit_btn" onclick="location.href='bdelete.do?id=${ board.id }';">삭제하기</a>
					<a href="#" class="button submit_btn" onclick="location.href='bupdateView.do?id=${ board.id }';">수정하기</a>
				</c:if>
			</div>
		</div>
		
		
		<!-- 게시판 신고하기 모달 -->
		<div class="modal fade de_modal" id="boardReport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">게시글 신고</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="bReportModal.do" method="post">
							<input type="hidden" name="targetId" value="${ b.id }">
							<input type="hidden" name="reportId" value="${ loginUser.id }">
							<input type="hidden" name="reportedId" value="${ b.memberId }">
							
						<div class="form-group">
							<input class="commentType" type="radio" value="1" name="content">부적절한내용
							&nbsp;
							<input class="commentType" type="radio" value="2" name="content">스포일러
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">신고보내기</button>
							<button class="btn btn-primary" data-dismiss="modal">Close</button>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		<script>
		
			// 댓글 작성
			$(function(){
				getCommentList();
				
				$("#comment-btn").on("click", function(){
					
					var content = $(".c-content").val();
					var boardId = ${board.id};
					var memberId = "${loginUser.id}";
					$.ajax({
						url:"insertComment.do",
						data:{
							content:content,
							boardId:boardId,
							memberId:memberId},
						dataType:"json",
						success:function(data){
							if(data == "success"){
								getCommentList();
								$(".c-content").val("");
							}else{
								alert("댓글 작성 실패");
							}
						},
						error:function(){
							console.log("ajax 통신 실패");
						}
					});
					
					
				})
				
			});
			
			// 댓글 리스트
			function getCommentList(){
				
				$.ajax({
					url:"commentsList.do",
					data:{id:${board.id}},
					dataType:"json",
					success:function(data){
						
						console.log(data);
						
						$commentarea = $(".comment-list");
						$commentarea.html("");
						
						if(data.length > 0){
							
								$.each(data, function(index, value){
									
									$commentarea = $(".comment-list");
									
									$commentDiv = $("<div class='commentDiv'></div>");
									
									$commentlistDiv = $("<div class='commentlistDiv'></div>");
									
									$commentcontentDiv = $("<div class='commentcontentDiv'></div>");
									
									$ninkName = $("<p class='ninkName'></p>").text(value.nickName);
									$content = $("<p class='comment'></p>").text(value.content);
									$date = $("<p class='date'>작성일</p>").text(value.createDate);
									
									$updateBtn = $("<a style='width:70px; float:right;' class='btn-reply updateBtn'>수정</a>");
									$deleteBtn = $("<a style='width:70px; float:right;' class='btn-reply deleteBtn'>삭제</a>");
									
									$modifyDiv = $("<div style='display:none;' class='modifyDiv'></div>");
									$modifyTextarea = $("<textarea class='modifyTextarea'></textarea>");
									$modifyBtn = $("<button class='modifyBtn'>등록</button>");
									$hiddenCid = $("<input type='hidden' class='hiddenCid'>").val(value.id);
									
									
									$modifyDiv.append($modifyTextarea).append($modifyBtn).append($hiddenCid);
									$commentarea.append($commentDiv).append($commentlistDiv).append($deleteBtn).append($updateBtn);
									$commentlistDiv.append($commentcontentDiv).append($modifyDiv);
									$commentcontentDiv.append($ninkName).append($content).append($date);
									
								});
								
							
						}else{	// 댓글 없을때
							$commentarea = $(".comment-list");
							$commentarea.append("<span>등록된 댓글이 없습니다.</span>");
						}
						
					},
					error:function(){
						console.log("ajax 통신 실패");
					}
				});
				
			}
			
			// 댓글 수정
			 $(document).on("click", ".updateBtn", function(){
				
				$(this).parent().children(".commentcontentDiv").toggle();
				$(this).parent().children(".modifyDiv").next().toggle();
				
			});
			
			$(document).on("click",".modifyBtn", function() {
				
		         var id = $(this).next().val();
		         
		         var content = $(this).prev().val();

		         $.ajax({
		            url:"updateComment.do",
		            data:{id:id,
		            	  content:content},
		            	  
		            success:function(data){
		               
		               if(data == "success"){
		            	   getCommentList();
		            	   alert("댓글을 수정하였습니다.");
		               }else{
		                  alert("댓글 수정 실패");
		               }
		            },
		            error:function(){
		               console.log("ajax 통신 실패");
		            }
		            
		         });
		      });
			
			
			// 댓글 삭제
		      $(document).on("click", ".deleteBtn", function(){
		         
		    	 var id = $(this).parent().children().eq(2).val();

		         if(confirm("댓글을 삭제하시겠습니까?")){
		            
		            $.ajax({
		               url:"deleteComment.do",
		               data:{id:id},
		               success:function(data){
		                  
		                  if(data == "success"){
		                	  getCommentList();
		                  }else{
		                     alert("댓글 삭제 실패");
		                  }
		               },
		               error:function(){
		                  console.log("ajax 통신 실패");
		               }
		            }); 
		         }
		      });
			
			
		      $("#board-image").on("click", function(){
					console.log("asd");
					$("#download-image").get(0).click();
				});
		</script>
		
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>