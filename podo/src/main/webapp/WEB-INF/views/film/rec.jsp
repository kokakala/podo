<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평점 기반 영화 추천</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<section class="blog-post-area section-margin">
		<div class="container">
		
				<c:set var="count" value="${ fn:length(list) }" />
				<c:choose>
					<c:when test="${ empty loginUser }">
						<div class="row">
							<div class="container">
							  <div class="row justify-content-md-center">
							  	<a id="rec-login-modal" class="button" href="#" data-toggle="modal">로그인</a>
							  </div>
							</div>
						</div>
					</c:when>
					<c:when test="${ not empty loginUser and not empty list and count ge 10 }">
						<h1>${ genre1.get(0).genre }</h1>
				    <section>
				      <div class="container">
				        <div class="owl-carousel owl-theme blog-slider">
				      		<c:forEach items="${ genre1 }" var="f">
					      	<!--================ Blog slider start =================-->
					        	
					          <div class="card blog__slide text-center">
					            <div class="blog__slide__img">
					              <img class="card-img rounded-0" src="resources/bootstrap/img/blog/blog-slider/blog-slide1.png" alt="">
					            </div>
					            <div class="blog__slide__content">
					              <a class="blog__slide__label" href="#">${ f.avgStarRating }</a>
					              <h3><a href="#">${ f.titleKor }</a></h3>
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
					            <div class="blog__slide__img">
					              <img class="card-img rounded-0" src="resources/bootstrap/img/blog/blog-slider/blog-slide1.png" alt="">
					            </div>
					            <div class="blog__slide__content">
					              <a class="blog__slide__label" href="#">${ f.avgStarRating }</a>
					              <h3><a href="#">${ f.titleKor }</a></h3>
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
					            <div class="blog__slide__img">
					              <img class="card-img rounded-0" src="resources/bootstrap/img/blog/blog-slider/blog-slide1.png" alt="">
					            </div>
					            <div class="blog__slide__content">
					              <a class="blog__slide__label" href="#">${ f.avgStarRating }</a>
					              <h3><a href="#">${ f.titleKor }</a></h3>
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
						10개 이상의 영화를 좋아해주세요!
					</c:otherwise>
				</c:choose>
				
				      	<%-- 
								<div class="col-md-12">
									<div class="single-recent-blog-post card-view">
										<div class="thumb">
											<img class="card-img rounded-0" src="http://placehold.it/1100x300" alt="">
											<ul class="thumb-info">
												<li><a href="#"><i class="ti-user"></i>${ f.director }</a></li>
												<li><a href="#"><i class="ti-themify-favicon"></i>${ f.releaseYear }</a></li>
											</ul>
										</div>
										<div class="details mt-20">
											<a href="detailFilm.do?id=${ f.id }">
	                    <h3>${ f.titleKor }</h3>
											</a>
			                <p>${ f.titleEng } / ${ f.productionCountry } / ${ f.genre }</p>
			                <a class="button" href="detailFilm.do?id=${ f.id }">More Info<i class="ti-arrow-right"></i></a>
			              </div>
									</div>
								</div>
								 --%>
			
		</div>
	</section>

	<jsp:include page="../common/footer.jsp" />
	
	<script>
		
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
				location.replace("rec.do");
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