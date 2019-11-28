<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	
	<link rel="icon" href="resources/bootstrap/img/Fevicon.png" type="image/png">
	<link rel="stylesheet" href="resources/bootstrap/vendors/bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="resources/bootstrap/vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="resources/bootstrap/vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="resources/bootstrap/vendors/linericon/style.css">
	<link rel="stylesheet" href="resources/bootstrap/vendors/owl-carousel/owl.theme.default.min.css">
	<link rel="stylesheet" href="resources/bootstrap/vendors/owl-carousel/owl.carousel.min.css">
	<link rel="stylesheet" href="resources/bootstrap/css/style.css">
	
	<script src="resources/bootstrap/vendors/jquery/jquery-3.2.1.min.js"></script>
	<script src="resources/bootstrap/vendors/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="resources/bootstrap/vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="resources/bootstrap/js/jquery.ajaxchimp.min.js"></script>
	<script src="resources/bootstrap/js/mail-script.js"></script>
	<script src="resources/bootstrap/js/main.js"></script>

</head>
<body>
	<header class="header_area">
		<div class="main_menu">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div class="container box_1620">
	      
					<!-- Brand and toggle get grouped for better mobile display -->
					<a class="navbar-brand logo_h" href="resources/bootstrap/index.html">
						<img src="img/logo.png" alt="">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse offset" id="navbarSupportedContent">
						<ul class="nav navbar-nav menu_nav justify-content-center">
							<li class="nav-item"><a class="nav-link" href="home.do">메인</a></li> 
							<li class="nav-item"><a class="nav-link" href="film.do">영화</a></li>
							<!-- 봉운 테스트 20191116 -->
							<li class="nav-item"><a class="nav-link" href="detailFilm.do?id=4">영화 상세페이지로(임시, 조커영화 번호 1번)</a></li>
							<li class="nav-item"><a class="nav-link" href="#">리뷰</a>
							<li class="nav-item"><a class="nav-link" href="#">추천</a>
							<li class="nav-item submenu dropdown">
								<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">게시판</a>
								<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="#">자유 게시판</a></li>
								</ul>
							</li>
							<c:if test="${ loginUser ne null }">
								<li class="nav-item"><a id="logout" class="nav-link" href="logout.do">로그아웃</a>
								<li class="nav-item"><a id="logout" class="nav-link" href="myPageForm.do">마이페이지</a>
							</c:if>
							<c:if test="${ loginUser eq null }">
								<li class="nav-item"><a id="login-modal" class="nav-link" href="#" data-toggle="modal">로그인</a>
							</c:if>
						</ul>
					</div>
				</div>
				
				<form method="post" action="skFilm.do" class="form-contact">
					<input class="form-control" type="search" placeholder="Search" aria-label="Keyword" name="keyword">
					<button class="button button--active button-contactForm" type="submit">검색</button>
				</form>
			</nav>
		</div>
	</header>
  
  	<!-- 로그인 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Login</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form class="" action="login.do" method="post">
						<div class="form-group">
							<label for="email">Email address</label>
							<input type="email" class="form-control" name="email" id="email" placeholder="email@address.com">
						</div>
						<div class="form-group">
							<label for="pwd">Password</label>
							<input type="password" class="form-control" name="pwd" id="pwd" placeholder="Password">
						</div>
						<div class="form-group">
							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
								<label class="form-check-label" for="rememberMe">
							  		Remember me
								</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							<button type="submit" id="btn-sign-in" class="btn" style="background:purple; color:white;">Sign in</button>
							<button type="button" class="btn btn-default" id="myBtn"  style="background:pink; color:white; width:60px;" onclick="location.href='insertFormMember.do';">Join</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<script>
		$(function(){
			$("#login-modal").on("click", function(){
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
	</script>
</body>
</html>