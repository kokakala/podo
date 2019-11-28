<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
                        <h5>${r.nickName }님</h5>
                 
                        <p>${ r.createDate }에 작성</p>
                      </div>
                      <div class="d-flex">
                        <img width="42" height="42" src="resources/memberProfileImage/${ r.userImage }" alt="">
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
			
	
	<br>
	

	</div>
	<!-- 신고하기 모달 -->
	<div class="modal fade" id="de_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body">
				신고하기
					<div class="eu">
						<p></p>	
								<input class="reviewType" type="radio"  name="reviewconent">부적절한내용
								<input class="reviewType" type="radio"  name="reviewconent">스포일러	
						<p></p>
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
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" >신고보내기</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>












	<script>
	
	
	// 신고하기 모달

		
	// 신고하기 버튼 클릭 시
	$("#declaration-modal").on( "click", function() {
        $("#de_modal").modal();
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