<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<h1 align="center">블랙리스트</h1>
	
	<h3 align="center">
		총 게시글 갯수 : ${ pi.listCount } 페이지 : ${ pi.currentPage } / ${ pi.maxPage } 
	</h3>
	

	
	<table align="center" border="1" cellspacing="0" width="700">
		<tr>
			<th>체크</th>
			<th>NO</th>
			<th>회원아이디</th>
			<th>닉네임</th>
			<th>블랙이관일</th>
			<th>살려주자</th>
		</tr>
		<c:forEach items="${ list }" var="b">	
			<tr>
				<td><input type="checkbox" value="${b.id}" class="checkbox_target" /></td>
				<td>${ b.id }</td>
				<td>${ b.email }</td>
				<td>${ b.blackName }</td>
				<td><fmt:formatDate value="${b.blackDate}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
				<td><a href="javascript:;" class="btn_unblock" data-id="${b.id}">해제</a></td><!-- data-id : li, el태그에는 data X / 자바스크립트에서 접근할 수 있음-->
			</tr>
		</c:forEach>
		
		<!-- 페이징 처리 -->
		<tr align="center" height="20">
			<td colspan="7">
				<!-- [이전] -->
				<c:if test="${ pi.currentPage eq 1 }">
					[이전] 
				</c:if>
				<c:if test="${ pi.currentPage ne 1 }">
					<c:url value="blackList.do" var="before">
						<c:param name="currentPage" value="${ pi.currentPage-1 }"/>
					</c:url>
					<a href="${ before }">[이전] </a>	
				</c:if>
				
				<!-- [페이지] -->
				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					<c:if test="${ p eq pi.currentPage }">
						<font color="red" size="4"> [${ p }] </font>
					</c:if>
					<c:if test="${ p ne pi.currentPage }">
						<c:url value="blackList.do" var="page">
							<c:param name="currentPage" value="${ p }"/>
						</c:url>
						<a href="${ page }"> ${ p } </a>
					</c:if>
				</c:forEach>
				
				<!-- [다음] -->
				<c:if test="${ pi.currentPage eq pi.maxPage }">
					 [다음]
				</c:if>
				<c:if test="${ pi.currentPage ne pi.maxPage }">
					<c:url value="blackList.do" var="after">
						<c:param name="currentPage" value="${ pi.currentPage+1 }"/>
					</c:url>
					<a href="${ after }"> [다음]</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="7" align="right"><a href="javascript:;" id="btn_multi_unblock">해제</a></td>
		</tr>
	</table>
<script>
$(function() {
	$('.btn_unblock').click(function() {
		var param = {
			blockIds: [$(this).data('id')]
		};
		
		$.ajax({
			url: '/podo/v1/blacklist/unblock.do',
			type: 'post',
			contentType: 'application/json',
			data: JSON.stringify(param),
			success: function(data){
				console.log(data);
				
				if (JSON.parse(data)) {
					location.reload();
				} else {
					alert('block 해제에 실패했습니다.');
				}
			},
			error: function(){
				console.log("아이디 ajax 통신 실패");
			}
		});
	});
	
	var $checkboxTarget = $('.checkbox_target');
	var checkedIds = [];
	$('#btn_multi_unblock').click(function() {
		$checkboxTarget.each(function() {
			var $this = $(this);
			if ($this.is(':checked')) {
				checkedIds.push($this.val());
			}
		});
		
		var param = {
			blockIds: checkedIds
				
		};
		
		$.ajax({
			url: '/podo/v1/blacklist/unblock.do', // API버전
			type: 'post',
			contentType: 'application/json',
			data: JSON.stringify(param),
			success: function(data){
				console.log(data);
				
 				if (JSON.parse(data)) {
					location.reload();
				} else {
					alert('block 해제에 실패했습니다.');
				}
			},
			error: function(){
				console.log("아이디 ajax 통신 실패");
			}
		});
	});
});
</script>
</body>
</html>