<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
	<body>
		<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
			<h1><spring:message code="label.pricing.plan"/></h1>
			<p class="lead"><spring:message code="placeholder.advertisement2"/></p>
		</div>
	
		<div class="container">
			<div class="card-deck mb-3 text-center">
			
				<div class="card premium-card shadow-sm">
					<div class="card-header">
						<h4 class="my-0 font-weight-normal"><spring:message code="label.user.free"/></h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
							<spring:message code="label.pay.free"/><small class="text-muted"><spring:message code="label.pay.per"/></small>
						</h1>
						<hr>
						<ul class="list-unstyled mt-3 mb-4">
							<li><spring:message code="label.free.signup"/></li>
							<li><spring:message code="label.unlimited.access"/></li>
						</ul>
						<button type="button" class="btn btn-lg btn-block btn-primary" onclick="freeJoin();">
							<spring:message code="button.signup"/>
						</button>
					</div>
				</div>
				
				<div class="card premium-card shadow-sm">
					<div class="card-header">
						<h4 class="my-0 font-weight-normal"><spring:message code="label.user.membership"/></h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
<!-- 							&#8361;1,100<small>/ 월</small> -->
							<spring:message code="label.pay.currency"/><small class="text-muted"><spring:message code="label.pay.per"/></small>
						</h1>
						<hr>
						<ul class="list-unstyled mt-3 mb-4">
							<li><spring:message code="label.remove.adv"/></li>
							<li><spring:message code="label.unlimited.access"/></li>
						</ul>
						<button type="button" class="btn btn-lg btn-block btn-primary" onclick="pay();">
							<spring:message code="button.subscribe"/>
						</button>
					</div>
				</div>
				
			</div>
		</div>
	
		<jsp:include page="../common/footer.jsp"></jsp:include>
		<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
		<script>
			
			$(function(){
				IMP.init("imp88684528");
			});
			/* 
			$(document).ready(function(){
				IMP.init("imp88684528");
			}); */
			
			function freeJoin(){
				var email = '${ loginUser.email }';
				if (email != '') {
					alert('이미 로그인 상태입니다.');
				} else {
					location.href='signup.do';
				}
			}
			
			function pay(){
				// 테스트 모드 전환시 아임포트에서 자정에 일괄 결제취소하기 때문에 환불기능은 생략
				var email = '${ loginUser.email }';
				var memberId = '${ loginUser.id }';
				var premium = '${ loginUser.premium }';
				
				if (premium === 'Y') {
					alert("이미 유료회원입니다.");
				} else if (email != '') {
					
					IMP.request_pay({
					    pg : 'html5_inicis',
					    pay_method : 'card',
					    merchant_uid : 'merchant_' + new Date().getTime(),
					    name : '포도 유료회원 결제 테스트',
					    amount : 1100,
					    buyer_email : '${ login }',
					    buyer_tel : '010-1234-5678', // (필수항목) 누락되거나 blank일 때 일부 PG사에서 오류 발생
					}, function(rsp) { // callback
					    if ( rsp.success ) {
					        
					        // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					        // jQuery로 HTTP 요청
					        jQuery.ajax({
					            url: "pay.do", // 가맹점 서버
					            method: "POST",
					            /* headers: { "Content-Type": "application/json" }, */
					            data: {
					                "impUid": rsp.imp_uid,	// 고유 ID
					                "merchantUid": rsp.merchant_uid,	// 상점 거래ID
					                "applyNum": rsp.apply_num,	// 카드 승인번호
					                "paidAmount": rsp.paid_amount,	// 결제 금액
					                "memberId": memberId	// 유저 ID
					            }
					        }).done(function (data) {
					          // 가맹점 서버 결제 API 성공시 로직
					          alert("결제가 완료되었습니다. 다시 로그인해주세요!")
					          if (data > 0) {
					        	  console.log("결제정보 DB 저장 완료");
					          }
					        });
					    }
					});
				} else {
					$("#login-modal").trigger("click");
				}
			}

			</script>
	</body>
</html>