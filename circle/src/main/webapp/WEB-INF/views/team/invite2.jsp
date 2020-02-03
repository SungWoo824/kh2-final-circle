<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> 
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script>
        $(function(){
      //팝업 Show 기능(팀 멤버로 초대 버튼 누르면 모달 화면 열림)

        //팝업 Close 기능(닫기 버튼 누르면 닫아짐)
        $(".modal-footer").click(function(){
             $('#myModal').hide();
        });
        //팝업 Close 기능(X 버튼 누르면 닫아짐)
        $(".modal-header").click(function(){
             $('#myModal').hide();
        });

    });
    
    </script>

    <style>
    .container{
        display: block;
    }
    </style>

</head>

<body>
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
                <input class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" type="email" placeholder="Enter email">
                <button type="button" class="btn btn-alltopic" data-dismiss="modal">이메일 전송</button>
              </div>
      
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">뒤로가기</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      
              </div>
      
            </div>
      
            
      
          </div>
      
        </div>  
      
      </div>

    
</body>
</html>