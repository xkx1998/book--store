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
<title>注册</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<link href="css/style1.css" rel='stylesheet' type='text/css' />

</head>

<body>
	<div class="main">
		<div class="login">
			<h1>图书商城后台管理</h1>
			<div class="inset">
				<!--start-main-->
				<form action="<c:url value='/UserServlet'/>" method="post">
					<input type="hidden" name="method" value="regist" />
					<input type="hidden" name="userType" value="administrator">
					<div>
						<h2>注册</h2>
						<p style="color: red; font-weight: 900" align="center">${msg}</p>
						<span><label>用户名</label></span> <span><input type="text"
							class="textbox" name="username" value="${form.username}"></span>
						<span style="color: red; font-weight: 900">${errors.username }</span>
					</div>
					<div>
						<span><label>密码</label></span> <span><input type="password"
							name="password" class="password" value="${form.password}"></span>
						<span style="color: red; font-weight: 900">${errors.password }</span>
					</div>
					<div>
						<span><label>邮箱</label></span> <span><input type="text"
							name="email" class="textbox" value="${form.email}"></span> <span
							style="color: red; font-weight: 900">${errors.email}</span>
					</div>
					<div class="sign">
						<input type="submit" value="注册" class="submit" />
					</div>
					<br>
					<p align="right">
						<a href="<c:url value='/jsps/user/login.jsp' />">已经有账号?</a>
					</p>
				</form>
			</div>
		</div>
		<!--//end-main-->
	</div>
</body>
</html>
