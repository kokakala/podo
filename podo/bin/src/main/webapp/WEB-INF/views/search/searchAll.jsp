<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			
			#search-film-result {
				border-collapse: collapse;
			}
			
			#search-film-result td,
			#search-film-result tr {
				text-align: center;
				border: 1px solid;
			}
			
		</style>
	</head>
	<body>
		<jsp:include page="../common/header.jsp"/>

		  <!--================ Start Blog Post Area =================-->
		  <section class="blog-post-area section-margin">
		    <div class="container">
		      <div class="row">
		        <div class="col-lg-8">
		        
		        	<!-- 검색된 컨텐츠 -->
		          <div class="row">
								<c:forEach items="${ list }" var="f">
			            <div class="col-md-6">
			              <div class="single-recent-blog-post card-view">
			                <div class="thumb">
			                  <img class="card-img rounded-0" src="http://placehold.it/300x300" alt="">
			                  <ul class="thumb-info">
			                    <li><a href="#"><i class="ti-user"></i>${ f.director }</a></li>
			                    <li><a href="#"><i class="ti-themify-favicon"></i>${ f.releaseYear }</a></li>
			                  </ul>
			                </div>
			                <div class="details mt-20">
			                  <a href="dfilm.do?id=${ f.id }">
			                    <h3>${ f.titleKor }</h3>
			                  </a>
			                  <p>${ f.titleEng } / ${ f.productionCountry } / ${ f.genre }</p>
			                  <a class="button" href="dfilm.do?id=${ f.id }">More Info<i class="ti-arrow-right"></i></a>
			                </div>
			              </div>
			            </div>
		          	</c:forEach>
		          </div>
		          
		          <!-- 페이지 -->
		          <div class="row">
		            <div class="col-lg-12">
	                <nav class="blog-pagination justify-content-center d-flex">
                    <ul class="pagination">
                   		
                   		<!-- [PREV] -->
                       <li class="page-item">
                         <a href="skFilm.do?currentPage=${ pi.currentPage - 1 }" class="page-link" aria-label="Previous" disabled>
                           <span aria-hidden="true">
                             <i class="ti-angle-left"></i>
                           </span>
                        </a>
                      </li>
                       
                      <!-- [페이지] -->
											<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                     		<c:if test="${ p eq pi.currentPage }">
													<c:url value="skFilm.do" var="page">
														<c:param name="currentPage" value="${ p }"/>
													</c:url>
                     			<li class="page-item disabled"><a href="${ page }" class="page-link">${ p }</a></li>
												</c:if>
												<c:if test="${ p ne pi.currentPage }">
													<c:url value="skFilm.do" var="page">
														<c:param name="currentPage" value="${ p }"/>
													</c:url>
                     			<li class="page-item"><a href="${ page }" class="page-link">${ p }</a></li>
												</c:if>
                     		
                      </c:forEach>
                       
                      <!-- [NEXT] -->
                      <li class="page-item">
												<a href="skFilm.do?currentPage=${ pi.currentPage + 1 }" class="page-link" aria-label="Next">
                           <span aria-hidden="true">
                             <i class="ti-angle-right"></i>
                           </span>
                        </a>
                      </li>
                    </ul>
	                </nav>
		            </div>
		          </div>
		        </div>
		
		        <!-- Start Blog Post Siddebar -->
		        <div class="col-lg-4 sidebar-widgets">
		            <div class="widget-wrap">
		              <div class="single-sidebar-widget newsletter-widget">
		                <h4 class="single-sidebar-widget__title">결과 내 재검색</h4>
		                <div class="form-group mt-30">
		                  <div class="col-autos">
		                    <input type="search" class="form-control" id="inlineFormInputGroup" placeholder="키워드를 입력해주세요" onfocus="this.placeholder = ''"
		                      onblur="this.placeholder = '키워드를 입력해주세요'">
		                  </div>
		                </div>
		                <button class="bbtns d-block mt-20 w-100">검색</button>
		              </div>
		
		
		              <div class="single-sidebar-widget post-category-widget">
		                <h4 class="single-sidebar-widget__title">카테고리</h4>
		                <ul class="cat-list mt-20">
		                  <li>
		                    <a href="#" class="d-flex justify-content-between">
		                      <p>영화</p>
		                      <c:if test="${ listCount lt 10 }">
			                      <p>(0${ listCount })</p>
		                      </c:if>
		                      <c:if test="${ listCount ge 10 }">
			                      <p>(${ listCount })</p>
		                      </c:if>
		                    </a>
		                  </li>
		                  <li>
		                    <a href="#" class="d-flex justify-content-between">
		                      <p>리뷰</p>
		                      <c:if test="${ listCount lt 10 }">
			                      <p>(0${ listCount })</p>
		                      </c:if>
		                      <c:if test="${ listCount ge 10 }">
			                      <p>(${ listCount })</p>
		                      </c:if>
		                    </a>
		                  </li>
		                  <li>
		                    <a href="#" class="d-flex justify-content-between">
		                      <p>자유게시판</p>
		                      <c:if test="${ listCount lt 10 }">
			                      <p>(0${ listCount })</p>
		                      </c:if>
		                      <c:if test="${ listCount ge 10 }">
			                      <p>(${ listCount })</p>
		                      </c:if>
		                    </a>
		                  </li>
		                </ul>
		              </div>
		
		              <div class="single-sidebar-widget popular-post-widget">
		                <h4 class="single-sidebar-widget__title">Popular Post</h4>
		                <div class="popular-post-list">
		                  <div class="single-post-list">
		                    <div class="thumb">
		                      <img class="card-img rounded-0" src="img/blog/thumb/thumb1.png" alt="">
		                      <ul class="thumb-info">
		                        <li><a href="#">Adam Colinge</a></li>
		                        <li><a href="#">Dec 15</a></li>
		                      </ul>
		                    </div>
		                    <div class="details mt-20">
		                      <a href="blog-single.html">
		                        <h6>Accused of assaulting flight attendant miktake alaways</h6>
		                      </a>
		                    </div>
		                  </div>
		                  <div class="single-post-list">
		                    <div class="thumb">
		                      <img class="card-img rounded-0" src="img/blog/thumb/thumb2.png" alt="">
		                      <ul class="thumb-info">
		                        <li><a href="#">Adam Colinge</a></li>
		                        <li><a href="#">Dec 15</a></li>
		                      </ul>
		                    </div>
		                    <div class="details mt-20">
		                      <a href="blog-single.html">
		                        <h6>Tennessee outback steakhouse the
		                          worker diagnosed</h6>
		                      </a>
		                    </div>
		                  </div>
		                  <div class="single-post-list">
		                    <div class="thumb">
		                      <img class="card-img rounded-0" src="img/blog/thumb/thumb3.png" alt="">
		                      <ul class="thumb-info">
		                        <li><a href="#">Adam Colinge</a></li>
		                        <li><a href="#">Dec 15</a></li>
		                      </ul>
		                    </div>
		                    <div class="details mt-20">
		                      <a href="blog-single.html">
		                        <h6>Tennessee outback steakhouse the
		                          worker diagnosed</h6>
		                      </a>
		                    </div>
		                  </div>
		                </div>
		              </div>
		
		                <div class="single-sidebar-widget tag_cloud_widget">
		                  <h4 class="single-sidebar-widget__title">Popular Post</h4>
		                  <ul class="list">
		                    <li>
		                        <a href="#">project</a>
		                    </li>
		                    <li>
		                        <a href="#">love</a>
		                    </li>
		                    <li>
		                        <a href="#">technology</a>
		                    </li>
		                    <li>
		                        <a href="#">travel</a>
		                    </li>
		                    <li>
		                        <a href="#">software</a>
		                    </li>
		                    <li>
		                        <a href="#">life style</a>
		                    </li>
		                    <li>
		                        <a href="#">design</a>
		                    </li>
		                    <li>
		                        <a href="#">illustration</a>
		                    </li>
		                  </ul>
		                </div>
		              </div>
		            </div>
		          </div>
		        <!-- End Blog Post Siddebar -->
		      </div>
		  </section>
		  <!--================ End Blog Post Area =================-->
	  <jsp:include page="../common/footer.jsp"/>
	</body>
</html>