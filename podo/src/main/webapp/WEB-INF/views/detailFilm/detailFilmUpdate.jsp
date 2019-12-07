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
        height:1300px;
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
    .movie_clip{
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
    .textArea{
    	background-color: rgb(9, 15, 33);
    	color:grey;
    }
    #addActor, .deleteActor, .modifyPoster, #cancel{
    	cursor:pointer;
    }
    #addActor, #cancel{
    	float:right;
    }
    #poster{
    	border-radius: 10px;
    	border : 1px solid white;
    }
    
    #actor_cover, #actor_cover1{
    	border : 0px solid lightgrey;
    	height: 200px;
    	width: 100%;
    	white-space:nowrap;
    	overflow-x: hidden;
    }
    .actor{
    	width: 33%;
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
    	color:black;
    }
    .image_cover{
    	text-align:center;
    	width:32%;
    	float:left;
    }
    .check_actor{
    	cursor:pointer;
    }
    #mdfPosterBtn{
    	display:none;
    }
</style>
<body>
	<!-- 헤더  -->
	<jsp:include page="../common/header.jsp"/>
    
    <!-- 본문 -->
    <div id="body">

        <div class="movie_info2">
        <!-- 왼쪽 영화 포스터 -->
        <!-- 포스터 -->
            <form action="detailFilmInsert.do" method="post" enctype="multipart/form-data">
	            <input type="hidden" name="id" value="${df.id}">	<!-- 영화 상세 정보 번호 -->
	            <input type="hidden" name="filmId" value="${df.filmId}">  <!-- 영화 번호  -->
	            <input type="hidden" name="actorList" value="${al}">	 <!-- 배우 리스트 -->
	            
	            <input type="hidden" id="filmImage" name="filmImage" value="${ i.changeName }">
	            <input type="hidden" name="uId" value="${ loginUser.id }">
            <div class="movie_poster_cover"> 
                <div id="movie_poster"> 
               		<c:if test="${i.changeName ne null}">
                    	<img id="poster" src="resources/detailFilmImage/${i.changeName}" style="width:100%; height:100%;">
                    </c:if>
                    <c:if test="${i.changeName eq null}">
    	                <img id="poster" src="resources/detailFilmImage/podoposter.jpg" style="width:100%; height:100%;">
                	</c:if>
                </div>
                <br>
                <div class="modifyPoster btn" style="background:purple; color:white;"  id="modify_p_Btn">수정하기</div>
                <div id="cancel" class="btn" style="background:#6c757d; color:white;" onclick="cancel();">취소하기</div>
                <div id="mdfPosterBtn"><input type="file" id="uploadPBtn" name="uploadPoster"></div>
            </div>
            <div class="movie_info_cover">      <!-- 오른쪽 영화 정보 -->
                <div id="movie_detail_info">
                	<div class="cover" id="title_cover">
	                    <span id="movie_title">${ df.titleKor }(${ df.titleEng })</span>
	                    <textarea class="movie_clip textArea" name="trailer" placeholder="유튜브 링크를 연결해주세요!" rows="2" cols="30" style="border:0px; resize: none;">${ df.trailer }</textarea>
                	</div>
                	<br>
                    <div class="cover" id="sysnobsis_cover">
   	                	<h5>감독</h5>
   	                	<div>${ df.director }</div>
                    </div>
                    <div class="cover" id="sysnobsis_cover">
                    <br>
                    <h5>출연 배우</h5>
   	               	<div class="actorImage">
		            	<c:forEach items="${ al }" var="a">
   		                	<div class="image_cover">
	   	                		<img src="resources/detailFilmImage/actor/${a.profileImage}" width='150' height='150' style="border-radius: 100px;">
				                <div class="actorName">${a.actorName}</div>
				                <div class="deleteActor " onclick="deleteActor('${a.id}');">삭제</div>
	   	                	</div>	
					    </c:forEach>   
   	                </div>
    	            <br>
                    <div id="addActor" class="btn" style="background:purple; color:white;">추가하기</div>
                    </div>
                    <br>
                    <div class="cover" id="sysnobsis_cover">
	                    <h5>시놉시스</h5>
                    	<div id="synopsys"><textarea id="text_synopsys" class="textArea" name="synopsys" placeholder="정보를 입력해주세요" rows="10" cols="80" style="border:0px; resize: none;">${df.synopsys}</textarea></div>
                    </div>
                    <br>
                    <div class="cover" id="plusInfo_cover">
                    	<h5>트리비아</h5>
                    	<div id="trivia"><textarea id="text_trivia" class="textArea" name="trivia" placeholder="정보를 입력해주세요" rows="10" cols="80" style="border:0px; resize: none;">${df.trivia}</textarea></div>
                    </div>
                    <br>
                    <div class="cover">
                    	<button type="submit" class="btn" style="background:purple; color:white;" id="modifyBtn">내용 저장</button>
                    </div>	
                </div>
            </div>
            </form>
        </div>
       
        <!-- actor 모달 -->
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
										<input type="hidden" class="actor_id" name="uId" value="${a.id}">
										<!-- 배우 사진 -->
										<div class="actor_profile" style="border-radius: 50%;">
											<img src="resources/detailFilmImage/actor/${a.profileImage}" width='150' height='150' style="border-radius: 50%;">
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
								<label>배우 검색</label>
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
    	
    	// 기존에 등록되있는 배우를 담을 리스트 -- 전역으로 선언
    	var actorList = new Array();
    	
    	// 배우 등록 modal
	    $(function(){
			$("#addActor").on("click", function(){
				$('#actor-model').modal('toggle');
			});
		});
    	
    	// 배우 검색
	    $(document).ready(function(){
	    	$("#searchName").keypress(function (e){
	    		if(e.which ==13){
	    			searchActorList();
	    		}
	    	});
	    });
	        
    	// 배우 검색 함수
	    function searchActorList(){
	    	
	    	var searchName = $('#searchName').val();
	    	
	    	$.ajax({
	    		url:"searchActorList.do",
	    		data:{searchName:searchName},
	    		datType:"json",
	    		success: function(list){
					actorList = list;
					
	    			var $aList = $("#actor_cover1");		//	<div>큰틀</div>
	    			
	    			$aList.html("");		// 기존 div 초기화
	    			$.each(list, function(index, value){
	    				
	    				var $div = $("<div class='actor check_actor'>");	// actor 틀
	    				var $check = $("<input type='radio' class='test' name='resultSearch'>").attr("value",value.id).css("display","none");				// 이거 됨
	    				var $profile = $("<div class='actor_profile'>").css({'border-radius':'50%'});	// 배우 사진 틀
	    				var $img = $("<img>").attr('src','resources/detailFilmImage/actor/'+value.profileImage).css({'width':'150', 'height':'150' ,'border-radius':'50%'});
	    				var $aName = $("<div class='actor_name'>").text(value.actorName).css('border-radius','100px');
	    				
	    				
	    				$profile.append($img);
	    				
	    				$div.append($check);
	    				$div.append($profile);
	    				$div.append($aName);
	    				
	    				$aList.append($div);
	    				
	    			});
	    		},error : function(){
	    			console.log("서버와의 통신 실패!");
	    		}
	    	});
	    }
	    
	    function test(){

	    	// 배우 번호만 짤라서 쭈우욱 담아줌.
	    	var a = $("#actor_cover .actor_name");
	    	
	    	// 이전에 등록돼있는 배우들 만큼, 번호만 뽑아서 저장
	    	var actorIdList = "";	// 담아 줄 곳 선언

	    	// 기존에 등록된 배우길이 만큼 for문 돌려주고, actorIdList 에 배우 번호를 쌓음
	    	for(var i=0 ; i<a.length ; i++){
	    		
	    		actorIdList += $(".actor_id").eq(i).val();
	    		
	    		// 마지막 인덱스면 , 붙여주지 않음
	    		if (i != a.length-1){
	    			actorIdList += "/";
	    		}
	    	}
	    	//--------- 기존에 저장된 배우들 문자열에 담아줌!

	    	var compare = actorIdList.split("/");
	    	
	    	$("input[class=test]:checked").each(function(){
	    		
	    		newActorId = $(this).val();
	    		newActor = $(this).val();
	    		
	    		if(compare.indexOf(newActor) == -1){
	    			location.href='addActor.do?id=${df.id}&filmId=${df.filmId}&newActorId='+newActorId;
	    		}
	    	});
	    }
	    
	    // 배우 삭제
	    function deleteActor(actorId){
	    	location.href='deleteActor.do?id=${df.id}&filmId=${df.filmId}&actorId='+actorId;
	    }
	    
		// 포스터 변경 버튼
		$('#modify_p_Btn').on('click',function(e){
			e.preventDefault();
			$("#uploadPBtn").click();
		});
	    
	    // 포스터 변경전 미리보기 
	    function readURL(input){
	    	if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                $('#poster').attr('src', e.target.result);
	            }
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
		// 이미지 변경 될 때마다 이미지 미리보기
		$(document).on("change","#uploadPBtn",function(){
			readURL(this);
		});
	    
	    // 이미지 삭제 = 완성
	    function cancel(){
	    	$("#mdfPosterBtn input").remove();
	    	$("#poster").attr('src','resources/detailFilmImage/${i.changeName}').css({'width':'100%','height':'100%'});
	    	var newInput = "<input type='file' id='uploadPBtn' name='uploadPoster'>";
	    	$("#mdfPosterBtn").append(newInput);
	    }
	    
	    $(document).on("click",".check_actor", function() {
	    	$(this).children('.test').prop('checked', true);
	    	console.log('클릭');
	    	$(this).parent().children('.check_actor').children('.actor_profile').css("border","none");
	    	$(this).children().eq(1).css("border","2px solid purple");	    	
		});
    </script>   
    
</body>
<jsp:include page="../common/footer.jsp"/>
</html>