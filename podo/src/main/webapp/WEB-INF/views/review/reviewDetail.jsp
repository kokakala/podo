<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<title>리뷰 상세 보기</title>
	</head>
	<body>
	
		<div class="container">
			<div class="row">
				<div class="col-lg-2">
					<img class="img-fluid" src="resources/detailFilmImage/${r.posterImage }" alt="poster">
				</div>
				
				<div class="col-lg-4">
					<canvas id="myChart"></canvas>
				</div>
				
				<div class="col-lg-6">
					<h1>${ r.titleKor }</h1>
					<c:forEach begin="1" end="${ r.star }">
						&#x2605;
					</c:forEach>
					
					<div class="review-user-profile">
						<c:if test="${ loginUser.id != r.memberId }">
							<a href="userPage.do?userId=${r.memberId}&loginUserId=${ loginUser.id }">
								<span>${r.nickName }</span>
							</a>
						</c:if>
						<c:if test="${ loginUser.id == r.memberId }">
							<a href="myPage.do?id=${ loginUser.id }"><h5>${r.nickName }님</h5></a>
						</c:if>
						<span>${ r.createDate }</span>
					</div>
				
					<div class="thumbnail py-3">
						<c:if test="${ loginUser.id == r.memberId }">
							<img width="42" height="42"
								<c:if test="${ not empty r.userImage }">
									src="resources/memberProfileImage/${ r.userImage }"
								</c:if>
								<c:if test="${ empty r.userImage }">
									src="resources/memberProfileImage/podoImage.png"
								</c:if>
								onclick="location.href='myPage.do?id=${ loginUser.id }'">
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
			
			<div class="col detail-film-info">
				<p class="py-3">${r.content }</p> 
			</div>
		</div>
		
		
		<div class="container">
			<div class="row my-2">
				<div class="btn-group mx-auto">
					<c:if test="${ not empty likeReivew }">
						<button class='button likeReviewBtn'>LIKED</button>
						<input type="hidden" class="likeInp" value="1" />
					</c:if>
					<c:if test="${ empty likeReivew }">
						<button class='button likeReviewBtn'>LIKE</button>
						<input type="hidden" class="likeInp" value="0" />
					</c:if>
					<a class="button declaration-modal btn-reply" href="#" data-toggle="modal">리뷰신고하기</a>
					<c:if test="${loginUser.id eq r.memberId }">
						<a class="button" href="reviewUpdateView.do?id=${r.id}">수정하기</a>
					</c:if>
					<c:if test="${ loginUser.id eq r.memberId }">
						<button class="button" onclick="location.href='reviewDelete.do?id=${r.id}';">삭제하기</button>
					</c:if>
				</div>
	
			</div>
			
			
				<!-- 댓글 등록 -->
				<div class="comment-form">
					<h4>댓글 작성</h4>
					<div class="form-group">
						<input type="hidden" id="reply-parent-id" value="">
						<textarea id="review-comment" class="form-control mb-10" rows="5" name="message" placeholder="댓글을 입력하세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '댓글을 입력하세요.'" data-toggle="tooltip" data-placement="top" title="" data-original-title="내용을 입력하세요."></textarea>
					</div>
					<div class="btn-group mx-auto">
						<button class="button" id="comment-btn">작성</button>
					</div>
				</div>
				
			  <!-- 댓글리스트 -->
			
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
								<input class="reviewType" type="radio" value="1" name="content">부적절한내용
								<input class="reviewType" type="radio" value="2" name="content">스포일러
							<p></p>
						</div>
						<div class="modal-footer">
							<button  type="submit" class="btn btn-primary">신고보내기</button>
							<button  class="btn btn-primary" data-dismiss="modal">Close</button>
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
						신고하기
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
							<button  type="submit" class="btn btn-primary">신고보내기</button>
							<button  class="btn btn-primary" data-dismiss="modal">Close</button>
						</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	
	
	
		<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
		<script>
		   var ctx = document.getElementById('myChart');
		   var chart = new Chart(ctx, {
		       // The type of chart we want to create
		       type: 'radar',
		
		       // The data for our dataset
		       data: {
		           labels: ["음악", "영상", "연기", "대중성", "각본","연출"],
		           datasets: [{
		              label: ["${ r.titleKor }"], 
			            backgroundColor: "rgb(165,102,255)",
			            pointBackground:"rgba(179,181,198,1)",
			            pointBorderColor:"#fff",
			            pointBorderBackgroundColor:"#fff",
		
	               data: [
	            	   ${r.ratingSound},${r.ratingVisual},${r.ratingActing},${r.ratingPop},${r.ratingScript},${r.ratingDirect}
            	   ]
		    
		           }]
		       },
		
		       // Configuration options go here
            options: {
              scale: {
                   angleLines: {
                       display: false
                   },
                   ticks: {
                       suggestedMin: 0,
                       suggestedMax: 10,
                   }
               },
               tooltips:{
                  callbacks: {
                       label: function(tooltipItem, data) {
                           
                           return data.labels[tooltipItem.index]  + " : "+ Math.round(tooltipItem.yLabel * 100) / 100 +"점";
                       }
                   }
               }
             }
		    });
		 
		// write comment
		$(function(){
			getReplyReviewCommentList();
				
				setInterval(function(){
					getReplyReviewCommentList();
				}, 50000);
				
				
				$("#rBtn").on("click", function(){
					
					var content = $("#review-comment").val();
					var memberId = ${loginUser.id};
					var reviewId = ${r.id};
						
					$.ajax({
						url:"insertReviewComment.do",
						data:{content:content,
							  memberId:memberId,
							  reviewId:reviewId,
						},
						success:function(data){
							if(data == "success"){
								//console.log(data);
								getReplyReviewCommentList();
								$("#review-comment").val("");
							}else{
								console.log(data);
								alert("댓글 작성 실패");
							}
						},error:function(){
							console.log("ajax 통신 실패");
						}
					});
				});			
			});
		
		
		
		// 댓글 리스트
			$(function () {
				getReplyReviewCommentList();
			});
			
			function getReplyReviewCommentList(){
				
				var rid = ${r.id};
				
				$.ajax({
					url:"reviewCommentList.do",
					data:{ id : rid },
					dataType:"json",
					success:function(data){
						// console.log(data);
						
						$tbody = $("#rtb tbody");
						$tbody.html("");
						
						$("#rCount").text("댓글(" + data.length + ")");
						
						if(data.length > 0){
							$.each(data, function(index, value){
								$tr = $("<tr></tr>");
								
								// console.log(value.nickName);
								
								$writerTd = $("<td width='100'></td>").text(value.nickName); 
								$contentTd = $("<td width='300'></td>").text(value.content);
								$dateTd = $("<td width='100'></td>").text(value.createDate);
								$deleteButton = $("<input class='delComment button' type='button' onclick='deleteReviewComment(id);'>").val('삭제')
								$updateButton = $("<input class='button' type='button'>").val('수정')
								$deButton = $("<a class='comment-modal btn-reply button' href='#' data-toggle='modal'>댓글신고하기</a>")
								
								
								
								$tr.append($writerTd);
								$tr.append($contentTd);
								$tr.append($dateTd);
								$tr.append($deleteButton);
								$tr.append($updateButton);
								$tr.append($deButton);
								
								$tbody.append($tr);
								
							});
							
						}else{
							
							$tr = $("<tr></tr>");
							
							$contentTd = $("<td colspan='4'></td>").text("등록된 댓글이 없습니다.");
							$tr.append($contentTd);
							
							$tbody.append($tr);
							
						}
					},
					error:function(){
						// console.log("ajax 실패");
					}
					
				});
			}
			

			function deleteReviewComment(id){
				var id = ${r.id};
				if(confirm("댓글을 삭제하시겠습니까")){
					$.ajax({
						type:"post",
						url:"deleteReviewComment.do",
						data:{"id":id},
						success:function(){
							alert("댓글이 삭제되었습니다.");
						},
						error:function(){
							// console.log(id);
							alert("댓글 삭제 실패");

						}
					});
				}
			}
			
			// 리뷰 좋아요		
			$(function() {
				//var likeReivew = $(".likeInp").val();
				//console.log("값 : " + likeReivew);
				
				$(".likeReviewBtn").on("click", function(){
					var userId = "${loginUser.id}";
					var targetId = "${ r.id }";
					var likeInp = $(".likeInp").val();
					var status = "";
					
					//console.log("버튼클릭시 : " + likeInp);
					
					if(likeInp == '0'){
						status = "like";
					}else if(likeInp == '1'){
						status = "nonlike";
					}
					//console.log(status);
					$.ajax({
							url:"likeReviewClick.do",
							data:{userId:userId,
								  targetId:targetId,
								  status:status},
							type:"post",
							success:function(data){
								//console.log(data);
								if(status == "like"){ // 좋아요클릭시
									if(data == 1){
										$(".likeReviewBtn").removeClass("btn-danger");
										$(".likeReviewBtn").removeClass("btn-secondary");
										$(".likeReviewBtn").addClass("btn-danger");
										$(".likeReviewBtn").text('LIKED');
										$(".likeInp").val('1');
									}else{
										alert("좋아요 실패");
									}
								}else if(status == "nonlike"){ // 좋아요 취소
									if(data >0){
										$(".likeReviewBtn").removeClass("btn-danger");
										$(".likeReviewBtn").removeClass("btn-secondary");
										$(".likeReviewBtn").addClass("btn-secondary");
										$(".likeReviewBtn").text('LIKE');
										$(".likeInp").val('0');
									}else{
										alert("좋아요 실패");
									}
								}
								//console.log("에이작스 후 : " + likeInp);
									
							},error:function(){
								// console.log("ajax 실패");
							}
						});  
				});
			});
	
			
			// 리뷰 신고하기 버튼 클릭 시
			$(".declaration-modal").on( "click", function() {
	        $(".de_modal").modal();
	        //console.log("${ loginUser.id }");
	    });
		
			// 댓글 신고하기 버튼 클릭시
			$(".comment-modal").on( "click", function() {
	        $(".cm_modal").modal();
	        //console.log("${ loginUser.id }");
	    });
			
			/*
		    $(document).on("click","cm_modal", function() {
		    	$(".cm_modal").modal(this);
		    });
			*/
		    
		    
			// 댓글 삭제
			$(".delComment button").on( "click", function() {
				$(function () {
					deleteReviewComment();
				});
			});
	
		</script>
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>