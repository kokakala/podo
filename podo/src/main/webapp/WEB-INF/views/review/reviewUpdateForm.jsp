<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/header.jsp"/>
	<title>리뷰 수정하기</title>
</head>
	<body>
	  <section class="blog-post-area section-margin">
	    <div class="container">
	      <div class="row">
	        <div class="col">
            <div class="main_blog_details">
            	<div class="movie-poster-cover">
								<img class="poster" src="resources/detailFilmImage/${ r.posterImage }" alt="">
            	</div>
                <div class="user_details">
                   <div class="float-left">
                     <div class="media">
	                     <div class="media-body">
					               <h5 align="center">${ r.titleKor }</h5>
	                     </div>
	                   </div>
                 	</div>
                  <div class="float-right mt-sm-0 mt-3">
                    <div class="media">
                      <div class="media-body">
                        <h5>${ r.nickName }</h5>
                        <p>${ r.modifyDate }</p>
                      </div>
                      <div class="d-flex thumbnail">
	                      <c:if test="${ loginUser.id == r.memberId }">
													<img 
														<c:if test="${ not empty r.userImage }">
															src="resources/memberProfileImage/${ r.userImage }"
															test
														</c:if>
														<c:if test="${ empty r.userImage }">
															src="resources/memberProfileImage/podoImage.png"
														</c:if>
														onclick="location.href='mypage.do?id=${ loginUser.id }'">
												</c:if>
												<c:if test="${ loginUser.id != r.memberId }">
													<img width="42" height="42"
														<c:if test="${ not empty r.userImage }">
															src="resources/memberProfileImage/${ r.userImage }"
														</c:if>
														<c:if test="${ empty r.userImage }">
															src="resources/memberProfileImage/podoImage.png"
														</c:if>
														onclick="location.href='userPage.do?userId=${r.memberId}&loginUserId=${ loginUser.id }'">
												</c:if>
                      </div>
                    </div>
                  </div>
                </div>
   

							<form action="reviewUpdate.do" method="post" id="movieform" class="pb-4 mb-4">
				      	<input type="hidden" name="id" value="${r.id}">
				      	<input type="hidden" name="ratingReviewId" value="${r.ratingReviewId }">
				      	<input type="checkbox" id="spoilerCheck" name="spoilerCheck">
				      	<label for="spoilerCheck">스포일러 유무</label>
								<div class="comment-form">
									<textarea class="form-control" rows="3" cols="75" name="content" id="content">${ r.content }</textarea>
								</div>
								<div class="d-flex justify-content-end">
									<button class="button" type="submit" id="ok1">리뷰수정하기</button>
									<button class="button" type="button" onclick="location.href='reviewList.do';">목록으로</button>
								</div>
						</form>	
				    </div>
					</div>
				</div>
			</div>
		</section>
		
		<script>
			$(document).ready(function() {
				var spoilerChecked = "${ r.spoilerCheck }";
				if (spoilerChecked === "Y") {
					$("#spoilerCheck").attr("checked", true);
				} else {
					$("#spoilerCheck").attr("checked", false);
				}
			})
		</script>
	</body>
</html>