<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
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

<script>

$("#exit-btn").click(function(){
	location.href="";
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
	            <li id="exit-btn" class="gnb-btn nav-item dropdown no-arrow mx-1">
	                    <a class="fa fa-2x fa-times nav-link" style="color:#ddd" 
	                    href="${pageContext.request.contextPath}/chat/topic_main?team_no=${param.team_no}&topic_no=${param.topic_no}"></a>
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
            <c:forEach items="${driveFolderName}" var="drive" >
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
		
		<!-- 파일까지 업로드됐을 때 리스트-->
		<c:choose>
			<c:when test="${driveFolderList.size()>0}">
			<!-- 파일을 하나라도 업로드하면 보이는 화면 -->
			<article id="file-wrap">
		
			<div class="upload-wrap">
				
				<div class="upload-wrap-box">
				
						<h3>${param.drive_name} </h3>
						<div class="fileupload-box">
							 <form action="driveupload" method="post" enctype="multipart/form-data">
							 	<input type="hidden" name="drive_name" value="${param.drive_name}">
								<input type="hidden" name="team_no" value="${param.team_no}">
								<input type="hidden"  name="member_no"  value="${sessionScope.member_no}">
								<input type="file" name ="file" multiple="multiple" >
								<input id="upload-btn" type="submit" value="업로드">
							</form>
						</div>
						<a href="filedelete?drive_file_no=${param.drive_file_no}&team_no=${param.team_no}&drive_name=${param.drive_name}">
							선택삭제
						</a>
				</div>
			</div>
				
					<div class="flist-wrap">
			           	<div class="chat-aside">
			                   <div class="chat-menu-bar">
			                   <div id="fileview">
			                   
									<c:forEach var="fileList" items="${driveFolderList}">
										<div class="upload-box">
											<form action="download" method="post">
													<c:if test="${fileList.drive_file_uploadname != 'null' }">
													<input type="hidden" name="drive_file_no" value="${fileList.drive_file_no}">
													<div class="img-view">
														<c:choose>
															<c:when test="${fn:startsWith(fileList.drive_file_type,'image')}">
																<img src="drive_file_view?drive_file_no=${fileList.drive_file_no}">
															</c:when>
															<c:otherwise>
																<img src="${pageContext.request.contextPath}/resources/image/filedummy.jpeg">
															</c:otherwise>
														</c:choose>
													</div>
													<div class="text-view">
													    <p>${fileList.drive_file_no }/${fileList.drive_file_uploadname }</p>
													    <div>
															<a href="download?drive_file_no=${fileList.drive_file_no}">
															<input type="checkbox" >
																다운로드
															</a>
															/<a href="filedelete?drive_file_no=${fileList.drive_file_no}&team_no=${param.team_no}&drive_name=${param.drive_name}">삭제</a>
													    </div> 
													</div>
													</c:if>
											</form>
										</div>
									</c:forEach>
								
								</div>
			                   
			                  <!-- 페이징 -->
<!-- 			                  <form action="driveSearch" method="post"> -->
<%-- 				                  <input type="search" name="value" value="${value }"> --%>
<!-- 				                  <input type="submit" value="검색"> -->
<!-- 			                  </form> -->
							<!--네비게이터(navigator) -->
<%-- 					         <jsp:include page="/WEB-INF/views/drive/paging.jsp"> --%>
<%-- 					            <jsp:param name="pno" value="${pno}" /> --%>
<%-- 					            <jsp:param name="count" value="${count}" /> --%>
<%-- 					            <jsp:param name="navsize" value="${navsize}" /> --%>
<%-- 					            <jsp:param name="pagesize" value="${pagesize}" /> --%>
<%-- 					         </jsp:include> --%>
									
									
<!-- 								<div> -->
<!-- 									<ul class="pagination" style="justify-content: center;"> -->
<%-- 					                    <c:if test="${pagination.curPage ne 1}"> --%>
<!-- 					                    	<li class="page-item disabled"> -->
<%-- 					                        	<a class="page-link" href="#" onClick="fn_paging('${pagination.prevPage }')">&laquo;</a>  --%>
<!-- 					                        </li> -->
<%-- 					                    </c:if> --%>
<%-- 					                    <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }"> --%>
<%-- 					                        <c:choose> --%>
<%-- 					                            <c:when test="${pageNum eq  pagination.curPage}"> --%>
<!-- 					                            	<li class="page-item active"> -->
<%-- 												      <span style="font-weight: bold;"><a class="page-link" href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a></span> --%>
<!-- 												    </li> -->
<%-- 					                            </c:when> --%>
<%-- 					                            <c:otherwise> --%>
<!-- 						                            <li class="page-item"> -->
<%-- 												      <a href="#" class="page-link" onClick="fn_paging('${pageNum }')">${pageNum }</a>  --%>
<!-- 												    </li> -->
					                                
<%-- 					                            </c:otherwise> --%>
<%-- 					                        </c:choose> --%>
<%-- 					                    </c:forEach> --%>
<%-- 					                    <c:if test="${pagination.curPage ne pagination.pageCount && pagination.pageCount > 0}"> --%>
<!-- 					                    	<li class="page-item"> -->
<%-- 					                        	<a href="#" class="page-link" onClick="fn_paging('${pagination.nextPage }')">&raquo;</a>  --%>
<!-- 					                    	</li> -->
<%-- 					                    </c:if>  --%>
<!-- 					                </ul> -->
<!-- 					              </div> -->
	
					      </div>
					    </div>
					  </div>
				</article>	
			</c:when>
			<c:when test="${driveFileList.size()<1}">
			<!-- 폴더를 생성만 했을 때 보이는 화면 -->
					<article>
					<div class="upload-wrap">
						
				
					</div>
					   <div id="fileview">
									<c:forEach var="drFN" items="${driveFolderName}">
										<div class="upload-box">
												<div class="img-view">
													<a href="${pageContext.request.contextPath}/drive/drive?team_no=${param.team_no}&drive_name=${drFN.drive_name}">
														<img src="${pageContext.request.contextPath}/resources/image/filedummy.jpeg">
													</a>
												</div>
												<div class="text-view">
												    <p class="folder-title">${drFN.drive_name }</p>
												    <div class="folder-title-box">
													    <div class="checkbox">
															<input type="checkbox" >
													    </div> 
														<div class="folder-btn">
															<a href="">수정</a> 
															<a href="">삭제</a>
														</div>
												    </div>
												</div>
										</div>
									</c:forEach>
								</div>
				</article>
			</c:when>
			<c:otherwise>
			<!-- 폴더 생성안했을때 기본화면 -->
					<article id="file-wrap">
		
							<div class="upload-wrap">
							
								<div class="upload-wrap-box">
									<h3>${param.drive_name} </h3>
									<div class="fileupload-box">
										 <form action="driveupload" method="post" enctype="multipart/form-data">
										 	<input type="hidden" name="drive_name" value="${param.drive_name}">
											<input type="hidden" name="team_no" value="${param.team_no}">
											<input type="hidden"  name="member_no"  value="${sessionScope.member_no}">
											<input type="file" name ="file" multiple="multiple" >
											<input id="upload-btn" type="submit" value="업로드">
										</form>
									</div>
								</div>
								
							</div>
						
							<div class="flist-wrap">
					           	파일이 없습니다.
					  		</div>
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

<!-- 드라이브 폴더 생성 -->
<form action="drivecreate" method="post">

	
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
						<input type="hidden" name="member_no" value="${sessionScope.member_no}">
		      		<input type="text" name ="drive_name"><span></span><br><br>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="check-btn" class="btn btn-primary" >생성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		

</form>

<!-- 파일명 변경 -->
<!-- <form action="editfile" method="post"> -->
<!-- 	<div class="modal fade" id="editFile" tabindex="-1" role="dialog" -->
<!-- 		aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog modal-dialog-centered" role="document"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h5 class="modal-title" id="exampleModalCenterTitle">파일명 변경</h5> -->
<!-- 					<button type="button" class="close" data-dismiss="modal" -->
<!-- 						aria-label="Close"> -->
<!-- 						<span aria-hidden="true">&times;</span> -->
<!-- 					</button> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body"> -->
					
<%-- 					<input type="hidden" name="drive_file_no" value="${driveFileList.drive_file_no}"> --%>
<!-- 					이름 :<input type="text" name="drive_file_uploadname"><br> -->
<!-- 					<br> -->
<!-- 					<br> -->
<!-- 				</div> -->
<!-- 				<div class="modal-footer"> -->
<!-- 					<button type="button" class="btn btn-secondary" -->
<!-- 						data-dismiss="modal">닫기</button> -->
<!-- 					<button type="submit" id="edit-btn" class="btn btn-primary">수정하기</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </form> -->

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

