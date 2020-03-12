<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<!--bootstrap template-->
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logofavi.png">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	
    <link href="${pageContext.request.contextPath}/resources/css/design/sb-admin-2.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/design/all.min.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
   <link href="${pageContext.request.contextPath}/resources/css/design/common.css" rel="stylesheet" type="text/css">
<script>

$(function(){
	function getfileSize(x) {
		  var s = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'];
		  var e = Math.floor(Math.log(x) / Math.log(1024));
		  return (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
	};
	
	var size = ${fileTotalSize};
	
	var sizeForm = getfileSize(size);
	var file_box = $('.manager-file-size');
	$(file_box).text(sizeForm);	
});

</script>
</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

	

    <!-- 왼쪽 바 시작 -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion newline" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <div class="sidebar-brand d-flex align-items-center justify-content-center" >
	    <div class="logowrap">
		    <div class="sidebar-brand-icon logo-back">
		            <img style="width:44px" src="${pageContext.request.contextPath}/resources/image/logo.png" alt="logo" />
		    </div>
		    <div class="sidebar-brand-text" style="top: 1.5rem; position: absolute; font-size:20px; top:18px; left:86px">
		    	<a href="${pageContext.request.contextPath}" style="text-decoration:none; color:#fff;">Circle</a>
		 </div>
	    </div>
    </div>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
	  <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/manager/main">
          <i class="fas fa-fw fa-home"></i>
          <span>관리자 메인</span></a>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider">


      <!-- 토픽 목록 시작-->
      <li class="nav-item active">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>회원 관리</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
<!--             <h6 class="collapse-header">Login Screens:</h6> -->
            <a class="collapse-item" href="${pageContext.request.contextPath}/manager/member?type=&value=">회원목록</a>
            <a class="collapse-item" href="#">채팅2</a>
            <div class="collapse-divider"></div>
          </div>
        </div>
      </li>
      
      <li class="nav-item active">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          <i class="fas fa-fw fa-folder"></i>
          <span>팀 관리</span>
        </a>
        <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
<!--             <h6 class="collapse-header">Login Screens:</h6> -->
            <a class="collapse-item" href="${pageContext.request.contextPath}/manager/team?type=&value=">팀목록</a>
            <a class="collapse-item" href="#">채팅2</a>
            <div class="collapse-divider"></div>
          </div>
        </div>
      </li>
      
      <li class="nav-item active">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
          <i class="fas fa-fw fa-folder"></i>
          <span>매출 관리</span>
        </a>
        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
<!--             <h6 class="collapse-header">Login Screens:</h6> -->
            <a class="collapse-item" href="#">채팅1</a>
            <a class="collapse-item" href="#">채팅2</a>
            <div class="collapse-divider"></div>
          </div>
        </div>
      </li>
      
      <li class="nav-item active">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-folder"></i>
          <span>관리자 관리</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
<!--             <h6 class="collapse-header">Login Screens:</h6> -->
            <a class="collapse-item" href="${pageContext.request.contextPath}/manager/admin?type=&value=">회원 목록</a>
            <a class="collapse-item" href="#">채팅2</a>
            <div class="collapse-divider"></div>
          </div>
        </div>
      </li>

    </ul>
    

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar static-top newborder">
			
          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

			<!-- 상단 토픽 정보 시작-->
	  		<div class="chat-img">
                  <div class="chat-img-bg">
                      <div></div>
                      <i class="fa fa-comment"></i>
                  </div>
            </div>
			<div class="chat-menu-center">
                   <div class="chat-menu-title">
                       <span>관리자 페이지</span>
                   </div>
             </div> 
			<!-- 상단 토픽 정보 끝-->
			
          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">


            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${member_name }</span>
                <img class="img-profile rounded-circle" src='${pageContext.request.contextPath}/member/download?member_no=${member_no}'>
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/modify">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  내 정보보기
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/signout" >
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  로그아웃
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->
		<div class="chat-wrap">
           	<div class="chat-aside">
                   <div class="chat-menu-bar">
        <!-- 채팅 창 -->
        <div class="container-fluid" style="overflow:auto">
		
          	<article class="admin-wrap" style="padding-top: 5rem;">
                    
						<div class="card border-primary mb-3 admin-card" style="width: 20rem; height: 15rem; margin:auto;">
						  <div class="card-header">접속자</div>
						  <div class="card-body admin-card-body">
						    <h4 class="card-title">Primary card title</h4>
						    <p class="card-text">
						    	<a href="#"></a>
						    </p>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-card" style="width: 20rem; height: 15rem;  margin:auto;">
						  <div class="card-header">총회원</div>
						  <div class="card-body admin-card-body">
						    <h4 class="card-title">${memberCount} 명</h4>
						    <p class="card-text">
						    	<a href="#"></a>
						    </p>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-card" style="width: 20rem; height: 15rem; margin:auto;">
						  <div class="card-header">등록팀수</div>
						  <div class="card-body admin-card-body">
						    <h4 class="card-title">${teamCount} 팀</h4>
						    <p class="card-text">
						    	<a href="#"></a>
						    </p>
						  </div>
						</div>	
			</article>
			<article class="admin-wrap" style="padding-top: 9rem;">
                    
						<div class="card border-primary mb-3 admin-card"
                                     style="width: 20rem; height: 15rem; margin:auto;">
                                    <div class="card-header">파일용량</div>
                                    <div class="card-body admin-card-body">
                                        <h4 class="card-title manager-file-size"></h4>
                                        <p class="card-text">
                                            <a href="#"></a>
                                        </p>
                                    </div>
                                </div>
						                    
						<div class="card border-primary mb-3 admin-card" style="width: 20rem; height: 15rem; margin:auto;">
						  <div class="card-header">이번달 매출</div>
						  <div class="card-body admin-card-body">
						    <h4 class="card-title">Primary card title</h4>
						    <p class="card-text">
						    	<a href="#"></a>
						    </p>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-card" style="width: 20rem; height: 15rem; margin:auto;">
						  <div class="card-header">등록 관리자 수</div>
						  <div class="card-body admin-card-body">
						    <h4 class="card-title">${managerCount} 명</h4>
						    <p class="card-text">
						    	<a href="#"></a>
						    </p>
						  </div>
						</div>	
			</article>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->


    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</div>

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/design/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resources/js/design/sb-admin-2.min.js"></script>

</body>

</html>