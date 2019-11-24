<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript"></script>
<title>PoDo</title>
</head>

<style>
    body{
        width:100%;
        height:100%;
    }
    #body{
        width:60%;
        height:100%;
        margin-left: auto;
        margin-right: auto;
    }
    .video-background {
		background: #000;
        width: 100%;
        height:25%;
	}
	
	.video-foreground, .video-background iframe {
		pointer-events: none;
	}
    #muteYouTubeVideoPlayer{
        width:100%;
    }
    .movie_info{
        width:100%;
        height:40%;
        float:left;
        border:0px solid black;
    }
    .movie_poster_cover{
        width:30%;
        height:100%;
        position:relative;
        float:left;
        left:20px;
        border:0px solid blue;
    }
    .movie_info_cover{
        width: 60%;
        float:right;
    }
    .icon{
        position: absolute;
        z-index: 1;
        width: 30px;
        height: 30px;
    }
    #collectionBtn{
        left:90%;
        cursor:pointer;
    }
    #likeBtn{
        top:90%;
    }
    #modifyBtn, #rollbackBtn{
        top:90%;
        left:90%;
    }
    #movie_poster{
        position: relative;
    }
    .review{
        width: 100%;
        border: 1px solid black;
        height: 40%;
    }
    .cover{
        border: 0px solid black;
    }
    #title_cover{
        font-size:50px;
    }
    #movie_clip{
        font-size:15px;
        border: 0px solid black;
        float:right;
    }
    #modify_all{
        width: 30%;
        float:right;
    }
    #modifyBtn{    
    	float:right;
    }
    #synopsys{
    	border: 0px solid black;
    }
    .df_r_spoilerCheck{
    	color:red;
	    cursor:pointer;
    	display : block;
    }
    .df_r_content{
    	display : none;
    }
</style>
<body>
	<!-- 헤더  -->
	<jsp:include page="../common/header.jsp"/>
    
    <!-- 본문 -->
    <div id="body">
    	<div class="video-background">
            <div class="video-foreground">
                <div id="muteYouTubeVideoPlayer"></div>
            </div>
        </div>
    	<hr>
        <div class="movie_info">
        	<!-- 왼쪽 영화 포스터 -->
            <div class="movie_poster_cover">
            
            	<c:if test="${ loginUser.id ne null }">
	                <div class="icon" id="collectionBtn">   <!-- 콜렉션 -->
	                    <img id="plus" src="resources/detailFilmImage/plus.jpg" style="width:30px; height:30px;">
	                </div>

	                <div class="icon" id="likeBtn">      <!-- 좋아요 -->
	                    <img id="heart" src="resources/detailFilmImage/heart.jpg" style="width:30px; height:30px;">
	                </div>
			    </c:if>
                                
                <div id="movie_poster"> <!-- 포스터 -->	
                    <img id="poster" src="resources/detailFilmImage/${i.changeName}" style="width:100%; height:100%;">
                </div>

            </div>
            <!-- 오른쪽 영화 정보 -->
            <div class="movie_info_cover">
                <div id="movie_detail_info">
                	<div class="cover" id="title_cover">
	                    <span id="movie_title">${ df.titleKor }(${ df.titleEng })</span>
	                    <span id="movie_clip">예고편 : ${ df.trailer }</span>
                	</div>
                    <div class="cover" id="director_cover">
   	                	<div>감독 : ${ df.director }</div>
                    </div>
                    
                    <div class="cover" id="actor_cover">
                    	<div>배우 : ${ df.actor }</div>
                    </div>
                    
                    <div class="cover" id="sysnobsis_cover">
                    	<div id="synopsys">시놉시스 : ${ df.synopsys }</div>
                    </div>
                    
                    <div class="cover" id="plusInfo_cover">
                    	<div id="trivia">트리비아 : ${ df.trivia }</div>
                    </div>
                    
                    <div class="cover" id="nickName_cover">
                    	<div id="trivia">작성자 : ${ df.nickName }</div>
                    </div>
                    
                    <c:if test="${ loginUser.id ne null }">
                    	<div class="cover" id="rollbackBtn">
                    		<a href="detailFilmRollback.do?filmId=${df.filmId}">되돌리기</a>
                    	</div>
                    </c:if>
                    
                    <c:if test="${ loginUser.id ne null }">
	                    <div class="cover" id="modifyBtn">
	                    	<a href="detailFilmUpdate.do?filmId=${ df.filmId }">정보 수정
	                    </div>
	                </c:if>
                </div>
            </form>
            </div>
        </div>
        <div class="df_review_list">
		    <div><a href="reviewWriteForm.do?filmId=${df.filmId}&loginUserId=${loginUser.id}">리뷰 작성하기 버튼</a></div>		<!-- 버튼 -->
		    
	        <c:forEach items="${ rl }" var="r">
		        <div class="review">
			        <div>리뷰</div>
			        <c:if test="${ r.spoilerCheck eq 'Y' }">
			            <div class="df_r_spoContent">
				            <div class="df_r_spoilerCheck">해당 내용은 스포일러를 포함하고 있습니다.</div>
				            <div class="df_r_content">내용 : ${ r.content }</div>
			            </div>
			        </c:if>
			        <c:if test="${ r.spoilerCheck eq 'N' }">
			            <div>내용 : ${ r.content }</div>
			        </c:if>
			            <div>별점 : 아직 처리 못함</div>			        
			            <div>작성자 : ${ r.nickname}</div>
			            <div>좋아요 : ${ r.likeCount }</div>
		        </div>
	        </c:forEach>
    	</div>
	    <br>
    	</div>
    <br>
    
    <!-- collection 모달 -->
	<hr style="margin: 0;">
	<div class="modal fade" id="collectionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">콜렉션</h5>						<!-- 모달창 제목 -->
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">	<!-- 닫기 버튼 -->
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="updateMember.do" method="post">
						<input type="hidden" name="id" value="${loginUser.id}">
						
						<div class="form-group">
							<label for="userId">콜렉션 제목</label>
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
    
    
    
    <script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script async src="https://www.youtube.com/iframe_api"></script>
	<script type="text/javascript">
		
		// 예고편 절단
		var trailer = "${df.trailer}";
		var trSplit = trailer.split('=');
		var trailer1 = trSplit[1];
		
		var player;
		
        function onYouTubePlayerAPIReady(){
			player = new YT.Player('muteYouTubeVideoPlayer', {
				
				//videoId : 'x60mB0zXZ38',
				videoId : trailer1,
				playerVars : {
					autoplay : 1, 		// Auto-play the video on load
					controls : 0, 		// Show pause/play buttons in player
					rel : 0,

					start : 75,         // 원하는 예고편 시작 지점
					end : 135,          // 원하는 예고편 끝나는 지점

					showinfo : 0,
					showinfo : 0, 		// Hide the video title
					modestbranding : 1, // Hide the Youtube Logo
					loop : 1, 			// Run the video in a loop
					playlist : trailer1,
					fs : 0, 			// Hide the full screen button
					cc_load_policy : 0, // Hide closed captions
					iv_load_policy : 3, // Hide the Video Annotations
					autohide : 1		// Hide video controls when playing
				},
                events:{
					onReady:function(e){
						e.target.mute();
					}
				}
			});
		}
        
	</script>
	<script>
		$(document).ready(function(){
			$(".df_r_spoContent").on("click",function(){
				$(this).children(".df_r_spoilerCheck").css("display","none");
	        	$(this).children(".df_r_content").css("display","block");
			});
		});
		
		$(function(){
			$("#collectionBtn").on("click", function(){
				$('#collectionModal').modal('toggle');
			});
		});
    </script>
    
    
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>