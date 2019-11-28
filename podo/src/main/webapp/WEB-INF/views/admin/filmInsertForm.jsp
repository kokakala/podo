<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>AdminPage</title>
  <script src="https://unpkg.com/ionicons@4.5.10-0/dist/ionicons.js"></script>

  <!-- Custom fonts for this template-->
  <link href="<c:url value="/resources/adBootstrap/vendor/fontawesome-free/css/all.min.css"/>" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="<c:url value="/resources/adBootstrap/vendor/datatables/dataTables.bootstrap4.css"/>" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="<c:url value="/resources/adBootstrap/css/sb-admin.css"/>" rel="stylesheet">

</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="home.do"><font size="3">Great, Grape!</font>&nbsp;PODO</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
        <div class="input-group-append">
          <button class="btn btn-primary" type="button">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>

    <!-- Navbar -->
    <ul class="navbar-nav ml-auto ml-md-0">
      <li class="nav-item dropdown no-arrow">
        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-user-circle fa-fw"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
        </div>
      </li>
    </ul>

  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="admin.do">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>AdminPage</span>
        </a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <ion-icon name="contacts"></ion-icon>
          <span>회원관리</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          <h6 class="dropdown-header">회원::</h6>
          <a class="dropdown-item" href="mlist.do">전체회원</a>
          <a class="dropdown-item" href="blackList.do">블랙리스트</a>
          <div class="dropdown-divider"></div>
          <h6 class="dropdown-header">신고::</h6>
          <a class="dropdown-item" href="rlist.do">신고회원관리</a>
          <a class="dropdown-item" href="rblist.do">신고게시글관리</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <ion-icon name="film"></ion-icon>
          <span>영화관리</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          <h6 class="dropdown-header">영화::</h6>
          <a class="dropdown-item" href="mlist.do">전체영화목록</a>
          <a class="dropdown-item" href="finsertForm.do">영화등록</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="adRlist.do">
          <ion-icon name="paper"></ion-icon>
          <span>리뷰관리</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="">
          <ion-icon name="done-all"></ion-icon>
          <span>공지사항</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="">
          <ion-icon name="help-circle"></ion-icon>
          <span>문의사항</span></a>
      </li>
    </ul>

    <div id="content-wrapper">

      <div class="container-fluid">

		  <!-- Page Content -->

        <ol class="breadcrumb">
          <li class="breadcrumb-item active">영화 등록하기</li>
        </ol>
		<form action="finsert.do" method="post" enctype="multipart/form-data">
			<table align="center">
				<tr>
					<td>장르</td>
					<td>
						<select name="genreId" required>
							<option value="">장르별</option>
							<c:forEach items="${ genre }" var="g">
								<option value="${ g.id }">${ g.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>포스터</td>
					<td>
						<div class="form-group">
							* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
							<img id="preview" src="resources/detailFilmImage/podoposter.jpg" style="width: 107px; height: 152px; object-fit: cover; cursor: pointer;"><br>
							<button type="button" id="uploadBtn">이미지 변경</button>
							<button type="button" onclick="fileReset();">이미지 삭제</button><br>
							<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
						</div>
					</td>
				</tr>
				<tr>
					<td>제목(국문)</td>
					<td><input type="text" name="titleKor" required></td>
				</tr>
				<tr>
					<td>제목(영문)</td>
					<td><input type="text" name="titleEng"></td>
				</tr>
				<tr>
					<td>감독</td>
					<td><input type="text" name="director" required></td>
				</tr>
				<tr>
					<td>제작년도</td>
					<td><input type="text" name="releaseYear" required></td>
				</tr>
				<tr>
					<td>제작국가</td>
					<td><input type="text" name="productionCountry" required></td>
				</tr>
				<tr>
					<td>개봉상태</td>
					<td>
						<input type="radio" id="released" name="productionStatus" value="개봉" required>
						<label for="released">개봉</label>
						<input type="radio" id="releasing" name="productionStatus" value="개봉예정" required>
						<label for="releasing">개봉예정</label>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">등록하기</button> 
						<button type="button" onclick="location.href='flist.do';">목록으로</button>
					</td>
				</tr>
			</table>
		</form>
		<hr>

      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © 2019 PODO ALL RIGHTS RESERVED</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">관리자 페이지를 종료하시려면 아래 Logout을 선택하십시오.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="home.do">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="<c:url value="/resources/adBootstrap/vendor/jquery/jquery.min.js" />"></script>
  <script src="<c:url value="/resources/adBootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js" />"></script>

  <!-- Core plugin JavaScript-->
  <script src="<c:url value="/resources/adBootstrap/vendor/jquery-easing/jquery.easing.min.js" />"></script>

  <!-- Page level plugin JavaScript-->
  <script src="<c:url value="/resources/adBootstrap/vendor/chart.js/Chart.min.js" />"></script>
  <script src="<c:url value="/resources/adBootstrap/vendor/datatables/jquery.dataTables.js" />"></script>
  <script src="<c:url value="/resources/adBootstrap/vendor/datatables/dataTables.bootstrap4.js" />"></script>

  <!-- Custom scripts for all pages-->
  <script src="<c:url value="/resources/adBootstrap/js/sb-admin.min.js" />"></script>

  <!-- Demo scripts for this page-->
  <script src="<c:url value="/resources/adBootstrap/js/demo/datatables-demo.js" />"></script>
  <script src="<c:url value="/resources/adBootstrap/js/demo/chart-area-demo.js" />"></script>
		
	<script>
		
		// Author : 혜경한
		// 이미지 삭제 버튼 클릭 시
		function fileReset() {
			$("#imgArea input").remove();
			$("#preview").attr({'src':'resources/detailFilmImage/podoposter.jpg',
													'style':'width: 107px; height: 152px; object-fit: cover; cursor: pointer;'});
			var newInput = "<input type='file' id='imgInp' name='poster'>";
			$("#imgArea").append(newInput);
		}
		
		// 이미지 미리보기
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#preview').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		};
	
		// 이미지 변경 될 때 마다 이미지 미리보기 함수 실행
		$(document).on("change", "#imgInp", function() {
			readURL(this);
		});
	
		// 이미지 버튼 클릭 시 인풋창 열리게 (안보이게 해둠)
		$("#uploadBtn, #preview").on('click', function(e) {
			e.preventDefault();
			$("#imgInp").click();
		});
	</script>
</body>

</html>