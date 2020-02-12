<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<title>영화 추천</title>
	</head>
	<body>
		
		<section class="mb-30px">
			<div class="container">
				<div class="rec-page-banner">
					<br>
					<span class="title">영화 추천</span>
					<br>
					<c:if test="${ not empty loginUser }">
						<span class="content">${ loginUser.nickname }님을 위한 포도의 추천 영화</span>
					</c:if>
					<c:if test="${ empty loginUser }">
						<span class="content">로그인 해주세요!</span>
					</c:if>
				</div>
			</div>
		</section>
		
    <!--================ Advertisement start =================-->
    <c:if test="${ (empty loginUser) or (loginUser.premium eq 'N')}">
	    <div class="container" style="background-color: black; background-clip: content-box; margin-bottom: 30px;">
	    	<div class="podo-ad-banner" onclick="location.href='premium.do'">
	    		<div>
		      	무료로 가입하시고 단돈 1,100원에 광고를 제거해보세요!
	    		</div>
	    	</div>
	    </div>
    </c:if>
    <!--================Advertisement end =================-->
		
		<div class="container">
		
<%-- 				<c:set var="count" value="${ fn:length(list) }" /> --%>
				<c:choose>
					<c:when test="${ empty loginUser }">
						<div class="row">
							<div class="container">
							  <div class="row justify-content-md-center" style="justify-content: center;">
							  	<a id="rec-login-modal" class="button" href="#" data-toggle="modal">로그인</a>
							  </div>
							</div>
						</div>
					</c:when>
					<c:when test="${ not empty loginUser and not empty genre1 and count ge 10 }">
						<h1>${ genre1.get(0).genre }</h1>
				    <section>
				      <div class="container">
				        <div class="owl-carousel owl-theme blog-slider">
				      		<c:forEach items="${ genre1 }" var="f">
					      	<!--================ Blog slider start =================-->
					        	
					          <div class="card blog__slide text-center">
					            <div class="blog__slide__img" onclick="location.href='detailFilm.do?filmId=${ f.id }'">
					            	<c:choose>
					            		<c:when test="${ not empty f.poster }">
							              <img class="card-img rounded-0" src="resources/detailFilmImage/${ f.poster }" alt="">
					            		</c:when>
					            		<c:otherwise>
							              <img class="card-img rounded-0" src="resources/detailFilmImage/podoposter.jpg" alt="">
					            		</c:otherwise>
					            	</c:choose>
					            </div>
					            <div class="blog__slide__content">
					              <a class="blog__slide__label" href="detailFilm.do?filmId=${ f.id }">${ f.avgStarRating }</a>
					              <h3><a href="detailFilm.do?filmId=${ f.id }">${ f.titleKor }</a></h3>
					              <p>${ f.releaseYear }</p>
					            </div>
					          </div>
				          	
							    <!--================ Blog slider end =================-->
				     			</c:forEach>
				        </div>
				      </div>
	   	  		</section>
						<h1>${ genre2.get(0).genre }</h1>
				    <section>
				      <div class="container">
				        <div class="owl-carousel owl-theme blog-slider">
				      		<c:forEach items="${ genre2 }" var="f">
					      	<!--================ Blog slider start =================-->
					        	
					          <div class="card blog__slide text-center">
					            <div class="blog__slide__img" onclick="location.href='detailFilm.do?filmId=${ f.id }'">
					            	<c:choose>
					            		<c:when test="${ not empty f.poster }">
							              <img class="card-img rounded-0" src="resources/detailFilmImage/${ f.poster }" alt="">
					            		</c:when>
					            		<c:otherwise>
							              <img class="card-img rounded-0" src="resources/detailFilmImage/podoposter.jpg" alt="">
					            		</c:otherwise>
					            	</c:choose>
					            </div>
					            <div class="blog__slide__content">
					              <a class="blog__slide__label" href="detailFilm.do?filmId=${ f.id }">${ f.avgStarRating }</a>
					              <h3><a href="detailFilm.do?filmId=${ f.id }">${ f.titleKor }</a></h3>
					              <p>${ f.releaseYear }</p>
					            </div>
					          </div>
				          	
							    <!--================ Blog slider end =================-->
				     			</c:forEach>
				        </div>
				      </div>
	   	  		</section>
						<h1>${ genre3.get(0).genre }</h1>
				    <section>
				      <div class="container">
				        <div class="owl-carousel owl-theme blog-slider">
				      		<c:forEach items="${ genre3 }" var="f">
					      	<!--================ Blog slider start =================-->
					        	
					          <div class="card blog__slide text-center">
					            <div class="blog__slide__img" onclick="location.href='detailFilm.do?filmId=${ f.id }'">
					            	<c:choose>
					            		<c:when test="${ not empty f.poster }">
							              <img class="card-img rounded-0" src="resources/detailFilmImage/${ f.poster }" alt="">
					            		</c:when>
					            		<c:otherwise>
							              <img class="card-img rounded-0" src="resources/detailFilmImage/podoposter.jpg" alt="">
					            		</c:otherwise>
					            	</c:choose>
					            </div>
					            <div class="blog__slide__content">
					              <a class="blog__slide__label" href="detailFilm.do?filmId=${ f.id }">${ f.avgStarRating }</a>
					              <h3><a href="detailFilm.do?filmId=${ f.id }">${ f.titleKor }</a></h3>
					              <p>${ f.releaseYear }</p>
					            </div>
					          </div>
				          	
							    <!--================ Blog slider end =================-->
				     			</c:forEach>
				        </div>
				      </div>
	   	  		</section>
	   	  		
						<!-- [더보기] -->
						<!-- 
						<div class="row">
							<div class="col-lg-12">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination">
										<li class="page-item">
											<a class="page-link" id="more-recommendation">더보기</a>
										</li>
									</ul>
								</nav>
							</div>
						</div>
						 -->
					</c:when>
					<c:otherwise>
						<blockquote class="blockquote text-center my-5">
						  <p class="mb-0">
							  <mark style="background-color:#7768b2;color:#d4d4d4;">10개 이상</mark> 의 영화를 좋아해주세요.
							  <mark style="background-color:#7768b2;color:#d4d4d4;">"좋아요"</mark> 이력을 기반으로 추천해드립니다.
						  </p>
						  <footer class="blockquote-footer">
						  	추천 목록을 불러올 수 없습니다!
						  </footer>
						</blockquote>
					  <div class="row justify-content-md-center">
					  	<a class="button" style="margin: 0 auto;" href="film.do">영화 페이지로</a>
					  </div>
					</c:otherwise>
				</c:choose>
		</div>
	
		<jsp:include page="../common/footer.jsp" />
		
		<script>
			
			$(function(){
				$(".nav").children("li").eq(2).addClass("active");
			});
			
			/*
			var page = 1;
			
			$(document).on("click", "#more-recommendation", function(){
				page = parseInt(page);
				if (page < 3) {
					ajaxMore();
					if (page == 2) {
						$("#more-recommendation").text("목록 다시 불러오기");
					}
				} else {
					location.replace("recommendation.do");
				}
			});
			
			function ajaxMore() {
				$.ajax({
					url:"moreRec.do",
					data:{"page":page},
					success:function(data){
						console.log(data);
						console.log(data.list);
						
						$row = $(".list-row:last");
						
						$.each(data.list, function(index, value){
							
							$outer = $("<div></div>").addClass("col-md-12");
							
							// card
							$card = $("<div></div>").addClass("single-recent-blog-post card-view");
							
							// thumbnail
							$thumb = $("<div></div>").addClass("thumb");
							$img = $("<img></img>").addClass("card-img rounded-0").prop("src", "http://placehold.it/1100x300");
							$ul = $("<ul></ul>").addClass("thumb-info");
							$tid = $("<li></li>").append("<a href='#'><i class='ti-user'></i>"+ value.director + "</a></li>");
							$tir = $("<li></li>").append("<a href='#'><i class='ti-themify-favicon'></i>"+ value.releaseYear + "</a></li>");
							
							$ul.append($tid).append($tir);
							$thumb.append($img).append($ul);
							
							// details
							$details = $("<div></div").addClass("details mt-20");
							$a = $("<a></a>").prop("href", "detailFilm.do?id=" + value.id).html("<h3>" + value.titleKor + "</h3>");
							$p = $("<p>" + value.titleEng + " / " + value.productionCountry + " / " + value.genre + "</p>");
							$btn = $("<a></a>").addClass("button").prop("href", "detailFilm.do?id=" + value.id).html("More Info<i class='ti-arrow-right'></i>");
							$details.append($a).append($p).append($btn);
							
							// 1. card에 thumbnail, details 붙이고
							$card.append($thumb).append($details);
							
							// 2. outer에 card 붙이고
							$outer.append($card);
							
							// 3. row에 넣기
							$row.append($outer);
						});
						
						page = data.page;
					},
					error:function(){
						console.log("통신 실패");
					}
				});
			}
			*/
			
		</script>
		
	</body>
</html>