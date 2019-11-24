<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>영화 찾기</title>
		<style>
			#search-film-result {
				border-collapse: collapse;
			}
			
			#search-film-result td, #search-film-result tr {
				text-align: center;
				border: 1px solid;
			}
			
			.star-input>.input,
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label {
				display: inline-block;
				vertical-align: middle;
				background: url('resources/common/img/rating-star.png') no-repeat;
			}
			
			.star-input {
				display: inline-block;
				white-space: nowrap;
				width: 150px;
				/* height: 40px; */
				/* padding: 25px; */
				line-height: 30px;
			}
			
			.star-input>.input {
				display: inline-block;
				width: 150px;
				background-size: 150px;
				height: 28px;
				white-space: nowrap;
				overflow: hidden;
				position: relative;
			}
			
			.star-input>.input>input {
				position: absolute;
				width: 1px;
				height: 1px;
				opacity: 0;
			}
			
			star-input>.input.focus {
				outline: 1px dotted #ddd;
			}
			
			.star-input>.input>label {
				width: 30px;
				height: 0;
				padding: 28px 0 0 0;
				overflow: hidden;
				float: left;
				cursor: pointer;
				position: absolute;
				top: 0;
				left: 0;
			}
			
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label {
				background-size: 150px;
				background-position: 0 bottom;
			}
			
			.star-input>.input>label:hover ~label{
				background-image: none;
			}
			
			.star-input>output {
				display: inline-block;
				width: 60px;
				font-size: 18px;
				text-align: right;
				vertical-align: middle;
			}
			
			.podo-film-card {
/* 				border: 1px solid; */
				padding-top: 40px;
				margin-left: 20px;
				display: inline-block;
				width: 241px;
				height: 620px;
				text-align: center;
			}
			
			.podo-film-card .poster img {
				 width: 240px;
				 height: 342px;
				 object-fit: cover;
			}
			
			@media (min-width: 1000px) {
				.film-page-banner {
					height: 550px;
				}
			}
			
			.film-page-banner {
				position: relative;
		    background: url(resources/bootstrap/img/banner/film-page-banner-exp.jpg) left center no-repeat;
		    background-size: cover;
		    /* filter: brightness(0.5); */
		    height: 400px;
			}
			
			.film-page-banner span {
				margin-left: 50px;
				color: white;
			}
			
			.film-page-banner .title {
				font-size: 40px;
			}
			
			.film-page-banner .content {
				font-size: 18px;
			}
			
		</style>
<!-- 		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
	</head>
  <body>
		<jsp:include page="../common/header.jsp"/>
		
		
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
						<%-- 
						<c:forEach begin="2010" end="2019" step="1" var="yyyy">
							<option value="${ yyyy }">${ yyyy }</option>
						</c:forEach>
						 --%>
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
					<select name="opt">
						<option value="all" data-display="정렬">모두</option>
						<option value="filmRatingDesc">평가 높은 순</option>
						<option value="reviewCountDesc">리뷰 많은 순</option>
					</select>
				</form>
				
			</div>
		</div>
		<!-- =================필터================= -->
		
		<div class="container">
			<div>
				<c:forEach items="${ film }" var="film" varStatus="status">
					<!-- width * 1.425 -->
					<div class="podo-film-card">
						<input class="hidden-filmId" type="hidden" value="${ film.id }">
						<div class="poster">
							<c:if test="${ not empty film.poster }">
								<img src="resources/detailFilmImage/${ film.poster }">
							</c:if>
							<c:if test="${ empty film.poster }">
								<img src="resources/detailFilmImage/podoposter.jpg">
							</c:if>
						</div>
						<div style="margin-top: 20px;">
							<h3>${ film.titleKor }</h3>
						</div>
						<div>
							<small>${ film.genre } / ${ film.releaseYear }</small>
						</div>
						<div style="margin-top: 10px;">
							<c:if test="${ not empty like[film.id] }">
								<button class='btn btn-danger btn-liked-film'>LIKED</button>
							</c:if>
							<c:if test="${ empty like[film.id] }">
								<button class='btn btn-secondary btn-like-film'>LIKE</button>
							</c:if>
						</div>
						<div style="margin-top: 10px;">
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
		</div>
		
		<!-- 페이지 -->
	<div class="row">
		<div class="col-lg-12">
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination">

					<!-- [PREV] -->
					<li class="page-item">
						<a href="film.do?currentPage=${ pi.currentPage - 1 }"
																		class="page-link" aria-label="Previous" disabled>
							<span aria-hidden="true"><i class="ti-angle-left"></i></span>
						</a>
					</li>

					<!-- [페이지] -->
					<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
						<c:if test="${ p eq pi.currentPage }">
							<c:url value="film.do" var="page">
								<c:param name="currentPage" value="${ p }" />
							</c:url>
							<li class="page-item disabled"><a href="${ page }"
								class="page-link">${ p }</a></li>
						</c:if>
						<c:if test="${ p ne pi.currentPage }">
							<c:url value="film.do" var="page">
								<c:param name="currentPage" value="${ p }" />
							</c:url>
							<li class="page-item"><a href="${ page }" class="page-link">${ p }</a></li>
						</c:if>

					</c:forEach>

					<!-- [NEXT] -->
					<li class="page-item">
						<a href="film.do?currentPage=${ pi.currentPage + 1 }"
								class="page-link" aria-label="Next">
							<span aria-hidden="true">
								<i class="ti-angle-right"></i>
							</span>
						</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>




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
			if ($.urlParam("opt") === "filmRatingDesc") {
				$("select[name=opt] option[value=filmRatingDesc]").attr("selected", true);
			} else if ($.urlParam("opt") === "reviewCountDesc") {
				$("select[name=opt] option[value=reviewCountDesc]").attr("selected", true);
			} else {
				$("select[name=opt] option[value=all]").attr("selected", true);
			}
		});

		/* nice-select 라이브러리 */
		$(document).ready(function() {
			$('select').niceSelect();
		});

		/* 영화 검색목록 불러오기 Synchronous 통신 */
		$(document).on(
				"click",
				"li.option",
				function() {
					// 연도별, 국가별 데이터도 같이 가져와야하기 때문에 $(this)가 무엇인지 고민해봐야하고 이벤트도 같이 걸어줘야함
					// 먼저 selected 클래스가 걸려있는 data-value 값을 가져옴
					// var releaseYear = $("select[name=releaseYear]").val();
					var releaseYear = $("li[data-display=연도별]").parent().find(".selected").attr("data-value");
					var productionCountry = $("li[data-display=국가별]").parent().find(".selected").attr("data-value");
					var genreId = $("li[data-display=장르별]").parent().find(".selected").attr("data-value");
					var saw = $("li[data-display=관람유무]").parent().find(".selected").attr("data-value");
					var opt = $("li[data-display=부가옵션]").parent().find(".selected").attr("data-value");

					// 만약 지금 클릭한 것이라면 selected 클래스가 추가되기 전이므로 $(this) 의 data-value 값을 가져옴
					if ($(this).siblings('li[data-display=장르별]').length
							|| $(this).attr("data-display") === "장르별") {
						// console.log($(this));
						genreId = $(this).attr("data-value");
						$("select[name=genreId] option")
								.attr("selected", false);
						$("select[name=genreId] option[value=" + genreId + "]")
								.attr("selected", true);
					} else if ($(this).siblings('li[data-display=연도별]').length
							|| $(this).attr("data-display") === "연도별") {
						releaseYear = $(this).attr("data-value");
						$("select[name=releaseYear] option").attr("selected", false);
						$("select[name=releaseYear] option[value=" + releaseYear + "]").attr("selected", true);
					} else if ($(this).siblings('li[data-display=국가별]').length
							|| $(this).attr("data-display") === "국가별") {
						productionCountry = $(this).attr("data-value");
						$("select[name=productionCountry] option").attr("selected", false);
						$("select[name=productionCountry] option[value=" + productionCountry + "]").attr("selected", true);
					} else if ($(this).siblings('li[data-display=관람]').length
							|| $(this).attr("data-display") === "관람") {
						saw = $(this).attr("data-value");
						$("select[name=saw] option").attr("selected", false);
						$("select[name=saw] option[value=" + saw + "]").attr("selected", true);
					} else if ($(this).siblings('li[data-display=정렬]').length
							|| $(this).attr("data-display") === "정렬") {
						opt = $(this).attr("data-value");
						$("select[name=opt] option").attr("selected", false);
						$("select[name=opt] option[value=" + opt + "]").attr("selected", true);
					} else {
						console.log("선택된 것이 없다?");
					}

					$("#search-film-form").submit();

					/* 
					location.href = 'film.do?releaseYear=' + releaseYear 
												+ '&productionCountry=' + productionCountry
												+ '&genreId=' + genreId;
					 */
				});

		// 페이징 처리를 위해 AJAX 대신 동기적으로 처리
		/* 영화 검색목록 불러오기 AJAX */
		/*
		// $("select[name=releaseYear], select[name=productionCountry], select[name=genre]").on("change", function(){
		$(document).on("click", "li.option", function() {
			
			// 연도별, 국가별 데이터도 같이 가져와야하기 때문에 $(this)가 무엇인지 고민해봐야하고 이벤트도 같이 걸어줘야함
			// 먼저 selected 클래스가 걸려있는 data-value 값을 가져옴
			// var releaseYear = $("select[name=releaseYear]").val();
			var releaseYear = $("li[data-display=연도별]").parent().find(".selected").attr("data-value");
			var productionCountry = $("li[data-display=국가별]").parent().find(".selected").attr("data-value");
			var genreId = $("li[data-display=장르별]").parent().find(".selected").attr("data-value");
			
			// 만약 지금 클릭한 것이라면 selected 클래스가 추가되기 전이므로 $(this) 의 data-value 값을 가져옴
			if ($(this).siblings('li[data-display=장르별]').length || $(this).attr("data-display") === "장르별") {
				console.log($(this));
				genreId = $(this).attr("data-value");
			} else if ($(this).siblings('li[data-display=연도별]').length || $(this).attr("data-display") === "연도별") {
				releaseYear = $(this).attr("data-value");
			} else if ($(this).siblings('li[data-display=국가별]').length || $(this).attr("data-display") === "국가별") {
				productionCountry = $(this).attr("data-value");
			} else {
				console.log("선택된 것이 없다?");
			}
			
			// 필터 검색 AJAX
			$.ajax({
				url:"sfFilm.do",
				data:{ releaseYear : releaseYear,
						   productionCountry : productionCountry,
						   genreId : genreId },
				success:function(data){
					
					$tbody = $("#search-film-result tbody");
					$tbody.html("");
					
					$("#film-count").text("검색결과(" + data.film.length + ")");
					
					if (data.film.length > 0){
						
						var like = data.like;
						var rate = data.rate;
						
						var i=1;
						var j=1;
						
						// 가져온 데이터를 $.each 메서드로 동적 생성
						$.each(data.film, function(index, value){
							$tr = $("<tr></tr>");
							
							$korTd = $("<td width='100'></td>").text(value.titleKor);
							$idTd = $("<td id='film-id-td' style='display: none;'></td>").text(value.id);
							$engTd = $("<td></td>").text(value.titleEng);
							$directorTd = $("<td></td>").text(value.director);
							$releaseTd = $("<td></td>").text(value.releaseYear);
							$countryTd = $("<td></td>").text(value.productionCountry);
							$genreTd = $("<td></td>").text(value.genre);
							$posterTd = $("<td></td>").html("<img src='resources/detailFilmImage/podoposter.jpg' style='width: 107px; height: 152px; object-fit: cover;'>");
							
							// 좋아요한 영화인지 검사
							if (like[value.id] != null) {
								$likeTd = $("<td></td>").html("<button class='btn btn-danger btn-liked-film'>LIKED</button>");
							} else {
								$likeTd = $("<td></td>").html("<button class='btn btn-secondary btn-like-film'>LIKE</button>");
							}
							
							
							var star1 = "style='width: 30px; z-index: 5;'";
							var star2 = "style='width: 60px; z-index: 4;'";
							var star3 = "style='width: 90px; z-index: 3;'";
							var star4 = "style='width: 120px; z-index: 2;'";
							var star5 = "style='width: 150px; z-index: 1;'";
							
							var	str = "<span class='star-input'>"
											+ "<span class='input'>"
											+ "<input type='radio' name='star-input" + j + "' value='1' id='p" + i + "'>"
		    							+ "<label for='p" + i + "' " + star1 + ">1</label>";
		    							i++;
					    							
			    				str += "<input type='radio' name='star-input" + j + "' value='2' id='p" + i +"'>"
		    							+ "<label for='p" + i + "' " + star2 + ">2</label>";
		    							i++;
			    						
			    				str	+= "<input type='radio' name='star-input" + j + "' value='3' id='p"+ i + "'>"
		    							+ "<label for='p" + i + "' " + star3 + ">3</label>";
		    							i++;
			    							
									str += "<input type='radio' name='star-input" + j + "' value='4' id='p" + i + "'>"
								    	+ "<label for='p" + i + "' " + star4 + ">4</label>";
								    	i++;
									    	
									str	+= "<input type='radio' name='star-input" + j + "' value='5' id='p" + i + "'>"
								    	+ "<label for='p" + i + "' " + star5 + ">5</label>"
								  		+ "</span>"
									  	+ "<output for='star-input'><b style='display: none;'>0</b></output>"
											+ "</span>";
											i++;
											j++;
											
							$starTd = $("<td></td>").html(str);

							if (rate[value.id] != null) {
								var star = parseInt(rate[value.id].star);
								var $rated = $($starTd).find("input");
								var $checked = $($rated).eq(star - 1);
								$($checked).prop("checked", true);
								$($checked).parent().siblings("output").find("b").text(star);
							}
							
							$tr.append($korTd);
							$tr.append($idTd);
							$tr.append($engTd);
							$tr.append($directorTd);
							$tr.append($releaseTd);
							$tr.append($countryTd);
							$tr.append($genreTd);
							$tr.append($posterTd);
							$tr.append($likeTd);
							$tr.append($starTd);
							
							$tbody.append($tr);
						
						});
						
					} else {
						
						$tr = $("<tr></tr>");
						
						$contentTd = $("<td colspan='9'></td>").text("검색된 결과가 없습니다.");
						$tr.append($contentTd);
						
						$tbody.append($tr);
					}
					
				},
				error:function(){
					console.log("ajax 통신 실패");
				}
			});
			
		});
		 */

		/* 좋아요 AJAX */
		$(document).on("click", ".btn-like-film, .btn-liked-film", function() {
					// 영화 ID 찾기
					// var fid = $(this).closest("tr").find("td").eq(1).text();
					var fid = $(this).parent().siblings("input[type=hidden]").val();
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
							if (data > 0
									&& $($this).hasClass(
											"btn-like-film")) {
								$($this).closest("div").find("button")
												.removeClass("btn-secondary")
												.removeClass("btn-like-film")
												.addClass("btn-danger")
												.addClass("btn-liked-film")
												.text("LIKED");
							} else {
								$($this).closest("div").find("button")
												.removeClass("btn-danger")
												.removeClass("btn-liked-film")
												.addClass("btn-secondary")
												.addClass("btn-like-film")
												.text("LIKE");
							}
						},
						error : function() {
							alert("로그인 해주세요!");
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
						// console.log($checked);
						if ($checked.length === 0) {
							$(this).siblings("output").find("b").text("0");
						} else {
							$(this).siblings("output").find("b").text($checked.next().text());
						}
					})
			// 별을 클릭했을 때 DB에 별점을 기록하기 위한 AJAX
			.on("click", ".star-input label", function() {
				// var fid = $(this).closest("tr").find("td").eq(1).text();
				var fid = $(this).closest("div").siblings(":hidden").val();
				var star = $(this).text();
				// console.log("fid : " + fid);
				// console.log("star : " + star);

				// var $checked = $(this).closest(".star-input").find(":checked");
				// console.log($checked);

				$.ajax({
					url : "rateFilm.do",
					data : {
						"fid" : fid,
						"star" : star
					},
					type : "post",
					dataType : "json",
					success : function(data) {
						// console.log(data);
					},
					error : function() {
						alert("로그인 해주세요!");
					}
				});
			});
		});
	</script>
	
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>