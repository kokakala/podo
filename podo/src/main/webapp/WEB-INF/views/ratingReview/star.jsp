<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>영화 찾기</title>
		<style>
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

		
		<span class="star-input">
		<span class="input">
		<input type="radio" name="star-input1" value="1" id="p1">
			<label for="p1" style="width: 30px; z-index: 5;">1</label>
		<input type="radio" name="star-input1" value="2" id="p2">
			<label for="p2" style="width: 60px; z-index: 4;">2</label>
		<input type="radio" name="star-input1" value="3" id="p3">
			<label for="p3" style="width: 90px; z-index: 3;">3</label>
		<input type="radio" name="star-input1" value="4" id="p4">
			<label for="p4" style="width: 120px; z-index: 2;">4</label>
		<input type="radio" name="star-input1" value="5" id="p5">
			<label for="p5" style="width: 150px; z-index: 1;">5</label>
		</span>
		<output for="star-input"><b style="display: none;"></b></output>
		</span>
	
	
	<script>
						
						
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
	</body>
</html>