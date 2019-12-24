<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<jsp:include page="common/header.jsp"/>
	</head>
	<body>
    <!--================Hero Banner start =================-->
    <section class="mb-30px">
      <div class="container">
        <div class="main-banner">
          <div class="hero-banner__content">
            <h3>Film &amp; Review</h3>
            <h1>Great, Grape!</h1>
            <h4>December 5, 2019</h4>
          </div>
        </div>
      </div>
    </section>
    <!--================Hero Banner end =================-->
    
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
		
    <!--================ Blog slider start =================-->
    <!-- 창수가 구현한 위페이지 -->
    <section class="blog-post-area section-margin">
			<div class="container">
        <div class="owl-carousel owl-theme blog-slider">
      		<c:forEach items="${ list }" var="film">
	          <div class="card blog__slide text-center">
	            <div class="blog__slide__img" onclick="location.href='detailFilm.do?filmId=${ film.id }'">
	            	<c:choose>
	            		<c:when test="${ not empty film.poster }">
			              <img class="card-img rounded-0" src="resources/detailFilmImage/${ film.poster }" alt="">
	            		</c:when>
	            		<c:otherwise>
			              <img class="card-img rounded-0" src="resources/detailFilmImage/podoposter.jpg" alt="">
	            		</c:otherwise>
	            	</c:choose>
	            </div>
	            <div class="blog__slide__content">
	              <a class="blog__slide__label" href="detailFilm.do?filmId=${ film.id }">${ film.avgStarRating }</a>
	              <h3><a href="detailFilm.do?filmId=${ film.id }">${ film.titleKor }</a></h3>
	              <p>${ film.releaseYear }</p>
	            </div>
	          </div>
     			</c:forEach>
   			</div>
			</div>
		</section>
    <!--================ Blog slider end =================-->  
	  <jsp:include page="common/footer.jsp"/>
	</body>
</html>