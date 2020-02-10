<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    
<h1>invite_create test</h1>

  <div class="container">

      
        <!-- Modal -->
      
        <div class="modal-fade" id="myModal" role="dialog">
      
          <div class="modal-dialog">
      
          
      
            <!-- Modal content-->
      
            <div class="modal-content">
      
              <div class="modal-header">
      
                <button type="button" class="close" data-dismiss="modal">&times;</button>
      
                <h4 class="modal-title" id="title">멤버 초대하기2</h4>
      
              </div>

              <div class="top-notice">
            </div>
            
            <div class="modal-body">
                
                <p id="content"></p>
                <p>모든 토픽에 멤버를 초대하실 수 있습니다</p>
                <p>초대 메일 보내기</p>
            </div>
                
              
    		  <!-- 이메일 전송 폼 -->	
              <form class="email-form" action="modal_invite2" method="post">
              	<input class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="cert_email" type="email" placeholder="Enter email">
              	<input type="hidden" value="${param.team_no}" name="team_no">
                <input type="submit" value="이메일전송" class="btn btn-primary" data-dismiss="modal">
                <span></span>
              </form>

      		  <!-- CLOSE버튼 -->
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
              
              <!-- 뒤로가기 버튼 -->
      		  <div class="modal-back">
                <button type="button" class="btn btn-default" data-dismiss="modal">뒤로가기</button>
      		  </div>	
      
            </div>
            
                        <li class="nav-item" id="invite-create">
            	<a data-toggle="modal" data-target="#exampleModalCenter2">
					멤버초대하기
            	</a>	<i class="fa fa-plus"></i>
            </li>
      
            
      
          </div>
      
        </div>  
      
      </div>
	<div id="Parse_Area"gt;lt;></div>