<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PoillY:회원가입</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="PoillY.css" type="text/css" media="screen" />
<%
	if (request.getParameter("fail").equals("1")) {
%><script>
	alert("회원가입 실패: 아이디 중복");
</script>
<%
	} else if (request.getParameter("fail").equals("2")) {
%><script>
	alert("회원가입 실패: 패스워드, 패스워드 확인 불일치");
</script>
<%
	}
%>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="row" align="center">
					<a href="index.jsp"><img src="img/logo.png" alt="logo"
						width="80%" height="80%"></a>
				</div>
			</div>
			<div class="col-md-3"></div>
		</div>
		<div class="row" align="center">
			<img src="img/signup.png">
			<form name=form method=post action=Servlet class="form">
				<input type="hidden" name="action" value="Sign">
				<div style="border: none;">
					<table class="F">
						<tr>
							<th>아이디</th>
							<td><input type="text" name="ID" maxlength="30"></td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td><input type="text" name="nickname" maxlength="30"></td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type="password" name="password" maxlength="30"></td>
						</tr>
						<tr>
							<th>패스워드 확인</th>
							<td><input type="password" name="password_check"
								maxlength="30"></td>
						</tr>
						</div>
					</table>
					<input type=submit value="회원가입" class="button"><input
						type="button" onclick="history.go(-1);" value="취소" class="button">
				</div>
			</form>
		</div>
		<div class="row" id="footer">
			<ul>
				<li>© 2018 Copyright 오픈소스전문프로젝트 14조 이진호 전희재 김민지</li>
			</ul>
		</div>
	</div>
</body>
</html>