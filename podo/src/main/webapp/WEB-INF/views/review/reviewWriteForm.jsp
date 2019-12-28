<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
</head>
<body>
	<div id="body">
		<section class="blog-post-area section-margin">
			<div class="container">
			
				<div class="row">
					<div class="main_blog_details">
						<img class="img-fluid" src="resources/detailFilmImage/${ f.poster }" alt="">
						<h4 align="center">${ f.titleKor }</h4>
						<p>장르 : ${ f.genre }</p>
					</div>

					<div class="user_details">
						<div class="float-left">
							<div class="media">
								<div class="media-body">
									<h5>${ loginUser.nickName }님이 작성</h5>
								</div>
								<div class="d-flex">
									<img width="42" height="42" src="resources/memberProfileImage/${ loginUser.image }" alt="">
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="chart-box">
						<canvas id="myChart"></canvas>
					</div>
				</div>
				
				<div class="row">
					<form action="reviewWrite.do" method="get" id="movieform">
						<input type="hidden" value="${f.id}" name="filmId">
						<input type="hidden" value="${loginUser.id}" name="memberId">
						<input type="checkbox" value="0" name="spoilerCheck">스포일러 유무
						<table>
							<tr>
								<td>영화제목</td>
								<td><input type="text" name="titleKor" id="vtitle" value="${f.titleKor}"></td>
							</tr>
							<tr>
								<td>음악</td>
								<td><input type="number" name="ratingSound" class="form-control insertRating" id="ratingSound" placeholder="10점까지 입력가능" min="0" max="10" value=""></td>
							</tr>
							<tr>
								<td>영상</td>
								<td><input type="number" name="ratingVisual" class="form-control insertRating" id="ratingVisual" placeholder="10점까지 입력가능" min="0" max="10"></td>
							</tr>
							<tr>
								<td>연기</td>
								<td><input type="number" name="ratingActing" class="form-control insertRating" id="ratingActing" placeholder="10점까지 입력가능" min="0" max="10"></td>
							</tr>
							<tr>
								<td>대중성</td>
								<td><input type="number" name="ratingPop" class="form-control insertRating" id="ratingPop" placeholder="10점까지 입력가능" min="0" max="10"></td>
							</tr>
							<tr>
								<td>각본</td>
								<td><input type="number" name="ratingScript" class="form-control insertRating" id="ratingScript" placeholder="10점까지 입력가능" min="0" max="10"></td>
							</tr>
							<tr>
								<td>연출</td>
								<td><input type="number" name="ratingDirect" class="form-control insertRating" id="ratingDirect" placeholder="10점까지 입력가능" min="0" max="10"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea class="form-control" rows="4" cols="22" name="content"></textarea></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<button class="button" type="submit" id="ok1">영화평점등록하기</button>
									<button class="button" type="button" onclick="location.href='reviewList.do';">목록으로</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
				
			</div>
		</section>

		<script>
	 
			var ctx = document.getElementById('myChart');
			var chart = new Chart(ctx, {
				// The type of chart we want to create
				type: 'radar',
	      // The data for our dataset
	      data: {
					labels: ["음악", "영상", "연기", "대중성", "각본","연출"],
					datasets: [{
										label: "${f.titleKor}", 
										backgroundColor: "rgb(165,102,255)",
										pointBackground:"rgba(179,181,198,1)",
										pointBorderColor:"#fff",
										pointBorderBackgroundColor:"#fff",
										data: [
											${rr.ratingSound},
											${rr.ratingVisual},
											${rr.ratingActing},
	     	  			 			${rr.ratingPop},
	     	  			 			${rr.ratingScript},
	     	  			 			${rr.ratingDirect}
	     	   					]
	      					}]},
				// Configuration options go here
				options: {
					scale: {angleLines: {display: false},
									ticks: {suggestedMin: 0, suggestedMax: 10}},
					tooltips:{callbacks:
											{label: function(tooltipItem, data) {
																return data.labels[tooltipItem.index]  + " : "+ Math.round(tooltipItem.yLabel * 100) / 100 +"점";
															}
												}
										}
				}
			});
	    
			$('.insertRating').on('input',function(){
				var ctx = document.getElementById('myChart');
				var chart = new Chart(ctx, {
					// The type of chart we want to create
					type: 'radar',
					// The data for our dataset
					data: {labels: ["음악", "영상", "연기", "대중성", "각본","연출"],
								 datasets: [{
									 label: "${ rr.titleKor }",
									 backgroundColor: "rgb(165,102,255)",
									 pointBackground:"rgba(179,181,198,1)",
									 pointBorderColor:"#fff",
									 pointBorderBackgroundColor:"#fff",
									 data: [
										 $('#ratingSound').val(),
										 $('#ratingVisual').val(),
										 $('#ratingActing').val(),
										 $('#ratingPop').val(),
										 $('#ratingScript').val(),
										 $('#ratingDirect').val()
										 ]
									}]},
					// Configuration options go here
					options: {
						scale: {angleLines: {display: false},
										ticks: {suggestedMin: 0, suggestedMax: 10}},
										tooltips:{callbacks:
																{label: function(tooltipItem, data) {
                          								return data.labels[tooltipItem.index]  + " : "+ Math.round(tooltipItem.yLabel * 100) / 100 +"점";
	                        							}
                 								}
	                						}
	            			}
	        });
				});
	 
	   </script>

	</div>
</body>
</html>