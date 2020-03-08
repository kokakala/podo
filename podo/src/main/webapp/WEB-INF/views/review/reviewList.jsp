<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
	<body>
    <!--================Hero Banner start =================-->
		<section class="mb-30px">
			<div class="container">
				<div class="review-page-banner">
					<br>
					<span class="title"><spring:message code="label.banner.review"/></span>
				</div>
			</div>
		</section>
    <!--================Hero Banner end =================-->
		
    <!--================ Advertisement start =================-->
    <c:if test="${ (empty loginUser) or (loginUser.premium eq 'N')}">
	    <div class="container" style="background-color: black; background-clip: content-box; margin-bottom: 30px;">
	    	<div class="podo-ad-banner" onclick="location.href='premium.do'">
	    		<div>
		      	<spring:message code="placeholder.advertisement" />
	    		</div>
	    	</div>
	    </div>
    </c:if>
    <!--================Advertisement end =================-->
		<div class="container my-5">
		
			<c:forEach items="${ list }" var="review">
				<div class="row my-4 review-list-card">
				
					<div class="podo-film-card col-md-4">
						<div class="poster" onclick="location.href='detailFilm.do?filmId=${ review.filmId }'">
							<img class="card-img rounded-0" src="resources/detailFilmImage/${ review.posterImage }" id="posterImage">
						</div>
					</div>
					
					<div class="col-md-8">
						<div>${review.titleKor }</div>
						<p><small>${ review.name }</small></p>
						
						<c:if test="${ review.spoilerCheck eq 'Y' }">
							<div class="df-r-spoContent">
								<div class="review-spoiler-check">해당 내용은 스포일러를 포함하고 있습니다.</div>
							</div>
						</c:if>
						<c:if test="${ review.spoilerCheck eq 'N' }">
							<div class="review-content">${ review.content }</div>
						</c:if>
						
						<div class="d-flex justify-content-between py-2">
							${ review.nickName }
							<small>${ review.createDate }</small>
						</div>
						<div class="d-flex justify-content-end">
							<button class="button" onclick="location.href='reviewDetail.do?id=${ review.id }';"><spring:message code="button.more"/></button>
						</div>
					</div>
					
				</div>
<!-- 				<div class="d-block p-2 bg-dark"></div> -->
			</c:forEach>
			
			<!-- Pagination -->
			<div class="row py-4">
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
			
		</div> <!-- container end -->
	
		<script>
			$(function() {
				$(".nav").children("li").eq(1).addClass("active");
			});
			
			/* 
			$(document).on("click", ".df-r-spoContent", function() {
				if (confirm("정말 확인하시겠습니까??") == true) {
					$(this).children(".df-r-spoilerCheck").css("display", "none");
					$(this).children(".df-r-content").css("display", "block");
				} else {
					return;
				}
			});
			 */
		</script>
		
	 	<jsp:include page="../common/footer.jsp"/> 
	</body>
</html>