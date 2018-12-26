<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>top</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	background: url(<c:url value='/images/backgound.jpg'/>) no-repeat;
}

a {
	text-transform: none;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

li {
	color: white;
}

ul li {
	list-style: none;
	float: left;
	position: relative;
	z-index: 5;
	text-decoration: none;
	color: activecaption;
	font-size: 14px;
	line-height: 40px;
	padding: 0 10px;
	margin-right: 2px;
	/*width: 60px;*/
	/*text-align: center;*/
}

ul li a {
	text-decoration: none;
	color: white;
	font-size: 14px;
	line-height: 40px;
	padding: 0 10px;
	margin-right: 2px;
}

#slider {
	width: 50px;
	height: 100px;
	background: #c00;
	position: absolute;
	top: 0;
	left: 0;
}
</style>
</head>

<body>
	<div>
		<h1 style="text-align: center;color:white;">图书商城后台管理</h1>
	</div>
	<br>
	<div align="left">
		<ul>
			<c:choose>
				<c:when test="${empty session_user}">
					<li><a href="<c:url value="/adminjsps/administrator/login.jsp"/>"
						target="_parent">登录</a></li>
					<li>&nbsp;&nbsp;|</li>
					<li>&nbsp;&nbsp;</li>
					<li><a href="<c:url value="/adminjsps/administrator/regist.jsp"/>"
						target="_parent">注册</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>

				</c:when>
				<c:otherwise>
					<li>管理员：${sessionScope.session_user.username}</li>
					<li><a href="<c:url value='/UserServlet?method=quit&userType=${session_user.userType}'/>"
						target="_parent">注销</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>

</body>
<script src="jquery/jquery-2.2.4.min.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript">
	$("li").mouseenter(function() {
		$("#slider").animate({
			left : $(this).offset().left - $('li').eq(0).offset().left,
		}, 50)
		$("#slider").css({
			width : $(this).width(),
		})

	})

	$("ul").mouseleave(function() {
		$("#slider").css({
			width : '50',
		})
		$("#slider").animate({
			left : "0",
		}, 200)
	})
</script>
</html>
