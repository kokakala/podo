<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			
			.pTitle{
				font-size: 20px;
				font-weight: bold;
				color: black;
			}
			.blog__slide__img{
				margin-left:auto;
				margin-right:auto;
				width:300px;
				height: 200px;
			}
			#posterImage{
				width: 200px;
				height: 200px;
			}
			#mide{
				text-align: center;
				font-weight: lighter;
			}
		</style>
	</head>
	<body>
		<div id="body">
			<c:forEach items="${ list }" var="review">
				<div class="container">
					<div class="card blog__slide text-center">
						<div class="blog__slide__img">
							<img class="card-img rounded-0"
								src="resources/detailFilmImage/${review.posterImage}" alt=""
								id="posterImage">
						</div>
						<div class="blog__slide__content">
							<p class="pTitle">${review.titleKor }</p>
							<a class="blog__slide__label">${ review.name }</a>
							<h3>
								<a href="ratingDetailReview.do?id=${review.id}">
									<p id="reviewContentFont">${ review.content }</p>
								</a>
							</h3>
							<button onclick="location.href='ratingDetailReview.do?id=${review.id}';">
								더보기
							</button>
							<p></p>
							<button onclick="location.href='reviewDelete.do?id=${review.id}';">삭제하기</button>
							<p>${review.nickName }님이작성</p>
							<p>${review.createDate }에작성됨</p>
						</div>
					</div>
				</div>
			</c:forEach>
			<button onclick="location.href='star.do';">스타 보기</button>
		</div>
		<jsp:include page="../common/footer.jsp"/> 
	</body>
</html>