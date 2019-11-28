<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PoDo_MyPage</title>

<style>
	#imgInp{display:none}
	.nickguide{
		display:none;
		font-size:12px;
		top:12px;
		right:10px;
	}
	.nickok{color:blue;}
	.nickno{color:red;}
	.originguide{
		display:none;
		font-size:12px;
		top:12px;
		right:10px;
	}
	.oriok{color:blue;}
	.orino{color:red;}
	.modal-dialog{z-index:2000;}
	/* --------------------- 탭메뉴시작 ---------------------  */
	#container {
		/* width:800px; */
		margin:0 auto;
		/* text-align:center */;
	}
	.tab {
		list-style: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
	}
	/* Float the list items side by side */
	.tab li {
		float: left;
	}
	/* Style the links inside the list items */
	.tab li a {
		display: inline-block;
		color: #000;
		text-align: center;
		text-decoration: none;
		padding: 14px 16px;
		font-size: 18px;
		transition:0.3s;
		
	}
	/* Style the tab content */
	.tabcontent {
		display: none;
		background-color:rgb(230, 204, 255);
		padding: 6px 12px;
		color:#fff;
	}
	ul.tab li.current{
		background-color: rgb(230, 204, 255);
		color: #222;
	}
	.tabcontent.current {
		display: block;
	}
	/* --------------------- 탭메뉴 끝 ---------------------  */
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<section class="blog-post-area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="comments-area">
						<h4>마이페이지</h4>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="resources/memberProfileImage/${ loginUser.image }" width="70px" height="70px" alt="">
									</div>
									<div class="desc">
										<h2>${ loginUser.nickName }</h2>
										<a href="#"><i class="ti-heart"></i></a>
										<p class="date">작성리뷰 - ${reviewCount}개  </p>
										<p class="date">콜렉션 - 0개  </p>
									</div>
								</div>
								<div class="reply-btn">
									<a id="update-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal" style="background:rgb(218, 179, 255); text-align:center;color:white;">정보수정</a>
									<a id="updatePwd-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal" style="background:rgb(218, 179, 255); color:white;">비밀번호 변경</a>
									<a id="question-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal" style="background:pink; text-align:center; color:white;">문의하기</a>
								</div>
							</div>
							<br><br>	
							<div style='border:1px solid lightgray'></div><br>
							
							<!------------------------- 탭 메뉴 시작 ----------------------->
							<div class="col-lg-12">
								<div id="container">
									<ul class="tab">
											<li class="tab1 current" data-tab="tab1" ><a>Review</a></li>
											<li class="tab2" data-tab="tab2" ><a>Collection</a></li>
											<li class="tab3" data-tab="tab3"><a>Like</a></li>
											<li class="tab4" data-tab="tab4"><a>Question</a></li>
									</ul>
							
								
										<div id="tab1" class="current tabcontent current"><br>
											<!-------------------------- 리뷰 탭메뉴 바디 ------------------------>
											<section class="blog-post-area section-margin mt-4">
												<div class="container">
													<div class="row">
														<div class="col-lg-12">
															<c:forEach items="${review}" var="list" >
																<div class="single-recent-blog-post" style="height:300px">
																	<div class="details mt-20">
																		<div class="thumb" style="float:left">
																			<div class="col-lg-12" id="moviePoster" style="width: 200px; height: 200px;  align-items: center; justify-content: center;overflow: hidde; display: flex">
																				<img class='img-fluid' src='resources/detailFilmImage/${list.posterImage}' width='100%' height='100%'>
																			</div>
																		</div>
																		<div style="float:left">
																			<div style="float:left">
																				<a href="#"><h3>${list.titleKor}</h3><br></a>
																				<p>${list.content}</p>
																			</div>
																		</div>
																	</div>
																</div>
															</c:forEach>
															<!-------------------------- 페이징바 시작 ------------------------>
															<div class="row">
																<div class="col-lg-12">
																	<nav class="blog-pagination justify-content-center d-flex">
																		<ul class="pagination">
																			<!------ [이전] ------>
																			<c:if test="${ pi.currentPage eq 1 }">
																				<li class="page-item">
																					<a class="page-link" aria-label="Previous" disabled>
																						<span aria-hidden="true">
																							<i class="ti-angle-left"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<c:if test="${ pi.currentPage ne 1 }">
																				<c:url value="myPageSelectReview.do" var="before">
																					<c:param name="currentPage" value="${ pi.currentPage-1 }"/>
																					<c:param name="id" value="${loginUser.id}"/>
																				</c:url>
																				<li class="page-item">
																					<a href="${ before }" class="page-link" aria-label="Previous">
																						<span aria-hidden="true">
																							<i class="ti-angle-left"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<!-- ------------- -->
																			<!------ [페이지] ----->
																			<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
																				<c:if test="${ p eq pi.currentPage }">
																					<li class="page-item active"><a class="page-link" disabled>${p}</a></li>
																				</c:if>
																			
																				<c:if test="${ p ne pi.currentPage }">
																					<c:url value="myPageSelectReview.do" var="page">
																						<c:param name="currentPage" value="${ p }"/>
																						<c:param name="id" value="${loginUser.id}"/>
																					</c:url>
																					<li class="page-item active"><a href="${ page }" class="page-link">${p}</a></li>
																				</c:if>
																			</c:forEach>
																			<!-- --------------- -->
																			<!------- [다음] ------->
																			<c:if test="${ pi.currentPage eq pi.maxPage }">
																				<li class="page-item">
																					<a class="page-link" aria-label="Next" disabled>
																						<span aria-hidden="true">
																							<i class="ti-angle-right"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<c:if test="${ pi.currentPage ne pi.maxPage }">
																				<c:url value="myPageSelectReview.do" var="after">
																					<c:param name="currentPage" value="${ pi.currentPage+1 }"/>
																					<c:param name="id" value="${loginUser.id}"/>
																				</c:url>
																				<li class="page-item">
																					<a href="${ after }" class="page-link" aria-label="Next">
																						<span aria-hidden="true">
																							<i class="ti-angle-right"></i>
																						</span>
																					</a>
																				</li>
																			</c:if>
																			<!-- --------------- -->
																		</ul>
																	</nav>
																</div>
															</div>
															<!-------------------------- 페이징바 끝 -------------------------->
														</div>
													</div>
												</div>
											</section>
										</div>
								
									
										
										<div id="tab2" class="tabcontent"><br>
											<h3>Collection</h3><br>
											<p>컬렉입니당.</p>
										</div>
										
										<div id="tab3" class="tabcontent"><br>
											<h3>Like</h3><br>
											<p>라이크임당.</p>
										</div>
										
										<div id="tab4" class="tabcontent tab4"><br>
											<h3>Question</h3><br>
											<p>문의지롱</p>
										</div>
								</div>
							</div>
							<!-------------------------- 탭 메뉴 끝 ------------------------>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
  
	<!-- 정보수정 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원정보 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="updateMember.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${ loginUser.id }">
						<input type="hidden" name="pwd" value="${ loginUser.pwd }">
						<input type="hidden" name="enrollDate" value="${ loginUser.enrollDate }">
						<input type="hidden" name="modifyDate" value="${ loginUser.modifyDate }">
						<input type="hidden" name="googleId" value="${ loginUser.googleId}">
						<input type="hidden" name="kakaoId" value="${ loginUser.kakaoId }">
						<input type="hidden" name="autho" value="${ loginUser.autho }">
						<input type="hidden" name="updatePwd" value="">
						<div class="form-group">
							<label for="userId">Email address</label>
							<input type="email" class="form-control" id="userId" name="email" value="${ loginUser.email }" readonly>
						</div>
						<div class="form-group">
							<label for="userNickName">NickName</label>
							<input type="text" class="form-control" id="userNickName" name="nickName" value="${ loginUser.nickName }">
							<span class="nickguide nickok">사용가능</span>
							<span class="nickguide nickno">사용불가</span>
							<input type="hidden" id="nickCheck" value="0"><br>
						</div>
						
						<div class="form-group">
							<label for="userId">Profile</label><br>
							* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
						<img id="preview" src="resources/memberProfileImage/${ loginUser.image }" width="70px" height="70px"><br>
						<button type="button" id="uploadBtn">이미지 변경</button>
						<button type="button" onclick="fileReset();">이미지 삭제</button><br>
						<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return validate();">Update</button>
						<!-- <button type="button" onclick="location.href='myPage.do';">Cancel</button> -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 비밀번호 변경 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="updatePwdModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="updateMember.do" method="post">
						<input type="hidden" name="id" value="${ loginUser.id }">
						<input type="hidden" name="pwd" value="${ loginUser.pwd }">
						<input type="hidden" name="image" value="${ loginUser.image }">
						<input type="hidden" name="nickName" value="${ loginUser.nickName }">
						<input type="hidden" name="enrollDate" value="${ loginUser.enrollDate }">
						<input type="hidden" name="modifyDate" value="${ loginUser.modifyDate }">
						<input type="hidden" name="googleId" value="${ loginUser.googleId}">
						<input type="hidden" name="kakaoId" value="${ loginUser.kakaoId }">
						<input type="hidden" name="autho" value="${ loginUser.autho }">
						<div class="form-group">
							<label for="userId">Email address</label>
							<input type="email" class="form-control" id="userId" name="email" value="${ loginUser.email }" readonly>
						</div>
						<div class="form-group">
							<label for="originPwd">변경 전 비밀번호</label>
							<input type="password" class="form-control" id="originPwd" name="originPwd">
							<span class="originguide oriok">일치</span>
							<span class="originguide orino">불일치</span>
							<input type="hidden" id="originPwdCheck" value="0"><br>
							<label for="updatePwd">변경 후 비밀번호</label>
							<input type="password" class="form-control" id="updatePwd" name="updatePwd">
							<label for="updatePwd2">변경 후 비밀번호 확인</label>
							<input type="password" class="form-control" id="updatePwd2">
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return pwdValidate();">Update</button>
						<!-- <button type="button" onclick="location.href='myPage.do';">Cancel</button> -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
<!-- 문의하기 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="questionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">문의하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="insertQuestion.do" method="post">
						<input type="hidden" name="userId" value="${ loginUser.id }">
						<div class="form-group">
							<label for="qucontent">문의내용</label>
							<textarea class="form-control" id="qucontent" name="content" rows="5" cols="50"  style="resize: none"></textarea>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="submit" class="btn" style="background:purple; color:white;" onclick="return quValidate();">Question</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
		



	<script>
		// 탭메뉴 관련 
		$(function() {
			console.log("${tab}");
				/* $('ul.tab li').click(function() {
					var activeTab = $(this).attr('data-tab');
					$('ul.tab li').removeClass('current');
					$('.tabcontent').removeClass('current');
					$(this).addClass('current');
					$('#' + activeTab).addClass('current');
				})
			 */
			$("#container ul>li").on("click", function(){
				var activeTab = $(this).attr('data-tab');
	            var tabMenu = $(this).text();
	            var strId = "${loginUser.id}";
	            
	            if(tabMenu == "Review"){
	                location.href="myPageSelectReview.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu =="Collection"){
	            	  location.href="myPageSelectCollection.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu == "Like"){
	            	  location.href="myPageSelectLike.do?id=${loginUser.id}&tab="+ activeTab;
	             }else if(tabMenu == "Question"){
	            	  location.href="myPageSelectQuestion.do?id=${loginUser.id}&tab="+ activeTab;
	             }  
			});
			if("${tab}" != ''){
				var tab = "${tab}";
				$('ul.tab li').removeClass('current');
				$('.tabcontent').removeClass('current');
				$("#" + tab).addClass('current');
				$("." + tab).addClass('current');
			}
		});

		// 회원정보 수정, 비밀번호 변경 시 알럴트창
		$(function(){
			if("${msg.equals('')}"){
				alert("${msg}");
			}
		});
		
		// 회원정보 수정 모달창
		$(function(){
			$("#update-modal").on("click", function(){
				$('#updateModal').modal('toggle');
			});
		});
		
		// 회원정보 업데이트 버튼 클릭 시 
		function validate(){
			// 미입력
			if($("#userNickName").val().length == 0){	
				alert("닉네임을 입력해주세요.")
				$("#userNickName").focus();
				return false;
			}else{	
				return true;
			}
		}
		
		// 닉네임 중복 체크
		$(function(){
			$("#userNickName").on("keyup", function(){
				var nickName = $("#userNickName").val();
				
				if(nickName.length < 1){
					$(".nickguide").hide();
					$("#nickCheck").val(0);
					return;
				}
			
				$.ajax({
					url:"nickCheck.do",
					data:{nick:nickName},
					type:"post",
					success:function(data){
						//console.log(data);
						if(data == "success"){
							$(".nickno").hide();
							$(".nickok").show();
							$("#nickCheck").val(1);
						}else{
							$(".nickok").hide();
							$(".nickno").show();
							$("#nickCheck").val(0);
						}
					},error:function(){
						console.log("닉네임 ajax 통신 실패");
					}
				});
			});
		});
		
		// 비밀번호 변경 모달창
		$(function(){
			$("#updatePwd-modal").on("click", function(){
				$('#updatePwdModal').modal('toggle');
			});
		});
		
		// 변경 전 비밀번호 일치 여부
		$(function(){
			$("#originPwd").on("keyup", function(){
				var originPwd = $("#originPwd").val();
				var email = "${loginUser.email}";
				var pwd = "{loginUser.pwd}";
				
				console.log(originPwd);
				console.log(email);
				
				if(originPwd.length < 1){
					$(".originguide").hide();
					$("#originPwdCheck").val(0);
					return;
				}
			
				$.ajax({
					url:"originPwdCheck.do",
					data:{originPwd:originPwd,
							email:email,
							pwd:pwd},
					type:"post",
					success:function(data){
						console.log(data);
						if(data == "success"){
							$(".orino").hide();
							$(".oriok").show();
							$("#originPwdCheck").val(1);
						}else{
							$(".oriok").hide();
							$(".orino").show();
							$("#originPwdCheck").val(0);
						}
					},error:function(){
						console.log("비밀번호 변경전 ajax 통신 실패");
					}
				});
			});
		});
		
		// 비밀번호 변경 버튼 클릭 시 변경 후 비밀번호 일치 여부		
		function pwdValidate(){
			// 미입력
			if($("#updatePwd").val().length == 0 || $("#updatePwd2").val().length == 0 || $("#originPwdCheck").val().length == 0){	
				alert("비밀번호를 입력해주세요.")
				$("#userNickName").focus();
				return false;
				
			}else if($("#updatePwd").val() != $("#updatePwd2").val()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#updatePwd").val("");
				$("#updatePwd2").val("");
				$("#updatePwd").focus();
				return false;
				
			}else if($("#originPwdCheck").val() == 0){
				alert("변경 전 비밀번호가 일치하지 않습니다.");
				$("#originPwd").val("");
				$("#originPwd").focus();
				return false;
				
			}else{
				return true;
			}
		}
		
		
		// 문의하기 모달창
		$(function(){
			$("#question-modal").on("click", function(){
				$('#questionModal').modal('toggle');
			});
		});
		
		// 문의하기 버튼 클릭 시		
		function quValidate(){
			// 미입력
			if(!$.trim($("#qucontent").val())){	
				alert("문의 내용을 입력해주세요");
				$("#qucontent").focus();
				return false;
			} else{
				return true;
			}
		}
		
		// 이미지 삭제 버튼 클릭 시
		function fileReset(){
			$("#imgArea input").remove();
			$("#preview").attr('src','resources/memberProfileImage/podoImage.png');
			var newInput = "<input type='file' id='imgInp' name='uploadFile'>";
			$("#imgArea").append(newInput);
		}
		
		// 이미지 미리보기
	    function readURL(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                $('#preview').attr('src', e.target.result);
	            }
	            reader.readAsDataURL(input.files[0]);
	        }
	    };
	    
		// 이미지 변경 될 때 마다 이미지 미리보기 함수 실행
	    $(document).on("change","#imgInp", function() {
	        readURL(this);
	    });
		
		// 이미지 버튼 클릭 시 인풋창 열리게 (안보이게 해둠)
		$("#uploadBtn").on('click', function(e){
			e.preventDefault();
			$("#imgInp").click();
		});
	</script>
	
</body>
</html>