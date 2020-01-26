<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/header.jsp"/>
	<style>
.faq {
	width: 100%;
	padding: 20px;
}

.faq-q {
	cursor: pointer;
	background: gray;
	font-size: 17px;
}

.faq-q+.contents {
	display: none;
}
</style>
</head>
<body>
	<h1 align="center">이용가이드</h1>
	
	<div class="container">
		<div class="faq">
			<div class="faq-q">
				Q. PODO는 어떤 사이트인가요?
			</div>
			<p class="contents">
				A. PODO는 유저들이 영화를 직접 평가하고 리뷰를 남기는 사이트 입니다.
				<br>
				유저들이 직접 영화에 대한 정보를 입력하고 작품을 검색하고 추천하는 서비스를 제공하고 있습니다.
			</p>
			
			<br>
			
			<div class="faq-q">Q. 영화 평가와 리뷰 작성은 어디서 할 수 있나요?</div>
			<p class="contents">A. 각 메뉴에서 사용할 수 있습니다.</p>
			
			<br>
			
			<div class="faq-q">Q. 비밀번호를 변경하고 싶어요.</div>
			<p class="contents">
				A. 로그인한 상태에서 [마이페이지]-[정보수정] 버튼을 클릭하시면 새 비밀번호로
				<br>
				기존의 비밀번호를 변경하실 수 있습니다.
			</p>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp"/>
	
	<script>
		$(".faq div").click(function(){
			if($(this).next().css("display") == "none"){
				$(this).siblings("p").slideUp();
				$(this).next().slideDown();
			}else{
				$(this).next().slideUp();
			}
		});
	</script>
</body>
</html>