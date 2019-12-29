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
				<div class="col-4">
					<img class="img-fluid" src="resources/detailFilmImage/${r.posterImage }" alt="">
				</div>
				
				<div class="col-8">
					<h4>${r.titleKor }</h4>
					<h2>★ :${r.star }점</h2>
					
					<div class="">
						<c:if test="${ loginUser.id != r.memberId }">
							<a href="userPage.do?userId=${r.memberId}&loginUserId=${ loginUser.id }"><h5>${r.nickName }님</h5></a>
						</c:if>
						<c:if test="${ loginUser.id == r.memberId }">
							<a href="myPage.do?id=${ loginUser.id }"><h5>${r.nickName }님</h5></a>
						</c:if>
						<p>${ r.createDate }</p>
					</div>
				
					<div class="">
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
			
			<div class="row">
				<div class="col-6">
					<canvas id="myChart"></canvas>
				</div>
				<div class="col-6">
					<form action="vinsert.do" method="post" id="movieform">
						<table align="center" id="vv">
							<tr>
								<td class="alert alert-primary">제목</td>
								<td><input style="text-align: center" class="button"
									type="text" name="title" id="vtitle" value="${ r.titleKor }"
									readonly></td>
							</tr>
							<tr>
								<td class="alert alert-primary">음악</td>
								<td><input style="text-align: center" class="button"
									type="text" name="ratingSound" class="insertRating"
									id="ratingSound" value="${r.ratingSound }" readonly></td>
							</tr>
							<tr>
								<td class="alert alert-primary">영상</td>
								<td><input style="text-align: center" class="button"
									type="text" name="ratingVisual" class="insertRating"
									id="ratingVisual" value="${r.ratingVisual }" readonly></td>
							</tr>
							<tr>
								<td class="alert alert-primary">연기</td>
								<td><input style="text-align: center" class="button"
									type="text" name="ratingActing" class="insertRating"
									id="ratingActing" value="${r.ratingActing }" readonly></td>
							</tr>
							<tr>
								<td class="alert alert-primary">대중성</td>
								<td><input style="text-align: center" class="button"
									type="text" name="ratingPop" class="insertRating"
									id="ratingPop" value="${r.ratingPop }" readonly></td>
							</tr>
							<tr>
								<td class="alert alert-primary">각본</td>
								<td><input style="text-align: center" class="button"
									type="text" name="ratingScript" class="insertRating"
									id="ratingScript" value="${r.ratingScript }" readonly></td>
							</tr>
							<tr>
								<td class="alert alert-primary">연출</td>
								<td><input style="text-align: center" class="button"
									type="text" name="ratingDirect" class="insertRating"
									id="ratingDirect" value="${r.ratingDirect }" readonly></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		
			<div class="row">
				<p>${r.content }</p> 
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
			
			
			<div class="row">
				<!-- 댓글 등록 -->
			  <table class="table table-striped table-dark">
				  <tr>
					  	<td><textarea rows="3" cols="100" id="review-comment"></textarea></td>
					  	<td><button class="button" id="rBtn">댓글등록</button></td>
				  </tr>
			  </table>
			  
			  <!-- 댓글리스트 -->
				<table class="table table-striped table-dark" id="rtb">
			 		<thead>
			  		<tr>
			  			<td><b id="rCount"></b></td>
			  		</tr>
			  		<tr>
			  			<td>닉네임</td>
			  			<td>내용</td>
			  			<td>작성일</td>
			  			<td width="200"></td>
			  		</tr>
			 		</thead>
			 		<tbody>
			 		
			 		</tbody>
			 	</table>
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
	
	
	
	
		<!-- 	<input id="commentDe" type="radio" onclick="commentClick();" name="defaultMenu">댓글
							<p></p>
									<input class="commentType" type="checkbox" style="display:none;"><p class="commentType" style="display:none;">부적절한내용</p>
									<input class="commentType" type="checkbox" style="display:none;"><p class="commentType" style="display:none;">스포일러</p>
							<p></p>
							<input id="freeDe" type="radio" onclick="freeClick();" name="defaultMenu">자유게시판
							<p></p>
									<input class="freeType" type="checkbox" style="display:none;"><p class="freeType" style="display:none;">부적절한내용</p>
									<input class="freeType" type="checkbox" style="display:none;"><p class="freeType" style="display:none;">스포일러</p>
							<p></p>						
							<input id="collectionDe"  type="radio" onclick="collectionClick();" name="defaultMenu">컬렉션
							<p></p>
									<input class="collectionType" type="checkbox" style="display:none;"><p class="collectionType" style="display:none;">부적절한내용</p>
									<input class="collectionType" type="checkbox" style="display:none;"><p class="collectionType" style="display:none;">스포일러</p>
							<p></p> -->
	
	
	
	
	
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
		 
		// 댓글 작성해주는거
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
		
		
		
		// 댓글 리스트 가져오는거
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
						console.log(data);
						
						$tbody = $("#rtb tbody");
						$tbody.html("");
						
						$("#rCount").text("댓글(" + data.length + ")");
						
						if(data.length > 0){
							$.each(data, function(index, value){
								$tr = $("<tr></tr>");
								
								console.log(value.nickName);
							
								
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
						console.log("통신실패");
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
							console.log(id);
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
							console.log("라이크 ajax 통신 실패");
						}
					});  
			});
			
		});
		// 신고하기 모달
	
			
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
		
		
	/*  신고..에이작스?   $(document).on("click","cm_modal", function() {
	    	$(".cm_modal").modal(this);
	    }); */
	    
	    
		// 댓글 삭제
		
		$(".delComment button").on( "click", function() {
			$(function () {
				deleteReviewComment();
			});
		});
		//리뷰 클릭시
/* 		function reviewClick() {
			if($("#reviewDe").is(":checked") == true) {
				$(".reviewType").css("display","inline-block");
			} else {
				$(".reviewType").css("display","none");
			}
		} */
	
		//댓글 클릭시
	/* 	function commentClick() {
			if($("#commentDe").is(":checked") == true) {
				$(".commentType").css("display","inline-block");
			} else {
				$(".commentType").css("display","none");
			}
		} */
		/* //자유게시판 클릭시
		function freeClick() {
			if($("#freeDe").is(":checked") == true) {
				$(".freeType").css("display","inline-block");
			} else {
				$(".freeType").css("display","none");
			}
		}
		// 컬렉션 신고시
		function collectionClick() {
			if($("#collectionDe").is(":checked") == true) {
				$(".collectionType").css("display","inline-block");
			} else {
				$(".collectionType").css("display","none");
			}
		} */
		
	
		</script>
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>