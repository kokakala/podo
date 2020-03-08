<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
	<body>
	
		<div class="container">
			<div class="row movie-poster-cover">
				<div class="col-md-4 d-flex align-items-start flex-column bd-highlight">
					<img class="poster" src="resources/detailFilmImage/${r.posterImage }" alt="poster">
				</div>
				
				<div class="col-md-8 my-3 d-flex align-items-end flex-column">
					<h1>${ r.titleKor }</h1>
					<c:forEach begin="1" end="${ r.star }">
						&#x2605;
					</c:forEach>
					
					<span>${ r.createDate }</span>
					
					<div class="thumbnail py-3">
						<c:if test="${ loginUser.id == r.memberId }">
							<img 
								<c:if test="${ not empty r.userImage }">
									src="resources/memberProfileImage/${ r.userImage }"
									test
								</c:if>
								<c:if test="${ empty r.userImage }">
									src="resources/memberProfileImage/podoImage.png"
								</c:if>
								onclick="location.href='mypage.do?id=${ loginUser.id }'">
						</c:if>
						<c:if test="${ loginUser.id != r.memberId }">
							<img width="42" height="42"
								<c:if test="${ not empty r.userImage }">
									src="resources/memberProfileImage/${ r.userImage }"
								</c:if>
								<c:if test="${ empty r.userImage }">
									src="resources/memberProfileImage/podoImage.png"
								</c:if>
								onclick="location.href='userPage.do?userId=${r.memberId}&loginUserId=${ loginUser.id }'">
						</c:if>
					</div>
					
				</div>
				
			</div>
			
			<div class="col my-3 detail-film-info">
				<p class="py-3">${r.content }</p> 
			</div>
		</div>
		
		
		<div class="container">
			<div class="row my-2">
				<div class="btn-group mx-auto">
					<c:if test="${ not empty likeReivew }">
						<button class='button likeReviewBtn'><spring:message code="tooltip.liked"/></button>
						<input type="hidden" class="likeInp" value="1" />
					</c:if>
					<c:if test="${ empty likeReivew }">
						<button class='button likeReviewBtn'><spring:message code="tooltip.like"/></button>
						<input type="hidden" class="likeInp" value="0" />
					</c:if>
					<a class="button declaration-modal btn-reply" href="#" data-toggle="modal"><spring:message code="button.report"/></a>
					<c:if test="${loginUser.id eq r.memberId }">
						<a class="button" href="reviewUpdateForm.do?id=${r.id}"><spring:message code="button.edit"/></a>
					</c:if>
					<c:if test="${ loginUser.id eq r.memberId }">
						<button class="button" onclick="location.href='reviewDelete.do?id=${r.id}';"><spring:message code="button.delete"/></button>
					</c:if>
				</div>
	
			</div>
			
		  <!-- 댓글리스트 -->
			<div class="comments-area" id="comment-area">
				<h4>COMMENTS</h4>
			</div>
			
			<!-- 댓글 등록 -->
			<div class="comment-form">
				<h4><spring:message code="label.comment.write"/></h4>
				<div class="form-group">
					<input type="hidden" id="reply-parent-id" value="">
					<textarea id="comment-content" class="form-control mb-10" rows="5" name="message" placeholder="<spring:message code="placeholder.enter.comment"/>"
									onfocus="this.placeholder = ''" onblur="this.placeholder = '<spring:message code="placeholder.enter.comment"/>'"
									data-toggle="tooltip" data-placement="top" title="" data-original-title="<spring:message code="placeholder.enter.content"/>"></textarea>
				</div>
				<div class="mx-auto d-flex justify-content-end">
					<div class="col-auto p-0">
						<button class="button" id="review-comment-btn"><spring:message code="button.write"/></button>
					</div>
				</div>
			</div>
			
		</div>
		
		
		
		<!-- 리뷰 신고하기 모달 -->
		<div class="modal fade de_modal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						신고하기
						<form action="declarationModal.do" method="post">
							<input type="hidden" name="reportId" value="${ loginUser.id }">
							<input type="hidden" name="targetId" value="${ r.id }">
							<input type="hidden" name="reportedId" value="${ r.memberId }">
							
						<div class="eu">
							
							<p></p>
								<input id="inappropriateReport" class="reviewType" type="radio" value="1" name="content">
								<label for="inappropriateReport">부적절한내용</label>
								<input id="spoilerReport" class="reviewType" type="radio" value="2" name="content">
								<label for="spoilerReport">스포일러</label>
							<p></p>
						</div>
						<div class="modal-footer">
							<button class="button" type="submit"><spring:message code="button.report"/></button>
							<button class="button" data-dismiss="modal"><spring:message code="button.cancel"/></button>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	
	<!-- 댓글 신고하기 모달 -->
		<div class="modal fade cm_modal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<spring:message code="label.report"/>
						<form action="declarationCommentModal.do" method="post">
							<input type="hidden" name="reportId" value="${ loginUser.id }">
							<input type="hidden" name="targetId" value="${ r.id }">
							<input type="hidden" name="reportedId" value="${ r.memberId }">
						<div class="eu">
							
							<p></p>
								<input class="commentType" type="radio" value="1" name="content">부적절한내용
								<input class="commentType" type="radio" value="2" name="content">스포일러
							<p></p>
						</div>
						<div class="modal-footer">
							<button  type="submit" class="btn btn-primary"><spring:message code="button.report"/></button>
							<button  class="btn btn-primary" data-dismiss="modal"><spring:message code="button.cancel"/></button>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	
		<script>
			const loginMemberId = '${loginUser.id}';
			
			// 댓글 작성
			$("#review-comment-btn").on("click", function(){
				var reviewId = ${ r.id };
				var content = document.getElementById('comment-content').value;
				var parentCommentId = $("#reply-parent-id").val();
				
				if (content.length > 150) {
					alert("150자 이상 작성할 수 없습니다.");
					return false;
				}
				
				if (loginMemberId === '' || loginMemberId === undefined) {
					alert('로그인 후 이용바랍니다.');
					$('#comment-content').focus();
				} else {
					insertComment(reviewId, '1', content, loginMemberId, parentCommentId);
				}
				
			});
			
			// 댓글 리스트
			$(function () {
				// getReplyReviewCommentList();
				var reviewId = ${r.id};
				var loginMemberId = '${loginUser.id}';
				getCommentList(reviewId, 1, loginMemberId);
			});
			
			// 리뷰 좋아요		
			$(function() {
				//var likeReivew = $(".likeInp").val();
				//console.log("값 : " + likeReivew);
				
				$(".likeReviewBtn").on("click", function(){
					const loginMemberId = "${loginUser.id}";
					var targetId = "${ r.id }";
					var likeInp = $(".likeInp").val();
					var status = "";
					
					if (loginMemberId == '') alert('로그인 후 이용바랍니다.');
					
					if (likeInp == '0') {
						status = "like";
					} else if (likeInp == '1') {
						status = "nonlike";
					}
					
					$.ajax({
							url: "likeReviewClick.do",
							data: {
								userId : loginMemberId,
								targetId : targetId,
								status : status
							},
							type: "post",
							success: function(data) {
								
							if (status == "like") { // 좋아요
								if (data == 1) {
									$(".likeReviewBtn").removeClass("btn-danger");
									$(".likeReviewBtn").removeClass("btn-secondary");
									$(".likeReviewBtn").addClass("btn-danger");
									$(".likeReviewBtn").text('LIKED');
									$(".likeInp").val('1');
								} else {
									alert("좋아요 실패");
								}
							} else if (status == "nonlike") { // 좋아요 취소
								if (data > 0) {
									$(".likeReviewBtn").removeClass("btn-danger");
									$(".likeReviewBtn").removeClass("btn-secondary");
									$(".likeReviewBtn").addClass("btn-secondary");
									$(".likeReviewBtn").text('LIKE');
									$(".likeInp").val('0');
								} else {
									alert("좋아요 취소 실패");
								}
							}
						},
						error : function() {
							// console.log("ajax error");
						}
					});
				});
			});

			// 리뷰 신고하기 버튼 클릭 시
			$(".declaration-modal").on("click", function() {
				$(".de_modal").modal();
				//console.log("${ loginUser.id }");
			});

			// 댓글 신고하기 버튼 클릭시
			$(".comment-modal").on("click", function() {
				$(".cm_modal").modal();
				//console.log("${ loginUser.id }");
			});
			
			// 대댓글 작성 focus
			$(document).on("click", "#comment-reply-btn", function(){
				var pid = $(this).closest(".single-comment").find(".cid").val();
				$("#comment-content").focus();
				$("#reply-parent-id").val(pid);
			});

			// 댓글 삭제
			// $('#comment-delete-btn').on('click', function() {
			$(document).on('click', '#comment-delete-btn', function() {
				var commentId = $(this).closest('.comment-list').find('.cid').val();
				var reviewId = '${r.id}';

				if (confirm("댓글을 삭제하시겠습니까?")) {
					// alert(loginMemberId);
					deleteComment(commentId, 1, reviewId, loginMemberId);
				}

			});
		</script>
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>