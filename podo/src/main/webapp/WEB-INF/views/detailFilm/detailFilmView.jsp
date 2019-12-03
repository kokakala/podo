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
        font-size:10px;
        border: 0px solid black;
        float:right;
    }
    #modify_all{
        width: 30%;
        float:right;
    }
    #rollbackBtn{
    	width:50%;
    	float:left;
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
    	float:left;
    	display : none;
    }
    .actorImage{
    	border: 0px solid black;
    	width:100%;
    	height:200px;
    	overflow-y:scroll;
    }
    .actor_name{
    	border : 0px solid lightgrey;
    	border-radius: 5px;
    }
    .image_cover{
    	text-align:center;
    	width:32%;
    	float:left;
    }
    .homeReviewArea{
		margin-left:auto;
		margin-right:auto;
		
		height: 150px;
		/* border: 1px solid blue; */
		width: 1150px;
	}
    .leftImage{
		 background:rgba(49,58,102,0.75);
		/* border: 1px solid green; */
		width: 20%;
		height: 100%;
		margin-left:auto;
		margin-right:auto;
		float: left;
	}
	.userImageHome{
		border-radius: 100%;
		height:60%;
		width:100%;
		border-radius:30;
		float:left;
		text-align:center;
	}
	.nickNameHome{
		font-size:10px;
		font-weight:bold;
		height:10%;
		width:100%;
		/* border: 1px solid purple; */
		float:left;
		text-align:center;
	}
	.countReview{
		height:15%;
		width:100%;
		float:left;
		text-align:center;
	}
	.starReview{
		height:15%;
		width:100%;
		float:left;
		text-align:center;
	}
	.rightContent{
		background:rgba(49,58,102,0.75);
		height:100%;
		width: 80%;
		float: left;
	}
	.homeContent{
		width:100%;
		height:100%;
		float:left;
	}
	.titleKorea{
		width:100%;
		float: left;
		height: 20%;
	}
	.contentKorea{
		background:rgb(18,22,49);
		float: left;
		width:95%;
		height:65%;
	}
	.btns{
	 	float:left;
		margin-left:610px;
		width:100%;
		height: 15%;
	}
	#poster{
		border-radius: 10px;
    	border : 1px solid white;
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
                <div id="movie_poster"> <!-- 포스터 -->
 	               	<c:if test="${i.changeName ne null}">
    	                <img id="poster" src="resources/detailFilmImage/${i.changeName}" style="width:100%; height:100%;">
                	</c:if>
                	<c:if test="${i.changeName eq null}">
    	                <img id="poster" src="resources/detailFilmImage/podoposter.jpg" style="width:100%; height:100%;">
                	</c:if>
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
   	                	<h5>감독</h5>
   	                	<div>${ df.director }</div>
                    </div>
                    <br>
                    <div>
                    	<h5>출연 배우</h5>
   	                	<div class="actorImage">
		                    <c:forEach items="${ al }" var="a">
   		                		<div class="image_cover">
	   	                			<img src="resources/detailFilmImage/actor/${a.profileImage}" width='150' height='150' style="border-radius: 100px;">
				                   	<div name="actorName">${a.actorName}</div>
	   	                		</div>	
					        </c:forEach>   
   	                	</div>
    	            </div>
			        <br>
                    <div class="cover" id="sysnobsis_cover">
                    	<h5>시놉시스</h5>
                    	<div id="synopsys">${ df.synopsys }</div>
                    </div>
                    <br>
                    <div class="cover" id="plusInfo_cover">
                    	<h5>트리비아</h5>
                    	<div id="trivia">${ df.trivia }</div>
                    </div>
                    <br>
                    <div class="cover" id="nickName_cover">
                    	<div id="df_nickName"><h5>작성자</h5>${ df.nickName }</div>
                    </div>
                    <br>
                    <c:if test="${ loginUser.autho eq 2 }">
                    	<div class="cover" id="rollbackBtn">
                    		<a href="detailFilmRollback.do?filmId=${df.filmId}" class="btn" style="background:purple; color:white;">되돌리기</a>
                    	</div>
                    </c:if>
                    <div class="cover" id="modifyBtn">
                    	<a href="detailFilmUpdate.do?filmId=${ df.filmId }" class="btn" style="background:purple; color:white;">정보 수정</a>
                    </div>
                    <br>
                </div>
            </div>
        </div>        
		<hr>
        <div class="df_review_list">
        <br>
		    <div>
	        	<h5>리뷰</h5><a href="reviewWriteForm.do?filmId=${df.filmId}&loginUserId=${loginUser.id}" class="btn" style="background:purple; color:white;">작성하기</a>
	    	</div>		<!-- 버튼 -->
		        <c:forEach items="${ rl }" var="r">
				<div class="homeReviewArea">
					
						<div class="leftImage">
						<img class="userImageHome" src="resources/memberProfileImage/${ r.userImage }" height="100%" width="100%">
						<div class="nickNameHome">${ r.nickName }님</div>
						<div class="starReview">★점:${ r.star }점</div>
						<div class="countReview">추천수:${ r.likeCount }회</div>
					</div>
					<div class="rightContent">
						<div class="titleKorea">${ r.titleKor }</div>
						<div class="contentKorea"> ${ r.content }</div>
						<div class="btns">${r.modifyDate }에
							작성 &nbsp;<a href="">추천</a>&nbsp;<a
								class="declaration-modal btn-reply text-uppercase" href="#"
								data-toggle="modal">신고하기</a> &nbsp;<a href="#">댓글 0개</a>
						</div>
						</div>
					
				</div>
				<br>
			</c:forEach>
    	</div>
	    <br>
    	</div>
    <br>
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
    </script>
    
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>