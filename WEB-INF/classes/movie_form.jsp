<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="PoillY_error.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PoillY:영화 추가</title>
<link rel="stylesheet" href="PoillY.css" type="text/css" media="screen" />
</head>
<body>
	<div align="center">
		<h2>PoillY:영화 추가</h2>
		<hr>
		[<a href="Servlet?action=movie_list">영화 목록으로</a>]
		<P>
		<form name=form1 method=post enctype="multipart/form-data" action=Servlet>
			<input type="hidden" name="action" value="movie_insert">
			<table border="1">
				<tr>
					<th>제 목</th>
					<td><input type="text" name="title" maxlength="30"></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td><input type="file" name="image"></td>
				</tr>
				<tr>
					<th>줄거리</th>
					<td><textarea name="story"></textarea></td>
				</tr>
				<tr>
					<td colspan=2 align=center><input type=submit value="저장">
						<input type="reset" value="취소"></td>
				</tr>
			</table>

		</form>
	</div>
</body>
</html>