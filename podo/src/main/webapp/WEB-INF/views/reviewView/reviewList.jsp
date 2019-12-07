<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<title>리뷰리스트</title>
		<style>
			
			.pTitle {
				font-size: 20px;
				font-weight: bold;
				/* color: black; */
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
					<div class="poster" onclick="location.href='detailFilm.do?filmId=${ film.id }'">
						<img class="card-img rounded-0" src="resources/detailFilmImage/${review.posterImage}" id="posterImage">
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

<!--  
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

							<p id="reviewContentFont" class="title">
								<c:if test="${ review.spoilerCheck eq 'Y' }">
									<div class="df_r_spoContent">
										<div class="df_r_spoilerCheck">해당 내용은 스포일러를 포함하고 있습니다.</div>
										<div class="df_r_content">${ review.content }</div>
									</div>
								</c:if>
								<c:if test="${ review.spoilerCheck eq 'N' }">
									<div>${ review.content }</div>
								</c:if>

							</p>

						</h3>
						<button class="btn btn-secondary btn-like-film"
							onclick="location.href='ratingDetailReview.do?id=${review.id}';">
							더보기</button>

						<p></p>
						<button onclick="location.href='reviewDelete.do?id=${review.id}';">x</button>
						<p>${review.nickName }님이작성</p>
						<p>${review.createDate }에작성됨</p>
					</div>
				</div>
			</div>
		</c:forEach> -->



	<%-- <p id=mide>총개시글 : ${pi.listCount } 페이지 : ${ pi.currentPage } / ${ pi.maxPage }</p> --%>
	<!--  <button onclick="location.href='star.do';">스타 보기</button> -->
	 
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