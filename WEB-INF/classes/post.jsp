<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="poilly.*" errorPage="PoillY_error.jsp"%>
<jsp:useBean id="post_data" scope="request" class="poilly.PoillY_Post" />
<jsp:useBean id="movie_data" scope="request" class="poilly.PoillY_Movie" />
<jsp:useBean id="account" class="poilly.PoillY_Account" />
<!DOCTYPE html>
<html>
<head>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="addrbook.css" type="text/css"
	media="screen" />
<title>PoillY:<%=post_data.getTitle()%></title>
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
		<div class="row">
			<%
				account = (PoillY_Account) session.getAttribute("account");
				if (account == null) {
			%>
			<div id="K">
				<ul>
					<li><a href="PoillY_login.jsp?fail=0">login</a></li>
					<li><a href="PoillY_Sign.jsp?fail=0">signup</a></li>
				</ul>
			</div>
			<%
				} else {
			%>
			<div id="K">
				<ul>
					<li><a href="PoillY_account.jsp">mypage</a></li>
					<li><a href="Servlet?action=logout">logout</a></li>
				</ul>
			</div>
			<%
				}
			%>
		</div>
		<div class="row" align="center">
			<h1 align="left" style="margin-left: 15%;">리뷰</h1>
			<div class="col-md-2"></div>
			<div class="col-md-4">
				<img src="<%=movie_data.getImage()%>" width="80%" height="80%">
			</div>
			<div class="col-md-4">
				<table class="table">
					<tr>
						<th style="width: 20%;">영화제목</th>
						<td><%=movie_data.getTitle()%></td>
					</tr>
					<tr>
						<th>영화평점</th>
						<td><%=String.format("%.2f",movie_data.getStar())%></td>
					</tr>
					<tr>
						<th>줄거리</th>
						<td><%=movie_data.getStory()%></td>
					</tr>
				</table>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row" align="center">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<br>
				<table class="table">
					<tbody>
						<tr>
							<th>제목</th>
							<td colspan="9"><%=post_data.getTitle()%></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><%=post_data.getWriter()%></td>
							<th>작성일</th>
							<td><%=post_data.getTime() %></td>
							<th>별점</th>
						<td>
						<%for(int i=0;i<post_data.getStar()/2;i++){ %>
						<img src="img/star1.png" width="14px" height="14px">
						<%}
						if(post_data.getStar()%2==1){
							%>
						<img src="img/star_half.png" width="14px" height="14px">
						<% }%>
						<%for(int i=0;i<(10-post_data.getStar())/2;i++){%>
						<img src="img/star2.png" width="14px" height="14px">
						<%} %></td>
							<th>스포일러</th>
							<td>
								<%
									if (post_data.getSpoiller() == 1) {
										out.println("O");
									} else {
										out.println("X");
									}
								%>
							</td>
							<th>조회수</th>
							<td><%=post_data.getView() %></td>
						</tr>
					</tbody>
					<tr>
						<td colspan='10'><%=post_data.getContents()%></td>
					</tr>
				</table>
				<hr>
				<input type="button" onclick="history.go(-1);" class="button"
					value="돌아가기  ✓">
				<%
					String writer_id = "";
					if (session.getAttribute("account") != null) {
						writer_id = account.getID();
					}
					if (post_data.getWriter_id().equals(writer_id)) {
				%>
				<a href="Servlet?action=post_edit&id=<%=post_data.getId()%>"><input
					type="button" class="button" value="수정  ✓"></a> <a
					href="Servlet?action=post_delete&id=<%=post_data.getId()%>"><input
					type="button" class="button" value="삭제  ✓"></a>
				<%
					}
				%>

			</div>
			<div class="col-md-1"></div>
		</div>

		<div class="row" id="footer">
			<ul>
				<li>© 2018 Copyright 오픈소스전문프로젝트 14조 이진호 전희재 김민지</li>
			</ul>
		</div>
	</div>
</body>
</html>