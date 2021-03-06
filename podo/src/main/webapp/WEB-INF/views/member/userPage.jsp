<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/header.jsp"/>
	<style>
		.modal-dialog {
			z-index: 5;
		}
		
		#noAnswer {
			color: red;
		}
		
		a.disabled {
			pointer-events: none;
			cursor: default;
		}
		
		.actorImage {
			border: 0px solid black;
			width: 100%;
			height: 200px;
			overflow-x: hidden;
		}
		
		.actor_name {
			border: 0px solid lightgrey;
			text-align: center;
			color: black;
		}
		
		.podo-user-card {
			/*border: 1px solid; */
			padding-top: 40px;
			display: inline-block;
			width: 241px;
			height: 400px;
			text-align: center;
		}
		
		.t:hover, .image_cover:hover {
			cursor: pointer;
		}
	</style>
</head>
<body>

	<section class="blog-post-area section-margin">
		<div class="container">
			<div class="row">
					<div class="col-md-10 d-flex align-items-start flex-column">
						<div class="user justify-content-between d-flex">
							<div class="thumb">
								<c:if test="${ userPageMem.image  != null }">
									<img src="resources/memberProfileImage/${ userPageMem.image }" id='userpage-profile-image'>
								</c:if>
								<c:if test="${ userPageMem.image == null }">
									<img src="resources/memberProfileImage/podoImage.png" id='userpage-profile-image'>
								</c:if>
							</div>
							<div class="desc">
								<h2>${ userPageMem.nickname }</h2>
								<p class="date">작성리뷰 - ${reviewListCount}개  </p>
							</div>
						</div>
					</div>
					<div class="col-md-2 px-4 d-flex align-items-end flex-column">
						<c:if test="${ not empty likeUser }">
	           	<button class='btn btn-danger likeBtn'>LIKED</button>
	           	<input type="hidden" class="likeInp" value="0"/>
           </c:if>
           <c:if test="${ empty likeUser }">
              <button class='btn btn-secondary likeBtn'>LIKE</button>
              <input type="hidden" class="likeInp" value="1"/>
           </c:if>
					</div>
			</div>
							
			<!------------------------- 탭 메뉴 시작 ----------------------->
			<div class="row">
			<ul class="tab d-flex justify-content-center">
					<li class="t tab1 current" data-tab="tab1"><a>리뷰</a></li>
					<li class="t tab2" data-tab="tab2"><a>좋아한 영화</a></li>
					<li class="t tab3" data-tab="tab3"><a>좋아한 리뷰</a></li>
					<li class="t tab4" data-tab="tab4"><a>좋아한 회원</a></li>
			</ul>
			</div>
				<div id="container">
			
					<!-- -------------------- Review --------------------------->
					<div id="tab1" class="tabcontent current"><br>
						<c:if test="${ !empty review }">
						<!-------------------------- Review Tab Menu Body ------------------------>
						<section class="blog-post-area section-margin mt-4">
							<div class="container">
								<c:forEach items="${review}" var="list" >
									<div class="row my-4 review-list-card">
										<div class="podo-film-card col-md-4">
											<div class="poster" onclick="location.href='detailFilm.do?filmId=${list.filmId}';">
												<img class='img-fluid' src='resources/detailFilmImage/${list.posterImage}' width='100%' height='100%'>
											</div>
										</div>
										<div class="col-md-8">
											<a href="reviewDetail.do?id=${list.ratingReviewId}">${list.titleKor}</a>
											<div class="review-list-content">${list.content}</div>
										</div>
									</div>
									
								</c:forEach>
								<!-------------------------- Pagination start ------------------------>
									<div class="row">
										<div class="col-lg-12">
											<nav class="blog-pagination justify-content-center d-flex">
												<ul class="pagination">
													<!------ [이전] ------>
													<c:if test="${ reviewPi.currentPage eq 1 }">
														<li class="page-item">
															<a class="page-link disabled" aria-label="Previous" >
																<span aria-hidden="true" style="color:white;"> &lt;
																	<!-- <i class="ti-angle-left"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<c:if test="${ reviewPi.currentPage ne 1 }">
														<c:url value="userPageSelectReview.do" var="before">
															<c:param name="currentPage" value="${ reviewPi.currentPage-1 }"/>
															<c:param name="tab" value="tab1"/>
															<c:param name="id" value="${userPageMem.id}"/>
														</c:url>
														<li class="page-item">
															<a href="${ before }" class="page-link" aria-label="Previous">
																<span aria-hidden="true" style="color:white;"> &lt;
																	<!-- <i class="ti-angle-left"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<!-- ------------- -->
													<!------ [페이지] ----->
													<c:forEach begin="${ reviewPi.startPage }" end="${ reviewPi.endPage }" var="p">
														<c:if test="${ p eq reviewPi.currentPage }">
															<li class="page-item active "><a class="page-link disabled"  >${p}</a></li>
														</c:if>
													
														<c:if test="${ p ne reviewPi.currentPage }">
															<c:url value="userPageSelectReview.do" var="page">
																<c:param name="currentPage" value="${ p }"/>
																<c:param name="tab" value="tab1"/>
																<c:param name="id" value="${userPageMem.id}"/>
															</c:url>
															<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
														</c:if>
													</c:forEach>
													<!-- --------------- -->
													<!------- [다음] ------->
													<c:if test="${ reviewPi.currentPage eq reviewPi.maxPage }">
														<li class="page-item">
															<a class="page-link disabled" aria-label="Next" >
																<span aria-hidden="true" style="color:white;">&gt;
																	<!-- <i class="ti-angle-right"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<c:if test="${ reviewPi.currentPage ne reviewPi.maxPage }">
														<c:url value="userPageSelectReview.do" var="after">
															<c:param name="currentPage" value="${ reviewPi.currentPage+1 }"/>
															<c:param name="tab" value="tab1"/>
															<c:param name="id" value="${userPageMem.id}"/>
														</c:url>
														<li class="page-item">
															<a href="${ after }" class="page-link" aria-label="Next">
																<span aria-hidden="true" style="color:white;">&gt;</span>
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
							</section>
							</c:if>
							<c:if test="${ empty review }">
								<div style="text-align: center;">
									<h3> 작성한 리뷰가 없습니다.</h3>
									<br>
								</div>
						</c:if>
					</div>
						<!-- -------------------- 리뷰 끝----------------------->
						
						<!-- -------------------- 라이크_영화----------------------->
						<div id="tab2" class="tabcontent"><br>
							<div class="container">
								<c:if test="${ !empty likeFilmList }">
									<div class="row">
										<c:forEach items="${ likeFilmList }" var="likeFilm" >
											<!-- width * 1.425 -->
											<div class="podo-film-card col-md-3">
												<input class="hidden-filmId" type="hidden" value="${ likeFilm.id }">
												<c:if test="${ not empty likeFilm.changeName }">
													<div class="poster" onclick="location.href='detailFilm.do?filmId=${likeFilm.targetId}'">
														<img src="resources/detailFilmImage/${ likeFilm.changeName }">
													</div>
												</c:if>
												<c:if test="${ empty likeFilm.changeName }">
													<div class="poster" onclick="location.href='detailFilm.do?filmId=${likeFilm.targetId}'">
														<img src="resources/detailFilmImage/podoposter.jpg">
													</div>
												</c:if>
												<div style="margin-top: 20px; text-overflow: ellipsis; overflow: hidden;">
													${ likeFilm.titleKor }
												</div>
												<div class="row" style="margin-top: 10px;">
													<div class="col">
                             	<button class='btn btn-danger likeBtn'>LIKED</button>
													</div>
												</div>
												<br>
											</div>
										</c:forEach>
									</div>
									<!-------------------------- 페이징바 시작 ------------------------>
									<div class="row">
										<div class="col-lg-12">
											<nav class="blog-pagination justify-content-center d-flex">
												<ul class="pagination">
													<!------ [이전] ------>
													<c:if test="${ filmPi.currentPage eq 1 }">
														<li class="page-item">
															<a class="page-link disabled" aria-label="Previous">
																<span aria-hidden="true" style="color:white;">&lt;
																	<!-- <i class="ti-angle-left"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<c:if test="${ filmPi.currentPage ne 1 }">
														<c:url value="myPageSelectLikeFilm.do" var="before">
															<c:param name="currentPage" value="${ filmPi.currentPage-1 }"/>
															<c:param name="tab" value="tab2"/>
															<c:param name="id" value="${userPageMem.id}"/>
														</c:url>
														<li class="page-item">
															<a href="${ before }" class="page-link" aria-label="Previous">
																<span aria-hidden="true" style="color:white;">&lt;
																	<!-- <i class="ti-angle-left"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<!-- ------------- -->
													<!------ [페이지] ----->
													<c:forEach begin="${ filmPi.startPage }" end="${ filmPi.endPage }" var="p">
														<c:if test="${ p eq filmPi.currentPage }">
															<li class="page-item disabled"><a class="page-link" >${p}</a></li>
														</c:if>
													
														<c:if test="${ p ne filmPi.currentPage }">
															<c:url value="myPageSelectLikeFilm.do" var="page">
																<c:param name="currentPage" value="${ p }"/>
																<c:param name="tab" value="tab2"/>
																<c:param name="id" value="${userPageMem.id}"/>
															</c:url>
															<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
														</c:if>
													</c:forEach>
													<!-- --------------- -->
													<!------- [다음] ------->
													<c:if test="${ filmPi.currentPage eq filmPi.maxPage }">
														<li class="page-item">
															<a class="page-link disabled" aria-label="Next" >
																<span aria-hidden="true" style="color:white;">&gt;
																	<!-- <i class="ti-angle-right"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<c:if test="${ filmPi.currentPage ne filmPi.maxPage }">
														<c:url value="myPageSelectLikeFilm.do" var="after">
															<c:param name="currentPage" value="${ filmPi.currentPage+1 }"/>
															<c:param name="tab" value="tab2"/>
															<c:param name="id" value="${userPageMem.id}"/>
														</c:url>
														<li class="page-item">
															<a href="${ after }" class="page-link" aria-label="Next" >
																<span aria-hidden="true" style="color:white;">&gt;
																	<!-- <i class="ti-angle-right"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<!-- --------------- -->
												</ul>
											</nav>
										</div>
									</div>
								</c:if>
								<!-------------------------- 페이징바 끝 -------------------------->
								<c:if test="${ empty likeFilmList }">
									<div style="text-align: center;">
										<h3> 좋아한 영화가 없습니다.</h3>
										<br>
									</div>
								</c:if>
							</div>
						</div>
						<!-- -------------------- 라이크_영화 끝--------------------->
						
						<!--------------------- 라이크_리뷰 시작 --------------------->
						<div id="tab3" class="tabcontent"><br>
							<c:if test="${ !empty likeReviewList }">
								<section class="blog-post-area section-margin mt-4">
									<div class="container">
										<c:forEach items="${likeReviewList}" var="list" >
											<div class="row">
												<div class="col-3 single-recent-blog-post">
													<div class="thumb podo-film-card">
														<div class="poster" onclick="location.href='reviewDetail.do?id=${list.rrId}';">										
															<img class='img-fluid' src='resources/detailFilmImage/${list.changeName}'>
														</div>
													</div>
												</div>
												<div class="col-9">
													<button class='btn btn-danger likeBtn'>LIKED</button>
													<a href="reviewDetail.do?id=${list.rrId}">${list.titleKor}<br></a>
													<p>${list.content}</p>
												</div>
											</div>
										</c:forEach>
												<!-------------------------- 페이징바 시작 ------------------------>
												<div class="row">
													<div class="col-lg-12">
														<nav class="blog-pagination justify-content-center d-flex">
															<ul class="pagination">
																<!------ [이전] ------>
																<c:if test="${ reviewlikePi.currentPage eq 1 }">
																	<li class="page-item">
																		<a class="page-link disabled" aria-label="Previous">
																			<span aria-hidden="true" style="color:white;"> &lt;
																				<!-- <i class="ti-angle-left"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${ reviewlikePi.currentPage ne 1 }">
																	<c:url value="myPageSelectLikeReview.do" var="before">
																		<c:param name="currentPage" value="${ reviewlikePi.currentPage-1 }"/>
																		<c:param name="tab" value="tab3"/>
																		<c:param name="id" value="${userPageMem.id}"/>
																	</c:url>
																	<li class="page-item">
																		<a href="${ before }" class="page-link" aria-label="Previous">
																			<span aria-hidden="true" style="color:white;">&lt;
																				<!-- <i class="ti-angle-left"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<!-- ------------- -->
																<!------ [페이지] ----->
																<c:forEach begin="${ reviewlikePi.startPage }" end="${ reviewlikePi.endPage }" var="p">
																	<c:if test="${ p eq reviewlikePi.currentPage }">
																		<li class="page-item disabled"><a class="page-link" >${p}</a></li>
																	</c:if>
																
																	<c:if test="${ p ne reviewlikePi.currentPage }">
																		<c:url value="myPageSelectLikeReview.do" var="page">
																			<c:param name="currentPage" value="${ p }"/>
																			<c:param name="tab" value="tab3"/>
																			<c:param name="id" value="${userPageMem.id}"/>
																		</c:url>
																		<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																	</c:if>
																</c:forEach>
																<!-- --------------- -->
																<!------- [다음] ------->
																<c:if test="${ reviewlikePi.currentPage eq reviewlikePi.maxPage }">
																	<li class="page-item">
																		<a class="page-link disabled" aria-label="Next" >
																			<span aria-hidden="true" style="color:white;">&gt;
																				<!-- <i class="ti-angle-right"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${ reviewlikePi.currentPage ne reviewlikePi.maxPage }">
																	<c:url value="myPageSelectLikeReview.do" var="after">
																		<c:param name="currentPage" value="${ reviewlikePi.currentPage+1 }"/>
																		<c:param name="tab" value="tab3"/>
																		<c:param name="id" value="${userPageMem.id}"/>
																	</c:url>
																	<li class="page-item">
																		<a href="${ after }" class="page-link" aria-label="Next">
																			<span aria-hidden="true" style="color:white;"> &gt;
																				<!-- <i class="ti-angle-right"></i> -->
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
								</section>
							</c:if>
							<c:if test="${ empty likeReviewList }">
								<div style="text-align: center;">
									<h3> 좋아한 리뷰가 없습니다.</h3>
									<br>
								</div>
							</c:if>
						</div>
						<!--------------------- 라이크_리뷰 끝 ---------------------->
						
            <!--------------------- 라이크_유저 시작 --------------------->
						<div id="tab4" class="tabcontent"><br>
							<div class="container">
								<c:if test="${ !empty likeUserList }">
									<div class="row">
										<c:forEach items="${ likeUserList }" var="likeUserList">
											<!-- width * 1.425 -->
											<div class="podo-user-card col-lg-3">
												<input class="hidden-filmId" type="hidden" value="${ likeUserList.id }">
												<div class="image_cover" onclick="location.href='userPage.do?userId=${likeUserList.targetId}&loginUserId=${loginUser.id}'">
														<c:if test="${likeUserList.changeName != null }">
															<img src="resources/memberProfileImage/${likeUserList.changeName}" id="profile" width='200' height='200' style="border-radius: 100px;">
														</c:if>
														<c:if test="${likeUserList.changeName == null }">
															<img src="resources/memberProfileImage/podoImage.png" id="profile" width='200' height='200' style=" border-radius: 100px;">
														</c:if>
														
												</div>
												<div style="margin-top: 20px; text-overflow: ellipsis; overflow: hidden;">
													${ likeUserList.nickname }
												</div>
												
												<div class="row" style="margin-top: 10px;">
													<div class="col">
                             	<button class='btn btn-danger likeBtn'>LIKED</button>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
									<!-------------------------- 페이징바 시작 ------------------------>
									<div class="row">
										<div class="col-lg-12">
											<nav class="blog-pagination justify-content-center d-flex">
												<ul class="pagination">
													<!------ [이전] ------>
													<c:if test="${ userPi.currentPage eq 1 }">
														<li class="page-item">
															<a class="page-link disabled" aria-label="Previous">
																<span aria-hidden="true" style="color:white;">&lt;
																	<!-- <i class="ti-angle-left"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<c:if test="${ userPi.currentPage ne 1 }">
														<c:url value="myPageSelectLikeUser.do" var="before">
															<c:param name="currentPage" value="${ userPi.currentPage-1 }"/>
															<c:param name="tab" value="tab4"/>
															<c:param name="id" value="${userPageMem.id}"/>
														</c:url>
														<li class="page-item">
															<a href="${ before }" class="page-link" aria-label="Previous">
																<span aria-hidden="true" style="color:white;">&lt;
																	<!-- <i class="ti-angle-left"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<!-- ------------- -->
													<!------ [페이지] ----->
													<c:forEach begin="${ userPi.startPage }" end="${ userPi.endPage }" var="p">
														<c:if test="${ p eq fuserPi.currentPage }">
															<li class="page-item disabled"><a class="page-link" >${p}</a></li>
														</c:if>
													
														<c:if test="${ p ne userPi.currentPage }">
															<c:url value="myPageSelectLikeUser.do" var="page">
																<c:param name="currentPage" value="${ p }"/>
																<c:param name="tab" value="tab4"/>
																<c:param name="id" value="${userPageMem.id}"/>
															</c:url>
															<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
														</c:if>
													</c:forEach>
													<!-- --------------- -->
													<!------- [다음] ------->
													<c:if test="${ userPi.currentPage eq userPi.maxPage }">
														<li class="page-item">
															<a class="page-link disabled" aria-label="Next" >
																<span aria-hidden="true" style="color:white;">&gt;
																	<!-- <i class="ti-angle-right"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<c:if test="${ userPi.currentPage ne userPi.maxPage }">
														<c:url value="myPageSelectLikeUser.do" var="after">
															<c:param name="currentPage" value="${ userPi.currentPage+1 }"/>
															<c:param name="tab" value="tab4"/>
															<c:param name="id" value="${userPageMem.id}"/>
														</c:url>
														<li class="page-item">
															<a href="${ after }" class="page-link" aria-label="Next">
																<span aria-hidden="true" style="color:white;">&gt;
																	<!-- <i class="ti-angle-right"></i> -->
																</span>
															</a>
														</li>
													</c:if>
													<!-- --------------- -->
												</ul>
											</nav>
										</div>
									</div>
								</c:if>
								<!-------------------------- 페이징바 끝 -------------------------->
							<c:if test="${ empty likeUserList }">
								<div style="text-align: center;">
									<h3> 좋아한 회원이 없습니다.</h3>
									<br>
								</div>
							</c:if>
						</div>
					</div>
					<!---------------------- 라이크_유저 끝 --------------------->
				<!-------------------------- 탭 메뉴 끝 ------------------------>
				</div>
		</div>
	</section>
  

	<script>
		$(function() {
			$(".likeBtn").on("click", function(){
				var targetId = '${ userPageMem.id }';
				var userId = '${ loginUser.id }';
				var flag = $(".likeInp").val();
				// var status = "${likeUser}";
				
				//console.log(status);
				$.ajax({
					url : "likeMember.do",
					data : {
						userId : userId,
						targetId : targetId,
						flag : flag
					},
					type : "post",
					success : function(data) {
						//console.log(data);
						if (data == 1) {
							if (flag == "1") { // 좋아요
								$(".likeBtn").removeClass("btn-secondary");
								$(".likeBtn").addClass("btn-danger");
								$(".likeBtn").text('LIKED');
								$(".likeInp").val('0');
							} else if (flag == "0") { // 좋아요 취소
								$(".likeBtn").removeClass("btn-danger");
								$(".likeBtn").addClass("btn-secondary");
								$(".likeBtn").text('LIKE');
								$(".likeInp").val('1');
							}
						}
						else {
							alert("좋아요 실패");
						}
						//console.log("에이작스 후 : " + likeInp);

					},
					error : function() {
						console.log("ajax error");
					}
				});
			});

			$(".container>.row>ul>li").on("click", function() {
				var activeTab = $(this).attr('data-tab');
				var tabMenu = $(this).text();

				if (tabMenu == "리뷰") {
					location.href = "userPageSelectReview.do?loginUserId=${loginUser.id}&id=${userPageMem.id}&tab=" + activeTab;
				} else if (tabMenu == "좋아한 영화") {
					location.href = "userPageSelectLikeFilm.do?loginUserId=${loginUser.id}&id=${userPageMem.id}&tab=" + activeTab;
				} else if (tabMenu == "좋아한 리뷰") {
					location.href = "userPageSelectLikeReview.do?loginUserId=${loginUser.id}&id=${userPageMem.id}&tab=" + activeTab;
				} else if (tabMenu == "좋아한 회원") {
					location.href = "userPageSelectLikeUser.do?loginUserId=${loginUser.id}&id=${userPageMem.id}&tab=" + activeTab;
				}
			});
			
			if ('${tab}' != '') {
				var tab = '${tab}';
				$('ul.tab li').removeClass('current');
				$('.tabcontent').removeClass('current');
				$("#" + tab).addClass('current');
				$("." + tab).addClass('current');
			}
		});
	</script>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>