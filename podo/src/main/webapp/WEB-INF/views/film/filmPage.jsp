<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
  <body>

		<section class="mb-30px">
			<div class="container">
				<div class="film-page-banner">
					<br>
					<span class="title">영화 찾기</span>
					<br>
					<span class="content">다양한 필터를 적용해</span>
					<br>
					<span class="content">오늘 감상할 영화를 찾아보세요!</span>
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
		
		<!-- =================필터================= -->
		<div class="container" style="margin-bottom: 40px; text-align: center;">
			<div style="display: inline-block;">
				<form action="film.do" method="get" id="search-film-form">
					<!-- 연도별 -->
					<select name="releaseYear">
						<option value="all" data-display="연도별">연도별</option>
						<c:forEach items="${ release }" var="release">
							<c:if test="${ sc.releaseYear eq release }">
								<option value="${ release }" selected>${ release }</option>
								</c:if>
								<c:if test="${ sc.releaseYear ne release }">
								<option value="${ release }">${ release }</option>
							</c:if>
						</c:forEach>
					</select>
					
					<!-- 국가별 -->
					<select name="productionCountry">
						<option value="all" data-display="국가별">국가별</option>
						<c:forEach items="${ country }" var="country">
							<c:if test="${ sc.productionCountry eq country }">
							<option value="${ country }" selected>${ country }</option>
							</c:if>
							<c:if test="${ sc.productionCountry ne country }">
							<option value="${ country }">${ country }</option>
							</c:if>
						</c:forEach>
					</select>
					
					<!-- 장르별 -->
					<select name="genreId">
						<option value="0" data-display="장르별">장르별</option>
						<c:forEach items="${ genre }" var="genre">
							<c:if test="${ sc.genreId eq genre.id }">
								<option value="${ genre.id }" selected>${ genre.name }</option>
							</c:if>
							<c:if test="${ sc.genreId ne genre.id }">
								<option value="${ genre.id }">${ genre.name }</option>
							</c:if>
						</c:forEach>
					</select>
					
					<!-- 장르별 -->
					<select name="saw">
						<option value="all" data-display="관람">관람</option>
						<option value="show">본 영화</option>
						<option value="hide">안 본 영화</option>
					</select>
					
					<!-- 부가옵션 -->
					<select name="order">
						<option value="all" data-display="정렬">모두</option>
						<option value="filmRatingDesc">평가 높은 순</option>
						<option value="reviewCountDesc">리뷰 많은 순</option>
					</select>
				</form>
				
			</div>
		</div>
		<!-- =================필터================= -->
		
		<div class="container">
			<c:if test="${ pi.listCount ne 0 }">
				<div class="row">
					<c:forEach items="${ film }" var="film" varStatus="status">
						<!-- width * 1.425 -->
						<div class="podo-film-card col-md-3 my-5">
							<input class="hidden-filmId" type="hidden" value="${ film.id }">
							<div class="poster" onclick="location.href='detailFilm.do?filmId=${ film.id }'">
								<c:if test="${ not empty film.poster }">
									<img src="resources/detailFilmImage/${ film.poster }">
								</c:if>
								<c:if test="${ empty film.poster }">
									<img src="resources/detailFilmImage/podoposter.jpg">
								</c:if>
							</div>
							<div style="margin-top: 20px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
								${ film.titleKor }
							</div>
							<div>
								<small>${ film.genre } / ${ film.releaseYear }</small>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col">
									<c:if test="${ not empty like[film.id] }">
										<button class='btn btn-danger btn-block btn-liked-film' data-toggle="tooltip" data-placement="bottom" title="좋아요 취소">
											<img src="resources/asterisk/img/like.png" style="width: 35px; height: 35px; display: block; margin: 0 auto;">
										</button>
									</c:if>
									<c:if test="${ empty like[film.id] }">
										<button class='btn btn-secondary btn-block btn-like-film' data-toggle="tooltip" data-placement="bottom" title="좋아요">
											<img src="resources/asterisk/img/like.png" style="width: 35px; height: 35px; display: block; margin: 0 auto;">
										</button>
									</c:if>
								</div>
								<div class="col">
									<c:if test="${ rate[film.id].saw eq 'Y' }">
										<button class='btn btn-danger btn-block btn-saw-film' data-toggle="tooltip" data-placement="bottom" title="봤어요 취소">
											<img src="resources/asterisk/img/see.png" style="width: 35px; height: 35px; display: block; margin: 0 auto;">
										</button>
									</c:if>
									<c:if test="${ rate[film.id].saw eq 'N' or empty rate[film.id].saw }">
										<button class='btn btn-secondary btn-block btn-see-film' data-toggle="tooltip" data-placement="bottom" title="봤어요">
											<img src="resources/asterisk/img/see.png" style="width: 35px; height: 35px; display: block; margin: 0 auto;">
										</button>
									</c:if>
								</div>
							</div>
							<div class="star-area" style="margin-top: 10px;">
								<span class="star-input">
									<span class="input">
										<input type="radio" name="star-input${ status.count }" value="1" id="p${ (status.count - 1) * 5 + 1 }" <c:if test="${ rate[film.id].star eq 1 }">checked</c:if>>
										<label for="p${ (status.count - 1) * 5 + 1 }" style='width: 30px; z-index: 5;'>1</label>
										<input type="radio" name="star-input${ status.count }" value="2" id="p${ (status.count - 1) * 5 + 2 }" <c:if test="${ rate[film.id].star eq 2 }">checked</c:if>>
										<label for="p${ (status.count - 1) * 5 + 2 }" style='width: 60px; z-index: 4;'>2</label>
										<input type="radio" name="star-input${ status.count }" value="3" id="p${ (status.count - 1) * 5 + 3 }" <c:if test="${ rate[film.id].star eq 3 }">checked</c:if>>
										<label for="p${ (status.count - 1) * 5 + 3 }" style='width: 90px; z-index: 3;'>3</label>
										<input type="radio" name="star-input${ status.count }" value="4" id="p${ (status.count - 1) * 5 + 4 }" <c:if test="${ rate[film.id].star eq 4 }">checked</c:if>>
										<label for="p${ (status.count - 1) * 5 + 4 }" style='width: 120px; z-index: 2;'>4</label>
										<input type="radio" name="star-input${ status.count }" value="5" id="p${ (status.count - 1) * 5 + 5 }" <c:if test="${ rate[film.id].star eq 5 }">checked</c:if>>
										<label for="p${ (status.count - 1) * 5 + 5 }" style='width: 150px; z-index: 1;'>5</label>
									</span>
									<output for="star-input"><b style="display: none;">${ rate[film.id].star }</b></output>
								</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${ pi.listCount eq 0 }">
				<div style="text-align: center;">
					<h3>검색된 영화가 없습니다.</h3>
					<br>
				</div>
			</c:if>
			
			<!-- 
			<table id="search-film-result" style="width: 100%;">
				<thead>
					<tr>
						<th colspan="9"><b id="film-count"></b></th>
					</tr>
					<tr>
						<th colspan="2">제목</th>
						<th>감독</th>
						<th>개봉연도</th>
						<th>국가</th>
						<th>장르</th>	
						<th>포스터</th>
						<th>좋아요</th>
						<th>별점</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			 -->
			 
			 
			<c:url var="filmUrl" value="film.do">
				<c:param name="releaseYear" value="${ param.releaseYear }" />
				<c:param name="productionCountry" value="${ param.productionCountry }" />
				<c:param name="genreId" value="${ param.genreId }" />
				<c:param name="saw" value="${ param.saw }" />
				<c:param name="order" value="${ param.order }" />
			</c:url>
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
								<a href=<c:out value="${ filmUrl }&p=${ pi.currentPage - 1 }"/> class="page-link" aria-label="Previous">
									&lt;
								</a>
							</li>
		
							<!-- [각 페이지] -->
							<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							
								<c:if test="${ p eq pi.currentPage }">
									<li class="page-item disabled"><a href=<c:out value="${ filmUrl }&p=${ p }"/> class="page-link">${ p }</a></li>
								</c:if>
								
								<c:if test="${ p ne pi.currentPage }">
									<li class="page-item"><a href="<c:out value="${ filmUrl }&p=${ p }"/>" class="page-link">${ p }</a></li>
								</c:if>
								
							</c:forEach>
		
							<!-- [NEXT] -->
							<c:if test="${ pi.currentPage eq pi.maxPage }">
								<li class="page-item disabled">
							</c:if>
							<c:if test="${ pi.currentPage ne pi.maxPage }">
								<li class="page-item">
							</c:if>
								<a href=<c:out value="${ filmUrl }&p=${ pi.currentPage + 1 }"/> class="page-link" aria-label="Next">
									&gt;
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</div> <!-- Pagination end -->
			 
		</div> <!-- container end -->
		
		<!-- back-to-top button -->
		<a class="top-link hide" href="" id="js-top">
		  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 12 6"><path d="M12 6H0l6-6z"/></svg>
		  <span class="screen-reader-text">Back to top</span>
		</a>
	
		<jsp:include page="../common/footer.jsp"/>
		<script>
			
			$(function(){
				$(".nav").children("li").eq(0).addClass("active");
			});
	
			// URL 파라미터 값을 가져오기 위한 메서드
			$.urlParam = function(name) {
				var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
				if (results == null) {
					return null;
				} else {
					return results[1] || 0;
				}
			}
	
			$(function() {
				// 관람유무 조건 유지
				if ($.urlParam("saw") === "show") {
					$("select[name=saw] option[value=show]").attr("selected", true);
				} else if ($.urlParam("saw") === "hide") {
					$("select[name=saw] option[value=hide]").attr("selected", true);
				} else {
					$("select[name=saw] option[value=all]").attr("selected", true);
				}
	
				// 부가옵션 조건 유지
				if ($.urlParam("order") === "filmRatingDesc") {
					$("select[name=order] option[value=filmRatingDesc]").attr("selected", true);
				} else if ($.urlParam("order") === "reviewCountDesc") {
					$("select[name=order] option[value=reviewCountDesc]").attr("selected", true);
				} else {
					$("select[name=order] option[value=all]").attr("selected", true);
				}
			});
	
			/* nice-select 라이브러리 */
			$(document).ready(function() {
				$('select').niceSelect();
			});
	
	
			// 페이징 처리를 위해 AJAX 대신 동기적으로 처리
			/* 영화 검색목록 불러오기 Synchronous 통신 */
			$(document).on("click", "li.option", function() {
						// 연도별, 국가별 데이터도 같이 가져와야하기 때문에 $(this)가 무엇인지 고민해봐야하고 이벤트도 같이 걸어줘야함
						// 먼저 selected 클래스가 걸려있는 data-value 값을 가져옴
						// https://api.jquery.com/prop/
						var releaseYear = $("li[data-display=연도별]").parent().find(".selected").attr("data-value");
						var productionCountry = $("li[data-display=국가별]").parent().find(".selected").attr("data-value");
						var genreId = $("li[data-display=장르별]").parent().find(".selected").attr("data-value");
						var saw = $("li[data-display=관람유무]").parent().find(".selected").attr("data-value");
						var order = $("li[data-display=정렬]").parent().find(".selected").attr("data-value");
	
						// 만약 지금 처음 클릭한 것이라면 selected 클래스가 추가되기 전이므로 $(this) 의 data-value 값을 가져옴
						if ($(this).siblings('li[data-display=장르별]').length
								|| $(this).attr("data-display") === "장르별") {
							// console.log($(this));
							genreId = $(this).attr("data-value");
							$("select[name=genreId] option").prop("selected", false);
							$("select[name=genreId] option[value=" + genreId + "]").prop("selected", true);
						} else if ($(this).siblings('li[data-display=연도별]').length
								|| $(this).attr("data-display") === "연도별") {
							releaseYear = $(this).attr("data-value");
							$("select[name=releaseYear] option").prop("selected", false);
							$("select[name=releaseYear] option[value=" + releaseYear + "]").prop("selected", true);
						} else if ($(this).siblings('li[data-display=국가별]').length
								|| $(this).attr("data-display") === "국가별") {
							productionCountry = $(this).attr("data-value");
							$("select[name=productionCountry] option").prop("selected", false);
							$("select[name=productionCountry] option[value=" + productionCountry + "]").prop("selected", true);
						} else if ($(this).siblings('li[data-display=관람]').length
								|| $(this).attr("data-display") === "관람") {
							saw = $(this).attr("data-value");
							$("select[name=saw] option").prop("selected", false);
							$("select[name=saw] option[value=" + saw + "]").prop("selected", true);
						} else if ($(this).siblings('li[data-display=정렬]').length
								|| $(this).attr("data-display") === "정렬") {
							order = $(this).attr("data-value");
							$("select[name=order] option").prop("selected", false);
							$("select[name=order] option[value=" + order + "]").prop("selected", true);
						} else {
							console.log("선택된 것이 없습니다.");
						}
						$("#search-film-form").submit();
					});
			
			$(document).ready(function(){
				$('[data-toggle="tooltip"]').tooltip();
				$('[data-toggle="tooltip"]').click(function () {
				 $(this).tooltip('toggle');
				});
		  });
			
			/* 좋아요 AJAX */
			$(document).on("click", ".btn-like-film, .btn-liked-film", function() {
				// 영화 ID 찾기
				// var fid = $(this).closest("tr").find("td").eq(1).text();
				var fid = $(this).closest(".row").siblings("input[type=hidden]").val();
				var $this = $(this)[0];
				// console.log(fid);
	
				// flag
				if ($($this).hasClass("btn-like-film")) {
					var likeFlag = 1;
				} else {
					var likeFlag = 0;
				}
	
				$.ajax({
					url : "likeFilm.do",
					data : {
						"fid" : fid,
						"flag" : likeFlag
					},
					type : "post",
					dataType : "json",
					success : function(data) {
						// 이미 'LIKE'라면 'LIKED' 버튼이 보여짐
						if (data == 0) {
							alert("로그인 해주세요!");
						} else if (data > 0 && $($this).hasClass("btn-like-film")) {
							$($this).closest("div").find("button")
											.removeClass("btn-secondary")
											.removeClass("btn-like-film")
											.addClass("btn-danger")
											.addClass("btn-block")
											.addClass("btn-liked-film")
											.attr({"data-original-title":"좋아요 취소"})
											.html("<img src='resources/asterisk/img/like.png' style='width: 35px; height: 35px; display: block; margin: 0 auto;'>")
											.blur();
							$(".tooltip-inner").html("좋아요 취소");
						} else {
							$($this).closest("div").find("button")
											.removeClass("btn-danger")
											.removeClass("btn-liked-film")
											.addClass("btn-secondary")
											.addClass("btn-block")
											.addClass("btn-like-film")
											.attr({"data-original-title":"좋아요"})
											.html("<img src='resources/asterisk/img/like.png' style='width: 35px; height: 35px; display: block; margin: 0 auto;'>")
											.blur();
							$(".tooltip-inner").html("좋아요");
						}
					},
					error : function() {
						// console.log("통신 실패!");
					}
				});
			});
			
			/* 봤어요 AJAX */
			$(document).on("click", ".btn-see-film, .btn-saw-film", function() {
						// 영화 ID 찾기
						var fid = $(this).closest(".row").siblings("input[type=hidden]").val();
						var $this = $(this)[0];
	
						// flag
						if ($($this).hasClass("btn-see-film")) {
							var sawFlag = 1;
						} else {
							var sawFlag = 0;
						}
	
						$.ajax({
							url : "sawFilm.do",
							data : {
								"fid" : fid,
								"flag" : sawFlag
							},
							type : "post",
							dataType : "json",
							success : function(data) {
								// 이미 'SEE'라면 'SAW' 버튼이 보여짐
								if (data == 0) {
									alert("로그인 해주세요!");
								} else if (data > 0 && $($this).hasClass("btn-see-film")) {
									$($this).closest("div").find("button")
													.removeClass("btn-secondary")
													.removeClass("btn-see-film")
													.addClass("btn-danger")
													.addClass("btn-block")
													.addClass("btn-saw-film")
													.attr({"data-original-title":"봤어요 취소"})
													.html("<img src='resources/asterisk/img/see.png' style='width: 35px; height: 35px; display: block; margin: 0 auto;'>")
													.blur();
									$(".tooltip-inner").html("봤어요 취소");
								} else {
									$($this).closest("div").find("button")
													.removeClass("btn-danger")
													.removeClass("btn-saw-film")
													.addClass("btn-secondary")
													.addClass("btn-block")
													.addClass("btn-see-film")
													.attr({"data-original-title":"봤어요"})
													.html("<img src='resources/asterisk/img/see.png' style='width: 35px; height: 35px; display: block; margin: 0 auto;'>")
													.blur();
									$(".tooltip-inner").html("봤어요");
	
									$($this).closest(".row").siblings(".star-area").find("[name*=star-input]")
																																 .prop("checked", false)
																															   .trigger("blur");
									$($this).closest(".row").siblings(".star-area").find("b").text("0");
								}
							},
							error : function() {
								// console.log("통신 실패!");
							}
						});
					});
	
			$(function() {
				$(document)
				// 별 위에 마우스가 올라가면 'output b' 안에 숫자도 변경
				.on(
						"mouseover",
						".star-input label",
						function() {
							$(this).parent().siblings("output").find("b").text($(this).text());
						})
				// 별 위에서 마우스가 나올 때 체크된 것이 있으면 고정
				.on(
						"mouseleave",
						".star-input>.input",
						function() {
							var $checked = $(this).closest(".star-input").find(":checked");
							
							if ($checked.length === 0) {
								$(this).siblings("output").find("b").text("0");
							} else {
								$(this).siblings("output").find("b").text($checked.next().text());
							}
						})
				// 별을 클릭했을 때 DB에 별점을 기록하기 위한 AJAX
				.on("click", ".star-input label", function() {
					var $this = $(this);
					var $fid = $(this).closest("div").siblings(":hidden").val();
					var $star = $(this).text();
	
					$.ajax({
						url : "rateFilm.do",
						data : {
							"fid" : $fid,
							"star" : $star
						},
						type : "post",
						dataType : "json",
						success : function(data) {
							// console.log(data);
							if (data === 1) {
								// jQuery 1.6 이후 부터 라디오버튼과 체크박스를 다루기 위해서는 .prop() 함수를 사용해야 한다.
								$($this).closest(".star-input").find("[name*=star-input]")
																							 .prop("checked", false)
																						   .trigger("blur");
								$($this).parent().siblings("output").find("b").text("0");
							} else {
								$this.closest(".podo-film-card")
										 .find(".btn-see-film")
										 .removeClass("btn-secondary")
										 .removeClass("btn-see-film")
										 .addClass("btn-danger")
										 .addClass("btn-block")
										 .addClass("btn-saw-film")
										 .attr({"data-original-title":"봤어요 취소"})
										 .html("<img src='resources/asterisk/img/see.png' style='width: 35px; height: 35px; display: block; margin: 0 auto;'>");
							}
						},
						error : function() {
							// 비회원일 경우 별점 checked false
							alert("로그인 해주세요!");
							
							// jQuery 1.6 이후 부터 라디오버튼과 체크박스를 다루기 위해서는 .prop() 함수를 사용해야 한다.
							$($this).closest(".star-input").find("[name*=star-input]")
																						 .prop("checked", false)
																						 .trigger("blur");
							$($this).parent().siblings("output").find("b").text("0");
						}
					});
				});
			});
	
		</script>
	</body>
</html>