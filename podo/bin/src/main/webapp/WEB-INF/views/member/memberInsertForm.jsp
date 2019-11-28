<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<div>
		<form action="insertMember.do" method="post" enctype="multipart/form-data">
			<input type="email" id="userId" name="email" placeholder="이메일을 입력하세요.">
				<span class="idguide idok">사용가능</span>
				<span class="idguide idno">사용불가</span>
				<input type="hidden" id="idCheck" value="0"><br>
			<input type="password" id="userPwd" name="pwd" placeholder="비밀번호를 입력하세요."><br>
			<input type="text" id="userNickName" name="nickName" placeholder="닉네임을 입력하세요.">
				<span class="nickguide nickok">사용가능</span>
				<span class="nickguide nickno">사용불가</span>
				<input type="hidden" id="nickCheck" value="0"><br>
			<input type="file" id="image" name="uploadFile"><br>
			<button type="submit" onclick="return validate();">Join</button>
			<button type="button" onclick="location.href='home.do';">Cancel</button>
		</form>
	</div>

	<script>
		function validate(){
			// 미입력
			if($("#userId").val().length == 0){	
				alert("이메일을 입력해주세요.");
				$("#userId").focus();
				return false;
				
			}else if($("#userPwd").val().length == 0){	
				alert("비밀번호를 입력해주세요.");
				$("#userPwd").focus();
				return false;
				
			}else if($("#userNickName").val().length == 0){	
				alert("닉네임을 입력해주세요.")
				$("#userNickName").focus();
				return false;
			}else{	
				return true;
			}
			
			// 아이디 중복체크
			if($("#idCheck").val() == 0){	// 아이디 사용불가
				alert("이메일을 확인해 주세요.");
				$("#userId").focus();
				return false;
			}else{	// 아이디 사용가능
				return true;
			}
			
			// 닉네임 중복체크
			if($("#nickCheck").val() == 0){	// 닉네임 사용불가
				alert("닉네임을 확인해 주세요.");
				$("#nickName").focus();
				return false;
			}else{	// 닉네임사용가능
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
	</script>
</body>
</html>