<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	</head>
	<body>
		<div style="width: 900px;">
			<h1>작품찾기에서는 원하는 영화를 어디에서 볼 수 있는지, 내가 이용하는 서비스가 어떤 영화들을 제공하고 있는지를 확인할 수 있습니다. <br>
				다양한 필터를 적용해 오늘 감상할 영화를 찾아보세요!</h1>
		</div>
		<select name="releaseYear">
			<option value="2019">2019</option>
			<option value="2018">2018</option>
		</select>
		<select name="productionCountry">
			<option value="한국">한국</option>
			<option value="미국">미국</option>
		</select>
		<select name="genre">
			<option value="1">드라마</option>
			<option value="2">액션</option>
			<option value="3">다큐멘터리</option>
		</select>
		
		<table id="search-film-result">
			<thead>
				<tr>
					<th colspan="6"><b id="film-count"></b></th>
				</tr>
				<tr>
					<th colspan="2">제목</th>
					<th>감독</th>
					<th>개봉연도</th>
					<th>국가</th>
					<th>장르</th>
				</tr>
			</thead>
			<tbody>
				<%-- <c:forEach items="${ list }" var="f">
					<tr>
						<td>${ f.titleKor }</td>
						<td>${ f.titleEng }</td>
						<td>${ f.director }</td>
						<td>${ f.releaseYear }</td>
						<td>${ f.productionCountry }</td>
						<td>${ f.genre }</td>
					</tr>
				</c:forEach> --%>
			</tbody>
		</table>
		<script>
			
			$("select[name=releaseYear], select[name=productionCountry], select[name=genre]").on("change", function(){
				
				var releaseYear = $("select[name=releaseYear]").val();
				var productionCountry = $("select[name=productionCountry]").val();
				var genre = $("select[name=genre]").val();
				// console.log(releaseYear);
				// console.log(productionCountry);
				// console.log(genre);
				
				$.ajax({
					url:"sfFilm.do",
					data:{ releaseYear : releaseYear,
						   productionCountry : productionCountry,
						   genre : genre },
					success:function(data){
						console.log("ajax 통신 성공");
						// console.log(data);
						
						$tbody = $("#search-film-result tbody");
						$tbody.html("");
						
						$("#film-count").text("검색결과(" + data.length + ")");
						
						if (data.length > 0){
							
							$.each(data, function(index, value){
								$tr = $("<tr></tr>");
								
								$korTd = $("<td width='100'></td>").text(value.titleKor);
								$engTd = $("<td></td>").text(value.titleEng);
								$directorTd = $("<td></td>").text(value.director);
								$releaseTd = $("<td></td>").text(value.releaseYear);
								$countryTd = $("<td></td>").text(value.productionCountry);
								$genreTd = $("<td></td>").text(value.genre);
								
								$tr.append($korTd);
								$tr.append($engTd);
								$tr.append($directorTd);
								$tr.append($releaseTd);
								$tr.append($countryTd);
								$tr.append($genreTd);
								
								$tbody.append($tr);
							
							});
							
						} else {
							
							$tr = $("<tr></tr>");
							
							$contentTd = $("<td colspan='6'></td>").text("검색된 결과가 없습니다.");
							$tr.append($contentTd);
							
							$tbody.append($tr);
						}
						
					},
					error:function(){
						console.log("ajax 통신 실패");
					}
				});
				
			});
			
		</script>
	</body>
</html>