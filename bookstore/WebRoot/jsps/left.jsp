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
<title>left</title>
<base target="body" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<link href="css/basic.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<script src="js/jquery.min.js"></script>
<script src="js/index.js"></script>
</head>

<body>
	<ul>
		<li style="font-size: 15px;font-weight: bold;"><a class="hover"
			href="<c:url value='/BookServlet?method=findAll'/>">全部分类</a></li>
		<c:forEach items="${CategoryList}" var="category">

			<li><a
				href="<c:url value='/BookServlet?method=findByCategory&cid=${category.cid}'/>">${category.cname}</a></li>
		</c:forEach>
		<div id="lanPos"></div>
	</ul>
</body>
</html>
