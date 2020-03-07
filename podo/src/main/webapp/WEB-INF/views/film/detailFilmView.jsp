<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp" />
	</head>
	<body>
		<div class="container">
		
			<div class="row">
				<div class="movie-poster-cover col-lg-4">
					<div class="movie-poster">
						<c:if test="${i.changeName ne null}">
							<img class="poster" src="resources/detailFilmImage/${i.changeName}">
						</c:if>
						<c:if test="${i.changeName eq null}">
							<img class="poster" src="resources/detailFilmImage/podoposter.jpg">
						</c:if>
					</div>
				</div>
				<div class="video-background col-lg-8">
					<div class="video-foreground">
						<c:if test="${df.trailer ne null}">
							<div id="muteYouTubeVideoPlayer"></div>
						</c:if>
						<c:if test="${df.trailer eq null}">
							<div>영화 정보를 수정해서 트레일러를 입력해주세요!</div>
						</c:if>
					</div>
				</div>
			</div>
			
			
			<!-- film info start -->
			<div class="detail-film-info">
				<h1 class="col">${ df.titleKor }(${ df.titleEng })</h1>
				
				<div class="col">
					<div>감독&nbsp;<span class="info-data">${ df.director }</span></div>
				</div>
				
				<div class="col">배우&nbsp;
					<c:forEach items="${ al }" var="a">
						<div class="info-actor">
							<img class="info-actor-img" src="resources/detailFilmImage/actor/${a.profileImage}">
							<span class="info-data">${a.actorName}</span>
						</div>
					</c:forEach>
				</div>
				
				<div class="col mt-3">시놉시스</div>
				<div class="col info-data">${ df.synopsys }</div>
			
				<div class="col mt-3">트리비아</div>
				<div class="col info-data">${ df.trivia }</div>
				
				<div class="col mt-3">마지막 작성자&nbsp;<span class="info-data">${ df.nickName }</span></div>
				
				<c:if test="${ loginUser.autho eq 2 }">
					<div class="col py-3 text-center justify-content-center">
						<a href="detailFilmRollback.do?filmId=${df.filmId}" class="button">되돌리기</a>
					</div>
				</c:if>
				<c:if test="${ loginUser.autho ne 2 }">
					<div class="col py-3 text-center justify-content-center">
						<a href="detailFilmUpdate.do?filmId=${ df.filmId }" class="button">정보 수정</a>
					</div>
				</c:if>
			</div>
			
			<!-- film info end -->
			
<!-- 			<div class="d-block p-2 bg-dark my-4"></div> -->
			<div class="col d-flex justify-content-between mt-5 px-0">
				<div class="pt-4">REVIEW</div>
				<div class="col-auto pb-3 pr-0">
					<button onclick="location.href='reviewWriteForm.do?filmId=${df.filmId}'" class="button">리뷰 작성</button>
				</div>
			</div>
			
			<c:forEach items="${ reviews }" var="review">
				<div class="row review-list-card">
					<div class="col-md-2">
						<div class="thumbnail">
							<a href="userPage.do?userId=${ review.memberId }&loginUserId=${ loginUser.id }">
								<c:if test="${ not empty review.userImage }">
									<img src="resources/memberProfileImage/${ review.userImage }">
								</c:if>
								<c:if test="${ empty review.userImage }">
									<img src="resources/memberProfileImage/podoImage.png">
								</c:if>
							</a>
							<div class="nickNameHome">${ review.nickName }</div>
							<c:forEach begin="1" end="${ review.star }">
								&#x2605;
							</c:forEach>
						</div>
					</div>
					<div class="df-review-container col-md-10">
					
						<c:if test="${ review.spoilerCheck eq 'Y' }">
							<div class="contentKorea df-r-spoContent">
								<div class="review-spoiler-check">해당 내용은 스포일러를 포함하고 있습니다.</div>
							</div>
						</c:if>
						<c:if test="${ review.spoilerCheck eq 'N' }">
							<div class="review-content">${ review.content }</div>
						</c:if>
						<div>${ review.modifyDate }</div>
						
						<div class="btn-group d-flex justify-content-end">
							<div class="col-auto">
								<%-- 
								<c:if test="${ review.like eq loginUser.id }">
									<button class='button btn-liked-film'>좋아요 취소</button>
									<input type="hidden" class="likeInp" value="1" />
								</c:if>
								<c:if test="${ review.like ne loginUser.id }">
									<button class='button btn-like-film'>좋아요</button>
									<input type="hidden" class="likeInp" value="0" />
								</c:if>
								<button class="declaration-modal button" data-toggle="modal">신고</button>
								 --%>
								<c:if test="${ loginUser.id eq review.memberId }">
									<a class="button" href="reviewUpdateForm.do?id=${review.id}">수정하기</a>
								</c:if>
								<c:if test="${ loginUser.id eq review.memberId }">
									<a class="button" href="reviewDelete.do?id=${review.id}">삭제하기</a>
								</c:if>
								<button class="button" onclick="location.href='reviewDetail.do?id=${ review.id }'">더보기</button>
							</div>
						</div>
					
					</div>
					
				</div>
			</c:forEach>
				
		</div>
		
		<script async="true" src="https://www.youtube.com/iframe_api"></script>
		<script type="text/javascript">
			// 예고편 절단
			var trailer = "${df.trailer}";
			var trSplit = trailer.split('=');
			var trailer1 = trSplit[1];
			var player;

			function onYouTubePlayerAPIReady() {
				player = new YT.Player('muteYouTubeVideoPlayer', {
					width: '100%',
					//videoId : 'x60mB0zXZ38',
					videoId : trailer1,
					playerVars : {
						autoplay : 1, // Auto-play the video on load
						controls : 1, // Show pause/play buttons in player
						disablekb: 1,
						rel : 0,

						// start : 0, // seconds
						// end : 20, // seconds

						showinfo : 0, // Hide the video title
						modestbranding : 1, // Hide the Youtube Logo
						loop : 1, // Run the video in a loop
						playlist : trailer1,
						fs : 0, // Hide the full screen button
						cc_load_policy : 0, // Hide closed captions
						iv_load_policy : 3, // Hide the Video Annotations
						autohide : 1 // Hide video controls when playing
					},
					events : {
						onReady : function(e) {
							e.target.mute(); // mute
						}
					}
				});
			}
		</script>
	
		<jsp:include page="../common/footer.jsp" />
	</body>
</html>