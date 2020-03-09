<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	$("#check-btn").attr("disabled",true);
	$("#editcheck-btn").attr("disabled",true);
	
	$(".afterName").on('input',function(){
		
		
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
					$(".afterName").next("span").text("동일한 이름이 있습니다.");
					$("#check-btn").prop("disabled",true); 
					$("#editcheck-btn").prop("disabled",true); 
				}
				else if(resp === "N"){
					$(".afterName").next("span").text(" ");
					$("#check-btn").prop("disabled",false); 
					$("#editcheck-btn").prop("disabled",false); 
				}
			}
		});			
	});
});
</script>

<script>

// function goBack(){
// 	window.history.back();
// }

$(function(){
	
	//폴더명 변경 모달 
	$('.editFolderName').click(function(e){
		e.preventDefault();//이거 있어야 a태그 눌러도 아무일 안생겨요(form도 마찬가지)
		
		var data = $(this).data('name');
// 		console.log("data = " + data);
// 		console.log($("#editFolder").find("input[name=drive_name]"));
		$("#editFolder").find("input[name=before_name]").val(data);
		
		$("#editFolder").modal("show");
	 });
	
	 
	 
	//선택 삭제
	$(".file-choice-delete-btn").click(function(){
		//하나도 체크 안되어 있으면 전송이 되면 안됩니다
		var check = $(".file-list-form").find("input[type=checkbox]:checked");
// 		console.log(check, check.length, !check.length);//확인용
		if(!check.length){
			alert("파일 삭제를 위해 1개 이상 선택해주세요")
		}
		else{
			if(confirm(check.length+"개 파일이 선택되었습니다.\n정말 삭제하시겠습니까?")){
				$(".file-list-form").submit();//폼 전송 코드
			}
		}
	});
	
	$(".fdel-one").click(function (){
		return confirm("파일을 삭제하시겠습니까?");

	});
	
	$(".folder-delete-btn").click(function (){
		return confirm("폴더를 삭제하시겠습니까?");

	});

	//내파일 보기 탭
	$('.myfile-btn').click(function(){
		
		$(".file-choice-delete-btn").show();
		$(".myfile-btn.allfile").show();
		
		var tab = $(this).attr('data-tab');
// 		console.log("tab = " + tab);
		$('.myfile-btn').removeClass('current');
		$('.fileview').removeClass('current');
		
		$(this).addClass('current');
		$("#"+tab).addClass('current');
		
		$(this).hide();
	})
	
	$('.myfile-btn.allfile').click(function(){
		$(".file-choice-delete-btn").hide();
		$(".myfile-btn").show();
		$(this).hide();
	})
	
	//내폴더 보기 탭
	$('.myfolder-btn').click(function(e){
		$(".myfolder-btn.allfolder").show();
		var foltab = $(this).attr('data-foltab');
		$('.myfolder-btn').removeClass('curr');
		$('.folderview').removeClass('curr');
		
		$(this).addClass('curr');
		$("#"+foltab).addClass('curr');
		$(this).hide();
	})
	
	$('.myfolder-btn.allfolder').click(function(){
		$(".myfolder-btn").show();
		$(this).hide();
	})
	
	
	//용량 제한
	$(function(){
		
		$("#upload-btn").attr("disabled",true);
		$("input[type=file]").bind( 'change', function (e)
	        {
	            if( !$(this).val() ) return;
	             
	            var f = this.files[0];
	            var size = f.size || f.fileSize;
	            var limit = 1073741824;
	                             
	            if( size > limit )
	            {
	                alert( '파일용량은 1GB를 넘을수 없습니다.' );
	                $(this).val('');
	                return;
	            }
	                     
			$("#upload-btn").attr("disabled",false);
	        
		})
	});

	//파일업로드
	$(function(){
		var uploadFile = $('.fileupload-box .uploadBtn');
		uploadFile.on('change', function(){
			if(window.FileReader){
				var filename = $(this)[0].files[0].name;
			} else {
				var filename = $(this).val().split('/').pop().split('\\').pop();
			}
			$(this).siblings('.fileName').val(filename);
		})
	});
	
	//전체 선택, 전체 해제
	$('#noCheckAll').click(function(e){
	        $("input[name=drive_file_no]").prop("checked", true);
	        $("#noReleaseAll").show();
	        $(this).hide();
	})
	$('#noReleaseAll').click(function(e){
	        $("input[name=drive_file_no]").prop("checked", false);
	        $("#noCheckAll").show();
	        $(this).hide();
	})


	//다중다운로드
	
	
});



</script>



</head>

<body id="page-top">
	<div class="drback">
            <i class="drback-btn">
<!--             	<a href="#" onClick="javascript:window.history.back(-1); return false;" class="fas fa-2x fa-arrow-left nav-link" style="color:#444"></a> -->
				<a href="${pageContext.request.contextPath}/drive/drive?team_no=${param.team_no}" class="fas fa-2x fa-arrow-left nav-link" style="color:#444"></a>
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
                    <form action="${pageContext.request.contextPath}/chat/topic" get="get" id="form">
              			<input type="hidden" name="team_no" value="${param.team_no}">
						<input type="hidden" name="topic_no" value="">
	                    <a class="fa fa-2x fa-times nav-link" style="color:#bbb" class="button" onclick="document.getElementById('form').submit();"></a>
                    </form>
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
			<c:when test="${driveFileList.size()>0}">
			<!-- 파일을 하나라도 업로드하면 보이는 화면 -->
			<article id="file-wrap">
		
			<div class="upload-wrap">
				
				<div class="upload-wrap-box">
					<div class="upload-wrap-title">
						<h3>${param.drive_name} </h3>
					</div>
					<div class="upload-wrap-btn">
						<a href="#" class="editFolderName" data-name="${param.drive_name }">
							<i style="color:#bbb" class="fa fa-lg fa-cog"></i>
						</a>
						<a href="drivedelete?team_no=${param.team_no}&drive_name=${param.drive_name}" class="folder-delete-btn">
							<i style="color:#bbb" class="fa fa-lg fa-trash-alt"></i>
						</a>
					</div>
					<div class="fileupload-box">
						 <form class="fupload" action="driveupload" method="post" enctype="multipart/form-data">
						 	<input type="hidden" name="drive_name" value="${param.drive_name}">
							<input type="hidden" name="team_no" value="${param.team_no}">
							<input type="hidden"  name="member_no"  value="${sessionScope.member_no}">
							<input type="text" class="fileName form-control" readonly="readonly">
							<label for="uploadBtn" class="btn_file btn btn-light">찾아보기</label>
							<input type="file" name ="file" multiple="multiple" id="uploadBtn" class="uploadBtn">
							<input id="upload-btn" class="btn btn-primary" type="submit" value="업로드"> 
						</form>
						<div class="fdel-btn">
							<button class="file-all-choice-btn btn btn-light" id="noCheckAll">전체선택</button>
							<button class="file-all-Release-btn btn btn-light" id="noReleaseAll">전체해제</button>
							<button class="file-choice-download-btn btn btn-secondary">선택다운로드</button>
							<button class="file-choice-delete-btn btn btn-secondary">선택삭제</button>
							<button class="myfile-btn allfile btn btn-primary" data-tab="alltab">모든 파일보기</button>
							<button class="myfile-btn current btn btn-primary" data-tab="mytab">내 파일보기</button>
						</div>
					</div>
				</div>
			</div>
					<div class="flist-wrap">
			           	<div class="chat-aside">
			                   <div class="chat-menu-bar">
		
				                   <div id="alltab" class="fileview current">
				                   		<form action="filelistdelete" method="post" class="file-list-form">
										<c:forEach var="fileList" items="${driveFileList}">
											<div class="upload-box">
												<div class="img-view">
													<c:choose>
														<c:when test="${fn:startsWith(fileList.drive_file_type,'image')}">
															<img src="drive_file_view?drive_file_no=${fileList.drive_file_no}">
														</c:when>
														<c:otherwise>
															<img src="${pageContext.request.contextPath}/resources/image/textdummy.jpeg">
														</c:otherwise>
													</c:choose>
												</div>
												<div class="text-view">
												    <p>${fileList.drive_file_uploadname }</p>
												    <div>
												    	<div class="check-box">
															<input class="fcheck-btn" type="checkbox" name="drive_file_no" value="${fileList.drive_file_no }">
												    	</div>
												    	<div class="down-delete">
															<a href="download?drive_file_no=${fileList.drive_file_no}" style="text-decoration:none;">
																<i style="color:#bbb" class="fa fa-m fa-download"></i>
															</a>
															<c:if test="${fileList.member_no eq sessionScope.member_no }">
																<a href="filedelete?drive_file_no=${fileList.drive_file_no}&team_no=${fileList.team_no}&drive_name=${fileList.drive_name}" 
																		class="fdel-one" style="margin-left:8px;">
																	<i style="color:#bbb" class="fa fa-m fa-trash-alt"></i>		
																</a>
															</c:if>
												    	</div>
												    </div> 
												</div>
											</div>
										</c:forEach>
											<input type="hidden" name="team_no" value="${param.team_no }">
											<input type="hidden" name="drive_name" value="${param.drive_name }">
										</form>
									</div>
									 <div id="mytab" class="fileview">
				                   
										<c:forEach var="myfileList" items="${myFileList}">
											<div class="upload-box">
												<form action="download" method="post">
														<input type="hidden" name="drive_file_no" value="${myfileList.drive_file_no}">
														<div class="img-view">
															<c:choose>
																<c:when test="${fn:startsWith(myfileList.drive_file_type,'image')}">
																	<img src="drive_file_view?drive_file_no=${myfileList.drive_file_no}">
																</c:when>
																<c:otherwise>
																	<img src="${pageContext.request.contextPath}/resources/image/textdummy.jpeg">
																</c:otherwise>
															</c:choose>
														</div>
														<div class="text-view">
														    <p>${myfileList.drive_file_uploadname }</p>
														 <div>
													    	<div class="check-box">
																<input class="fcheck-btn" type="checkbox" name="drive_file_no" value="${myfileList.drive_file_no }">
													    	</div>
													    	<div class="down-delete">
																<a href="download?drive_file_no=${myfileList.drive_file_no}" style="margin-right:8px; text-decoration:none;">
																	<i style="color:#bbb" class="fa fa-m fa-download"></i>
																</a>
																<c:if test="${myfileList.member_no eq sessionScope.member_no }">
																	<a href="filedelete?drive_file_no=${myfileList.drive_file_no}&team_no=${myfileList.team_no}&drive_name=${myfileList.drive_name}" 
																			class="fdel-one">
																		<i style="color:#bbb" class="fa fa-m fa-trash-alt"></i>		
																	</a>
																</c:if>
													    	</div>
													    </div> 
														</div>
												</form>
											</div>
										</c:forEach>
									
									</div>
			            
			                   
			                  <!-- 페이징 -->
								<div>
									<ul class="pagination" style="justify-content: center;">
					                    <c:if test="${pagination.curPage ne 1}">
					                    	<li class="page-item disabled">
					                        	<a class="page-link" href="#" onClick="fn_paging('${pagination.prevPage }')">&laquo;</a> 
					                        </li>
					                    </c:if>
					                    <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }">
					                        <c:choose>
					                            <c:when test="${pageNum eq  pagination.curPage}">
					                            	<li class="page-item active">
												      <span style="font-weight: bold;"><a class="page-link" href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a></span>
												    </li>
					                            </c:when>
					                            <c:otherwise>
						                            <li class="page-item">
												      <a href="${pageContext.request.contextPath}/drive/drive?team_no=${param.team_no }&drive_name=${param.drive_name }&curPage=${pageNum}" class="page-link" onClick="fn_paging('${pageNum }')">${pageNum }</a> 
												    </li>
					                                
					                            </c:otherwise>
					                        </c:choose>
					                    </c:forEach>
					                    <c:if test="${pagination.curPage ne pagination.pageCount && pagination.pageCount > 0}">
					                    	<li class="page-item">
					                        	<a href="#" class="page-link" onClick="fn_paging('${pagination.nextPage }')">&raquo;</a> 
					                    	</li>
					                    </c:if> 
					                </ul>
					              </div>
	
					      </div>
					    </div>
					  </div>
				</article>	
			</c:when>
			<c:when test="${driveFolderList.size()>0}">
			<!-- 폴더를 생성만 했을 때 보이는 화면 -->
				<article id="file-wrap">
					<div class="upload-wrap">
					<div class="upload-wrap-box">
						<div class="upload-wrap-title">
							<h3>${param.drive_name} </h3>
						</div>
						<div class="upload-wrap-btn">
							<a href="#" class="editFolderName" data-name="${param.drive_name }">
								<i style="color:#bbb" class="fa fa-lg fa-cog"></i>
							</a>
							<a href="drivedelete?team_no=${param.team_no}&drive_name=${param.drive_name}" class="folder-delete-btn">
								<i style="color:#bbb" class="fa fa-lg fa-trash-alt"></i>
							</a>
						</div>
						<div class="fileupload-box">
							 <form class="fupload" action="driveupload" method="post" enctype="multipart/form-data">
							 	<input type="hidden" name="drive_name" value="${param.drive_name}">
								<input type="hidden" name="team_no" value="${param.team_no}">
								<input type="hidden"  name="member_no"  value="${sessionScope.member_no}">
								<input type="text" class="fileName form-control" readonly="readonly">
								<label for="uploadBtn" class="btn_file btn btn-light">찾아보기</label>
								<input type="file" name ="file" multiple="multiple" id="uploadBtn" class="uploadBtn">
								<input id="upload-btn" class="btn btn-primary" type="submit" value="업로드"> 
							</form>
						</div>
					</div>
				</div>
				<div class="flist-wrap" style="text-align:center;">
					<div class="chat-aside">
	                   <div class="chat-menu-bar">
							<div class="noFile">
								<div>
						           	<i style="color:#bbb" class="fa fa-3x fa-exclamation"></i>
								</div>
						           	<p style="margin-top:10px;">파일이 없습니다.</p>
							</div>
	                   </div>
				    </div>
		  		</div>
				</article>	
					
			</c:when>
		
			<c:when test="${driveFolderName.size()>0}">
			<article>
				
				<div class="upload-wrap">
				<div class="upload-wrap-box">
					<div class="upload-wrap-title">
						<div class="exp-drive">
							<p>* 멤버들과 공유한 파일을 언제 어디서든 확인가능합니다.</p>
							<p>* 준회원은 잔디 드라이브 업로드이용이 제한됩니다.</p>
						</div>
					</div>
					<div class="fileupload-box">
						<div class="fdel-btn">
							<button class="myfolder-btn curr btn btn-primary" data-foltab="myFolderTab">내 폴더보기</button>
							<button class="myfolder-btn allfolder btn btn-primary" data-foltab="allFolderTab">전체 폴더보기</button>
						</div>
						</div>
					</div>
				</div>
					   <div id="allFolderTab" class="folderview curr">
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
												<div class="folder-btn">
										    		<div>
												    	<div class="down-delete">
															<c:if test="${drFN.member_no eq sessionScope.member_no }">
																<a class="editFolderName" data-name="${drFN.drive_name }" style="margin-right:8px; text-decoration:none; cursor:pointer;">
																	<i style="color:#bbb" class="fa fa-m fa-cog"></i>
																</a>
																<a href="drivedelete?team_no=${param.team_no}&drive_name=${drFN.drive_name}" 
																		 class="folder-delete-btn">
																	<i style="color:#bbb" class="fa fa-m fa-trash-alt"></i>		
																</a>
															</c:if>
												    	</div>
													</div> 
												</div>
										    </div>
										</div>
								</div>
							</c:forEach>
						</div>
						<div id="myFolderTab" class="folderview">
							<c:forEach var="myF" items="${myFolderList}">
								<div class="upload-box">
										<div class="img-view">
											<a href="${pageContext.request.contextPath}/drive/drive?team_no=${param.team_no}&drive_name=${myF.drive_name}">
												<img src="${pageContext.request.contextPath}/resources/image/filedummy.jpeg">
											</a>
										</div>
										<div class="text-view">
										    <p class="folder-title">${myF.drive_name }</p>
										    <div class="folder-title-box">
												<div class="folder-btn">
										    		<div>
												    	<div class="down-delete">
															<a class="editFolderName" data-name="${myF.drive_name }" style="margin-right:8px; text-decoration:none; cursor:pointer;">
																<i style="color:#bbb" class="fa fa-m fa-cog"></i>
															</a>
															<c:if test="${myF.member_no eq sessionScope.member_no }">
																<a href="drivedelete?team_no=${param.team_no}&drive_name=${drFN.drive_name}" 
																		 class="folder-delete-btn">
																	<i style="color:#bbb" class="fa fa-m fa-trash-alt"></i>		
																</a>
															</c:if>
												    	</div>
													</div> 
												</div>
										    </div>
										</div>
								</div>
							</c:forEach>
						</div>
						
				</article>
			</c:when>
				<c:otherwise>
				<article>
					<div class="upload-wrap">
						<div class="upload-wrap-box">
							<div class="upload-wrap-title">
								<div class="exp-drive">
									<p>* 멤버들과 공유한 파일을 언제 어디서든 확인가능합니다.</p>
									<p>* 준회원은 잔디 드라이브 업로드가 불가능합니다.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="flist-wrap" style="text-align:center;">
						<div class="chat-aside">
		                   <div class="chat-menu-bar">
								<div class="noFile">
									<div>
							           	<i style="color:#bbb" class="fa fa-3x fa-exclamation"></i>
									</div>
							           	<p style="margin-top:10px;">폴더가 없습니다. 폴더를 생성하세요.</p>
								</div>
		                   </div>
					    </div>
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
		      		드라이브 명 : <input class="afterName" type="text" name ="drive_name"><span></span><br><br>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="check-btn" class="btn btn-primary" >생성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		

</form>

<!-- 폴더명 변경 -->
<form action="editfolder" method="post">
	
<!-- Modal -->
		<div class="modal fade" id="editFolder" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalCenterTitle">폴더명 변경</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      			<input type="hidden" name="team_no" value="${param.team_no}">
		      			<input class="beforeName" type="hidden" name="before_name">
		      		드라이브 명 : <input class="afterName" type="text" name ="after_name"><span></span><br><br>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="editcheck-btn" class="btn btn-primary" >수정하기</button>
		      </div>
		    </div>
		  </div>
		</div>
</form>


<!-- ------------------------------- 모달 종료--------------------------------- -->

  <!-- Bootstrap core JavaScript-->
<%--   <script src="${pageContext.request.contextPath}/resources/js/design/jquery.min.js"></script> --%>
  <script src="${pageContext.request.contextPath}/resources/js/design/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resources/js/design/sb-admin-2.min.js"></script>
</div>
</div>
</div>
</body>

