<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<script src="resources/asterisk/vendors/owl-carousel/owl.carousel.min.js"></script>
		<script src="resources/asterisk/vendors/nice-select/jquery.nice-select.min.js"></script>
		<script src="resources/asterisk/js/jquery.ajaxchimp.min.js"></script>
		<script src="resources/asterisk/js/mail-script.js"></script>
		<script src="resources/asterisk/js/main.js"></script>
		<script src="resources/asterisk/js/podo.js"></script>
	</head>
<body>

	<hr>
	
	<!--================ Start Footer Area =================-->
	<div class="footer-container">
		<div class="footer-1" align="center">
			<a href="termsofuse.do"><spring:message code="footer.terms.service"/></a> | 
			<a href="privacyPolicy.do"><spring:message code="footer.privacy.policy"/></a> | 
			<a href="faq.do"><spring:message code="footer.guide"/></a> | 

			<c:if test="${!empty loginUser }">
				<a href="#" data-toggle="modal" id="db" data-target="#db-inquiry-modal"><spring:message code="footer.db.report"/></a>
			</c:if>
			<c:if test="${empty loginUser }">
				<a href="#" onclick="needLogin();"><spring:message code="footer.db.report"/></a>
			</c:if> |
			<a href="https://markruler.com">Mark Ruler</a>
		</div>
		
		<br>
		<div class="footer-2">
			<p>Copyright &copy; 2019 PODO ALL RIGHTS RESERVED.</p>
		</div>
		
	</div>
	
	<!-- 문의 modal -->
	<div class="modal fade" id="db-inquiry-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel"><spring:message code="footer.db.report"/></h4>
					<button type="button" id="close" class="close" data-dismiss="modal" aria-lable="Close">
					<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form class="" action="dbInquiryInsert.do" method="post">
						<div class="form-group">
							<label for="db-inquiry-cate"><spring:message code="footer.modal.category"/></label>
							<input type="text" class="form-control" value="DB제보" readonly>
						</div>
						<div class="form-group">
							<label for="db-inquiry-content"><spring:message code="footer.modal.content"/></label>
							<textarea rows="10" cols="15" class="form-control" id="DBcontent" name="content"></textarea>
						</div>
						
						<div class="modal-footer">
							<div class="db-inquiry-btn">
								<button type="button" class="button" data-dismiss="modal"><spring:message code="footer.modal.cancel"/></button>
								&nbsp;
								<button type="button" class="button" id="db-submit-btn" onclick="return DBvalidate();"><spring:message code="footer.modal.send"/></button>
							</div>
						</div>
					</form>
				</div>
				
			</div>
		</div>	
	</div>
	
	<script>
	
		$(function() {
			$("#db").on("click", function() {
				$('#db-inquiry-modal').modal('toggle');
			});
		});

		function needLogin() {
			alert("로그인 후 DB 제보가 가능합니다.");
		}

		function DBvalidate() {
			var content = $("#DBcontent").val();
			var userId = "${loginUser.id}";

			// 미입력
			if ($("#DBcontent").val().length == 0) {
				alert("내용을 입력해주세요.")
				$("#DBcontent").focus();
				return false;

			} else {
				$.ajax({
					url : "dbInquiryInsert.do",
					data : {
						content : content,
						userId : userId
					},
					type : "post",
					success : function(data) {
						if (data == "success") {
							alert("DB제보 완료");
							$('#DBcontent').val('');
							$(".close").click();

						} else {
							alert("DB제보 실패");
						}
					},
					error : function() {
						console.log("DB제보 ajax실패");
					}

				});
				return true;
			}
		}
	</script>
</body>
</html>