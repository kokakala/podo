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
						<div id="muteYouTubeVideoPlayer"></div>
					</div>
				</div>
			</div>
			
			<h1 class="movie-title">${ df.titleKor }(${ df.titleEng })</h1>
			<div class="row">
				<div class="col-md-4">
					<div>감독</div>
					<div>${ df.director }</div>
				</div>
				
				<div class="col-md-8">
					<h5>출연 배우</h5>
					<c:forEach items="${ al }" var="a">
						<div class="image-cover">
							<img src="resources/detailFilmImage/actor/${a.profileImage}" style="border-radius: 50%;">
							<div>${a.actorName}</div>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-2">시놉시스</div>
				<div class="col-md-10 detail-film-synopsys">${ df.synopsys }</div>
			</div>
			
			<div class="row">
				<div class="col-md-2">트리비아</div>
				<div class="col-md-10 detail-film-trivia">${ df.trivia }</div>
			</div>
			
			<div class="row">
				<div class="col-md-2">마지막 작성자</div>
				<div class="col-md-10">
					<h4>${ df.nickName }</h4>
				</div>
			</div>
			
			<c:if test="${ loginUser.autho eq 2 }">
				<div class="row justify-content-center">
					<a href="detailFilmRollback.do?filmId=${df.filmId}" class="button">되돌리기</a>
				</div>
			</c:if>
			<c:if test="${ loginUser.autho ne 2 }">
				<div class="row justify-content-center">
					<a href="detailFilmUpdate.do?filmId=${ df.filmId }" class="button">정보 수정</a>
				</div>
			</c:if>
			
			<div class="d-block p-2 bg-dark my-4"></div>
			<div class="row justify-content-center">
				<div class="col-md-2"><h4>리뷰</h4></div>
				<div class="col-md-10" style="text-align: right;">
					<button onclick="location.href='reviewWriteForm.do?filmId=${df.filmId}'" class="button">작성하기</button>
				</div>
			</div>
			
			<c:forEach items="${ rl }" var="r">
				<div class="row review-list-card">
					<div class="col-md-2">
						<div class="thumbnail">
							<c:if test="${ not empty r.userImage }">
								<img src="resources/memberProfileImage/${ r.userImage }">
							</c:if>
							<c:if test="${ empty r.userImage }">
								<img src="resources/memberProfileImage/podoImage.png">
							</c:if>
							<div class="nickNameHome">${ r.nickName }님</div>
							<div class="starReview">별점 ${ r.star }점</div>
							<div class="countReview">추천수 ${ r.likeCount }</div>
							<div>${ r.titleKor }</div>
						</div>
					</div>
					<div class="df-review-content col-md-10">
					
						<c:if test="${ r.spoilerCheck eq 'Y' }">
							<div class="contentKorea df-r-spoContent">
								<div class="df-r-spoilerCheck">해당 내용은 스포일러를 포함하고 있습니다.</div>
								<div class="df-r-content">${ r.content }</div>
							</div>
						</c:if>
						<c:if test="${ r.spoilerCheck eq 'N' }">
							<div>${ r.content }</div>
						</c:if>
						<div>${ r.modifyDate }</div>
						
						<c:if test="${ loginUser.id eq r.memberId }">
							<a href="reviewUpdateView.do?id=${r.id}">수정하기</a>
						</c:if>
						<c:if test="${ loginUser.id eq r.memberId }">
							<a href="reviewDelete.do?id=${r.id}">삭제하기</a>
						</c:if>
						
						
						<div class="btn-group">
							<c:if test="${ r.like eq loginUser.id }">
								<button class='button btn-liked-film'>LIKED</button>
								<input type="hidden" class="likeInp" value="1" />
							</c:if>
							<c:if test="${ r.like ne loginUser.id }">
								<button class='button btn-like-film'>LIKE</button>
								<input type="hidden" class="likeInp" value="0" />
							</c:if>
							<button class="declaration-modal button" data-toggle="modal">REPORT</button>
							<button class="button" onclick="location.href='reviewDetail.do?id=${ r.id }'">MORE</button>
						</div>
					
					</div>
					
					
				</div>
			</c:forEach>
				
		</div>
		
		<script async src="https://www.youtube.com/iframe_api"></script>
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