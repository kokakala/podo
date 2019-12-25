<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../common/header.jsp"/>
		<style>
			#imgInp{display:none}
			.idguide{
				display:none;
				font-size:12px;
				top:12px;
				right:10px;
			}
			.idok{color:blue;}
			.idno{color:red;}
			
			.nickguide{
				display:none;
				font-size:12px;
				top:12px;
				right:10px;
			}
			.nickok{color:blue;}
			.nickno{color:red;}
		</style>
	</head>
<body>

	 <h1 align="center">회원가입</h1>
      
      <br>
      
      <form action="insertMember.do" method="post" enctype="multipart/form-data" style="width: 600px; margin-right: auto; margin-left: auto;">
        <div class="form-group row">
          <label for="joinUserId" class="col-sm-4 col-form-label">* ID</label>
          <div class="col-sm-8">
            <input type="email" class="form-control" name="email" id="userId" placeholder="이메일을 입력해주세요" required>
            <span class="idguide idok">사용가능</span>
			<span class="idguide idno">사용불가</span>
			<input type="hidden" id="idCheck" value="0"><br>
          </div>
        </div>
        <div class="form-group row">
          <label for="joinUserPwd" class="col-sm-4 col-form-label">* Password</label>
          <div class="col-sm-8">
            <input type="password" class="form-control" name="pwd" id="userPwd" placeholder="비밀번호를 입력해주세요" required>
          </div>
        </div>
        <div class="form-group row">
          <label for="joinUserPwd2" class="col-sm-4 col-form-label">* Confirm</label>
          <div class="col-sm-8">
            <input type="password" class="form-control" name="joinUserPwd2" id="userPwd2" placeholder="비밀번호를 다시 입력해주세요" required>
          </div>
        </div>
        <div class="form-group row">
          <label for="userName" class="col-sm-4 col-form-label">* NickName</label>
          <div class="col-sm-8">
            <input type="text" class="form-control" name="nickName" id="userNickName" placeholder="닉네임을 입력해주세요" required>
            <span class="nickguide nickok">사용가능</span>
			<span class="nickguide nickno">사용불가</span>
			<input type="hidden" id="nickCheck" value="0"><br>
          </div>
        </div>
        <div class="form-group row">
          <label for="email" class="col-sm-4 col-form-label">* Profile</label>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
          <div class="col-sm-8">
            <img id="preview" src="resources/memberProfileImage/podoImage.png" width="70px" height="70px"><br><br>
			<button type="button" id="uploadBtn">이미지 변경</button>
			<button type="button" onclick="fileReset();">이미지 삭제</button><br>
			* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
			<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
          </div>
        </div>
        
        <div class="form-group row" align="center">
          <div class="col-sm-12">
            <button type="reset" class="btn btn-outline-dark">Reset</button>
            <button type="submit" class="btn btn-outline-success" onclick="return validate();">Sign in</button>
          </div>
        </div>
      </form>

				<!-- 	<form action="insertMember.do" method="post" enctype="multipart/form-data">
						<input type="email" id="userId" name="email" placeholder="이메일을 입력하세요.">
							<span class="idguide idok">사용가능</span>
							<span class="idguide idno">사용불가</span>
							<input type="hidden" id="idCheck" value="0"><br>
							
						<input type="password" id="userPwd" name="pwd" placeholder="비밀번호를 입력하세요."><br>
						<label for="userPwd2">비밀번호 확인 : </label>
						<input type="password" id="userPwd2"  placeholder="비밀번호를 입력하세요."><br>
						<input type="text" id="userNickName" name="nickName" placeholder="닉네임을 입력하세요.">
							<span class="nickguide nickok">사용가능</span>
							<span class="nickguide nickno">사용불가</span>
							<input type="hidden" id="nickCheck" value="0"><br>
						<div class="form-group">
							<label for="userId">Profile</label><br>
						<img id="preview" src="resources/memberProfileImage/podoImage.png" width="70px" height="70px"><br><br>
						<button type="button" id="uploadBtn">이미지 변경</button>
						<button type="button" onclick="fileReset();">이미지 삭제</button><br>
						* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
						<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
						</div>
						
						<button type="submit" onclick="return validate();">Join</button>
						<button type="button" onclick="location.href='home.do';">Cancel</button>
					</form> -->
		

	<script>
		function validate(){
			// 미입력
			if($("#userId").val().length == 0 || $("#idCheck").val() == 0){	
				alert("이메일을 확인해주세요.");
				$("#userId").focus();
				return false;
				
			}else if($("#userPwd").val().length == 0){	
				alert("비밀번호를 입력해주세요.");
				$("#userPwd").focus();
				return false;
				
			}else if($("#userPwd").val() != $("#userPwd2").val()){
				alert("비밀번호가 틀립니다.");
				$("#userPwd").val("");
				$("#userPwd2").val("");
				$("#userPwd").focus();
				return false;
			
			}else if($("#userNickName").val().length == 0 || $("#nickCheck").val() == 0){	
				alert("닉네임을 확인해주세요.")
				$("#userNickName").focus();
				return false;
				
			}else{
				return true;
			}
		}
		
		$(function(){
			$("#userId").on("keyup", function(){
				var userId = $(this).val();
				
				if(userId.length < 1){
					$(".idguide").hide();
					$("#idCheck").val(0);
					return;
				}
				$.ajax({
					url:"idCheck.do",
					data:{id:userId},
					type:"post",
					success:function(data){
						//console.log(data);
						if(data =="success"){
							$(".idno").hide();
							$(".idok").show();
							$("#idCheck").val(1);
						}else{
							$(".idok").hide();
							$(".idno").show();
							$("#idCheck").val(0);
						}
						
					},error:function(){
						console.log("아이디 ajax 통신 실패");
					}
				});
			});
		});
		
		$(function(){
			$("#userNickName").on("keyup", function(){
				var nickName = $("#userNickName").val();
				
				if(nickName.length < 1){
					$(".nickguide").hide();
					$(".nickCheck").val(0);
					return;
				}
			
				$.ajax({
					url:"nickCheck.do",
					data:{nick:nickName},
					type:"post",
					success:function(data){
						//console.log(data);
						if(data == "success"){
							$(".nickno").hide();
							$(".nickok").show();
							$("#nickCheck").val(1);
						}else{
							$(".nickok").hide();
							$(".nickno").show();
							$("#nickCheck").val(0);
						}
					},error:function(){
						console.log("닉네임 ajax 통신 실패");
					}
				});
			});
		});
		
		// 이미지 삭제 버튼 클릭 시
		function fileReset(){
			$("#imgArea input").remove();
			$("#preview").attr('src','resources/memberProfileImage/podoImage.png');
			var newInput = "<input type='file' id='imgInp' name='uploadFile'>";
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
	    $(document).on("change","#imgInp", function() {
	        readURL(this);
	    });
		
		// 이미지 버튼 클릭 시 인풋창 열리게 (안보이게 해둠)
		$("#uploadBtn").on('click', function(e){
			e.preventDefault();
			$("#imgInp").click();
		});
	</script>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>