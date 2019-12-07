<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>포도포도</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<link rel="icon" href="resources/bootstrap/img/favicon.png" type="image/png">
		
		<!-- js -->
		<script src="resources/bootstrap/vendors/jquery/jquery-3.2.1.min.js"></script>
		<script src="resources/bootstrap/vendors/bootstrap/bootstrap.bundle.min.js"></script>
		
		<!-- css -->
		<link rel="stylesheet" href="resources/bootstrap/vendors/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" href="resources/bootstrap/vendors/fontawesome/css/all.min.css">
		<link rel="stylesheet" href="resources/bootstrap/vendors/themify-icons/themify-icons.css">
		<link rel="stylesheet" href="resources/bootstrap/vendors/linericon/style.css">
		<link rel="stylesheet" href="resources/bootstrap/vendors/owl-carousel/owl.theme.default.min.css">
		<link rel="stylesheet" href="resources/bootstrap/vendors/owl-carousel/owl.carousel.min.css">
		<link rel="stylesheet" href="resources/bootstrap/vendors/nice-select/nice-select.css">
		<link rel="stylesheet" href="resources/bootstrap/css/style.css">
		
		<!-- 폰트 -->
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700&display=swap" rel="stylesheet">
		
		<style>
			
			.search-form {
				display: inline-block;
				text-align: center;
			}
			
			.owl-carousel .owl-item img {
				height: 340px;
				object-fit: cover;
			}
			
			.blog__slide__img {
				cursor: pointer;
			}
			
			.modal-dialog,
			.modal-title {
				color: #495057;
			}
			
		</style>
		
	</head>
	<body>
		<header class="header_area">
			<div class="main_menu">
				<nav class="navbar navbar-expand-lg navbar-light">
					<div class="container box_1620">
		      
						<!-- Brand and toggle get grouped for better mobile display -->
						<a class="navbar-brand logo_h" href="home.do">
							<img src="resources/bootstrap/img/logo/logo-transparent-text-lg.png" alt="" style="width: 80px; height: 80px; object-fit: cover;">
						</a>
						<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						
						<div class="navbar-collapse offset collapse" id="navbarSupportedContent">
							<ul class="nav navbar-nav menu_nav justify-content-center">
								<li class="nav-item"><a class="nav-link" href="film.do?p=1">영화</a></li>
								<li class="nav-item"><a class="nav-link" href="reviewList.do">리뷰</a>
								<li class="nav-item"><a class="nav-link" href="rec.do">추천</a>
	
								<li class="nav-item"><a class="nav-link" href="blist.do">게시판</a>					
								<c:choose>
							       <c:when test="${ loginUser.autho eq 2}">
							       		<li class="nav-item"><a id="logout" class="nav-link" href="logout.do">로그아웃</a>
										<li class="nav-item"><a id="logout" class="nav-link" href="manyStar.do">관리자</a>
							       </c:when>
							       <c:when test="${ loginUser ne null }">
							       		<li class="nav-item"><a id="logout" class="nav-link" href="logout.do">로그아웃</a>
										<li class="nav-item"><a id="logout" class="nav-link" href="myPage.do?id=${ loginUser.id }">마이페이지</a>
							       </c:when>
							       <c:otherwise>
							       		<li class="nav-item"><a id="login-modal" class="nav-link" href="#" data-toggle="modal">로그인</a>
							       </c:otherwise>
							   </c:choose>
							</ul>
						</div>
						<form method="get" action="skFilm.do" class="form-inline my-4 my-lg-0">
							<c:if test="${ !empty keyword }">
								<input class="form-control mr-sm-2" type="search" placeholder="키워드를 입력해주세요" aria-label="Search" name="keyword" value="${ keyword }">
							</c:if>
							<c:if test="${ empty keyword }">
								<input class="form-control mr-sm-2" type="search" placeholder="키워드를 입력해주세요" aria-label="Search" name="keyword">
							</c:if>
							<button class="button button--active my-2 my-sm-0" type="submit">검색</button>
						</form>
					</div>
				</nav>
			</div>
		</header>
	  
  	<!-- 로그인 모달 -->
		<hr style="margin: 0;">
		<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
						<form class="" action="login.do" method="post">
							<div class="form-group">
								<label for="email">이메일</label>
								<input type="email" class="form-control" name="email" id="email" placeholder="email@address.com">
							</div>
							<div class="form-group">
								<label for="pwd">비밀번호</label>
								<input type="password" class="form-control" name="pwd" id="pwd" placeholder="Password">
							</div>
							<div class="form-group">
								<div class="form-check">
									<input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
									<label class="form-check-label" for="rememberMe">
								  		로그인 정보 기억하기
									</label>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" id="btn-sign-in" class="btn" style="background:purple; color:white;">로그인</button>
								<button type="button" class="btn btn-default" id="myBtn"  style="background:#ff79fb; color:white;" onclick="location.href='insertFormMember.do';">가입하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	
	
		<script>
			$(function(){
				$("#login-modal, #rec-login-modal").on("click",function(){
					$('#loginModal').modal('toggle');
				});
			});
		
			$(function(){
			    if (getCookie("email")) {
			       var email = getCookie("email").split(";")
			       $("#email").val(email[0]);
				}
			    
			    if (getCookie("pwd")) {
			    	var pwd = getCookie("pwd").split(";")
					$("#pwd").val(pwd[0]);
				}  
			    
			    if ($("#email").val() != "" && $("#pwd").val() != ""){
			        $("#rememberMe").attr("checked", true);
			    }
			});
		 	
			function getCookie(cookieName) {
				cookieName = cookieName + '=';
				var cookieData = document.cookie;
				var start = cookieData.indexOf(cookieName);
				var cookieValue = '';
				if (start != -1) {
					start += cookieName.length;
					var end = cookieData.indexOf(';', start);
					if (end == -1)
						end = cookieData.length;
					cookieValue = cookieData.substring(start, end);
				}
				return unescape(cookieValue);
			}
			
			$(function(){
				var msg = '${msg}';
				if (msg != '') {
					alert(msg);
					<% session.removeAttribute("msg"); %>
				}
			});
			
		</script>
	</body>
</html>