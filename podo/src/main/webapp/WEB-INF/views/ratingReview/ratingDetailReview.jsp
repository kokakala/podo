<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
  <link rel="icon" href="img/Fevicon.png" type="image/png">

  <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="vendors/linericon/style.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
<!-- 제이쿼리 -->
  <script src="https://code.jquery.com/jquery-latest.js"></script> 
  <link rel="stylesheet" href="css/style.css">
  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="js/jquery.ajaxchimp.min.js"></script>
  <script src="js/mail-script.js"></script>
  <script src="js/main.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>Insert title here</title>
<style>




	body{
		width: 100%;
		height: 100%;
	}
	#body{
		width: 60%;
		height: 100%;
		margin-left:auto;
		margin-right:auto;
	}
	#mychart2{
		margin-left:auto;
		margin-right:auto;
		
		width:350px;
		height:350px;
		display:inline-block;
		
	}
	
	#movieform{
		display:inline-block;
		
	
	}
	.img-fluid{
		margin-left:260px;
		width:200px;
		height:50px;
	}
			.star-input>.input,
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label {
				display: inline-block;
				vertical-align: middle;
				background: url('resources/common/img/rating-star.png') no-repeat;
			}
			
			.star-input {
				display: inline-block;
				white-space: nowrap;
				width: 225px;
				height: 40px;
				padding: 25px;
				line-height: 30px;
			}
			
			.star-input>.input {
				display: inline-block;
				width: 150px;
				background-size: 150px;
				height: 28px;
				white-space: nowrap;
				overflow: hidden;
				position: relative;
			}
			
			.star-input>.input>input {
				position: absolute;
				width: 1px;
				height: 1px;
				opacity: 0;
			}
			
			star-input>.input.focus {
				outline: 1px dotted #ddd;
			}
			
			.star-input>.input>label {
				width: 30px;
				height: 0;
				padding: 28px 0 0 0;
				overflow: hidden;
				float: left;
				cursor: pointer;
				position: absolute;
				top: 0;
				left: 0;
			}
			
			.star-input>.input>label:hover,
			.star-input>.input>input:focus+label,
			.star-input>.input>input:checked+label {
				background-size: 150px;
				background-position: 0 bottom;
			}
			
			.star-input>.input>label:hover ~label{
				background-image: none;
			}
		
			.star-input>output {
				display: inline-block;
				width: 60px;
				font-size: 18px;
				text-align: right;
				vertical-align: middle;
			}
		.main_blog_details{
			margin-left:200px;
			width: 100%;
		}
		#movieform{
			text-align: center;
		}
	#like{
		margin-left: 500px;

	}

	
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div id="body">
		<h1 align="center">레이팅리뷰상세페이지</h1>
		
		<br>
		
		<h3 align="center">
			<a href="reviewUpdateView.do?id=${r.ratingReviewId}">수정하기</a>
		</h3>
	  <section class="blog-post-area section-margin">
    <div class="container">
      <div class="row">
        <div class="col-lg-8">
            <div class="main_blog_details">
              <img class="img-fluid" src="resources/detailFilmImage/${r.posterImage }" alt=""> 
        <%--     <img class="img-fluid" src="resources/detailFilmImage/${rr.posterImage }" alt=""> --%>
               <h4 align="center">${r.titleKor }</h4>
                <div class="user_details">
                    <div class="float-left">
                      <div class="media">
                      <div class="media-body">
                        <a href="userPage.do?userId=${r.memberId}&loginUserId=${ loginUser.id }"><h5>${r.nickName }님</h5></a>
                 
                        <p>${ r.createDate }에 작성</p>
                      </div>
                      <div class="d-flex">
                        <img width="42" height="42" src="resources/memberProfileImage/${ r.userImage }" onclick="location.href='userPage.do?userId=${r.memberId}&loginUserId=${ loginUser.id }'">
                      </div>
                    </div>
                  	</div>
                  <div class="float-right mt-sm-0 mt-3">
                    <div class="media">
  					  <div class="media-body">
                        <h2>★ :${r.star }점</h2>
                        
                      </div>
                      <div class="d-flex">
                        <img width="42" height="42" src="resources/bootstrap/img/blog/user-img.png" alt="">
                      </div>
                    </div>
                  </div>
                </div>
                <br>
                <br>
                <div id="mychart2">
   <canvas id="myChart">캔버스</canvas>
   
   <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
   
   
   
   <script>
   var ctx = document.getElementById('myChart');
   var chart = new Chart(ctx, {
       // The type of chart we want to create
       type: 'radar',

       // The data for our dataset
       data: {
           labels: ["음악", "영상", "연기", "대중성", "각본","연출"],
           datasets: [{
               label: ["${ r.titleKor }"], 
            backgroundColor: "rgb(165,102,255)",
            pointBackground:"rgba(179,181,198,1)",
            pointBorderColor:"#fff",
            pointBorderBackgroundColor:"#fff",

               data: [
            	   ${r.ratingSound},${r.ratingVisual},${r.ratingActing},${r.ratingPop},${r.ratingScript},${r.ratingDirect}
            	   ]
    
           }]
       },

       // Configuration options go here
             options: {
                 
                 scale: {
                      angleLines: {
                          display: false
                      },
                      ticks: {
                          suggestedMin: 0,
                          suggestedMax: 10,
                      }
                  },
                  tooltips:{
                     callbacks: {
                          label: function(tooltipItem, data) {
                              
                              return data.labels[tooltipItem.index]  + " : "+ Math.round(tooltipItem.yLabel * 100) / 100 +"점";
                          }
                      }
                  }
              }
    });
   </script>
   </div>
   
    <form action="vinsert.do" method="post" id="movieform">
      <table align="center" id="vv">
         <tr>
            <td class="alert alert-primary">제목</td>
            <td><input style="text-align: center" class="button" type="text" name="title" id="vtitle"  value="${ r.titleKor }"  readonly></td>
         </tr>
         <tr>
            <td class="alert alert-primary">음악</td>
            <td><input style="text-align: center" class="button" type="text" name="ratingSound" class="insertRating" id="ratingSound" value="${r.ratingSound }" readonly></td>
         </tr>
         <tr>   
            <td class="alert alert-primary">영상</td>
            <td><input style="text-align: center" class="button" type="text" name="ratingVisual" class="insertRating" id="ratingVisual" value="${r.ratingVisual }" readonly></td>
         </tr>
         <tr>
            <td class="alert alert-primary">연기</td>
            <td><input style="text-align: center" class="button" type="text" name="ratingActing" class="insertRating" id="ratingActing" value="${r.ratingActing }" readonly></td>
         </tr>
         <tr>
            <td class="alert alert-primary">대중성</td>
            <td><input style="text-align: center" class="button" type="text" name="ratingPop" class="insertRating" id="ratingPop" value="${r.ratingPop }" readonly></td>
         </tr>
         <tr>
            <td class="alert alert-primary">각본</td>
            <td><input style="text-align: center" class="button" type="text" name="ratingScript" class="insertRating" id="ratingScript" value="${r.ratingScript }" readonly></td>
         </tr>
         <tr>
            <td class="alert alert-primary">연출</td>
            <td><input style="text-align: center" class="button" type="text" name="ratingDirect" class="insertRating" id="ratingDirect" value="${r.ratingDirect }" readonly></td>
         </tr>
                 
		
      </table>
   </form>
   </div>
  
        <p class="main_blog_details">${r.content }</p>
               
     	<div class="likedeclaration">
		<a id="like" class="btn-reply text-uppercase" href="#">좋아요</a>
		<a id="declaration-modal" class="btn-reply text-uppercase" href="#" data-toggle="modal">신고하기</a>
		</div>
		<div>

					
		</div>
              </div>
        </div>
      </div>
      
      
  </section>
  
  <!-- 댓글 등록 -->
  <table align="center" width="500" border="1" cellspacing="0">
	  <tr>
		  	<td><textarea rows="3" cols="55" id="review-comment"></textarea></td>
		  	<td><button id="rBtn">댓글등록</button></td>
	  </tr>
  </table>
  
  <!-- 댓글리스트 -->
	<table align="center" width="500" border="1" cellspacing="0" id="rtb">
  		<thead>
	  		<tr>
	  			<td colspan="3"><b id="rCount"></b></td>
	  		</tr>
  		</thead>
  		<tbody>
  		
  		</tbody>
  	</table>
	
	
	<script>
	// 댓글 작성해주는거
	$(function(){
		getReplyReviewCommentList();
			
			setInterval(function(){
				getReplyReviewCommentList();
			}, 50000);
			
			
			$("#rBtn").on("click", function(){
				
				var content = $("#review-comment").val();
				var boardId = ${r.id};
				var nickName = "${r.nickName}";
				
				$.ajax({
					url:"insertReviewComment.do",
					data:{content:content,
						  boardId:boardId,
						  nickName:nickName
					},
					success:function(data){
						if(data == "success"){
							console.log(data);
							getReplyReviewCommentList();
							$("#review-comment").val("");
						}else{
							alert("댓글 작성 실패");
						}
					},error:function(){
						console.log("ajax 통신 실패");
					}
				});
			});			
		});
	
	
	
	// 댓글 리스트 가져오는거
		$(function () {
			getReplyReviewCommentList();
		});
		
		function getReplyReviewCommentList(){
			
			
			
			$.ajax({
				url:"reviewCommentList.do",
				data:{id:${r.id}},
				dataType:"json",
				success:function(data){
					//console.log(data);
					
					$tbody = $("#rtb tbody");
					$tbody.html("");
					
					$("#rCount").text("댓글(" + data.length + ")");
					
					if(data.length > 0){
						$.each(data, function(index, value){
							$tr = $("<tr></tr>");
							
							$writerTd = $("<td width='200'></td>").text(value.nickName);
							$contentTd = $("<td></td>").text(value.content);
							$dateTd = $("<td></td>").text(value.createDate);
							
							$tr.append($writerTd);
							$tr.append($contentTd);
							$tr.append($dateTd);
							
							$tbody.append($tr);
							
						});
						
					}else{
						
						$tr = $("<tr></tr>");
						
						$contentTd = $("<td colspan='3'></td>").text("등록된 댓글이 없습니다.");
						$tr.append($contentTd);
						
						$tbody.append($tr);
						
					}
				},
				error:function(){
					console.log("통신실패");
				}
				
			});
		}
		
		
	</script>
	
	
	<!-- 	<div class="comments-area">
			<h4>05 Comments</h4>
			<div class="comment-list">
				<div class="single-comment justify-content-between d-flex">
					<div class="user justify-content-between d-flex">
						<div class="thumb">
							<img src="img/blog/c1.jpg" alt="">
						</div>
						<div class="desc">
							<h5>
								<a href="#">Emilly Blunt</a>
							</h5>
							<p class="date">December 4, 2017 at 3:12 pm</p>
							<p class="comment">Never say goodbye till the end comes!</p>
						</div>
					</div>
					<div class="reply-btn">
						<a href="" class="btn-reply text-uppercase">reply</a>
					</div>
				</div>
			</div>
		</div>


		<div class="comment-form">
			<h4>Leave a Reply</h4>
			<form>
				<div class="form-group form-inline">
					<div class="form-group col-lg-6 col-md-6 name">
						<input type="text" class="form-control" id="name"
							placeholder="Enter Name" onfocus="this.placeholder = ''"
							onblur="this.placeholder = 'Enter Name'">
					</div>
					<div class="form-group col-lg-6 col-md-6 email">
						<input type="email" class="form-control" id="email"
							placeholder="Enter email address" onfocus="this.placeholder = ''"
							onblur="this.placeholder = 'Enter email address'">
					</div>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" id="subject"
						placeholder="Subject" onfocus="this.placeholder = ''"
						onblur="this.placeholder = 'Subject'">
				</div>
				<div class="form-group">
					<textarea class="form-control mb-10" rows="5" name="message"
						placeholder="Messege" onfocus="this.placeholder = ''"
						onblur="this.placeholder = 'Messege'" required=""></textarea>
				</div>
				<a href="#" class="button submit_btn">Post Comment</a>
			</form>
		</div> -->

		<br>
	

	</div>
	<!-- 신고하기 모달 -->
	<div class="modal fade" id="de_modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					신고하기
					<form action="declarationModal.do" method="post">
						<input type="hidden" name="reportId" value="${ loginUser.id }">
						<input type="hidden" name="targetId" value="${ r.id }">
						<input type="hidden" name="reportedId" value="${ r.memberId }">
						
					<div class="eu">
						
						<p></p>
							<input class="reviewType" type="radio" value="1" name="content">부적절한내용
							<input class="reviewType" type="radio" value="2" name="content">스포일러
						<p></p>
					</div>
					<div class="modal-footer">
						<button  type="submit" class="btn btn-primary">신고보내기</button>
						<button  class="btn btn-primary" data-dismiss="modal">Close</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>







	<!-- 	<input id="commentDe" type="radio" onclick="commentClick();" name="defaultMenu">댓글
						<p></p>
								<input class="commentType" type="checkbox" style="display:none;"><p class="commentType" style="display:none;">부적절한내용</p>
								<input class="commentType" type="checkbox" style="display:none;"><p class="commentType" style="display:none;">스포일러</p>
						<p></p>
						<input id="freeDe" type="radio" onclick="freeClick();" name="defaultMenu">자유게시판
						<p></p>
								<input class="freeType" type="checkbox" style="display:none;"><p class="freeType" style="display:none;">부적절한내용</p>
								<input class="freeType" type="checkbox" style="display:none;"><p class="freeType" style="display:none;">스포일러</p>
						<p></p>						
						<input id="collectionDe"  type="radio" onclick="collectionClick();" name="defaultMenu">컬렉션
						<p></p>
								<input class="collectionType" type="checkbox" style="display:none;"><p class="collectionType" style="display:none;">부적절한내용</p>
								<input class="collectionType" type="checkbox" style="display:none;"><p class="collectionType" style="display:none;">스포일러</p>
						<p></p> -->





	<script>
	
	
	// 신고하기 모달

		
	// 신고하기 버튼 클릭 시
	$("#declaration-modal").on( "click", function() {
        $("#de_modal").modal();
        //console.log("${ loginUser.id }");
    });



	//리뷰 클릭시
	function reviewClick() {
		if($("#reviewDe").is(":checked") == true) {
			$(".reviewType").css("display","inline-block");
		} else {
			$(".reviewType").css("display","none");
		}
		
	}

	/* //댓글 클릭시
	function commentClick() {
		if($("#commentDe").is(":checked") == true) {
			$(".commentType").css("display","inline-block");
		} else {
			$(".commentType").css("display","none");
		}
		

	}
	//자유게시판 클릭시
	function freeClick() {
		if($("#freeDe").is(":checked") == true) {
			$(".freeType").css("display","inline-block");
		} else {
			$(".freeType").css("display","none");
		}
		

	}
	// 컬렉션 신고시
	function collectionClick() {
		if($("#collectionDe").is(":checked") == true) {
			$(".collectionType").css("display","inline-block");
		} else {
			$(".collectionType").css("display","none");
		}
		

	} */

	</script>
</body>
</html>