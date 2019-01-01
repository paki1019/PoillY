<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div align="center">
		<h2>에러</h2>
		<hr>
		<table cellpadding=5 width=400>
			<tr width="100%" bgcolor="yellow">
				<td>요청 처리중 에러가 발생했습니다.<br>관리자에게 문의해 주세
					<hr>에러내용 : <%=request.getAttribute("exception")%><hr></td>
			</tr>
		</table>
	</div>

</body>
</html>