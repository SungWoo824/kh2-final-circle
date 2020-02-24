<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
<link href="${pageContext.request.contextPath}/resources/css/design/sb-admin-2.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/design/all.min.css" rel="stylesheet" type="text/css">

 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link href="${pageContext.request.contextPath}/resources/css/design/common.css" rel="stylesheet" type="text/css">

<script>
$(function(){
	
	$("#check-btn").attr("disabled",true);
	
	$("input[name=drive_name]").blur(function(){
		
		
		var drive_name = $(this).val();
		var team_no = $("input[name=team_no]").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/drive/drive_namecheck",
			type:"get",
			data:{
				drive_name : drive_name,
				team_no: team_no
			},
			dataType:"text",
			success: function(resp){
				if(resp === "Y"){
					$("input[name=drive_name]").next("span").text("동일한 이름이 있습니다.");
					$("#check-btn").prop("disabled",true); 
				}
				else if(resp === "N"){
					$("input[name=drive_name]").next("span").text(" ");
					$("#check-btn").prop("disabled",false); 
				}
			}
		});			
	});
});
</script>

<!-- 파일 업로드하고 업로드된 파일 미리보기 -->
<script>
$(function(){
	

});
</script>



</head>

<body id="page-top">
	<div class="drback">
            <i class="drback-btn">
            	<a class="fas fa-2x fa-arrow-left nav-link" style="color:#444"></a>
            </i>
	</div>
  <!-- Page Wrapper -->
  <div id="wrapper">

	<!-- 오른쪽 메뉴 바 시작 -->
	<div class="menu-wrap drmenu-wrap">
	<div class="menu-con bg-base">
	    <div class="menu-top">
	        <ul class="menu-bar">
	            <li class="gnb-btn nav-item dropdown no-arrow mx-1">
	                    <a class="fa fa-2x fa-times nav-link" style="color:#ddd"></a>
	            </li>
	        </ul>
	    </div>
	</div>
	</div>
    <!-- 오른쪽 메뉴 바 끝 -->

    <!-- 왼쪽 바 시작 -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion newline drmenu" id="accordionSidebar">


      <!-- Heading -->
      <div class="sidebar-heading" style="padding-top:1rem">
		    <a class="nav-link" data-toggle="modal" data-target="#newDrive">
			     <i style="color:#2196f3" class="fa fa-fw fa-plus"></i> 
			     <span style="color:#666">새 드라이브 생성</span>
		     </a>
      </div>

	<hr class="sidebar-divider">

      <!-- 드라이브 목록 시작-->
      <li class="nav-item active">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>드라이브</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
<!--             <h6 class="collapse-header">Login Screens:</h6> -->
            <c:forEach items="${driveFolderList}" var="drive" >
		            <a class="collapse-item" href="${pageContext.request.contextPath}/drive/drive?team_no=${param.team_no}&drive_name=${drive.drive_name}">
		                 ${drive.drive_name}
		            </a>
            </c:forEach>
            <div class="collapse-divider"></div>
          </div>
        </div>
      </li>
      <!-- 드라이브 목록 끝 -->
      
     
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
	  		<div class="chat-img drtop">
                      <div>드라이브</div>
            </div>
			<div class="chat-menu-center">

             </div> 
			<!-- 상단 토픽 정보 끝-->
			</nav>
		
		<c:set var="dfList" value="${driveFolderList.get(0)}"></c:set>
		<c:choose>
			<c:when test="${dfList.drive_folder == '1'}">
			<!-- 파일을 하나라도 업로드하면 보이는 화면 -->
			<article id="file-wrap">
		
			<div class="upload-wrap">
			
				
				 <form action="driveupload" method="post" enctype="multipart/form-data">
				 	<input type="hidden" name="drive_name" value="${param.drive_name}">
					<input type="hidden" name="team_no" value="${param.team_no}">
					<input type="hidden"  name="member_no"  value="${sessionScope.member_no}">
					<input type="file" name ="file" multiple="multiple" >
					<input id="upload-btn" type="submit" value="업로드">
				</form>
				
			</div>
				
					<div class="flist-wrap">
			           	<div class="chat-aside">
			                   <div class="chat-menu-bar">
			                   <div id="fileview">
			                   
									<c:forEach var="fileList" items="${driveFileList}">
										<form action="download" method="post">
												<c:if test="${fileList.drive_file_uploadname != 'null' }">
												<input type="hidden" name="drive_file_no" value="${fileList.drive_file_no}">
											    <div>${fileList.drive_file_no }</div> 
												<a href="download?drive_file_no=${fileList.drive_file_no}">
													<input type="checkbox" >
														<img src="drive_file_view?drive_file_no=${fileList.drive_file_no}"><br>
															다운로드
												</a>
														/<a href="filedelete?drive_file_no=${fileList.drive_file_no}&team_no=${fileList.team_no}&drive_name=${fileList.drive_name}">삭제</a>
												</c:if>
										</form>
									</c:forEach>
								
								</div>
			                   
			                   <nav class="paging" aria-label="Page navigation example">
									  <ul class="pagination">
									    <li class="page-item">
									      <a class="page-link" href="#" aria-label="Previous">
									        <span aria-hidden="true">&laquo;</span>
									      </a>
									    </li>
									    <li class="page-item"><a class="page-link" href="#">1</a></li>
									    <li class="page-item"><a class="page-link" href="#">2</a></li>
									    <li class="page-item"><a class="page-link" href="#">3</a></li>
									    <li class="page-item">
									      <a class="page-link" href="#" aria-label="Next">
									        <span aria-hidden="true">&raquo;</span>
									      </a>
									    </li>
									  </ul>
							</nav>
			
			      </div>
			    </div>
			  </div>
		</article>	
			</c:when>
			<c:when test="${dfList.drive_file_uploadname=='null' }">
			<!-- 폴더를 생성만 했을 때 보이는 화면 -->
						<article id="file-wrap">
		
							<div class="upload-wrap">
							
								<h5>팀 :${param.team_no }번 의 드라이브</h5>
								
								 <form action="driveupload" method="post" enctype="multipart/form-data">
								 	<input type="hidden" name="drive_name" value="${param.drive_name}">
									<input type="hidden" name="team_no" value="${param.team_no}">
									<input type="hidden"  name="member_no"  value="${sessionScope.member_no}">
									<input type="file" name ="file" multiple="multiple" >
									<input id="upload-btn" type="submit" value="업로드">
								</form>
								
									</div>
						
							<div class="flist-wrap">
					           	파일이 없습니다.
					  </div>
				</article>	
			</c:when>
			<c:otherwise>
			<!-- 폴더 생성안했을때 기본화면 -->
					<article>
						파일이 없습니다. 폴더를 생성하세요.
					</article>
			</c:otherwise>
		</c:choose>
		
         
        <!-- End of Topbar -->
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>


<!-- --------------------- 모달 ---------------------- -->

<form action="drive" method="post">

	
<!-- Modal -->
		<div class="modal fade" id="newDrive" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalCenterTitle">새 드라이브 생성</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      			<input type="hidden" name="team_no" value="${param.team_no}">
						<input type="hidden" name="member_no" value="${param.member_no}">
		      		드라이브 이름 : <input type="text" name ="drive_name"><span></span><br><br>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="check-btn" class="btn btn-primary" >생성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		

</form>

<!-- ------------------------------- 모달 종료--------------------------------- -->

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/design/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resources/js/design/sb-admin-2.min.js"></script>
</div>
</div>
</div>
</body>

