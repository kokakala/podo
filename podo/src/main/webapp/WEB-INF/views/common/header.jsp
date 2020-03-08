<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>포도포도</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<%@ include file="./mod.jspf" %>
	</head>
	<body>
		<header class="header_area">
			<div class="main_menu">
				<nav class="navbar navbar-expand-lg navbar-light">
					<div class="container box_1620">
						<!-- Brand and toggle get grouped for better mobile display -->
						<a class="navbar-brand logo_h" href="home.do">
							<img src="resources/asterisk/img/logo/logo-transparent-text-lg.png" alt="" style="width: 80px; height: 80px; object-fit: cover; margin-right: 40px;">
						</a>
						<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						
						<div class="navbar-collapse collapse" id="navbarSupportedContent">
							<ul class="nav navbar-nav mr-auto justify-content-center">
								<li class="nav-item"><a class="nav-link" href="film.do?p=1"><spring:message code="nav.menu.movie" /></a></li>
								<li class="nav-item"><a class="nav-link" href="reviewList.do"><spring:message code="nav.menu.review" /></a>
								<li class="nav-item"><a class="nav-link" href="recommendation.do"><spring:message code="nav.menu.recommend" /></a>
								<li class="nav-item"><a class="nav-link" href="blist.do"><spring:message code="nav.menu.board" /></a>					
								<c:choose>
						       <c:when test="${ loginUser.autho eq 2}">
						       		<li class="nav-item"><a id="logout" class="nav-link" href="logout.do"><spring:message code="nav.menu.logout" /></a>
									<li class="nav-item"><a id="logout" class="nav-link" href="manyStar.do"><spring:message code="nav.menu.admin" /></a>
						       </c:when>
						       <c:when test="${ loginUser ne null }">
						       		<li class="nav-item"><a id="logout" class="nav-link" href="logout.do"><spring:message code="nav.menu.logout" /></a>
									<li class="nav-item"><a id="logout" class="nav-link" href="mypage.do?id=${ loginUser.id }"><spring:message code="nav.menu.mypage" /></a>
						       </c:when>
						       <c:otherwise>
						       		<li class="nav-item"><a id="login-modal" class="nav-link" href="#" data-toggle="modal"><spring:message code="nav.menu.login" /></a>
						       </c:otherwise>
							   </c:choose>
							</ul>
							<form method="get" action="skFilm.do" class="form-inline my-2">
								<c:if test="${ !empty keyword }">
									<input class="form-control mr-sm-2" id="keywordInput" type="search" placeholder="<spring:message code="placeholder.search" />" aria-label="Search" name="keyword" maxlength="150" value="${ keyword }">
								</c:if>
								<c:if test="${ empty keyword }">
									<input class="form-control mr-sm-2" id="keywordInput" type="search" placeholder="<spring:message code="placeholder.search" />" aria-label="Search" name="keyword" maxlength="150">
								</c:if>
								<button class="button button--active my-2 my-sm-0" type="submit"><spring:message code="button.search" /></button>
							</form>
						</div>
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
						<h5 class="modal-title" id="exampleModalLabel"><spring:message code="nav.menu.login" /></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
						<form class="" action="login.do" method="post">
							<div class="form-group">
								<label for="email"><spring:message code="label.email" /></label>
								<input type="email" class="form-control" name="email" id="email" placeholder="email@address.com">
							</div>
							<div class="form-group">
								<label for="pwd"><spring:message code="label.password" /></label>
								<input type="password" class="form-control" name="password" id="pwd" placeholder="Password">
							</div>
							<div class="modal-footer">
								<button type="button" class="button" data-dismiss="modal"><spring:message code="button.cancel" /></button>
								<button type="submit" id="btn-sign-in" class="button"><spring:message code="nav.menu.login" /></button>
								<button type="button" id="myBtn" class="button" onclick="location.href='signup.do';"><spring:message code="button.signup" /></button>
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
				var msg = '${msg}';
				if (msg != '') {
					alert(msg);
					<% session.removeAttribute("msg"); %>
				}
			});
		</script>
	</body>
</html>