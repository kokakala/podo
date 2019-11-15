<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="insertMember.do" method="post">
			<input type="email" name="email" placeholder="이메일을 입력하세요."/><br>
			<input type="password" name="pwd" placeholder="비밀번호를 입력하세요."/><br>
			<input type="text" name="nickName" placeholder="닉네임을 입력하세요."/><br>
			<input type="file" name="image"/><br>
			<button type="submit">Join</button>
		</form>
	
	</div>

</body>
</html>