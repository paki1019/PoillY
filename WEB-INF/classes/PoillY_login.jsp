<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="PoillY_error.jsp"
	import="java.util.*,poilly.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PoillY:로그인</title>
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
%>
<script>
	alert("로그인 실패: 아이디 패스워드를 확인하시오");
</script>
<%
	}else if(request.getParameter("fail").equals("2")){
%>
<script>
	alert("게시글을 작성하려면 로그인을 해야합니다.");
</script>
<%
		
	}
%>
</head>
<jsp:useBean id="account" class="poilly.PoillY_Account" />
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
			<form method="post" action="Servlet" class="form">
				<input type="hidden" name="action" value="login">
				<fieldset style="border: none;">
					<img src="img/login.png">
					<table class="F">
						<tr>
							<th>아이디</th>
							<td><input type="text" name="ID" maxlength="30"></td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type="password" name="password" maxlength="30"></td>
						<tr>
					</table>
				</fieldset>
				<input type="submit" class="button" value="로그인  ✓">
				<input type="button" class="button" onclick="history.go(-1);" value="돌아가기  ✓">
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