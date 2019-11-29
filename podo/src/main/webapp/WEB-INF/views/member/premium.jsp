<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>프리미엄 회원 구독</title>
		<jsp:include page="../common/header.jsp"/>
		<style>
			
			.card {
			  border: none;
			  border-radius: 1rem;
			  transition: all 0.2s;
			  box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
			}
			
			.card:hover {
				margin-top: -.25rem;
		    margin-bottom: .25rem;
		    box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.3);
  			transition: all 0.2s;
			}
			
			.card .btn {
			  font-size: 80%;
			  border-radius: 5rem;
			  letter-spacing: .1rem;
			  font-weight: bold;
			  padding: 1rem;
			  opacity: 0.7;
			  transition: all 0.2s;
			  background-color: #a4508b;
				background-image: linear-gradient(326deg, #a4508b 0%, #5f0a87 74%);
				border-color: unset;
			}

			.card-body:hover .btn {
				opacity: 1;
			}
			
		</style>
	</head>
	<body>

	
		<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
			<h1 class="display-4">프리미엄 회원 구독</h1>
			<p class="lead">단돈 1,100원으로 광고없이 포도를 이용해보세요!</p>
		</div>
	
		<div class="container">
			<div class="card-deck mb-3 text-center">
			
				<div class="card shadow-sm">
					<div class="card-header">
						<h4 class="my-0 font-weight-normal">Free</h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
							&#8361;0 <small class="text-muted">/ 월</small>
						</h1>
						<hr>
						<ul class="list-unstyled mt-3 mb-4">
							<li>무료 가입</li>
							<li>무제한 이용</li>
						</ul>
						<button type="button" class="btn btn-lg btn-block btn-primary" onclick="location.href='insertFormMember.do'">
							가입하기
						</button>
					</div>
				</div>
				
				<div class="card shadow-sm">
					<div class="card-header">
						<h4 class="my-0 font-weight-normal">Pro</h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
							&#8361;1,100 <small class="text-muted">/ 월</small>
						</h1>
						<hr>
						<ul class="list-unstyled mt-3 mb-4">
							<li>광고 제거</li>
							<li>무제한 이용</li>
						</ul>
						<button type="button" class="btn btn-lg btn-block btn-primary">
							구독하기
						</button>
					</div>
				</div>
				
			</div>
		</div>
	
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</body>
</html>