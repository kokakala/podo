<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp" />
	</head>
	<body>
		<!--================ Start Blog Post Area =================-->
		<div class="container">
			<div class="col-lg-12">
				<div class="main_blog_details">
					<c:if test="${ !empty board.imageName }">
						<a
							href="${ pageContext.servletContext.contextPath }/resources/boardUploadFiles/${ board.imageName }"
							download="${ board.imageName}" id="download-image"
							style="display: none;">${ board.imageName}</a>
						<div class="row">
							<img id="board-image" class="mx-auto my-5"
								src="${ pageContext.servletContext.contextPath }/resources/boardUploadFiles/${ board.imageName }"
								style="width: 400px;">
						</div>
					</c:if>
					<h4>${ board.title }</h4>
					<div class="user_details">
						<div class="float-left">
							<button type="button" class="button" data-toggle="modal" data-target="#boardReport">
							  신고하기
							</button>
						</div>
						<div class="float-right mt-sm-0 mt-3">
							<div class="media">
								<div class="media-body">
									<h5>${ board.nickName }</h5>
									<p>${ board.modifyDate }</p>
								</div>
								<div class="d-flex">
									<!-- 프로필 이미지 -->
<%-- 									<img width="42" height="42" src="resources/memberProfileImage/${ board.memberImage }" alt=""> --%>
								</div>
							</div>
						</div>
					</div>
	
					<p>${ board.content }</p>
	
	
					<div class="news_d_footer flex-column flex-sm-row">
						<!-- 
						<a class="justify-content-sm-center ml-sm-auto mt-sm-0 mt-2" href="" onclick="getCommentList(); return false;">
							<span class="align-middle mr-2">
								<i class="ti-themify-favicon"></i>댓글 보기
							</span>
						</a>
						 -->
					</div>
				</div>
	<!-- 
				<div class="navigation-area">
						<div class="row">
							<div
								class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
								<div class="thumbnail">
									<a href="#"><img class="img-fluid" src="img/blog/prev.jpg"alt=""></a>
								</div>
								<div class="arrow">
									<a href="#"><span class="lnr text-white lnr-arrow-left"></span></a>
								</div>
								<div class="detials">
									<p>이전 게시물</p>
									<a href="#"><h4>A Discount Toner</h4></a>
								</div>
							</div>
							<div
								class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
								<div class="detials">
									<p>다음 게시물</p>
									<a href="#"><h4>Cartridge Is Better</h4></a>
								</div>
								<div class="arrow">
									<a href="#"><span class="lnr text-white lnr-arrow-right"></span></a>
								</div>
								<div class="thumbnail">
									<a href="#"><img class="img-fluid" src="img/blog/next.jpg" alt=""></a>
								</div>
							</div>
						</div>
					</div>
	
	 -->
				<!-- 댓글 목록 -->
				<div class="comments-area" id="comment-area"></div>
				<div style="text-align: center;">
<!-- 					<button class="button">더보기</button> -->
				</div>
	
	
				<!-- 댓글 작성 -->
				<div class="comment-form">
					<h4>댓글 작성</h4>
					<div class="form-group">
						<input type="hidden" id="reply-parent-id" value="">
						<textarea id="comment-content" class="form-control mb-10"
							rows="5" name="message" placeholder="댓글을 입력하세요."
							onfocus="this.placeholder = ''"
							onblur="this.placeholder = '댓글을 입력하세요.'"
							data-toggle="tooltip" data-placement="top" title="내용을 입력하세요."></textarea>
					</div>
					<button class="button" id="comment-btn">작성</button>
				</div>
	
			</div>
		</div>
		<!--================ End Blog Post Area =================-->
	
	
	
		<div class="form-group row">
			<div class="btn-group btn-group-lg mx-auto" role="group" aria-label="...">
				<c:if test="${ loginUser.id eq board.memberId }">
					<a href="boardDelete.do?id=${ board.id }" class="button submit_btn">삭제하기</a>
					<a href="boardUpdateForm.do?id=${ board.id }" class="button submit_btn">수정하기</a>
				</c:if>
			</div>
		</div>
	
	
		<!-- 게시판 신고하기 모달 -->
		<div class="modal fade de_modal" id="boardReport" tabindex="-1"
				 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">게시글 신고</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="boardReportModal.do" method="post">
							<input type="hidden" name="targetId" value="${ board.id }">
							<input type="hidden" name="reportId" value="${ loginUser.id }">
							<input type="hidden" name="reportedId" value="${ board.memberId }">
	
							<div class="form-group">
								<input class="commentType" id="boardInap" type="radio" value="1" name="content">
								<label for="boardInap">부적절한내용</label>
								<input class="commentType" id="boardSpoil" type="radio" value="2"name="content">
								<label for="boardSpoil">스포일러</label>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn button">신고</button>
								<button class="btn button" data-dismiss="modal">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	
		<script>
			const loginMemberId = '${loginUser.id}';
			
			// 댓글 작성
			$(document).on("click", "#comment-btn", function(){
				var content = $("#comment-content").val();
				var boardId = ${ board.id };
				var parentId = $("#reply-parent-id").val();
				
				if (loginMemberId === '' || loginMemberId === undefined) {
					alert("로그인이 필요합니다.");
					$('#comment-content').focus();
				} else {
					insertComment(boardId, '2', content, loginMemberId, parentId);
				}
			});
			
			// bootstrap tooltip
			$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			});
			
			// go to member profile
			$(document).on("click", ".thumbnail img", function(){
				var loginUserId = '${ loginUser.id}';
				var writerUserId = $(this).closest(".user").find(".writerMemId").val();
				
				location.href="userPage.do?loginUserId=" + loginUserId + "&userId=" + writerUserId;
			});
			
			// 대댓글 작성 focus
			$(document).on("click", "#comment-reply-btn", function(){
				var pid = $(this).closest(".single-comment").find(".cid").val();
				$("#comment-content").focus();
				$("#reply-parent-id").val(pid);
			});
			
			// 댓글 삭제
			$(document).on("click", "#comment-delete-btn", function() {
				var commentId = $(this).closest('.comment-list').find('.cid').val();
				var boardId = ${ board.id };
				
				if (confirm("댓글을 삭제하시겠습니까?")) {
					// alert(loginMemberId);
					deleteComment(commentId, 2, boardId, loginMemberId);
				}
			});
			
			window.onload = function() {
				var bid = ${ board.id };
				var loginUser = '${ loginUser.id }';
				getCommentList(bid, '2', loginMemberId);
			};

		</script>
		
		<jsp:include page="../common/footer.jsp" />
	</body>
</html>