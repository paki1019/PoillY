<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="PoillY_error.jsp"
	import="java.util.*,poilly.*"%>
<jsp:useBean id="account" class="poilly.PoillY_Account" />
<%
	Beans gb = new Beans();
	account = (PoillY_Account) session.getAttribute("account");
	PoillY_Movie movie_data = gb.getMoviebyName(request.getParameter("movie_title"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">

<title>PoillY:<%=request.getParameter("movie_title")%></title>
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
<style>
.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('img/grade_img.png')repeat-x;}
.star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:0;line-height:50px;}
.star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:600px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label:hover~label{background-image: none;}

.star-input>.input>label[for="p1"]{width:15px;z-index:10;}
.star-input>.input>label[for="p2"]{width:30px;z-index:9;}
.star-input>.input>label[for="p3"]{width:45px;z-index:8;}
.star-input>.input>label[for="p4"]{width:60px;z-index:7;}
.star-input>.input>label[for="p5"]{width:75px;z-index:6;}
.star-input>.input>label[for="p6"]{width:90px;z-index:5;}
.star-input>.input>label[for="p7"]{width:105px;z-index:4;}
.star-input>.input>label[for="p8"]{width:120px;z-index:3;}
.star-input>.input>label[for="p9"]{width:135px;z-index:2;}
.star-input>.input>label[for="p10"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:40px; font-size:18px;text-align:right; vertical-align:middle;}
</style>

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
			<h1 align="left" style="margin-left: 15%;">글쓰기</h1>
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
						<td><%=String.format("%.2f", movie_data.getStar())%></td>
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
				<form name=form2 method=post action=Servlet>
					<input type="hidden" name="action" value="post_insert"> <input
						type="hidden" name="movie"
						value='<%=request.getParameter("movie_title")%>'> <input
						type="hidden" name="writer_id" value="<%=account.getID()%>">
					<input type="hidden" name="writer"
						value="<%=account.getNickname()%>">
					<div class="form-group" align="left">
						<label>제목</label> <input type="text" name="title" maxlength="30"
							class="form-control" placeholder="제목">
					</div>
					<div class="form-group" align="left">
						<label>별점</label> <br> 
<span class="star-input">
	<span class="input">
    	<input type="radio" name="star-input" value="1" id="p1">
    	<label for="p1">1</label>
    	<input type="radio" name="star-input" value="2" id="p2">
    	<label for="p2">2</label>
    	<input type="radio" name="star-input" value="3" id="p3">
    	<label for="p3">3</label>
    	<input type="radio" name="star-input" value="4" id="p4">
    	<label for="p4">4</label>
    	<input type="radio" name="star-input" value="5" id="p5">
    	<label for="p5">5</label>
		<input type="radio" name="star-input" value="6" id="p6">
    	<label for="p6">6</label>
    	<input type="radio" name="star-input" value="7" id="p7">
    	<label for="p7">7</label>
    	<input type="radio" name="star-input" value="8" id="p8">
    	<label for="p8">8</label>
    	<input type="radio" name="star-input" value="9" id="p9">
    	<label for="p9">9</label>
    	<input type="radio" name="star-input" value="10" id="p10">
    	<label for="p10">10</label>
  	</span>
	<output for="star-input"><b>0</b>점</output>					
</span>
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/star.js"></script>
					</div>
					<div align="left">
						<label>스포일러</label><br> <label class="radio-inline">
							<input type="radio" name="spoiller" id="inlineRadio1" value="1">
							O
						</label> <label class="radio-inline"> <input type="radio"
							name="spoiller" id="inlineRadio2" value="0"> X
						</label>
					</div>
					<div align="left">
						<label>내용</label>
					</div>
					<textarea name="contents" class="form-control" rows="4"></textarea>
					<input type="submit" class="button" value="제출  ✓"> <input
						type="button" onclick="history.go(-1);" class="button"
						value="취소  ✓">

				</form>
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