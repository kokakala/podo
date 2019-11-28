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
	#posterImage{
		width: 200px;
		height: 200px;
	}
	#mide{
		text-align: center;
		font-weight: lighter;
	}
	
	#reviewContentFont{
		margin-top: 20px; text-overflow: ellipsis; overflow: hidden;
	}
	.df_r_content{
    	display : none;
    }
    .df_r_spoContent{
    	cursor: pointer;
    }
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	
	
	
	
	<div id="body">
	<h1 align="center">리뷰 리스트</h1>


	 <c:forEach items="${ list }" var="review">
	  <div class="container">
          <div class="card blog__slide text-center">
            <div class="blog__slide__img">
              <img class="card-img rounded-0" src="resources/detailFilmImage/${review.posterImage}" alt="" id="posterImage">
            </div>
            <div class="blog__slide__content">
              <p class="pTitle"> ${review.titleKor }</p>
              <a class="blog__slide__label">${ review.name }</a>
              <h3>
              
              	<p id="reviewContentFont"  class="title">
              		<div class="df_r_spoContent">
				          <div class="df_r_spoilerCheck">해당 내용은 스포일러를 포함하고 있습니다.</div>
					       <div class="df_r_content">내용 : ${ review.content }</div>
				    </div>
              	</p>
              
              </h3>
              <button class="btn btn-secondary btn-like-film" onclick="location.href='ratingDetailReview.do?id=${review.id}';"> 더보기 </button> 
              
              <p></p>
          	  <button onclick="location.href='reviewDelete.do?id=${review.id}';">x</button>
              <p>${review.nickName }님이 작성</p>
              <p>${review.createDate }에 작성됨</p>
            </div>
          </div>
      </div>
	</c:forEach> 
	
	<!-- 페이징 처리 -->
 		 <div align="center" height="20">
			<!-- [이전] -->
			<c:if test="${ pi.currentPage eq 1 }">
				[이전]
			</c:if>
			
			<c:if test="${ pi.currentPage ne 1 }">
				<c:url value="reviewList.do" var="before">
					<c:param name="currentPage" value="${pi.currentPage-1 }"/>
				</c:url>
				<a href="${ before }">[이전]</a>
			</c:if>
			
			<!-- [페이지] -->
			<c:forEach begin="${pi.startPage }" end="${ pi.endPage }" var="p">
				<c:if test="${ p eq pi.currentPage }">
					<font color="red" size="4">[${ pi.currentPage }]</font>
				</c:if>
				<c:if test="${ p ne pi.currentPage }">
					<c:url value="reviewList.do" var="page">
						<c:param name="currentPage" value="${p }"/>
					</c:url>
					<a href="${ page }">[${ p }]</a>
				</c:if>
			</c:forEach>
			<!-- [다음] -->

			<c:if test="${ pi.currentPage eq pi.maxPage }">
					[다음]
				</c:if>
				<c:if test="${ pi.currentPage ne pi.maxPage }">
					<c:url value="reviewList.do" var="after">
						<c:param name="currentPage" value="${ pi.currentPage+1 }"/>
					</c:url>
					<a href="${ after }">[다음]</a>
				</c:if>
		
		</div> 

	<%-- <p id=mide>총개시글 : ${pi.listCount } 페이지 : ${ pi.currentPage } / ${ pi.maxPage }</p> --%>
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
	
	
	
	<script>
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