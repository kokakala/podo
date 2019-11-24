<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>

	<h1 align="center">등록페이지</h1>
	<br>
	
	<form action="finsert.do" method="post" enctype="multipart/form-data">
		<table align="center">
			<tr>
				<td>장르</td>
				<td>
					<select name="genreId">
						<option value="">장르별</option>
						<c:forEach items="${ genre }" var="g">
							<option value="${ g.id }">${ g.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>포스터</td>
				<td>
					<div class="form-group">
						* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
						<img id="preview" src="resources/detailFilmImage/podoposter.jpg" style="width: 107px; height: 152px; object-fit: cover; cursor: pointer;"><br>
						<button type="button" id="uploadBtn">이미지 변경</button>
						<button type="button" onclick="fileReset();">이미지 삭제</button><br>
						<div id="imgArea"><input type='file' id='imgInp' name='poster'></div><br>
					</div>
				</td>
			</tr>
			<tr>
				<td>제목(국문)</td>
				<td><input type="text" name="titleKor"></td>
			</tr>
			<tr>
				<td>제목(영문)</td>
				<td><input type="text" name="titleEng"></td>
			</tr>
			<tr>
				<td>감독</td>
				<td><input type="text" name="director"></td>
			</tr>
			<tr>
				<td>제작년도</td>
				<td><input type="text" name="releaseYear"></td>
			</tr>
			<tr>
				<td>제작국가</td>
				<td><input type="text" name="productionCountry"></td>
			</tr>
			<tr>
				<td>개봉상태</td>
				<td>
					<input type="radio" id="released" name="productionStatus" value="개봉">
					<label for="released">개봉</label>
					<input type="radio" id="releasing" name="productionStatus" value="개봉예정">
					<label for="releasing">개봉예정</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">등록하기</button> 
					<button type="button" onclick="location.href='flist.do';">목록으로</button>
				</td>
			</tr>
		</table>
	</form>
	
	<script>
		
		// Author : 혜경한
		// 이미지 삭제 버튼 클릭 시
		function fileReset() {
			$("#imgArea input").remove();
			$("#preview").attr({'src':'resources/detailFilmImage/podoposter.jpg',
													'style':'width: 107px; height: 152px; object-fit: cover; cursor: pointer;'});
			var newInput = "<input type='file' id='imgInp' name='poster'>";
			$("#imgArea").append(newInput);
		}
		
		// 이미지 미리보기
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#preview').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		};

		// 이미지 변경 될 때 마다 이미지 미리보기 함수 실행
		$(document).on("change", "#imgInp", function() {
			readURL(this);
		});

		// 이미지 버튼 클릭 시 인풋창 열리게 (안보이게 해둠)
		$("#uploadBtn, #preview").on('click', function(e) {
			e.preventDefault();
			$("#imgInp").click();
		});
	</script>
	<jsp:include page="../common/footer.jsp"/>
	
</body>
</html>