<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="PoillY_error.jsp"
	import="java.util.*,poilly.*,java.text.*"%>
<jsp:useBean id="movie_data" scope="request" class="poilly.PoillY_Movie" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>PoillY:게시글</title>
</head>
<jsp:useBean id="post_datas" scope="request" class="java.util.ArrayList" />
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
			<h1 align="left" style="margin-left: 15%;">리뷰 리스트</h1>
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
			<table id="P">
				<thead>
					<tr>
						<th scope="cols" style="width: 350px">게시글 제목</th>
						<th scope="cols" style="width: 100px">닉네임</th>
						<th scope="cols" style="width: 100px">별</th>
						<th scope="cols" style="width: 50px">스포</th>
						<th scope="cols" style="width: 150px">작성일</th>
						<th scope="cols" style="width: 100px">조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						Date today = new Date();
						SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
						for (PoillY_Post post : (ArrayList<PoillY_Post>) post_datas) {
					%>
					<tr>
						<td><a href="Servlet?action=contents&id=<%=post.getId()%>"><%=post.getTitle()%></a></td>
						<td><%=post.getWriter()%></td>
						<td>
						<%for(int i=0;i<post.getStar()/2;i++){ %>
						<img src="img/star1.png" width="14px" height="14px">
						<%}
						if(post.getStar()%2==1){
							%>
						<img src="img/star_half.png" width="14px" height="14px">
						<% }%>
						<%for(int i=0;i<(10-post.getStar())/2;i++){%>
						<img src="img/star2.png" width="14px" height="14px">
						<%} %></td>
						<td>
							<%
								if (post.getSpoiller() == 1) {
										out.println("O");
									} else {
										out.println("X");
									}
							%>
						</td>
						<%
							String getdate = "";
								if (post.getTime().contains(date.format(today))) {
									getdate = post.getTime().substring(11, 16);
								} else {
									getdate = post.getTime().substring(0, 10);
								}
						%>
						<td><%=getdate%></td>
						<td><%=post.getView()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			<%
				int maxpagenum = (int) request.getAttribute("maxpagenum");
				if (maxpagenum % 10 == 0) {
					maxpagenum = maxpagenum / 10 - 1;
				} else {
					maxpagenum = maxpagenum / 10;
				}
				for (int i = 0; i <= maxpagenum; i++) {
					if (i == (int) request.getAttribute("pagenum")) {
			%><%=i + 1%>
			<%
				} else {
			%><a
				href='Servlet?action=post_list&movie_title=<%=request.getParameter("movie_title")%>&pagenum=<%=i%>'><%=i + 1%></a>
			<%
				}
			%>
			<%
				}
			%>
			</div>
			<div class="col-md-1"></div>
			<br>

			<%if(account==null){ %>
			<a href="PoillY_login.jsp?fail=2"><input type="button" class="button" value="게시글작성  ✓"></a> 
			<%}else{ %>
			<a href="post_form.jsp?movie_title=<%=request.getParameter("movie_title")%>"><input type="button" class="button" value="게시글작성  ✓"></a>
			<%} %>
			<a href="Servlet?action=movie_list"><input type="button" class="button" value="돌아가기  ✓"></a>
		</div>
		<div class="row" id="footer">
			<ul>
				<li>© 2018 Copyright 오픈소스전문프로젝트 14조 이진호 전희재 김민지</li>
			</ul>
		</div>
		
	</div>
</body>
</html>