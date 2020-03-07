<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp" />
		<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	</head>
	<body>
		<section class="blog-post-area section-margin">
			<div class="container">
			
				<div class="movie_poster_cover d-flex justify-content-center">
					<c:if test="${ not empty f.poster }">
						<img id="poster" class="img-fluid rounded img-thumbnail" src="resources/detailFilmImage/${ f.poster }" alt="poster">
					</c:if>
					<c:if test="${ empty f.poster }">
						<img id="poster" class="img-fluid rounded img-thumbnail" src="resources/detailFilmImage/podoposter.jpg" alt="poster">
					</c:if>
				</div>
				
				<h2 class="lead py-3 text-center">${ f.titleKor }</h2>
				
				<%-- 
				<div class="row">
					<div class="chart-box">
						<canvas id="myChart"></canvas>
					</div>
				</div>
				--%>
				
				<div class="container">
					<form action="reviewWrite.do" method="post">
						<input type="hidden" value="${f.id}" name="filmId">
						<input type="hidden" value="${loginUser.id}" name="memberId">
						
						<div class="d-flex justify-content-between">
							<div class="thumbnail py-3">
								<c:if test="${ not empty loginUser.image }">
									<img src="resources/memberProfileImage/${ loginUser.image }" alt="profile">
								</c:if>
								<c:if test="${ empty loginUser.image }">
									<img src="resources/memberProfileImage/podoImage.png" alt="profile">
								</c:if>
							</div>
							
							<div class="pt-5">
								<input type="checkbox" value="0" name="spoilerCheck" id="spoilerCheck">
								<label for="spoilerCheck">스포일러 유무</label><br>
							</div>
						</div>
						
						<div class="comment-form">
							<label for="ratingSound">음악</label>
							<input type="number" name="ratingSound" class="form-control insertRating" id="ratingSound" placeholder="10점까지 입력가능" min="0" max="10" required>
							
							<label for="ratingSound">영상</label>
							<input type="number" name="ratingVisual" class="form-control insertRating" id="ratingVisual" placeholder="10점까지 입력가능" min="0" max="10" required>
							
							<label for="ratingSound">연기</label>
							<input type="number" name="ratingActing" class="form-control insertRating" id="ratingActing" placeholder="10점까지 입력가능" min="0" max="10" required>
							
							<label for="ratingSound">대중성</label>
							<input type="number" name="ratingPop" class="form-control insertRating" id="ratingPop" placeholder="10점까지 입력가능" min="0" max="10" required>
							
							<label for="ratingSound">각본</label>
							<input type="number" name="ratingScript" class="form-control insertRating" id="ratingScript" placeholder="10점까지 입력가능" min="0" max="10" required>
							
							<label for="ratingSound">연출</label>
							<input type="number" name="ratingDirect" class="form-control insertRating" id="ratingDirect" placeholder="10점까지 입력가능" min="0" max="10" required>
						</div>
						
						<div class="comment-form">
							<label for="reviewContent">내용</label>
							<textarea id="reviewContent" class="form-control" name="content"></textarea>
						</div>
						
						<div class="btn-group d-flex justify-content-center">
							<button class="button" type="submit" id="ok1">리뷰 등록</button>
							<button class="button" type="button" onclick="location.href='reviewList.do';">목록으로</button>
						</div>
						
					</form>
				</div>
				
			</div>
		</section>
			
	</body>
</html>