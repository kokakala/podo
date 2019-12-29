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

  <link rel="stylesheet" href="css/style.css">
  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="js/jquery.ajaxchimp.min.js"></script>
  <script src="js/mail-script.js"></script>
  <script src="js/main.js"></script>
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
		width:300px;
		height:190px;
		display:inline-block;
	}
	#movieform{
		display:inline-block;
	}
	.img-fluid{
		margin-left:180px;
		width:300px;
		height:190px;
	}
	.insertRating{
		width:179px;
	}
	.main_blog_details{
		margin-left:200px;
		width: 100%;
	}
	#ok1{
		margin-left: 150px;
	}
		
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div id="body">
		<h1 align="center">리뷰 수정 페이지</h1>
		
		<br>
		
		<h3 align="center">
			
		</h3>
	  <section class="blog-post-area section-margin">
    <div class="container">
      <div class="row">
        <div class="col-lg-8">
            <div class="main_blog_details">
                <img class="img-fluid" src="resources/detailFilmImage/${ r.posterImage }" alt="">
               <h4 align="center">${r.titleKor }<p>장르 : ${f.genre } </p></h4>
                <div class="user_details">
                    <div class="float-left">
                      <div class="media">
                      <div class="media-body">
                        <h5>${r.nickName }님</h5>
                        <p>${ r.modifyDate }에 수정하려함</p>
                      </div>
                      <div class="d-flex">
                        <img width="42" height="42" src="resources/memberProfileImage/${ r.userImage }" alt="">
                      </div>
                    </div>
                  	</div>
                  <div class="float-right mt-sm-0 mt-3">
                    <div class="media">
                      <div class="media-body">
                        <h5>청포도</h5>
                        <p>수정하는 공간입니다</p>
                      </div>
                      <div class="d-flex">
                       <!--  <img width="42" height="42" src="resources/bootstrap/img/blog/user-img.png" alt=""> -->
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
               label: ["${ rr.titleKor }"], 
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
   

    <form action="reviewUpdate.do" method="post" id="movieform">
      	<input type="hidden" name="id" value="${r.id}">
      	<input type="hidden" name="ratingReviewId" value="${r.ratingReviewId }">
      	<input type="checkbox" name="spoilerCheck" value="${r.spoilerCheck }">스포일러 유무
      <table align="center" id="vv">
         <tr>
            <td>영화제목</td>
            <td><input class="form-control" type="text" name="title" id="vtitle"  value="${ r.titleKor }"  readonly></td>
         </tr>
         <tr>
            <td>음악</td>
            <td><input type="number" name="ratingSound" class="form-control insertRating" id="ratingSound" value="${r.ratingSound }" min="0" max="10"></td>
         </tr>
         <tr>   
            <td>영상</td>
            <td><input type="number" name="ratingVisual" class="form-control insertRating" id="ratingVisual" value="${r.ratingVisual }" min="0" max="10"></td>
         </tr>
         <tr>
            <td>연기</td>
            <td><input type="number" name="ratingActing" class="form-control insertRating" id="ratingActing" value="${r.ratingActing }" min="0" max="10"></td>
         </tr>
         <tr>
            <td>대중성</td>
            <td><input type="number" name="ratingPop" class="form-control insertRating" id="ratingPop" value="${r.ratingPop }" min="0" max="10"></td>
         </tr>
         <tr>
            <td>각본</td>
            <td><input type="number" name="ratingScript" class="form-control insertRating" id="ratingScript" value="${r.ratingScript }" min="0" max="10"></td>
         </tr>
         <tr>
            <td>연출</td>
            <td><input type="number" name="ratingDirect" class="form-control insertRating" id="ratingDirect" value="${r.ratingDirect }" min="0" max="10"></td>
         </tr>

      </table>
   
                <p><textarea class="form-control" rows="3" cols="75" name="content" id="content"  >${r.content }</textarea></p>
                <button class="button" type="submit" id="ok1">리뷰수정하기</button>
               <button class="button" type="button" onclick="location.href='reviewList.do';">목록으로</button>
   </form>	
    </div>
     

              </div>
        </div>
      </div>
  
  </section>	
	
	<br>
	

	</div>
	
	 <script>
	
      $('.insertRating').on('input',function(){
         var ctx = document.getElementById('myChart');
         var chart = new Chart(ctx, {
             // The type of chart we want to create
             type: 'radar',

             // The data for our dataset
             data: {
                 labels: ["음악", "영상", "연기", "대중성", "각본","연출"],
                 datasets: [{
                	 label: ["${ rr.titleKor }"], 
                     backgroundColor: "rgb(165,102,255)",
                     pointBackground:"rgba(179,181,198,1)",
                     pointBorderColor:"#fff",
                     pointBorderBackgroundColor:"#fff", 
             
                    data: [$('#ratingSound').val(),$('#ratingVisual').val(),$('#ratingActing').val(),$('#ratingPop').val(),$('#ratingScript').val(),$('#ratingDirect').val()]
   
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
   })
 

   </script>
	
</body>
</html>