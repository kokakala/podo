<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
	</head>
	<body>
    <!-- 본문 -->
    <div class="container">
	
        <div class="movie-info">
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
                    	<img id="poster" src="resources/detailFilmImage/${i.changeName}">
                    </c:if>
                    <c:if test="${i.changeName eq null}">
    	                <img id="poster" src="resources/detailFilmImage/podoposter.jpg"">
                	</c:if>
                </div>
                <br>
                <div class="modifyPoster btn button" id="modify_p_Btn">수정하기</div>
                <div id="cancel" class="btn button" onclick="cancel();">취소하기</div>
                <div id="mdfPosterBtn">
                	<input type="file" id="uploadPBtn" name="uploadPoster">
               	</div>
            </div>
					<div class="movie-info-cover">
						<!-- 오른쪽 영화 정보 -->
						<div class="container">
							<div class="row" id="title-cover">
								<span id="movie-title">${ df.titleKor }(${ df.titleEng })</span>
								<input type=text class="movie_clip" name="trailer" placeholder="유튜브 링크를 연결해주세요!" value="${ df.trailer }">
							</div>
							<br>
							<div class="row" id="sysnobsis_cover">
								<h5>감독</h5>
								<div>${ df.director }</div>
							</div>
							<div class="row" id="sysnobsis_cover">
								<br>
								<h5>출연 배우</h5>
								<div class="actorImage">
									<c:forEach items="${ al }" var="a">
										<div class="image_cover">
											<img src="resources/detailFilmImage/actor/${a.profileImage}">
											<div class="actorName">${a.actorName}</div>
											<div class="deleteActor" onclick="deleteActor('${a.id}');">삭제</div>
										</div>
									</c:forEach>
								</div>
							<div id="addActor" class="btn button">추가하기</div>
						</div>
						<br>
						<div class="comment-form" id="sysnobsis_cover">
							<h5>시놉시스</h5>
							<div id="synopsys">
								<textarea id="text_synopsys" class="form-control" name="synopsys" placeholder="정보를 입력해주세요">${df.synopsys}</textarea>
							</div>
						</div>
						<br>
						<div class="comment-form" id="plusInfo_cover">
							<h5>트리비아</h5>
							<div id="trivia">
								<textarea id="text_trivia" class="form-control" name="trivia" placeholder="정보를 입력해주세요" style="resize: none;">${df.trivia}</textarea>
							</div>
						</div>
						<br>
						<div class="cover">
							<button type="submit" class="btn button" id="modifyBtn">저장</button>
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