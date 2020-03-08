<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			a { color: #c69ce6; }
			a:hover { color : #d4d4d4; }
		</style>
	</head>
	<body>

		  <!--================ Start Blog Post Area =================-->
		  <section class="blog-post-area section-margin">
		    <div class="container">
		      <div class="row">
		        <div class="col-xl-8">
		        
		        	<!-- 검색된 컨텐츠 -->
		          <div class="row">
								<c:forEach items="${ list }" var="f">
			            <div class="col-md-6">
			              <div class="single-recent-blog-post card-view">
			                <div class="thumb">
			                	<a href="detailFilm.do?filmId=${f.id}">
						            	<c:choose>
						            		<c:when test="${ not empty f.poster }">
								              <img class="card-img rounded-0" src="resources/detailFilmImage/${ f.poster }" alt="">
						            		</c:when>
						            		<c:otherwise>
								              <img class="card-img rounded-0" src="resources/detailFilmImage/podoposter.jpg" alt="">
						            		</c:otherwise>
						            	</c:choose>
					            	</a>
			                  <ul class="thumb-info">
			                    <li><a href="detailFilm.do?filmId=${f.id}"><i class="ti-user"></i>${ f.director }</a></li>
			                    <li><a href="detailFilm.do?filmId=${f.id}"><i class="ti-themify-favicon"></i>${ f.releaseYear }</a></li>
			                  </ul>
			                </div>
			                <div class="details mt-20">
			                  <a href="detailFilm.do?filmId=${f.id}">
			                    <h3>${ f.titleKor }</h3>
			                  </a>
			                  <p>${ f.titleEng } / ${ f.productionCountry } / ${ f.genre }</p>
			                </div>
			              </div>
			            </div>
		          	</c:forEach>
		          </div>
		          
		          <c:url var="keywordSearchUrl" value="skFilm.do">
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="skeyword" value="${ skeyword }" />
							</c:url>
		          <!-- Pagination -->
		          <div class="row">
		          	<c:if test="${ pi.listCount eq 0 }">
			          	<h2><spring:message code="placeholder.not.found"/> "${ keyword }"</h2>
		          	</c:if>
			          <c:if test="${ pi.listCount ne 0 }">
			            <div class="col-lg-12 my-5">
		                <nav class="blog-pagination justify-content-center d-flex">
	                    <ul class="pagination">
	                   		
	                   		<!-- [PREV] -->
	                      <c:if test="${ pi.currentPage eq 1 }">
													<li class="page-item disabled">
												</c:if>
												<c:if test="${ pi.currentPage ne 1 }">
													<li class="page-item">
												</c:if>
	                         <a href=<c:out value="${ keywordSearchUrl }&p=${ pi.currentPage - 1 }"/> class="page-link" aria-label="Previous" disabled>
	                           &lt;
	                        </a>
	                      </li>
	                       
	                      <!-- [각 페이지] -->
												<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
												
	                     		<c:if test="${ p eq pi.currentPage }">
	                     			<li class="page-item disabled"><a href=<c:out value="${ keywordSearchUrl }&p=${ p }"/> class="page-link">${ p }</a></li>
													</c:if>
													<c:if test="${ p ne pi.currentPage }">
	                     			<li class="page-item"><a href=<c:out value="${ keywordSearchUrl }&p=${ p }"/> class="page-link">${ p }</a></li>
													</c:if>
	                     		
	                      </c:forEach>
	                       
	                      <!-- [NEXT] -->
	                      <c:if test="${ pi.currentPage eq pi.maxPage }">
													<li class="page-item disabled">
												</c:if>
												<c:if test="${ pi.currentPage ne pi.maxPage }">
													<li class="page-item">
												</c:if>
													<a href=<c:out value="${ keywordSearchUrl }&p=${ pi.currentPage + 1 }"/> class="page-link" aria-label="Next">
	                           &gt;
	                        </a>
	                      </li>
	                    </ul>
		                </nav>
			            </div>
			          </c:if>
		          </div>
		          
		        </div>
		
		        <!-- Start Blog Post Siddebar -->
		        <div class="col-xl-4 sidebar-widgets">
		            <div class="widget-wrap">
		
		              <div class="single-sidebar-widget popular-post-widget">
		                <h4 class="single-sidebar-widget__title"><spring:message code="label.boxoffice.daily"/></h4>
		                <div class="popular-post-list">
		                  <div class="single-post-list">
		                  	<table style="width: 100%;">
		                  		<thead>
		                  			<tr style="border-bottom: 2px solid white;">
		                  				<th style="text-align:center;min-width:33px;"><spring:message code="label.boxoffice.rank"/></th>
		                  				<th style="text-align:center;min-width:150px;"><spring:message code="label.boxoffice.title"/></th>
		                  				<th style="text-align:right;min-width:105px;"><spring:message code="label.boxoffice.aud"/></th>
		                  			</tr>
		                  		</thead>
		                  		<tbody id="dailyBoxOffice">
		                  			<tr id="loadingBoxOffice">
		                  				<td colspan="3">
		                  					<div style="text-align:center;font-size:13px;">
																	<div class="lds-spinner my-4">
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	  <div></div>
																	</div>
		                  						<p>영화진흥위원회에서 데이터를 가져오는 중입니다.</p>
		                  					</div>
		                  				</td>
		                  			</tr>
		                  		</tbody>
		                  	</table>
		                  </div>
		                </div>
		              </div>
		            	
		            	<form action="skFilm.do" method="get" class="single-sidebar-widget newsletter-widget">
			                <h4 class="single-sidebar-widget__title"><spring:message code="label.search.again"/></h4>
			                <div class="form-group mt-30">
			                  <div class="col-autos">
			                  	<input type="hidden" name="keyword" value="${ keyword }">
			                    <input type="search" class="form-control" id="inlineFormInputGroup" placeholder="<spring:message code="placeholder.search"/>" name="skeyword"
			                    	onfocus="this.placeholder = ''" onblur="this.placeholder = '<spring:message code="placeholder.search"/>'">
			                  </div>
			                </div>
			                <%-- <a class="bbtns d-block mt-20 w-100" style="text-align:center;" href=<c:out value="${ keywordSearchUrl }"/>>재검색</a> --%>
			                <button class="bbtns d-block mt-20 w-100" onclick="submit"><spring:message code="button.search"/></button>
		            	</form>
		
		
		              <div class="single-sidebar-widget post-category-widget">
		                <h4 class="single-sidebar-widget__title"><spring:message code="label.category"/></h4>
		                <ul class="cat-list mt-20">
		                  <li>
		                    <a href="<c:out value="${ keywordSearchUrl }&p=1"/>" class="d-flex justify-content-between">
		                      <p><spring:message code="nav.menu.movie"/></p>
		                      <c:if test="${ filmCount lt 10 }">
			                      <p>(0${ filmCount })</p>
		                      </c:if>
		                      <c:if test="${ filmCount ge 10 }">
			                      <p>(${ filmCount })</p>
		                      </c:if>
		                    </a>
		                  </li>
		                  <!--
		                  <li>
		                    <a href="reviewList.do" class="d-flex justify-content-between">
		                      <p>리뷰</p>
		                      <c:if test="${ listCount lt 10 }">
			                      <p>(0${ listCount })</p>
		                      </c:if>
		                      <c:if test="${ listCount ge 10 }">
			                      <p>(${ listCount })</p>
		                      </c:if>
		                    </a>
		                  </li>
		                  -->
		                  <!--
		                  <li>
		                    <a href="blist.do" class="d-flex justify-content-between">
		                      <p>자유게시판</p>
		                      <c:if test="${ listCount lt 10 }">
			                      <p>(0${ listCount })</p>
		                      </c:if>
		                      <c:if test="${ listCount ge 10 }">
			                      <p>(${ listCount })</p>
		                      </c:if>
		                    </a>
		                  </li>
		                  -->
		                </ul>
		              </div>
		
		                <div class="single-sidebar-widget tag_cloud_widget">
		                  <h4 class="single-sidebar-widget__title"><spring:message code="label.keyword.hot"/></h4>
		                  <ul class="list">
		                    <li>
		                        <a href="skFilm.do?keyword=조커">#조커</a>
		                    </li>
		                    <li>
		                        <a href="skFilm.do?keyword=미인어">#미인어</a>
		                    </li>
		                    <li>
		                        <a href="skFilm.do?keyword=감쪽같은 그녀">#감쪽같은 그녀</a>
		                    </li>
		                    <li>
		                        <a href="skFilm.do?keyword=매드 맥스">#매드 맥스</a>
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
	  <script>
	  	$(document).ready(function(){
	  		$("#loadingBoxOffice").hide();
				$.ajax({
					type : "get",
					url : "getDailyBoxOffice.do",
					success : function(data) {
						var arr = data.boxOfficeResult.dailyBoxOfficeList;
						$.each(arr, function(index, value) {
							var $tdRank = $("<td style='text-align: center;'></td>").text(value.rank);
							var $tdTitle = $("<td style='text-align: center; font-size: 14px;'></td>").text(value.movieNm);
							var $tdAudiAcc = $("<td style='text-align: right;'></td>").text(Number(value.audiAcc).toLocaleString().split(/\s/).join(',') + "명"); // \s : whitespace
							var $tr = $("<tr style='border-bottom: 1px solid rgba(144, 144, 144, 0.29);'></tr>").append($tdRank).append($tdTitle).append($tdAudiAcc);
							$("#dailyBoxOffice").append($tr);
						});
					},
					error : function() {
						console.error("ajax error");
					}
				});
	  	})
	  	.ajaxStart(function(){
	  		$('#loadingBoxOffice').show();
	  	})
	  	.ajaxStop(function(){
	  		$('#loadingBoxOffice').hide();
	  	});
			</script>
	</body>
</html>