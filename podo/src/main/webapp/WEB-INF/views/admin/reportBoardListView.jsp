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
  
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
 
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

    <!-- Sidebar 메뉴바 -->
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
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <ion-icon name="film"></ion-icon>
          <span>영화관리</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          <h6 class="dropdown-header">영화::</h6>
          <a class="dropdown-item" href="flist.do">전체영화목록</a>
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

        <!-- 테이블 -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            	신고게시물</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead align="center">                
                  <tr>
                  	<th>체크</th>
					<th>NO</th>
					<th>타입</th>
					<th>신고게시글</th>
					<th>신고내용</th>
					<th>신고대상자</th>
					<th>신고자</th>
					<th>블라인드</th>
                  </tr>
                </thead>
                <tbody align="center">
					<c:forEach items="${ list }" var="r">	
						<tr>
							<td><input type="checkbox" value="${r.id}" class="checkbox_target" /></td>
							<td>${ r.id }</td>
							<td>
								<input type="hidden" value="${ r.type }">
								<c:choose>
								    <c:when test="${  r.type == 1}">
										리뷰
								    </c:when>
								    <c:when test="${  r.type == 2}">
										댓글
								    </c:when>
								    <c:when test="${  r.type == 3}">
										자유게시판
								    </c:when>
								    <c:when test="${  r.type == 4}">
										컬렉션
								    </c:when>
								</c:choose>
							</td>
							<td class="target-id">${ r.targetId }</td>
							<td>
								<c:choose>
								    <c:when test="${  r.content == 1}">
										부적절한 내용
								    </c:when>
								    <c:when test="${  r.content == 2}">
										스포일러
								    </c:when>
								</c:choose>
							</td>
							<td>${ r.reportedName }</td>
							<td>${ r.reportName }</td>
							<td><a href="javascript:;" class="btn_blind" data-id="${r.targetId}, ${r.type}">블라인드</a></td>
						</tr>
					</c:forEach>
                </tbody>
              </table>
              <a href="javascript:;" id="btn_multi_blind">블라인드</a>
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

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
  
  
  
    <!-- 블라인드처리 ajax -->

	<script>
		$(function() {
			$('.btn_blind').click(function() {
				
				var blinds = $(this).data('id');
				var jbSplit = blinds.split(', ');
				
				console.log(jbSplit);
				
				$.ajax({
					url: '/podo/v1/reportList/blind.do',
					type:"post",
					data: {targetId: jbSplit[0],
						   type: jbSplit[1]},
					success: function(data){
						console.log(data);
						
						if (data) {
							location.reload();
						} else {
							alert('blind에 실패했습니다.');
						}
					},
					error: function(){
						console.log("아이디 ajax 통신 실패");
					}
				});
			});
			
			var $checkboxTarget = $('.checkbox_target');
			var checkedIds = [];
			
			$('#btn_multi_blind').click(function() {
				
				$checkboxTarget.each(function() {
					var $this = $(this);
					if ($this.is(':checked')) {
						checkedIds.push($this.closest("tr").find(".target-id").text());
						checkedIds.push($this.closest("tr").find("input[type=hidden]").val());
					}
				});
				console.log(checkedIds);
				
				$.ajax({
					url: '/podo/v1/reportList/blind.do',
					type: 'post',
					data: {checked:checkedIds},
				    traditional : true,
					success: function(data){
						console.log(data);
						
		 				if (data) {
							location.reload();
						} else {
							alert('blind에 실패했습니다.');
						}
					},
					error: function(){
						console.log("아이디 ajax 통신 실패");
					}
				});
			});
		});
	</script>
  
 
 
  

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

</body>

</html>