<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PoDo_UserPage</title>

<style>
	#imgInp{display:none}
	.nickguide{
		display:none;
		font-size:12px;
		top:12px;
		right:10px;
	}
	.nickok{color:blue;}
	.nickno{color:red;}
	.originguide{
		display:none;
		font-size:12px;
		top:12px;
		right:10px;
	}
	.oriok{color:blue;}
	.orino{color:red;}
	.modal-dialog{z-index:2000;}
	/* --------------------- 탭메뉴시작 ---------------------  */
	#container {
		/* width:800px; */
		margin:0 auto;
		/* text-align:center */;
	}
	.tab {
		list-style: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
	}
	/* Float the list items side by side */
	.tab li {
		float: left;
	}
	/* Style the links inside the list items */
	.tab li a {
		display: inline-block;
		color: #000;
		text-align: center;
		text-decoration: none;
		padding: 14px 16px;
		font-size: 18px;
		transition:0.3s;
		
	}
	/* Style the tab content */
	.tabcontent {
		display: none;
		background-color:rgb(230, 204, 255);
		padding: 6px 12px;
		color:#fff;
	}
	ul.tab li.current{
		background-color: rgb(230, 204, 255);
		color: #222;
	}
	.tabcontent.current {
		display: block;
	}
	/* --------------------- 탭메뉴 끝 ---------------------  */
	#noAnswer{color:red;}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<section class="blog-post-area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="comments-area">
						<h4></h4>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="resources/memberProfileImage/${ userPageMem.image }" width="70px" height="70px" alt=""><br><br>
										<c:if test="${ not empty likeUser }">
		                                	<button class='btn btn-danger likeBtn'>LIKED</button>
		                                	<input type="hidden" class="likeInp" value="1"/>
		                                </c:if>
		                                <c:if test="${ empty likeUser }">
		                                    <button class='btn btn-secondary likeBtn'>LIKE</button>
		                                   <input type="hidden" class="likeInp" value="0"/>
		                                </c:if>
		                                <!-- <input type="hidden" class="likeInp" value="0"/> -->
									</div>
									<div class="desc">
										<h2>${ userPageMem.nickName }</h2>
										<p class="date">작성리뷰 - ${reviewListCount}개  </p>
									</div>
								</div>
							</div>
							<br><br>	
							<div style='border:1px solid lightgray'></div><br>
							
							<!------------------------- 탭 메뉴 시작 ----------------------->
							<div class="col-lg-12">
								<div id="container">
									<ul class="tab">
											<li class="tab1 current" data-tab="tab1" ><a>Review</a></li>
											<li class="tab2" data-tab="tab2" ><a>Collection</a></li>
											<li class="tab3" data-tab="tab3"><a>Like</a></li>
									</ul>
							
										<div id="tab1" class="tabcontent current"><br>
											<!-------------------------- 리뷰 탭메뉴 바디 ------------------------>
											<section class="blog-post-area section-margin mt-4">
												<div class="container">
													<div class="row">
														<div class="col-lg-12">
															<c:forEach items="${review}" var="list" >
																<div class="single-recent-blog-post" style="height:300px">
																	<div class="details mt-20">
																		<div class="thumb" style="float:left">
																			<div class="col-lg-12" id="moviePoster" style="width: 200px; height: 200px;  align-items: center; justify-content: center;overflow: hidde; display: flex">
																				<img class='img-fluid' src='resources/detailFilmImage/${list.posterImage}' width='100%' height='100%'>
																			</div>
																		</div>
																		<div style="float:left">
																			<div style="float:left">
																				<a href="#"><h3>${list.titleKor}</h3><br></a>
																				<p>${list.content}</p>
																			</div>
																		</div>
																	</div>
																</div>
															</c:forEach>
															<!-------------------------- 페이징바 시작 ------------------------>
															<div class="row">
																<div class="col-lg-12">
																	<nav class="blog-pagination justify-content-center d-flex">
																		<ul class="pagination">
																			<!------ [이전] ------>
																			<c:if test="${ reviewPi.currentPage eq 1 }">
																				<li class="page-item">
																					<a class="page-link" aria-label="Previous" disabled>
																						<span aria-hidden="true">
																							<i class="ti-angle-left"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<c:if test="${ reviewPi.currentPage ne 1 }">
																				<c:url value="userPageSelectReview.do" var="before">
																					<c:param name="currentPage" value="${ reviewPi.currentPage-1 }"/>
																					<c:param name="id" value="${userPageMem.id}"/>
																				</c:url>
																				<li class="page-item">
																					<a href="${ before }" class="page-link" aria-label="Previous">
																						<span aria-hidden="true">
																							<i class="ti-angle-left"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<!-- ------------- -->
																			<!------ [페이지] ----->
																			<c:forEach begin="${ reviewPi.startPage }" end="${ reviewPi.endPage }" var="p">
																				<c:if test="${ p eq reviewPi.currentPage }">
																					<li class="page-item active"><a class="page-link" disabled>${p}</a></li>
																				</c:if>
																			
																				<c:if test="${ p ne reviewPi.currentPage }">
																					<c:url value="userPageSelectReview.do" var="page">
																						<c:param name="currentPage" value="${ p }"/>
																						<c:param name="id" value="${userPageMem.id}"/>
																					</c:url>
																					<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																				</c:if>
																			</c:forEach>
																			<!-- --------------- -->
																			<!------- [다음] ------->
																			<c:if test="${ reviewPi.currentPage eq reviewPi.maxPage }">
																				<li class="page-item">
																					<a class="page-link" aria-label="Next" disabled>
																						<span aria-hidden="true">
																							<i class="ti-angle-right"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<c:if test="${ reviewPi.currentPage ne reviewPi.maxPage }">
																				<c:url value="userPageSelectReview.do" var="after">
																					<c:param name="currentPage" value="${ reviewPi.currentPage+1 }"/>
																					<c:param name="id" value="${userPageMem.id}"/>
																				</c:url>
																				<li class="page-item">
																					<a href="${ after }" class="page-link" aria-label="Next">
																						<span aria-hidden="true">
																							<i class="ti-angle-right"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<!-- --------------- -->
																		</ul>
																	</nav>
																</div>
															</div>
															<!-------------------------- 페이징바 끝 -------------------------->
														</div>
													</div>
												</div>
											</section>
										</div>
								
									
										
										<div id="tab2" class="tabcontent"><br>
											<h3>Collection</h3><br>
											<p>컬렉입니당.</p>
										</div>
										
										<div id="tab3" class="tabcontent"><br>
											<h3>Like</h3><br>
											<p>라이크임당.</p>
										</div>
										
										<c:if test="${ empty inquiry  }">
											<div id="tab4" class="tabcontent"><br>
											문의 내용이 없습니다.
											</div>
										</c:if>
										
										<c:if test="${ not empty inquiry }">
										<div id="tab4" class="tabcontent"><br>
											<table align="center" border="1" cellspacing="0" width="700" style="text-align:center">
												<tr>
													<th>번호</th>
													<th>내용</th>
													<th>작성일</th>
													<th>답변여부</th>
												</tr>
											
												<c:forEach items="${ inquiry }" var="list" > 
													<tr>
														<td>${ list.id }</td>
														<td>${ list.content }</td>
														<td>${ list.createDate }</td>
														<c:if test="${ list.answer != null}">
															<td>${ list.answer }</td> 
															<!-- <td><button type="button" id="answerBtn" onclick="answer();"></button></td> -->
														</c:if>
														<c:if test="${ list.answer == null}">
															 <td id="noAnswer">답변 미등록</td> 
														</c:if>
													</tr>
												</c:forEach>
												</table><br>
												<!-------------------------- 페이징바 시작 ------------------------>
												<div class="col-lg-12">
													<nav class="blog-pagination justify-content-center d-flex">
														<ul class="pagination">
															<!------ [이전] ------>
															<c:if test="${ inquiryPi.currentPage eq 1 }">
																<li class="page-item">
																	<a class="page-link" aria-label="Previous" disabled>
																		<span aria-hidden="true">
																			<i class="ti-angle-left"></i>
																		</span>
																	</a>
																</li>
															</c:if>
															<c:if test="${ inquiryPi.currentPage ne 1 }">
																<c:url value="userPageSelectQuestion.do" var="before">
																	<c:param name="currentPage" value="${ inquiryPi.currentPage-1 }"/>
																	<c:param name="tab" value="tab4"/>
																	<c:param name="id" value="${userPageMem.id}"/>
																</c:url>
																<li class="page-item">
																	<a href="${ before }" class="page-link" aria-label="Previous">
																		<span aria-hidden="true">
																			<i class="ti-angle-left"></i>
																		</span>
																	</a>
																</li>
															</c:if>
															<!-- ------------- -->
															<!------ [페이지] ----->
															<c:forEach begin="${ inquiryPi.startPage }" end="${ inquiryPi.endPage }" var="p">
																<c:if test="${ p eq inquiryPi.currentPage }">
																	<li class="page-item active"><a class="page-link" disabled>${p}</a></li>
																</c:if>
															
																<c:if test="${ p ne inquiryPi.currentPage }">
																	<c:url value="userPageSelectQuestion.do" var="page">
																		<c:param name="currentPage" value="${ p }"/>
																		<c:param name="tab" value="tab4"/>
																		<c:param name="id" value="${userPageMem.id}"/>
																	</c:url>
																	<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																</c:if>
															</c:forEach>
															<!-- --------------- -->
															<!------- [다음] ------->
															<c:if test="${ inquiryPi.currentPage eq pi.maxPage }">
																<li class="page-item">
																	<a class="page-link" aria-label="Next" disabled>
																		<span aria-hidden="true">
																			<i class="ti-angle-right"></i>
																		</span>
																	</a>
																</li>
															</c:if>
															<c:if test="${ inquiryPi.currentPage ne inquiryPi.maxPage }">
																<c:url value="userPageSelectQuestion.do" var="after">
																	<c:param name="currentPage" value="${ inquiryPi.currentPage+1 }"/>
																	<c:param name="tab" value="tab4"/>
																	<c:param name="id" value="${userPageMem.id}"/>
																</c:url>
																<li class="page-item">
																	<a href="${ after }" class="page-link" aria-label="Next">
																		<span aria-hidden="true">
																			<i class="ti-angle-right"></i>
																		</span>
																	</a>
																</li>
															</c:if>
															<!-- --------------- -->
														</ul>
													</nav>
												</div>
												<!-------------------------- 페이징바 끝 -------------------------->
										</div>
										</c:if>
									</div>
								</div>
								<!-------------------------- 탭 메뉴 끝 ------------------------>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
  

	<script>
		// 탭메뉴 관련 
		
		$(function() {
			//var likeUser = $(".likeInp").val();
			//console.log("처음인풋 : " + likeUser);
			
			$(".likeBtn").on("click", function(){
				var targetId = "${userPageMem.id}";
				var userId = "${loginUser.id}";
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
						url:"likeClick.do",
						data:{userId:userId,
							  targetId:targetId,
							  status:status},
						type:"post",
						success:function(data){
							//console.log(data);
							if(status == "like"){ // 좋아요클릭시
								if(data == 1){
									$(".likeBtn").removeClass("btn-danger");
									$(".likeBtn").removeClass("btn-secondary");
									$(".likeBtn").addClass("btn-danger");
									$(".likeBtn").text('LIKED');
									$(".likeInp").val('1');
								}else{
									alert("좋아요 실패");
								}
							}else if(status == "nonlike"){ // 좋아요 취소
								if(data == 1){
									$(".likeBtn").removeClass("btn-danger");
									$(".likeBtn").removeClass("btn-secondary");
									$(".likeBtn").addClass("btn-secondary");
									$(".likeBtn").text('LIKE');
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
			
			$("#container ul>li").on("click", function(){
				var activeTab = $(this).attr('data-tab');
	            var tabMenu = $(this).text();
	            
	            if(tabMenu == "Review"){
	                location.href="userPageSelectReview.do?id=${userPageMem.id}&tab="+ activeTab;
	             }else if(tabMenu =="Collection"){
	            	  location.href="userPageSelectCollection.do?id=${userPageMem.id}&tab="+ activeTab;
	             }else if(tabMenu == "Like"){
	            	  location.href="userPageSelectLike.do?id=${userPageMem.id}&tab="+ activeTab;
	             }
			});
			if("${tab}" != ''){
				var tab = "${tab}";
				$('ul.tab li').removeClass('current');
				$('.tabcontent').removeClass('current');
				$("#" + tab).addClass('current');
				$("." + tab).addClass('current');
			}
		});

	</script>
	
</body>
</html>