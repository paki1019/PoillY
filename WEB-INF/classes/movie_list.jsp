<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="PoillY_error.jsp"
	import="java.util.*,poilly.*"%>
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
<link rel="stylesheet" type="text/css" href="./slick/slick.css">
<link rel="stylesheet" type="text/css" href="./slick/slick-theme.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PoillY:영화목록</title>
</head>
<jsp:useBean id="movie_datas" scope="request"
	class="java.util.ArrayList" />
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
					<%
						if (account.getAdmin() == 1) {
					%>
					<li><a href="movie_form.jsp">movie</a></li>
				</ul>
			</div>
			<%
				}
				}
			%>
		</div>
		<div class="row" id="slidd" width="95%">
			<section class="center slider">
			<%
						for (PoillY_Movie movie : (ArrayList<PoillY_Movie>) movie_datas) {
					%>
			<div>
			<a href="Servlet?action=post_list&movie_title=<%=movie.getTitle()%>">
			<img src="<%=movie.getImage()%>" width="75%"></a>
			</div>
			<%
						}
					%>
			</section>

			<script src="https://code.jquery.com/jquery-2.2.0.min.js"
				type="text/javascript"></script>
			<script src="./slick/slick.min.js" type="text/javascript"
				charset="utf-8"></script>
			<script type="text/javascript">
				$(document).on('ready', function() {
					$(".vertical-center-4").slick({
						dots : true,
						vertical : true,
						centerMode : true,
						slidesToShow : 4,
						slidesToScroll : 2
					});
					$(".vertical-center-3").slick({
						dots : true,
						vertical : true,
						centerMode : true,
						slidesToShow : 3,
						slidesToScroll : 3
					});
					$(".vertical-center-2").slick({
						dots : true,
						vertical : true,
						centerMode : true,
						slidesToShow : 2,
						slidesToScroll : 2
					});
					$(".vertical-center").slick({
						dots : true,
						vertical : true,
						centerMode : true,
					});
					$(".vertical").slick({
						dots : true,
						vertical : true,
						slidesToShow : 3,
						slidesToScroll : 3
					});
					$(".regular").slick({
						dots : true,
						infinite : true,
						slidesToShow : 3,
						slidesToScroll : 3
					});
					$(".center").slick({
						dots : true,
						infinite : true,
						centerMode : true,
						slidesToShow : 3,
						slidesToScroll : 3
					});
					$(".variable").slick({
						dots : true,
						infinite : true,
						variableWidth : true
					});
					$(".lazy").slick({
						lazyLoad : 'ondemand', // ondemand progressive anticipated
						infinite : true
					});
				});
			</script>
		</div>
		<div class="row" id="footer">
			<ul>
				<li>© 2018 Copyright 오픈소스전문프로젝트 14조 이진호 전희재 김민지</li>
			</ul>
		</div>
	</div>
</body>
</html>