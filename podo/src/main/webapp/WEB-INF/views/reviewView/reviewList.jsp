<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		width: 100%;
		height: 100%;
	}
	#body{
		width: 60%;
		height: 100%;
		margin-left:auto;
		margin-right:auto;
	}
	
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

</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	
	
	
	
	<div id="body">
	<h1 align="center">리뷰 리스트</h1>
	<button onclick="location.href='reviewWriteForm.do';"> 글쓰기 </button> 
	 	<c:forEach items="${ list }" var="review">
	  <div class="container">
          <div class="card blog__slide text-center">
            <div class="blog__slide__img">
              <img class="card-img rounded-0" src="resources/bootstrap/img/blog/blog-slider/blog-slide1.png" alt="">
            </div>
            <div class="blog__slide__content">
              <p class="pTitle"> ${review.titleKor }</p>
              <a class="blog__slide__label">${ review.name }</a>
              <h3><a href="ratingDetailReview.do?id=${review.id}"><p id="reviewContentFont">${ review.content }</p></a> </h3>
              <button onclick="location.href='ratingDetailReview.do?id=${review.id}';"> 더보기 </button> 
              
              <p></p>
          	  <button onclick="location.href='reviewDelete.do?id=${review.id}';">삭제하기</button>
              <p>${review.nickname }</p>
              <p>${review.createDate }에 작성됨</p>
            </div>
          </div>
      </div>
	</c:forEach> 
	 <button onclick="location.href='star.do';">스타 보기</button>
	<%-- ${list.get(2).titleKor} --%>
	
	
<%--  이건 3개씩나오는거	 <c:forEach items="${ list }" var="review">
      <div class="container">
        <div class="owl-carousel owl-theme blog-slider">
          <div class="card blog__slide text-center">
            <div class="blog__slide__img">
              <img class="card-img rounded-0" src="img/blog/blog-slider/blog-slide1.png" alt="">
            </div>
            <div class="blog__slide__content">
              <a class="blog__slide__label" href="#">${ review.name }</a>
              <h3><a href="#">${ review.content }</a></h3>
              <p>2 days ago</p>
            </div>
          </div>
        </div>
      </div>
    </c:forEach> --%>
	
	
	<%-- <c:forEach items="${ list }" var="review">
	<div class="reviewArea">
		<div class="leftImage">
				<img src="resources/bootstrap/img/logo.png" alt="" class="img1">
		</div>
		<div class="rightContentArea">
			<div class="reviewTitle">
				영화제목 : ${ review.titleKor }
			</div>
			<div class="reviewName">
				장르 : ${ review.name }
				<div class="reviewRelsaseYear">제작년도 : ${ review.releaseYear }</div>
			</div>
			<div class="reviewNickname">
				글쓴이 : ${ review.nickname }
				<div class="insertDate">
					글쓴시간 : 추가할예정
				</div>
			</div>
			<div class="reviewContent">
				내용 : ${ review.content }
			</div>
		<hr>
		</div>
	
	</div>
	</c:forEach> --%>
	<br>

	</div>
	
	
	
	
	
	
 	<jsp:include page="../common/footer.jsp"/> 
</body>
</html>