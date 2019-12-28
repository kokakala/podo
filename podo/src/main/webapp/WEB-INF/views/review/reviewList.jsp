<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			
			.pTitle {
				font-size: 20px;
				font-weight: bold;
			}

			#mide {
				text-align: center;
				font-weight: lighter;
			}
			
			#reviewContentFont {
				margin-top: 20px;
				text-overflow: ellipsis;
				overflow: hidden;
			}
			
			.df_r_content {
				display: none;
			}
			
			.df_r_spoContent {
				cursor: pointer;
			}
			
			.df_r_spoilerCheck {
				color: red;
				cursor: pointer;
			}
			
		</style>
	</head>
<body>

	<div class="container my-5">
	
		<c:forEach items="${ list }" var="review">
			<div class="row my-2">
			
				<div class="col-3">
					<div class="poster" onclick="location.href='detailFilm.do?filmId=${ review.filmId }'">
						<img class="card-img rounded-0" src="resources/detailFilmImage/${ review.posterImage }" id="posterImage">
					</div>
				</div>
				
				<div class="col-9">
					
					<div>
						<p class="pTitle">${review.titleKor }</p>
					</div>
					
					<div>
						<small>${ review.name }</small>
					</div>
					
					<c:if test="${ review.spoilerCheck eq 'Y' }">
						<div class="df_r_spoContent">
							<div class="df_r_spoilerCheck">해당 내용은 스포일러를 포함하고 있습니다.</div>
							<div class="df_r_content" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">${ review.content }</div>
						</div>
						<div>
							<small>${review.nickName }</small>
						</div>
						<div>
							<small>${review.createDate }</small>
						</div>
						<button class="btn btn-secondary" onclick="location.href='ratingDetailReview.do?id=${review.id}';">더보기</button>
					</c:if>
					
					<c:if test="${ review.spoilerCheck eq 'N' }">
						<div style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">${ review.content }</div>
						<div>
							<small>${review.nickName }</small>
						</div>
						<div>
							<small>${review.createDate }</small>
						</div>
						<button class="btn btn-secondary" onclick="location.href='ratingDetailReview.do?id=${review.id}';">더보기</button>
					</c:if>
				</div>
				
			</div>
		</c:forEach>
		
	</div>

	
	
	
	<!-- Pagination -->
	<div class="row my-3">
		<div class="col-lg-12">
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination">

					<!-- [PREV] -->
					<c:if test="${ pi.currentPage eq 1 }">
						<li class="page-item disabled">
					</c:if>
					<c:if test="${ pi.currentPage ne 1 }">
						<li class="page-item">
					</c:if>
						<c:url value="reviewList.do" var="before">
							<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
						</c:url>
						<a href=<c:out value="${ before }"/> class="page-link" aria-label="Previous">
							&lt;
						</a>
					</li>
					
					<!-- [각 페이지] -->
					<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					
						<c:if test="${ p eq pi.currentPage }">
							<li class="page-item disabled"><a href="#" class="page-link">${ p }</a></li>
						</c:if>
						
						<c:if test="${ p ne pi.currentPage }">
							<c:url value="reviewList.do" var="page">
								<c:param name="currentPage" value="${ p }"/>
							</c:url>
							<li class="page-item"><a href="<c:out value='${ page }'/>" class="page-link">${ p }</a></li>
						</c:if>
						
					</c:forEach>

					<!-- [NEXT] -->
					<c:if test="${ pi.currentPage eq pi.maxPage }">
						<li class="page-item disabled">
					</c:if>
					<c:if test="${ pi.currentPage ne pi.maxPage }">
						<li class="page-item">
					</c:if>
						<c:url value="reviewList.do" var="after">
							<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
						</c:url>
						<a href=<c:out value="${ after }&p=${ pi.currentPage + 1 }"/> class="page-link" aria-label="Next">
							&gt;
						</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
	
	<script>

	$(function(){
		$(".nav").children("li").eq(1).addClass("active");
	});
	
	$(document).ready(function(){
		$(".df_r_spoContent").on("click",function(){
			  if (confirm("정말 확인하시겠습니까??") == true){    //확인
					$(this).children(".df_r_spoilerCheck").css("display","none");
		        	$(this).children(".df_r_content").css("display","block");
			  }else{   //취소
			      return;
			  }
		});
	});
	</script>
	
	
 	<jsp:include page="../common/footer.jsp"/> 
</body>
</html>