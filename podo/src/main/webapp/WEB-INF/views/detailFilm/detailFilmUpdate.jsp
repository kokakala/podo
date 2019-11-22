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
        height:100px;
    }
    #body{
        width:60%;
        height:100%;
        margin-left: auto;
        margin-right: auto;
    }
    .movie_info2{
        width:100%;
        float:left;
        border:1px solid black;
    }
    .movie_poster_cover{
        width:30%;
        height:100%;
        position:relative;
        float:left;
        left:20px;
        border:1px solid blue;
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
    #collection{
        left:90%;
    }
    #likeBtn{
        top:90%;
    }
    #modifyBtn{
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
        border: 1px solid black;
    }
    #title_cover{
        font-size:50px;
    }
    .movie_clip{
        font-size:15px;
        border: 1px solid black;
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
</style>
<body>
	<!-- 헤더  -->
	<jsp:include page="../common/header.jsp"/>
    
    <!-- 본문 -->
    <div id="body">

        <div class="movie_info2">
            <div class="movie_poster_cover">    <!-- 왼쪽 영화 포스터 -->

                <div class="icon" id="collection">   <!-- 콜렉션 -->
                    <img id="plus" src="resources/detailFilmImage/plus.jpg" onclick="#" style="width:30px; height:30px;">
                </div>

                <div class="icon" id="likeBtn">      <!-- 좋아요 -->
                    <img id="heart" src="resources/detailFilmImage/heart.jpg" onclick="#" style="width:30px; height:30px;">
                </div>

                <div class="icon" id="modifyBtn">    <!-- 수  정 -->
                    <img id="memo" src="resources/detailFilmImage/modifyBtn.jpg" onclick="#" style="width:30px; height:30px;">
                </div>

                <div id="movie_poster"> <!-- 포스터 -->
                    <img id="poster" src="resources/detailFilmImage/${i.changeName}" onclick="#" style="width:100%; height:100%;">
                </div>

            </div>
            <div class="movie_info_cover">      <!-- 오른쪽 영화 정보 -->
            <form action="detailFilmInsert.do" method="post">
            <input type="hidden" name="id" value="${ df.id }">	<!-- 영화 상세 정보 번호 -->
            <input type="hidden" name="filmId" value="${ df.filmId }"> <!-- 영화 번호  -->
            
            <input type="hidden" name="filmImage" value="${ i.changeName }">
            <input type="hidden" name="uId" value="${ loginUser.id }">
                <div id="movie_detail_info">
                	<div class="cover" id="title_cover">
	                    <span id="movie_title">${ df.titleKor }(${ df.titleEng })</span>
	                    <textarea class="movie_clip" name="trailer" placeholder="유튜브 링크를 연결해주세요!" rows="2" cols="40">${ df.trailer }</textarea>
                	</div>
                    <div class="cover" id="sysnobsis_cover">
   	                	<div name="director">감독 : ${ df.director }</div>
                    </div>
                    <div class="cover" id="sysnobsis_cover">
                    	<div id="synopsys">배우 <textarea id="text_actor" name="actor" placeholder="정보를 입력해주세요" rows="1" cols="90">${ df.actor }</textarea></div>
                    </div>
                    <div class="cover" id="sysnobsis_cover">
                    	<div id="synopsys">시놉시스 <textarea id="text_synopsys" name="synopsys" placeholder="정보를 입력해주세요" rows="10" cols="90">${df.synopsys}</textarea></div>
                    </div>
                    
                    <div class="cover" id="plusInfo_cover">
                    	<div id="trivia">트리비아 <textarea id="text_trivia" name="trivia" placeholder="정보를 입력해주세요" rows="10" cols="90">${df.trivia}</textarea></div>
                    </div>
                    
                    <div class="cover">
                    	<button type="submit" id="modifyBtn">내용 저장</button>
                    </div>	<!-- 버튼 클릭시, updateForm 으로 이동 -->
                    		<!-- updateForm 에서 수정하고 저장 누르면 다시 이 페이지 -->
                </div>
            </form>
            </div>
        </div>
        <hr>
    </div>
    <br>

</body>

</html>