<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<jsp:include page="../common/admin-header.jsp"/>  
</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="home.do"><font size="3">Great, Grape!</font>&nbsp;PODO</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle">
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
        <a class="nav-link" href="manyStar.do">
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
        <a class="nav-link" href="blist.do">
          <ion-icon name="done-all"></ion-icon>
          <span>공지사항</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="inquiryList.do">
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
            	블랙리스트</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead align="center">                
                  <tr>
                    <th>체크</th>
					<th>NO</th>
					<th>회원아이디</th>
					<th>닉네임</th>
					<th>블랙이관일</th>
					<th>블랙해제</th>
                  </tr>
                </thead>
                <tbody align="center">
					<c:forEach items="${ list }" var="b">	
						<tr>
							<td><input type="checkbox" value="${b.id}" class="checkbox_target" /></td>
							<td>${ b.id }</td>
							<td>${ b.email }</td>
							<td>${ b.blackName }</td>
							<td><fmt:formatDate value="${b.blackDate}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
							<td><a href="javascript:;" class="btn_unblock" data-id="${b.id}">해제</a></td><!-- data-id : li, el태그에는 data X / 자바스크립트에서 접근할 수 있음-->
						</tr>
					</c:forEach>
                </tbody>
              </table>
 				<a href="javascript:;" id="btn_multi_unblock">해제</a>
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
          <a class="btn btn-primary" href="logout.do">Logout</a>
        </div>
      </div>
    </div>
  </div>
  
  
	<jsp:include page="../common/admin-footer.jsp"/>
  
  <!-- 블랙리스트 ajax -->
	<script>
		$(function() {
			$('.btn_unblock').click(function() {
				var param = {
					blockIds: [$(this).data('id')]
				};
				
				$.ajax({
					url: '/podo/v1/blacklist/unblock.do', // API버전
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify(param),
					success: function(data){
						console.log(data);
						
						if (JSON.parse(data)) {
							location.reload();
						} else {
							alert('block 해제에 실패했습니다.');
						}
					},
					error: function(){
						console.log("아이디 ajax 통신 실패");
					}
				});
			});
			
			var $checkboxTarget = $('.checkbox_target');
			var checkedIds = [];
			$('#btn_multi_unblock').click(function() {
				$checkboxTarget.each(function() {
					var $this = $(this);
					if ($this.is(':checked')) {
						checkedIds.push($this.val());
					}
				});
				
				var param = {
					blockIds: checkedIds
						
				};
				
				$.ajax({
					url: '/podo/v1/blacklist/unblock.do', // API버전
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify(param),
					success: function(data){
						console.log(data);
						
		 				if (JSON.parse(data)) {
							location.reload();
						} else {
							alert('block 해제에 실패했습니다.');
						}
					},
					error: function(){
						console.log("아이디 ajax 통신 실패");
					}
				});
			});
		});
	</script>
</body>

</html>