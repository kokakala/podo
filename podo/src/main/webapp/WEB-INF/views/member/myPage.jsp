<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
<body>
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
				<div class="col-sm-8 d-flex align-items-start flex-column">
					<div class="justify-content-between d-flex">
						<div class="thumb thumbnail">
							<c:if test="${ loginUser.image != null }">
								<img src="resources/memberProfileImage/${ loginUser.image }"  id="userpage-profile-image">
							</c:if>		
							<c:if test="${ loginUser.image == null }">
								<img src="resources/memberProfileImage/podoImage.png"  id="userpage-profile-image">
							</c:if>
							<h2 class="nickname">${ loginUser.nickname }</h2>
							<h6 class="nickname">작성리뷰 - ${reviewListCount}개  </h6>
						</div>
					</div>
				</div>
				<div class="col-sm-4 px-4 align-items-end flex-column">
					<a id="update-modal" class="button" href="#" data-toggle="modal">정보수정</a>
					<a id="updatePwd-modal" class="button" href="#" data-toggle="modal">비밀번호 변경</a>
					<a id="question-modal" class="button" href="#" data-toggle="modal">문의하기</a>
					<a class="button" href="premium.do">프리미엄</a>
				</div>
			</div>
			
			<!------------------------- 탭 메뉴 시작 ----------------------->
			<div class="row">
				<ul class="tab d-flex justify-content-center">
						<li class="t tab1 current" data-tab="tab1" ><a>리뷰</a></li>
						<li class="t tab2" data-tab="tab2" ><a>좋아한 영화</a></li>
						<li class="t tab3" data-tab="tab3"><a>좋아한 리뷰</a></li>
						<li class="t tab4" data-tab="tab4"><a>좋아한 회원</a></li>
						<li class="t tab5" data-tab="tab5"><a>문의</a></li>
				</ul>
			</div>
			
				<div id="container">
						<!-- -------------------- Review --------------------------->
						<div id="tab1" class="tabcontent current">
							<c:if test="${ !empty review }">
							<!-------------------------- Review Tab Menu Body------------------------>
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
															<!------ [prev] ------>
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
															<!------ [page] ----->
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
															<!------- [next] ------->
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
											<!-------------------------- pagination end -------------------------->
								</div>
							</section>
							</c:if>
							<c:if test="${ empty review }">
								<div class="my-5">
									<h3> 작성한 리뷰가 없습니다.</h3>
								</div>
							</c:if>
						</div>
						<!-- -------------------- review end -------------------------->
					
						<!-- -------------------- like-film ----------------------->
						<div id="tab2" class="tabcontent">
							<div class="container">
								<c:if test="${ !empty likeFilmList }">
									<div class="row">
										<c:forEach items="${ likeFilmList }" var="likeFilm" >
											<!-- width * 1.425 -->
											<div class="podo-film-card col-md-4">
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
                             	<input type="hidden" class="likeFlag" value="0"/>
                             	<input type="hidden" class="targetType" value="1"/>
                             	<input type="hidden" class="targetId" value="${ likeFilm.targetId }"/>
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
									<div class="my-5">
										<h3> 좋아한 영화가 없습니다.</h3>
									</div>
								</c:if>
							</div>
						</div>
						<!-- -------------------- like-film end--------------------->
						
						<!--------------------- like-review start --------------------->
						<div id="tab3" class="tabcontent">
							<c:if test="${ !empty likeReviewList }">
								<section class="blog-post-area section-margin mt-4">
									<div class="container">
										<c:forEach items="${ likeReviewList }" var="list" >
											<div class="row">
												<div class="col-md-4 single-recent-blog-post">
													<div class="thumb podo-film-card">
														<div class="poster" onclick="location.href='reviewDetail.do?id=${ list.targetId }';">										
															<img class='img-fluid' src='resources/detailFilmImage/${ list.changeName }'>
														</div>
													</div>
												</div>
												<div class="col-md-8">
													<button class='btn btn-danger likeBtn'>LIKED</button>
                            	<input type="hidden" class="likeFlag" value="0"/>
                             	<input type="hidden" class="targetType" value="3"/>
                            	<input type="hidden" class="targetId" value="${ list.targetId }"/><br><br>
													<a href="reviewDetail.do?id=${ list.targetId }">${list.titleKor}<br></a>
													<p>${ list.content }</p>
												</div>
											</div>
										</c:forEach>
												<!-------------------------- like-review pagination ------------------------>
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
								</section>
							</c:if>
							<c:if test="${ empty likeReviewList }">
								<div class="my-5">
									<h3> 좋아한 리뷰가 없습니다.</h3>
								</div>
							</c:if>
						</div>
						</div>
						<!--------------------- 라이크_리뷰 끝 ---------------------->
						
		   	    <!--------------------- 라이크_유저 시작 --------------------->
						<div id="tab4" class="tabcontent">
							<div class="container">
								<c:if test="${ !empty likeUserList }">
									<div class="row">
										<c:forEach items="${ likeUserList }" var="likeUserList">
											<!-- width * 1.425 -->
											<div class="podo-film-card col-3">
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
                             	<input type="hidden" class="likeFlag" value="0"/>
                             	<input type="hidden" class="targetType" value="2"/>
                             	<input type="hidden" class="targetId" value="${ likeUserList.targetId }"/>
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
									<div class="my-5">
										<h3>좋아요 한 회원이 없습니다.</h3>
									</div>
								</c:if>
							</div>
						</div>
						<!---------------------- 라이크_유저 끝 --------------------->
						
						<!-------------------------- 문의 시작 --------------------->
						<div id="tab5" class="tabcontent">
							<div class="container">
							<c:if test="${ empty inquiry  }">
								<div class="my-5">
									<h3>문의한 내용이 없습니다.</h3>
								</div>
								<div class="d-flex justify-content-center">
									<button class="button" onclick="bye();">회원탈퇴</button>
								</div>
							</c:if>
						
							<c:if test="${ not empty inquiry }">
								<table class="table table-striped table-dark">
									<tr>
										<th>#</th>
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
									</table>
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
															<c:param name="tab" value="myPageSelectQuestion.do"/>
															<c:param name="id" value="${loginUser.id}"/>
														</c:url>
														<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
													</c:if>
												</c:forEach>
												<!-- --------------- -->
												<!------- [다음] ------->
												<c:if test="${ inquiryPi.currentPage eq inquiryPi.maxPage }">
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
								<button class="button" onclick="bye();">회원탈퇴</button>
							</c:if>
						</div>
						<!-------------------------- 문의 끝 ----------------------->
					</div>
					<!-------------------------- 탭 메뉴 끝 ------------------------>
				</section>
  
	<!-- 정보수정 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원정보 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="updateMember.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${ loginUser.id }">
						<input type="hidden" name="password" value="${ loginUser.password }">
						<input type="hidden" name="enrollDate" value="${ loginUser.enrollDate }">
						<input type="hidden" name="modifyDate" value="${ loginUser.modifyDate }">
						<input type="hidden" name="googleId" value="${ loginUser.googleId}">
						<input type="hidden" name="kakaoId" value="${ loginUser.kakaoId }">
						<input type="hidden" name="autho" value="${ loginUser.autho }">
						<input type="hidden" name="image" value="${ loginUser.image }">
						<input type="hidden" name="newPassord" value="">
						<div class="form-group">
							<label for="userId">Email address</label>
							<input type="email" class="form-control" id="userId" name="email" value="${ loginUser.email }" readonly>
						</div>
						<div class="form-group">
							<label for="userNickname">Nickname</label>
							<input type="text" class="form-control" id="userNickname" name="Nickname" value="${ loginUser.nickname }">
							<span class="nickguide nickok">사용가능</span>
							<span class="nickguide nickno">사용불가</span>
							<input type="hidden" id="nickCheck" value="0"><br>
						</div>
						
						<div class="form-group">
							<label for="userId">Profile</label><br>
							* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
						<c:if test="${loginUser.image != null }">
							<img id="preview" src="resources/memberProfileImage/${ loginUser.image }" width="70px" height="70px"><br>
						</c:if>
						<c:if test="${loginUser.image == null }">
							<img id="preview" src="resources/memberProfileImage/podoImage.png" width="70px" height="70px"><br>
						</c:if>
						<button type="button" id="uploadBtn">이미지 변경</button>
						<button type="button" onclick="fileReset();">이미지 삭제</button><br>
						<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return validate();">Update</button>
						<!-- <button type="button" onclick="location.href='mypage.do';">Cancel</button> -->
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
						<input type="hidden" name="password" value="${ loginUser.password }">
						<input type="hidden" name="image" value="${ loginUser.image }">
						<input type="hidden" name="nickname" value="${ loginUser.nickname }">
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
							<label for="newPassword">변경 후 비밀번호</label>
							<input type="password" class="form-control" id="newPassword" name="newPassword">
							<label for="newPassword2">변경 후 비밀번호 확인</label>
							<input type="password" class="form-control" id="newPassword2">
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return pwdValidate();">Update</button>
						<!-- <button type="button" onclick="location.href='mypage.do';">Cancel</button> -->
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
		
		$(function(){
			$(".nav").children("li").eq(5).addClass("active");
		});
		
		
		function bye(){
			// console.log("test");
			if (confirm("정말 탈퇴하시겠습니까?") == true) {    //확인
		    location.href="exit.do?id=${loginUser.id}";
			} else {   //취소
		    return;
			}
		}
	
		$(function() {
			var likeUser = $(".likeInp").val();
			
			$(".likeBtn").on("click", function(){
				var $this = $(this);
				console.log($this);
				
				var userId = "${loginUser.id}";
				var targetType = $this.parent().find(".targetType").val();
				var targetId = $this.parent().find(".targetId").val();
				var flag = $this.parent().find(".likeFlag").val();
				console.log(targetType);
				console.log(targetId);
				console.log(flag);
				
				var likeUrl = "";
				switch (targetType) {
				case "1":
					likeUrl = "likeFilm.do"; break;
				case "2":
					likeUrl = "likeMember.do"; break;
				case "3":
					likeUrl = "likeReview.do"; break;
				}
				
				$.ajax({
					url: likeUrl,
					data: {
						userId: userId,
					  targetId: targetId,
					  flag: flag
				  },
					type: "post",
					success: function(data){
						// console.log(data);
						if (data != 1) {
							alert("좋아요 실패");
						} else {
							if (flag == "1"){ // 좋아요
								$this.removeClass("btn-secondary");
								$this.addClass("btn-danger");
								$this.text('LIKED');
								$this.parent().find(".likeFlag").val('0');
							} else if (flag == "0") { // 좋아요 취소
								$this.removeClass("btn-danger");
								$this.addClass("btn-secondary");
								$this.text('LIKE');
								$this.parent().find(".likeFlag").val('1');
							}
						}
					},
					error: function(){
						console.error('ajax error');
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
			$(".container ul>li").on("click", function(){
				var activeTab = $(this).attr('data-tab');
				var tabMenu = $(this).text();
				var strId = "${loginUser.id}";

				// console.log(activeTab);
				// console.log(tabMenu);

				if (tabMenu == "리뷰") {
					location.href = "myPageSelectReview.do?id=${loginUser.id}&tab=" + activeTab;
				} else if (tabMenu == "좋아한 영화") {
					location.href = "myPageSelectLikeFilm.do?id=${loginUser.id}&tab=" + activeTab;
				} else if (tabMenu == "좋아한 리뷰") {
					location.href = "myPageSelectLikeReview.do?id=${loginUser.id}&tab=" + activeTab;
				} else if (tabMenu == "좋아한 회원") {
					location.href = "myPageSelectLikeUser.do?id=${loginUser.id}&tab=" + activeTab;
				} else if (tabMenu == "문의") {
					location.href = "myPageSelectQuestion.do?id=${loginUser.id}&tab=" + activeTab;
				}
			});
			
			if ('${param.tab}' != '') {
				// console.log('active tab');
				var tab = '${param.tab}';
				// tab
				$('ul.tab li').removeClass('current');
				$("." + tab).addClass('current');
				// content
				$('.tabcontent').removeClass('current');
				$("#" + tab).addClass('current');
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
		$(function() {
			if ("${msg.equals('')}") {
				alert("${msg}");
			}
		});

		// 회원정보 수정 모달창
		$(function() {
			$("#update-modal").on("click", function() {
				$('#updateModal').modal('toggle');
			});
		});

		// 회원정보 업데이트 버튼 클릭 시 
		function validate() {
			// 미입력
			if ($("#userNickname").val().length == 0) {
				alert("닉네임을 입력해주세요.")
				$("#userNickname").focus();
				return false;
			} else {
				return true;
			}
		}

		// 닉네임 중복 체크
		$(function() {
			$("#userNickname").on("keyup", function() {
				var Nickname = $("#userNickname").val();

				if (Nickname.length < 1) {
					$(".nickguide").hide();
					$("#nickCheck").val(0);
					return;
				}

				$.ajax({
					url : "nickCheck.do",
					data : {
						nick : Nickname
					},
					type : "post",
					success : function(data) {
						//console.log(data);
						if (data == "success") {
							$(".nickno").hide();
							$(".nickok").show();
							$("#nickCheck").val(1);
						} else {
							$(".nickok").hide();
							$(".nickno").show();
							$("#nickCheck").val(0);
						}
					},
					error : function() {
						console.log("ajax error");
					}
				});
			});
		});

		// 비밀번호 변경 모달창
		$(function() {
			$("#updatePwd-modal").on("click", function() {
				$('#updatePwdModal').modal('toggle');
			});
		});

		// 변경 전 비밀번호 일치 여부
		$(function() {
			$("#originPwd").on("keyup", function() {
				var originPwd = $("#originPwd").val();
				var email = "${loginUser.email}";
				var pwd = "{loginUser.pwd}";

				// console.log(originPwd);
				// console.log(email);

				if (originPwd.length < 1) {
					$(".originguide").hide();
					$("#originPwdCheck").val(0);
					return;
				}

				$.ajax({
					url : "originPwdCheck.do",
					data : {
						originPwd : originPwd,
						email : email,
						pwd : pwd
					},
					type : "post",
					success : function(data) {
						// console.log(data);
						if (data == "success") {
							$(".orino").hide();
							$(".oriok").show();
							$("#originPwdCheck").val(1);
						} else {
							$(".oriok").hide();
							$(".orino").show();
							$("#originPwdCheck").val(0);
						}
					},
					error : function() {
						console.log("ajax error");
					}
				});
			});
		});

		// 비밀번호 변경 버튼 클릭 시 변경 후 비밀번호 일치 여부		
		function pwdValidate() {
			// 미입력
			if ($("#newPassword").val().length == 0
					|| $("#newPassword2").val().length == 0
					|| $("#originPwdCheck").val().length == 0) {
				alert("비밀번호를 입력해주세요.")
				$("#userNickname").focus();
				return false;

			} else if ($("#newPassword").val() != $("#newPassword2").val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#newPassword").val("");
				$("#newPassword2").val("");
				$("#newPassword").focus();
				return false;

			} else if ($("#originPwdCheck").val() == 0) {
				alert("변경 전 비밀번호가 일치하지 않습니다.");
				$("#originPwd").val("");
				$("#originPwd").focus();
				return false;

			} else {
				return true;
			}
		}

		// 문의하기 모달창
		$(function() {
			$("#question-modal").on("click", function() {
				$('#questionModal').modal('toggle');
			});
		});

		// 문의하기 버튼 클릭 시		
		function quValidate() {
			// 미입력
			if (!$.trim($("#qucontent").val())) {
				alert("문의 내용을 입력해주세요");
				$("#qucontent").focus();
				return false;
			} else {
				alert("문의 등록 완료");
				return true;
			}
		}

		// 이미지 삭제 버튼 클릭 시
		function fileReset() {
			$("#imgArea input").remove();
			$("#preview").attr('src',
					'resources/memberProfileImage/podoImage.png');
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
		$(document).on("change", "#imgInp", function() {
			readURL(this);
		});

		// 이미지 버튼 클릭 시 인풋창 열리게 (안보이게 해둠)
		$("#uploadBtn").on('click', function(e) {
			e.preventDefault();
			$("#imgInp").click();
		});
	</script>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>