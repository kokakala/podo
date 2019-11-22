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
				width: 225px;
				height: 40px;
				padding: 25px;
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
		</style>
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	</head>
  <body>
		<jsp:include page="../common/header.jsp"/>
		
		<div class="container">
			<h3>
				작품찾기에서는 원하는 영화를 어디에서 볼 수 있는지, 내가 이용하는 서비스가 어떤 영화들을 제공하고 있는지를 확인할 수 있습니다. <br>
				다양한 필터를 적용해 오늘 감상할 영화를 찾아보세요!
			</h3>
			
			<select name="releaseYear">
				<option value="">연도별</option>
				<c:forEach begin="2010" end="2019" step="1" var="yyyy">
					<option value="${ yyyy }">${ yyyy }</option>
				</c:forEach>
			</select>
			<select name="productionCountry">
				<option value="">국가별</option>
				<option value="한국">한국</option>
				<option value="미국">미국</option>
				<option value="일본">일본</option>
			</select>
			<select name="genre">
				<option value="">장르별</option>
				<c:forEach items="${ genre }" var="g">
					<option value="${ g.id }">${ g.name }</option>
				</c:forEach>
			</select>
			
			<table id="search-film-result">
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
		
		</div>
		
		
		<script>
			
			/* 영화 검색목록 불러오기 AJAX */
			$("select[name=releaseYear], select[name=productionCountry], select[name=genre]").on("change", function(){
				
				var releaseYear = $("select[name=releaseYear]").val();
				var productionCountry = $("select[name=productionCountry]").val();
				var genre = $("select[name=genre]").val();
				
				$.ajax({
					url:"sfFilm.do",
					data:{ releaseYear : releaseYear,
							   productionCountry : productionCountry,
							   genre : genre },
					success:function(data){
						
						$tbody = $("#search-film-result tbody");
						$tbody.html("");
						
						$("#film-count").text("검색결과(" + data.film.length + ")");

						if (data.film.length > 0){
							
							var like = data.like;
							var rate = data.rate;
							console.log(rate);
							
							var i=1;
							var j=1;
							
							$.each(data.film, function(index, value){
								$tr = $("<tr></tr>");
								
								$korTd = $("<td width='100'></td>").text(value.titleKor);
								$idTd = $("<td id='film-id-td' style='display: none;'></td>").text(value.id);
								$engTd = $("<td></td>").text(value.titleEng);
								$directorTd = $("<td></td>").text(value.director);
								$releaseTd = $("<td></td>").text(value.releaseYear);
								$countryTd = $("<td></td>").text(value.productionCountry);
								$genreTd = $("<td></td>").text(value.genre);
								$posterTd = $("<td></td>").html("<img src='http://placehold.it/107x152'>");
								
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
			
			/* 좋아요 AJAX */
			$(document).on("click", ".btn-like-film, .btn-liked-film", function(){
				// 영화 ID 찾기
				var fid = $(this).closest("tr").find("td").eq(1).text();
				var $this = $(this)[0];
				
				// flag
				if ($($this).hasClass("btn-like-film")) {
					var likeFlag = 1;
				} else {
					var likeFlag = 0;
				}
				
				$.ajax({
					url:"likeFilm.do",
					data:{"fid":fid, "flag":likeFlag},
					type:"post",
					dataType:"json",
					success:function(data){
						// 이미 'LIKE'라면 'LIKED' 버튼이 보여짐
						if (data > 0 && $($this).hasClass("btn-like-film")) {
							$($this).closest("td").find("button")
							 				.removeClass("btn-secondary")
										 	.removeClass("btn-like-film")
										  .addClass("btn-danger")
										  .addClass("btn-liked-film")
										  .text("LIKED");
						} else {
							$($this).closest("td").find("button")
											.removeClass("btn-danger")
											.removeClass("btn-liked-film")
											.addClass("btn-secondary")
											.addClass("btn-like-film")
											.text("LIKE");
						}
					},
					error:function(){
						alert("로그인 해주세요!");
					}
				});
			});
			
			$(function(){
		  	$(document)
		    .on("mouseover", ".star-input label", function(){
		    	$(this).parent().siblings("output").find("b").text($(this).text());
		    })
		    .on("mouseleave", ".star-input>.input", function(){
	    		var $checked = $(this).closest(".star-input").find(":checked");
	    		if ($checked.length === 0) {
	    			$(this).siblings("output").find("b").text("0");
	   		 	} else {
	   		 		$(this).siblings("output").find("b").text($checked.next().text());
	    		}
		  	})
		  	.on("click", ".star-input label", function(){
					var fid = $(this).closest("tr").find("td").eq(1).text();
		  		var star = $(this).text();
		  		console.log("star : " + star);
		  		console.log("fid : " + fid);
		  		
		  		var $checked = $(this).closest(".star-input").find(":checked");
		  		console.log($checked);
		  		
		  		$.ajax({
		  			url:"rateFilm.do",
						data:{"fid":fid, "star":star},
						type:"post",
						dataType:"json",
						error:function(){
							alert("로그인 해주세요!");
						}
		  		});
		  	});
			});

		</script>
	
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>