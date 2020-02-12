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
					               <p>장르 : ${ r.name }</p>
	                     </div>
	                   </div>
                 	</div>
                  <div class="float-right mt-sm-0 mt-3">
                    <div class="media">
                      <div class="media-body">
                        <h5>${ r.nickName }</h5>
                        <p>${ r.modifyDate }</p>
                      </div>
                      <div class="d-flex">
                        <img width="42" height="42" src="resources/memberProfileImage/${ r.userImage }" alt="">
                      </div>
                    </div>
                  </div>
                </div>
   

							<form action="reviewUpdate.do" method="post" id="movieform">
				      	<input type="hidden" name="id" value="${r.id}">
				      	<input type="hidden" name="ratingReviewId" value="${r.ratingReviewId }">
				      	<input type="checkbox" id="spoilerCheck" name="spoilerCheck" value="${r.spoilerCheck }">
				      	<label for="spoilerCheck">스포일러 유무</label>
								<div class="comment-form">
									<p>
										<textarea class="form-control" rows="3" cols="75" name="content" id="content">${ r.content }</textarea>
									</p>
									<button class="button" type="submit" id="ok1">리뷰수정하기</button>
									<button class="button" type="button" onclick="location.href='reviewList.do';">목록으로</button>
								</div>
						</form>	
				    </div>
					</div>
				</div>
			</div>
		</section>
			
	</body>
</html>