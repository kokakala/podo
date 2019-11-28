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
			
			#search-film-result td,
			#search-film-result tr {
				text-align: center;
				border: 1px solid;
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
						<th colspan="6"><b id="film-count"></b></th>
					</tr>
					<tr>
						<th colspan="2">제목</th>
						<th>감독</th>
						<th>개봉연도</th>
						<th>국가</th>
						<th>장르</th>	
						<th>포스터</th>	
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ list }" var="f">
						<tr>
							<td>${ f.titleKor }</td>
							<td>${ f.titleEng }</td>
							<td>${ f.director }</td>
							<td>${ f.releaseYear }</td>
							<td>${ f.productionCountry }</td>
							<td>${ f.genre }</td>
							<td><img src="http://placehold.it/150x200"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
		
		
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
								$posterTd = $("<td></td>").html("<img src='http://placehold.it/107x152'>");
								
								$tr.append($korTd);
								$tr.append($engTd);
								$tr.append($directorTd);
								$tr.append($releaseTd);
								$tr.append($countryTd);
								$tr.append($genreTd);
								$tr.append($posterTd);
								
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
	
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>