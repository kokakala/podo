<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<div class="container">
			<table class="table table-hover table-striped table-dark my-5">
				<thead>
				<tr>
			      <th scope="col">#</th>
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			      <th scope="col">작성일</th>
			      <th scope="col">조회수</th>
				</tr>
				</thead>
				<tr>
				<c:if test="${ notice.id eq null}">
					<td></td>
					<td colspan="4" scope="row" >공지사항이 없습니다.</td>
				</c:if>
				<c:if test="${ notice.id ne null}">
					<td scope="row">${ notice.id }</td>
						<td scope="row">
							<a href="ndetail.do?id=${ notice.id }">${ notice.title }</a>					
						</td>
						<td scope="row">${ notice.nickName }</td>
						<td scope="row">${ notice.createDate }</td>
						<td scope="row">${ notice.viewCount }</td>
				</c:if>
				</tr>
				<c:forEach items="${ list }" var="b">
					<tr>
						<td scope="row">${ b.id }</td>
						<td scope="row">
							<a href="bdetail.do?id=${ b.id }">${ b.title }</a>					
						</td>
						<td scope="row">${ b.nickName }</td>
						<td scope="row">${ b.createDate }</td>
						<td scope="row">${ b.viewCount }</td>
					</tr>
				</c:forEach>
			</table>
			
			<div class="row">
			<c:if test="${loginUser.autho == 2 }">
				<button class="button mx-auto" onclick="location.href='ninsertForm.do';">공지사항</button>
			</c:if>
			<c:if test="${loginUser.autho == 1 }">
				<button class="button mx-auto" onclick="location.href='binsertForm.do';">작성하기</button>
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