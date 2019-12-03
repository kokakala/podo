<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PoDo_MyPage</title>

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
		/* background-color:rgb(230, 204, 255); */
		padding: 6px 12px;
		color:#fff;
	}
	ul.tab li.current{
		/* background-color: rgb(230, 204, 255); */
		color: rgb(230, 204, 255);
	}
	.tabcontent.current {
		display: block;
	}
	/* --------------------- 탭메뉴 끝 ---------------------  */
	#noAnswer{color:red;}
	
	/* --------------------- 리뷰_영화 관련---------------------  */
	.podo-film-card {
		/*border: 1px solid; */
		padding-top: 40px;
		display: inline-block;
		width: 241px;
		height: 620px;
		text-align: center;
	}
	
	.podo-film-card .poster {
		overflow: hidden;
		cursor: pointer;
		border-radius: 10px;
    	border: 1px solid #b3bfdd;
	}
	
	.podo-film-card .poster img {
	/* 	width: 240px; */
		width: 100%;
		height: 342px;
		object-fit: cover;
	}
	
	.podo-film-card .poster img:hover {
		-moz-transform: scale(1.1);
	    -webkit-transform: scale(1.1);
	    -o-transform:scale(1.1);  
	    transform: scale(1.1);
		-moz-transition: all 0.3s;
	    -webkit-transition: all 0.3s;
	    -o-transition: all 0.3s;
	    transition: all 0.3s;
	}
	/* --------------------- 리뷰_영화 관련 끝---------------------  */
	a.disabled {
	  pointer-events: none;
	  cursor: default;
	}
	
    .actorImage{
    	border: 0px solid black;
    	width:100%;
    	height:200px;
    	overflow-x:hidden;
    }
    .actor_name{
    	border : 0px solid lightgrey;
    	text-align:center;
    	color:black;
    }
    .podo-user-card {
		/*border: 1px solid; */
		padding-top: 40px;
		display: inline-block;
		width: 241px;
		height: 400px;
		text-align: center;
	}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<c:if test="${ empty loginUser}">
		<div style="text-align: center; color:white">
			<h3> 로그인해주세요</h3>
			<br>
		</div>
	</c:if>
	
	<c:if test="${ !empty loginUser}">
	<section class="blog-post-area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="">
						<h4>마이페이지</h4><br><br>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="resources/memberProfileImage/${ loginUser.image }" width='150' height='150' style="border-radius: 100px;"><br><br>
										
									</div>
									<div class="desc">
										<h2>${ loginUser.nickName }</h2>
										<p class="date">작성리뷰 - ${reviewListCount}개  </p>
									</div>
								</div>
								<div class="reply-btn">
									<a id="update-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal" style="background:rgb(218, 179, 255); text-align:center;color:white;">정보수정</a>
									<a id="updatePwd-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal" style="background:rgb(218, 179, 255); color:white;">비밀번호 변경</a>
									<a id="question-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal" style="background:pink; text-align:center; color:white;">문의하기</a>
									<a class="btn-reply text-uppercase" href="premium.do" style="background:pink; text-align:center; color:white;">프리미엄</a>
								</div>
							</div>
							<br><br>
							<div style='border:1px solid lightgray'></div><br>
							
							<!------------------------- 탭 메뉴 시작 ----------------------->
							<div class="col-lg-12">
								<div id="container">
									<ul class="tab">
											<li class="tab1 current" data-tab="tab1" ><a>Review</a></li>
											<li class="tab2" data-tab="tab2" ><a>Like_Film</a></li>
											<li class="tab3" data-tab="tab3"><a>Like_Review</a></li>
											<li class="tab4" data-tab="tab4"><a>Like_User</a></li>
											<li class="tab5" data-tab="tab5"><a>Question</a></li>
									</ul>
							
										<!-- -------------------- 리뷰 --------------------------->
										<div id="tab1" class="tabcontent current"><br>
											<c:if test="${ !empty review }">
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
																					<a class="page-link disabled" aria-label="Previous">
																						<span aria-hidden="true" style="color:white;">&lt;
																							<!-- <i class="ti-angle-left"></i> -->
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<c:if test="${ reviewPi.currentPage ne 1 }">
																				<c:url value="myPageSelectReview.do" var="before">
																					<c:param name="currentPage" value="${ reviewPi.currentPage-1 }"/>
																					<c:param name="tab" value="tab1"/>
																					<c:param name="id" value="${loginUser.id}"/>
																				</c:url>
																				<li class="page-item">
																					<a href="${ before }" class="page-link" aria-label="Previous">
																						<span aria-hidden="true" style="color:white;"> &lt;
																						<!-- 	<i class="ti-angle-left"></i> -->
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<!-- ------------- -->
																			<!------ [페이지] ----->
																			<c:forEach begin="${ reviewPi.startPage }" end="${ reviewPi.endPage }" var="p">
																				<c:if test="${ p eq reviewPi.currentPage }">
																					<li class="page-item disabled"><a class="page-link" >${p}</a></li>
																				</c:if>
																			
																				<c:if test="${ p ne reviewPi.currentPage }">
																					<c:url value="myPageSelectReview.do" var="page">
																						<c:param name="currentPage" value="${ p }"/>
																						<c:param name="tab" value="tab1"/>
																						<c:param name="id" value="${loginUser.id}"/>
																					</c:url>
																					<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																				</c:if>
																			</c:forEach>
																			<!-- --------------- -->
																			<!------- [다음] ------->
																			<c:if test="${ reviewPi.currentPage eq reviewPi.maxPage }">
																				<li class="page-item">
																					<a class="page-link disabled" aria-label="Next" >
																						<span aria-hidden="true" style="color:white;"> &gt;
																							<!-- <i class="ti-angle-right"></i> -->
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<c:if test="${ reviewPi.currentPage ne reviewPi.maxPage }">
																				<c:url value="myPageSelectReview.do" var="after">
																					<c:param name="currentPage" value="${ reviewPi.currentPage+1 }"/>
																					<c:param name="tab" value="tab1"/>
																					<c:param name="id" value="${loginUser.id}"/>
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
													</div>
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
										<!-- -------------------- 리뷰끝 -------------------------->
									
										<!-- -------------------- 라이크_영화----------------------->
										<div id="tab2" class="tabcontent"><br>
											<div class="container">
												<c:if test="${ !empty likeFilmList }">
													<div class="row">
														<c:forEach items="${ likeFilmList }" var="likeFilm" >
															<!-- width * 1.425 -->
															<div class="podo-film-card col-3">
																<input class="hidden-filmId" type="hidden" value="${ likeFilm.id }">
																<div class="poster">
																	<c:if test="${ not empty likeFilm.changeName }">
																		<a href="ratingDetailReview.do?id=${likeFilm.targetId}"><img src="resources/detailFilmImage/${ likeFilm.changeName }"></a>
																	</c:if>
																	<c:if test="${ empty likeFilm.changeName }">
																		<img src="resources/detailFilmImage/podoposter.jpg">
																	</c:if>
																</div>
																<div style="margin-top: 20px; text-overflow: ellipsis; overflow: hidden;">
																	${ likeFilm.titleKor }
																</div>
																<div class="row" style="margin-top: 10px;">
																	<div class="col">
									                                	<button class='btn btn-danger likeBtn'>LIKED</button>
									                                	<input type="hidden" class="likeInp" value="1"/>
									                                	<input type="hidden" class="targetInp" value="${ likeFilm.targetId }"/>
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
																<c:if test="${ filmPi.currentPage eq 1 }">
																	<li class="page-item">
																		<a class="page-link disabled" aria-label="Previous">
																			<span aria-hidden="true" style="color:white;"> &lt;
																				<!-- <i class="ti-angle-left"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${ filmPi.currentPage ne 1 }">
																	<c:url value="myPageSelectLikeFilm.do" var="before">
																		<c:param name="currentPage" value="${ filmPi.currentPage-1 }"/>
																		<c:param name="tab" value="tab2"/>
																		<c:param name="id" value="${loginUser.id}"/>
																	</c:url>
																	<li class="page-item">
																		<a href="${ before }" class="page-link" aria-label="Previous">
																			<span aria-hidden="true" style="color:white;"> &lt;
																			<!-- 	<i class="ti-angle-left"></i> -->
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
																			<c:param name="id" value="${loginUser.id}"/>
																		</c:url>
																		<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																	</c:if>
																</c:forEach>
																<!-- --------------- -->
																<!------- [다음] ------->
																<c:if test="${ filmPi.currentPage eq filmPi.maxPage }">
																	<li class="page-item">
																		<a class="page-link disabled" aria-label="Next" >
																			<span aria-hidden="true" style="color:white;"> &gt;
																				<!-- <i class="ti-angle-right"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${ filmPi.currentPage ne filmPi.maxPage }">
																	<c:url value="myPageSelectLikeFilm.do" var="after">
																		<c:param name="currentPage" value="${ filmPi.currentPage+1 }"/>
																		<c:param name="tab" value="tab2"/>
																		<c:param name="id" value="${loginUser.id}"/>
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
												</c:if>
												<!-------------------------- 페이징바 끝 -------------------------->
												<c:if test="${ FilmlistCount eq 0 }">
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
														<div class="row">
															<div class="col-lg-12">
																<c:forEach items="${likeReviewList}" var="list" >
																	<div class="single-recent-blog-post" style="height:300px">
																		<div class="details mt-20">
																			<div class="thumb" style="float:left">
																				<div class="col-lg-12" id="moviePoster" style="width: 200px; height: 200px;  align-items: center; justify-content: center;overflow: hidde; display: flex">
																					<img class='img-fluid' src='resources/detailFilmImage/${list.changeName}' width='100%' height='100%'>
																				</div>
																				
																			</div>
																			<div style="float:left">
																				<div style="float:left">
										                                	<button class='btn btn-danger likeBtn'>LIKED</button>
										                                	<input type="hidden" class="likeInp" value="1"/>
										                                	<input type="hidden" class="targetInp" value="${ list.targetId }"/><br><br>
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
																				<c:if test="${ reviewlikePi.currentPage eq 1 }">
																					<li class="page-item">
																						<a class="page-link disabled" aria-label="Previous">
																							<span aria-hidden="true" style="color:white;"> &lgt;
																								<!-- <i class="ti-angle-left"></i> -->
																							</span>
																						</a>
																					</li>
																				</c:if>
																				<c:if test="${ reviewlikePi.currentPage ne 1 }">
																					<c:url value="myPageSelectLikeReview.do" var="before">
																						<c:param name="currentPage" value="${ reviewlikePi.currentPage-1 }"/>
																						<c:param name="tab" value="tab3"/>
																						<c:param name="id" value="${loginUser.id}"/>
																					</c:url>
																					<li class="page-item">
																						<a href="${ before }" class="page-link" aria-label="Previous">
																							<span aria-hidden="true" style="color:white;">&lgt;
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
																							<c:param name="id" value="${loginUser.id}"/>
																						</c:url>
																						<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																					</c:if>
																				</c:forEach>
																				<!-- --------------- -->
																				<!------- [다음] ------->
																				<c:if test="${ reviewlikePi.currentPage eq reviewlikePi.maxPage }">
																					<li class="page-item">
																						<a class="page-link disabled" aria-label="Next" >
																							<span aria-hidden="true" style="color:white;"> &gt;
																								<!-- <i  class="ti-angle-right"></i> -->
																							</span>
																						</a>
																					</li>
																				</c:if>
																				<c:if test="${ reviewlikePi.currentPage ne reviewlikePi.maxPage }">
																					<c:url value="myPageSelectLikeReview.do" var="after">
																						<c:param name="currentPage" value="${ reviewlikePi.currentPage+1 }"/>
																						<c:param name="tab" value="tab3"/>
																						<c:param name="id" value="${loginUser.id}"/>
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
														</div>
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
										</div>
										<!--------------------- 라이크_리뷰 끝 ---------------------->
										
						   	            <!--------------------- 라이크_유저 시작 --------------------->
										<div id="tab4" class="tabcontent"><br>
											<div class="container">
												<c:if test="${ !empty likeUserList }">
													<div class="row">
														<c:forEach items="${ likeUserList }" var="likeUserList">
															<!-- width * 1.425 -->
															<div class="podo-user-card col-3">
																<input class="hidden-filmId" type="hidden" value="${ likeUserList.id }">
																<div class="image_cover">
																		<img src="resources/memberProfileImage/${likeUserList.changeName}" width='150' height='150' style="border-radius: 100px;">
																</div>
																<div style="margin-top: 20px; text-overflow: ellipsis; overflow: hidden;">
																	${ likeUserList.nickName }
																</div>
																
																<div class="row" style="margin-top: 10px;">
																	<div class="col">
									                                	<button class='btn btn-danger likeBtn'>LIKED</button>
									                                	<input type="hidden" class="likeInp" value="1"/>
									                                	<input type="hidden" class="targetInp" value="${ likeUserList.targetId }"/>
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
																			<span aria-hidden="true" style="color:white;"> &lt;
																				<!-- <i class="ti-angle-left"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${ userPi.currentPage ne 1 }">
																	<c:url value="myPageSelectLikeUser.do" var="before">
																		<c:param name="currentPage" value="${ userPi.currentPage-1 }"/>
																		<c:param name="tab" value="tab4"/>
																		<c:param name="id" value="${loginUser.id}"/>
																	</c:url>
																	<li class="page-item">
																		<a href="${ before }" class="page-link" aria-label="Previous">
																			<span aria-hidden="true" style="color:white;"> &lt;
																			<!-- 	<i class="ti-angle-left"></i> -->
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
																			<c:param name="id" value="${loginUser.id}"/>
																		</c:url>
																		<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																	</c:if>
																</c:forEach>
																<!-- --------------- -->
																<!------- [다음] ------->
																<c:if test="${ userPi.currentPage eq userPi.maxPage }">
																	<li class="page-item">
																		<a class="page-link disabled" aria-label="Next" >
																			<span aria-hidden="true" style="color:white;"> &gt;
																				<!-- <i class="ti-angle-right"></i> -->
																			</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${ userPi.currentPage ne userPi.maxPage }">
																	<c:url value="myPageSelectLikeUser.do" var="after">
																		<c:param name="currentPage" value="${ userPi.currentPage+1 }"/>
																		<c:param name="tab" value="tab4"/>
																		<c:param name="id" value="${loginUser.id}"/>
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
												</c:if>
												<!-------------------------- 페이징바 끝 -------------------------->
												
													<c:if test="${ UserlistCount eq 0 }">
													<div style="text-align: center;">
														<h3> 좋아요 한 유저가 없습니다.</h3>
														<br>
													</div>
												</c:if>
											</div>
										</div>
										<!---------------------- 라이크_유저 끝 --------------------->
										
										<!-------------------------- 문의 시작 --------------------->
										<c:if test="${ empty inquiry  }">
											<div id="tab5" class="tabcontent"><br>
												<div style="text-align: center;">
													<h3> 문의한 내용이 없습니다.</h3>
													<br>
												</div>
											</div>
										</c:if>
										
										<c:if test="${ not empty inquiry }">
										<div id="tab5" class="tabcontent"><br>
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
																	<a class="page-link disabled" aria-label="Previous" >
																		<span aria-hidden="true" style="color:white;">&lt;
																			<!-- <i class="ti-angle-left"></i> -->
																		</span>
																	</a>
																</li>
															</c:if>
															<c:if test="${ inquiryPi.currentPage ne 1 }">
																<c:url value="myPageSelectQuestion.do" var="before">
																	<c:param name="currentPage" value="${ inquiryPi.currentPage-1 }"/>
																	<c:param name="tab" value="tab5"/>
																	<c:param name="id" value="${loginUser.id}"/>
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
															<c:forEach begin="${ inquiryPi.startPage }" end="${ inquiryPi.endPage }" var="p">
																<c:if test="${ p eq inquiryPi.currentPage }">
																	<li class="page-item disabled"><a class="page-link" >${p}</a></li>
																</c:if>
															
																<c:if test="${ p ne inquiryPi.currentPage }">
																	<c:url value="myPageSelectQuestion.do" var="page">
																		<c:param name="currentPage" value="${ p }"/>
																		<c:param name="tab" value="tab5"/>
																		<c:param name="id" value="${loginUser.id}"/>
																	</c:url>
																	<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																</c:if>
															</c:forEach>
															<!-- --------------- -->
															<!------- [다음] ------->
															<c:if test="${ inquiryPi.currentPage eq pi.maxPage }">
																<li class="page-item">
																	<a class="page-link disabled" aria-label="Next" >
																		<span aria-hidden="true" style="color:white;"> &gt;
																			<!-- <i class="ti-angle-right"></i> -->
																		</span>
																	</a>
																</li>
															</c:if>
															<c:if test="${ inquiryPi.currentPage ne inquiryPi.maxPage }">
																<c:url value="myPageSelectQuestion.do" var="after">
																	<c:param name="currentPage" value="${ inquiryPi.currentPage+1 }"/>
																	<c:param name="tab" value="tab5"/>
																	<c:param name="id" value="${loginUser.id}"/>
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
												<!-------------------------- 페이징바 끝 -------------------------->
										</div>
										</c:if>	
										<!-------------------------- 문의 끝 ----------------------->
									</div>
								</div>
								<!-------------------------- 탭 메뉴 끝 ------------------------>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
  
	<!-- 정보수정 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원정보 수정</h5>3.
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="updateMember.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${ loginUser.id }">
						<input type="hidden" name="pwd" value="${ loginUser.pwd }">
						<input type="hidden" name="enrollDate" value="${ loginUser.enrollDate }">
						<input type="hidden" name="modifyDate" value="${ loginUser.modifyDate }">
						<input type="hidden" name="googleId" value="${ loginUser.googleId}">
						<input type="hidden" name="kakaoId" value="${ loginUser.kakaoId }">
						<input type="hidden" name="autho" value="${ loginUser.autho }">
						<input type="hidden" name="image" value="${ loginUser.image }">
						<input type="hidden" name="updatePwd" value="">
						<div class="form-group">
							<label for="userId">Email address</label>
							<input type="email" class="form-control" id="userId" name="email" value="${ loginUser.email }" readonly>
						</div>
						<div class="form-group">
							<label for="userNickName">NickName</label>
							<input type="text" class="form-control" id="userNickName" name="nickName" value="${ loginUser.nickName }">
							<span class="nickguide nickok">사용가능</span>
							<span class="nickguide nickno">사용불가</span>
							<input type="hidden" id="nickCheck" value="0"><br>
						</div>
						
						<div class="form-group">
							<label for="userId">Profile</label><br>
							* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
						<img id="preview" src="resources/memberProfileImage/${ loginUser.image }" width="70px" height="70px"><br>
						<button type="button" id="uploadBtn">이미지 변경</button>
						<button type="button" onclick="fileReset();">이미지 삭제</button><br>
						<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return validate();">Update</button>
						<!-- <button type="button" onclick="location.href='myPage.do';">Cancel</button> -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 비밀번호 변경 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="updatePwdModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="updateMember.do" method="post">
						<input type="hidden" name="id" value="${ loginUser.id }">
						<input type="hidden" name="pwd" value="${ loginUser.pwd }">
						<input type="hidden" name="image" value="${ loginUser.image }">
						<input type="hidden" name="nickName" value="${ loginUser.nickName }">
						<input type="hidden" name="enrollDate" value="${ loginUser.enrollDate }">
						<input type="hidden" name="modifyDate" value="${ loginUser.modifyDate }">
						<input type="hidden" name="googleId" value="${ loginUser.googleId}">
						<input type="hidden" name="kakaoId" value="${ loginUser.kakaoId }">
						<input type="hidden" name="autho" value="${ loginUser.autho }">
						<div class="form-group">
							<label for="userId">Email address</label>
							<input type="email" class="form-control" id="userId" name="email" value="${ loginUser.email }" readonly>
						</div>
						<div class="form-group">
							<label for="originPwd">변경 전 비밀번호</label>
							<input type="password" class="form-control" id="originPwd" name="originPwd">
							<span class="originguide oriok">일치</span>
							<span class="originguide orino">불일치</span>
							<input type="hidden" id="originPwdCheck" value="0"><br>
							<label for="updatePwd">변경 후 비밀번호</label>
							<input type="password" class="form-control" id="updatePwd" name="updatePwd">
							<label for="updatePwd2">변경 후 비밀번호 확인</label>
							<input type="password" class="form-control" id="updatePwd2">
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return pwdValidate();">Update</button>
						<!-- <button type="button" onclick="location.href='myPage.do';">Cancel</button> -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 문의하기 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="questionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">문의하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="insertQuestion.do" method="post">
						<input type="hidden" name="userId" value="${ loginUser.id }">
						<div class="form-group">
							<label for="qucontent">문의내용</label>
							<textarea class="form-control" id="qucontent" name="content" rows="5" cols="50"  style="resize: none"></textarea>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return quValidate();">Question</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<%-- <!-- 문의하기_답변보기 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="answerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">답변보기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="insertQuestion.do" method="post">
						<input type="hidden" name="userId" value="${ loginUser.id }">
						<div class="form-group">
							<label for="qucontent">문의내용</label>
							<textarea class="form-control" id="qucontent" name="content" rows="5" cols="50"  style="resize: none"></textarea>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div> --%>

	</c:if>

	<script>
	
		$(function() {
			var likeUser = $(".likeInp").val();
			console.log("처음인풋 : " + likeUser);
			
			$(".likeBtn").on("click", function(){
				var targetId = $(".targetInp").val();
				var userId = "${loginUser.id}";
				var likeInp = $(".likeInp").val();
				var status = "";
				
				console.log("버튼클릭시 라이크인풋: " + likeInp);
				console.log("버튼클릭시 타켓인풋 : " + targetId);
				
				if(likeInp == '0'){
					status = "like";
				}else if(likeInp == '1'){
					status = "nonlike";
				}
				console.log(status);
				$.ajax({
						url:"likeClick.do",
						data:{userId:userId,
							  targetId:targetId,
							  status:status},
						type:"post",
						success:function(data){
							console.log(data);
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
							console.log("에이작스 후 : " + likeInp);
								
						},error:function(){
							console.log("라이크 ajax 통신 실패");
						}
					});  
			});
		});
		// 탭메뉴 관련 
		$(function() {
				//console.log("${tab}");
				/* $('ul.tab li').click(function() {
					var activeTab = $(this).attr('data-tab');
					$('ul.tab li').removeClass('current');
					$('.tabcontent').removeClass('current');
					$(this).addClass('current');
					$('#' + activeTab).addClass('current');
				})
			 */
			$("#container ul>li").on("click", function(){
				var activeTab = $(this).attr('data-tab');
	            var tabMenu = $(this).text();
	            var strId = "${loginUser.id}";
	            
	            console.log(activeTab);
	            console.log(tabMenu);
	            
	            if(tabMenu == "Review"){
	                location.href="myPageSelectReview.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu =="Like_Film"){
	            	  location.href="myPageSelectLikeFilm.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu == "Like_Review"){
	            	  location.href="myPageSelectLikeReview.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu == "Like_User"){
	            	  location.href="myPageSelectLikeUser.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu == "Question"){
	            	  location.href="myPageSelectQuestion.do?id=${loginUser.id}&tab="+ activeTab;
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
		
		/* // 문의하기 답변보기 모달 창
		$(function(){
			$("#answerBtn").on("click", function(){
				var tr = $(this);
		        var td = tr.parent().parent();

		        alert("클릭한 Row의 모든 데이터 : " + td.eq(2).text());

				
				$('#answerModal').modal('toggle');
			});
		}); */

		// 회원정보 수정, 비밀번호 변경 시 알럴트창
		$(function(){
			if("${msg.equals('')}"){
				alert("${msg}");
			}
		});
		
		// 회원정보 수정 모달창
		$(function(){
			$("#update-modal").on("click", function(){
				$('#updateModal').modal('toggle');
			});
		});
		
		// 회원정보 업데이트 버튼 클릭 시 
		function validate(){
			// 미입력
			if($("#userNickName").val().length == 0){	
				alert("닉네임을 입력해주세요.")
				$("#userNickName").focus();
				return false;
			}else{	
				return true;
			}
		}
		
		// 닉네임 중복 체크
		$(function(){
			$("#userNickName").on("keyup", function(){
				var nickName = $("#userNickName").val();
				
				if(nickName.length < 1){
					$(".nickguide").hide();
					$("#nickCheck").val(0);
					return;
				}
			
				$.ajax({
					url:"nickCheck.do",
					data:{nick:nickName},
					type:"post",
					success:function(data){
						//console.log(data);
						if(data == "success"){
							$(".nickno").hide();
							$(".nickok").show();
							$("#nickCheck").val(1);
						}else{
							$(".nickok").hide();
							$(".nickno").show();
							$("#nickCheck").val(0);
						}
					},error:function(){
						console.log("닉네임 ajax 통신 실패");
					}
				});
			});
		});
		
		// 비밀번호 변경 모달창
		$(function(){
			$("#updatePwd-modal").on("click", function(){
				$('#updatePwdModal').modal('toggle');
			});
		});
		
		// 변경 전 비밀번호 일치 여부
		$(function(){
			$("#originPwd").on("keyup", function(){
				var originPwd = $("#originPwd").val();
				var email = "${loginUser.email}";
				var pwd = "{loginUser.pwd}";
				
				console.log(originPwd);
				console.log(email);
				
				if(originPwd.length < 1){
					$(".originguide").hide();
					$("#originPwdCheck").val(0);
					return;
				}
			
				$.ajax({
					url:"originPwdCheck.do",
					data:{originPwd:originPwd,
							email:email,
							pwd:pwd},
					type:"post",
					success:function(data){
						console.log(data);
						if(data == "success"){
							$(".orino").hide();
							$(".oriok").show();
							$("#originPwdCheck").val(1);
						}else{
							$(".oriok").hide();
							$(".orino").show();
							$("#originPwdCheck").val(0);
						}
					},error:function(){
						console.log("비밀번호 변경전 ajax 통신 실패");
					}
				});
			});
		});
		
		// 비밀번호 변경 버튼 클릭 시 변경 후 비밀번호 일치 여부		
		function pwdValidate(){
			// 미입력
			if($("#updatePwd").val().length == 0 || $("#updatePwd2").val().length == 0 || $("#originPwdCheck").val().length == 0){	
				alert("비밀번호를 입력해주세요.")
				$("#userNickName").focus();
				return false;
				
			}else if($("#updatePwd").val() != $("#updatePwd2").val()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#updatePwd").val("");
				$("#updatePwd2").val("");
				$("#updatePwd").focus();
				return false;
				
			}else if($("#originPwdCheck").val() == 0){
				alert("변경 전 비밀번호가 일치하지 않습니다.");
				$("#originPwd").val("");
				$("#originPwd").focus();
				return false;
				
			}else{
				return true;
			}
		}
		
		
		// 문의하기 모달창
		$(function(){
			$("#question-modal").on("click", function(){
				$('#questionModal').modal('toggle');
			});
		});
		
		// 문의하기 버튼 클릭 시		
		function quValidate(){
			// 미입력
			if(!$.trim($("#qucontent").val())){	
				alert("문의 내용을 입력해주세요");
				$("#qucontent").focus();
				return false;
			} else{
				alert("문의 등록 완료");
				return true;
			}
		}
		
		// 이미지 삭제 버튼 클릭 시
		function fileReset(){
			$("#imgArea input").remove();
			$("#preview").attr('src','resources/memberProfileImage/podoImage.png');
			var newInput = "<input type='file' id='imgInp' name='uploadFile'>";
			$("#imgArea").append(newInput);
		}
		
		// 이미지 미리보기
	    function readURL(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                $('#preview').attr('src', e.target.result);
	            }
	            reader.readAsDataURL(input.files[0]);
	        }
	    };
	    
		// 이미지 변경 될 때 마다 이미지 미리보기 함수 실행
	    $(document).on("change","#imgInp", function() {
	        readURL(this);
	    });
		
		// 이미지 버튼 클릭 시 인풋창 열리게 (안보이게 해둠)
		$("#uploadBtn").on('click', function(e){
			e.preventDefault();
			$("#imgInp").click();
		});
	</script>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>