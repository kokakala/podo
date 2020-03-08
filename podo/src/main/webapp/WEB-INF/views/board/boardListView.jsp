<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			a { color: #c69ce6; }
			a:hover { color : #d4d4d4; cursor: pointer;}
		</style>
	</head>
	<body>
    <!--================Hero Banner start =================-->
		<section class="mb-30px">
			<div class="container">
				<div class="board-page-banner">
					<br>
					<span class="title"><spring:message code="label.board.free"/></span>
				</div>
			</div>
		</section>
    <!--================Hero Banner end =================-->
		
    <!--================ Advertisement start =================-->
    <c:if test="${ (empty loginUser) or (loginUser.premium eq 'N')}">
	    <div class="container" style="background-color: black; background-clip: content-box; margin-bottom: 30px;">
	    	<div class="podo-ad-banner" onclick="location.href='premium.do'">
	    		<div>
		      	<spring:message code="placeholder.advertisement" />
	    		</div>
	    	</div>
	    </div>
    </c:if>
    <!--================Advertisement end =================-->
		
		<div class="container">
			<table class="table table-hover table-striped table-dark board-table">
				<thead>
				<tr>
			      <th scope="col">#</th>
			      <th scope="col"><spring:message code="label.board.title"/></th>
			      <th scope="col"><spring:message code="label.board.writer"/></th>
			      <th scope="col"><spring:message code="label.board.date"/></th>
			      <th scope="col"><spring:message code="label.board.view"/></th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${ list }" var="b">
						<tr>
							<td scope="row">${ b.id }</td>
							<td scope="row">
								<div><a href="boardDetail.do?id=${ b.id }">${ b.title }</a></div>
								<div class="d-md-none right-cell">
									<small>${ b.nickName }</small>
									<small>&nbsp;|&nbsp;</small>
									<small>${ b.createDate }</small>
								</div>
<%-- 								<div class="d-md-none right-cell"><small>${ b.viewCount }</small></div> --%>
							</td>
							<td scope="row"><div class="d-none d-md-block">${ b.nickName }</div></td>
							<td scope="row"><div class="d-none d-md-block">${ b.createDate }</div></td>
							<td scope="row"><div class="d-none d-md-block">${ b.viewCount }</div></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="row">
			<c:if test="${loginUser.autho == 2 }">
				<button class="button mx-auto" onclick="location.href='ninsertForm.do';">공지사항</button>
			</c:if>
			<c:if test="${loginUser.autho == 1 }">
				<button class="button mx-auto" onclick="location.href='binsertForm.do';"><spring:message code="button.write"/></button>
			</c:if>
			</div>
			
			
			<!-- Pagination -->
			<div class="row my-3">
				<div class="col-lg-12">
					<nav class="blog-pagination justify-content-center d-flex">
						<ul class="pagination">
		
							<!-- [PREV] -->
							<c:if test="${ pi.currentPage eq 1 }">
								<li class="page-item disabled">
							</c:if>
							<c:if test="${ pi.currentPage ne 1 }">
								<li class="page-item">
							</c:if>
								<c:url value="blist.do" var="before">
									<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
								</c:url>
								<a href=<c:out value="${ before }"/> class="page-link" aria-label="Previous">
									&lt;
								</a>
							</li>
							
							<!-- [각 페이지] -->
							<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							
								<c:if test="${ p eq pi.currentPage }">
									<li class="page-item disabled"><a href="#" class="page-link">${ p }</a></li>
								</c:if>
								
								<c:if test="${ p ne pi.currentPage }">
									<c:url value="blist.do" var="page">
										<c:param name="currentPage" value="${ p }"/>
									</c:url>
									<li class="page-item"><a href="<c:out value='${ page }'/>" class="page-link">${ p }</a></li>
								</c:if>
								
							</c:forEach>
		
							<!-- [NEXT] -->
							<c:if test="${ pi.currentPage eq pi.maxPage }">
								<li class="page-item disabled">
							</c:if>
							<c:if test="${ pi.currentPage ne pi.maxPage }">
								<li class="page-item">
							</c:if>
								<c:url value="blist.do" var="after">
									<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
								</c:url>
								<a href=<c:out value="${ after }&p=${ pi.currentPage + 1 }"/> class="page-link" aria-label="Next">
									&gt;
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
		
		
		<script>

			$(function(){
				$(".nav").children("li").eq(3).addClass("active");
			});
		
		</script>
		<jsp:include page="../common/footer.jsp"/>
	</body>
</html>