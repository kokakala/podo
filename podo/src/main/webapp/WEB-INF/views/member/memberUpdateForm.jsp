<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>PoDo_회원정보수정</title>

<style>
	#imgInp{display:none}
</style>
</head>

<body>

	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	
	
	<div>
		<form action="updateMember.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${ loginUser.id }" readonly>
			<input type="email" id="userId" name="email" value="${ loginUser.email }"><br>
			<input type="text" id="userNickName" name="nickName" value="${ loginUser.nickName }"><br>
			
			<input type="password" id="updatePwd" name="updatePwd" placeholder="변경 버튼을 눌러주세요."><button type="button">비밀번호 변경</button><br><br>
			<input type="hidden" id="sessionPwd" name="pwd" value="${ loginUser.pwd }">
			
			
				* 이미지를 삭제하면 기본이미지로 등록됩니다.<br>
			<img id="preview" src="resources/memberProfileImage/${ loginUser.image }" width="70px" height="70px"><br>
			<button type="button" id="uploadBtn">이미지 변경</button>
			<button type="button" onclick="fileReset();">이미지 삭제</button><br>
			<div id="imgArea"><input type='file' id='imgInp' name='uploadFile'></div><br>
			
			
			
			<button type="submit" onclick="return validate();">Update</button>
			<button type="button" onclick="location.href='myPage.do';">Cancel</button>
		</form>
	</div>
	
	

	
	
	<script>
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
	




</body>
</html>