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
        height:1000px;
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
    #addActor{
    	cursor:pointer;
    }
    #actor_cover, #actor_cover1{
    	border : 0px solid lightgrey;
    	height: 200px;
    	width: 100%;
    	white-space:nowrap;
    	overflow-x: hidden;
    }
    .actor{
    	width: 40%;
    	height: 180px;
    	float:left;
    	border : 0px solid lightgrey;
    }
    .actorImage{
    	border: 0px solid black;
    	width:100%;
    	height:200px;
    	overflow-x:hidden;
    }
    .actor_name{
    	border : 0px solid lightgrey;
    	text-align:center;
    }
    .image_cover{
    	text-align:center;
    	width:32%;
    	float:left;
    }
    .check_actor{
    	cursor:pointer;
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
                    <img id="plus" src="resources/detailFilmImage/plus.jpg" style="width:30px; height:30px;">
                </div>

                <div class="icon" id="likeBtn">      <!-- 좋아요 -->
                    <img id="heart" src="resources/detailFilmImage/heart.jpg" style="width:30px; height:30px;">
                </div>

                <div class="icon" id="modifyBtn">    <!-- 수  정 -->
                    <img id="memo" src="resources/detailFilmImage/modifyBtn.jpg" style="width:30px; height:30px;">
                </div>
                
                <div id="movie_poster"> <!-- 포스터 -->
                    <img id="poster" src="resources/detailFilmImage/${i.changeName}" style="width:100%; height:100%;">
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
	                    <textarea class="movie_clip" name="trailer" placeholder="유튜브 링크를 연결해주세요!" rows="2" cols="40" style="border:0px;">${ df.trailer }</textarea>
                	</div>
                    <div class="cover" id="sysnobsis_cover">
   	                	<h5>감독</h5>
   	                	<div>${ df.director }</div>
                    </div>
                    <div class="cover" id="sysnobsis_cover">
                    
                    <h5>출연 배우</h5>
   	               	<div class="actorImage">
		            	<c:forEach items="${ al }" var="a">
   		                	<div class="image_cover">
	   	                		<img src="resources/detailFilmImage/actor/${a.profileImage}" width='150' height='150' style="border-radius: 100px;">
				                <div name="actorName">${a.actorName}</div>
	   	                	</div>	
					    </c:forEach>   
   	                </div>
    	            
                    <div id="addActor">추가하기</div>
                    </div>
                    <div class="cover" id="sysnobsis_cover">
	                    <h5>시놉시스</h5>
                    	<div id="synopsys"><textarea id="text_synopsys" name="synopsys" placeholder="정보를 입력해주세요" rows="10" cols="80" style="border:0px; resize: none;">${df.synopsys}</textarea></div>
                    </div>
                    
                    <div class="cover" id="plusInfo_cover">
                    	<h5>트리비아</h5>
                    	<div id="trivia"><textarea id="text_trivia" name="trivia" placeholder="정보를 입력해주세요" rows="10" cols="80" style="border:0px; resize: none;">${df.trivia}</textarea></div>
                    </div>
                    
                    <div class="cover">
                    	<button type="submit" id="modifyBtn">내용 저장</button>
                    </div>	<!-- 버튼 클릭시, updateForm 으로 이동 -->
                    		<!-- updateForm 에서 수정하고 저장 누르면 다시 이 페이지 -->
                </div>
            </form>
            </div>
        </div>
       
        <!-- collection 모달 -->
		<hr style="margin: 0;">
		<div class="modal fade" id="actor-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content" style="height:730px;">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">배우</h5>						<!-- 모달창 제목 -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">	<!-- 닫기 버튼 -->
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					
					<div class="modal-body">
						<h5 class="modal-title" id="exampleModalLabel">출연</h5>
						<div class="form-group">
							<!-- actor 큰틀 -->
							<div id="actor_cover">
								<c:forEach items="${ al }" var="a">
								<!-- actor 틀 -->
									<div class="actor">
										<!-- 배우 사진 -->
										<div class="actor_profile">
											<img src="resources/detailFilmImage/actor/${a.profileImage}" width='150' height='150' style="border-radius: 100px;">
										</div>
										<!-- 배우 이름 -->
										<div class="actor_name">${a.actorName}</div>
									</div>
								</c:forEach>
							</div>
						</div>

						<!-- 배우 검색부 모달창 -->
						<form action="#" onsubmit='return false;'>
							<div class="form-group">
								<lavel>배우 검색</label>
								<input type="text" id="searchName" class="form-control" name="searchName" placeholder="이름을 입력해주세요">
							</div>
						</form>
						
						<!-- 배우 검색 결과 -->
						<form action="#" onsubmit='return false;'>
							<div class="form-group">
								<div id="actor_cover1">
									<div class="actor searchActor">
										<div class="actor_profile">
											<img>
										</div>
										<div class="actor_name"></div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal" >Close</button>
								<button type="submit" class="btn" style="background:purple; color:white;" onclick="test();">등록하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
    </div>
    <br>
    
    <script>
	    $(function(){
			$("#addActor").on("click", function(){
				$('#actor-model').modal('toggle');
			});
		});
	    
	    $(document).ready(function(){
	    	$("#searchName").keypress(function (e){
	    		if(e.which ==13){
	    			searchActorList();
	    		}
	    	});
	    });
	        
	    function searchActorList(){
	    	
	    	var searchName = $('#searchName').val();
	    	
	    	$.ajax({
	    		url:"searchActorList.do",
	    		data:{searchName:searchName},
	    		datType:"json",
	    		success: function(list){
	    			console.log(list)
	    			var $aList = $("#actor_cover1");		//	<div>큰틀</div>
	    			
	    			$aList.html("");		// 기존 div 초기화
	    			$.each(list, function(index, value){
	    				
	    				var $div = $("<div class='actor check_actor'>");	// actor 틀
	    				
//	    				var $check = $("<input type='checkbox'>").attr({"name":"actorId", "value":value.id});		// 이거 아님
//	    				var $check = $("<input type='checkbox'>").attr("name","actorId").val(value.id);				// 이거 아님
	    				var $check = $("<input type='checkbox' class='test'>").attr("value",value.id);				// 이거 아님
	    				
	    				var $profile = $("<div class='actor_profile'>");	// 배우 사진 틀
	    				var $img = $("<img>").attr('src','resources/detailFilmImage/actor/'+value.profileImage).css({'width':'150', 'height':'150' ,'border-radius':'100px'});
	    				var $aName = $("<div class='actor_name'>").text(value.actorName).css('border-radius','100px');
	    				
	    				$div.append($profile);
	    				$div.append($check);	    				
	    				$div.append($img);
	    				$div.append($aName);
	    				
	    				$aList.append($div);
	    				
	    			});
	    		},error : function(){
	    			console.log("서버와의 통신 실패!");
	    		}
	    	});
	    }
	    
	    function test(){
	    	
	    	// 이 부분 수정필요////////////////////////////////
	    	
	    	var actorId = $(".test:checked").val();
	    	var befordActorId = "${al}";
	    	var acotr = befordActorId+ actorId;
	    	
	    	console.log(acotr);
	    	
	    	//location.href='addActor.do?id=${df.id}&filmId=${df.filmId}&actorId=' + actorId;
	    }
    </script>   
    
</body>
<jsp:include page="../common/footer.jsp"/>
</html>