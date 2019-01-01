<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="PoillY_error.jsp"
	import="java.util.*,poilly.*"%>
<jsp:useBean id="account" class="poilly.PoillY_Account" />
<%
	account = (PoillY_Account) session.getAttribute("account");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PoillY:내 정보</title>
</head>
<body>
	<div align="center">
		<h2>PoillY:내 정보</h2>
		<hr>
		[<a href="Servlet?action=movie_list">영화 목록으로</a>]
		<P>
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><%=account.getID()%></td>
			</tr>
			<tr>
			<th>닉네임</th>
			<td><%=account.getNickname() %></td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>