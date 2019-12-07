<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <jsp:useBean id="today" class="java.util.Date"/> --%>
<%-- <fmt:formatDate var="today" value="${ today }" pattern="yyyy-MM-dd"/> --%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			
			#board-image {
				cursor: pointer;
			}
			
		</style>
	</head>
	<body>
		
		<div class="container">
		<br>
		<h1 align="center">공지사항</h1>
			<div class="col-lg-12">
				<div class="main_blog_details">
					<c:if test="${ !empty notice.imageName }">
						<a href="${ pageContext.servletContext.contextPath }/resources/noticeUploadFiles/${ notice.imageName }" download="${ notice.imageName}"
							 id="download-image" style="display: none;">${ notice.imageName}</a>
						<div class="row">
							<img id="notice-image" class="mx-auto my-5" src="${ pageContext.servletContext.contextPath }/resources/noticeUploadFiles/${ notice.imageName }" style="width: 400px;">
						</div>
					</c:if>
					<a 	href="#"><h4>${ notice.title }</h4></a>
					<div class="user_details">
						<!-- <div class="float-left">
							<a href="#">Lifestyle</a> <a href="#">Gadget</a>
						</div> -->
						<div class="float-right mt-sm-0 mt-3">
							<div class="media">
								<div class="media-body">
									<h5>${ notice.nickName }</h5>
									<p>${ notice.modifyDate }</p>
								</div>
								<!-- <div class="d-flex">
									프로필 이미지
									<img width="42" height="42" src="img/blog/user-img.png" alt="">
								</div> -->
							</div>
						</div>
					</div>
					
					<div class="row">
						<p>${ notice.content }</p>
					</div>
					
				</div>

				<div class="navigation-area">
					<div class="row">
						<div
							class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
							<div class="thumb">
								<a href="#"><img class="img-fluid" src="img/blog/prev.jpg"
									alt=""></a>
							</div>
							<div class="arrow">
								<a href="#"><span class="lnr text-white lnr-arrow-left"></span></a>
							</div>
							<!-- <div class="detials">
								<p>Prev Post</p>
								<a href="#"><h4>A Discount Toner</h4></a>
							</div> -->
						</div>
						<div
							class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
							<!-- <div class="detials">
								<p>Next Post</p>
								<a href="#"><h4>Cartridge Is Better</h4></a>
							</div> -->
							<div class="arrow">
								<a href="#"><span class="lnr text-white lnr-arrow-right"></span></a>
							</div>
							<div class="thumb">
								<a href="#"><img class="img-fluid" src="img/blog/next.jpg"
									alt=""></a>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
		<br><br>
		
		<div class="form-group row">
			<div class="btn-group btn-group-lg mx-auto" role="group" aria-label="...">
				<c:if test="${ loginUser.id eq notice.adminId }">
					<button class="btn btn-secondary btn-lg" onclick="location.href='ndelete.do?id=${ notice.id }';">삭제하기</button>
					<button class="btn btn-lg btn-primary" onclick="location.href='nupdateView.do?id=${ notice.id }';">수정하기</button>
				</c:if>
			</div>
		</div>
	
		<br><br>
		<hr>
	
		
		<!-- <a class="comment-modal btn-reply text-uppercase" href="#" data-toggle="modal">댓글신고하기</a> -->
		
		
		<script>
			$("#notice-image").on("click", function(){
				console.log("asd");
				$("#download-image").get(0).click();
			});
		</script>
		
		<jsp:include page="../common/footer.jsp"/>
		
	</body>
</html>