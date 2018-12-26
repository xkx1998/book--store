<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>图书详细</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
body {
	font-size: 10pt;
	background: url(<c:url value='/images/backgound2.jpg'/>) no-repeat;
}

div {
	margin: 20px;
	border: solid 2px gray;
	width: 600px;
	height: 350px;
	text-align: center;
}

li {
	margin: 10px;
	list-style-type:none;
}

a {
	background: url(<c:url value = '/images/all.png'/>) no-repeat;
	display: inline-block;
	background-position: 0 -70px;
	margin-left: 30px;
	height: 36px;
	width: 146px;
}

a:HOVER {
	background: url(<c:url value = '/images/all.png'/>) no-repeat;
	display: inline-block;
	background-position: 0 -106px;
	margin-left: 30px;
	height: 36px;
	width: 146px;
}
</style>
</head>

<body>
	<center>
	<div>
	    <br>
	    <br>
		<img src="<c:url value='/${book.image}'/>" border="0"/>
	<ul>
		<li>书名：${book.bname }</li>
		<li>作者：${book.author }</li>
		<li style="color: red;">￥${book.price }元</li>
	</ul>
	
	<form id="form" action="<c:url value='/CartServlet'/>" method="post">
		<%-- 指定要调用的方法 --%>
		<input type="hidden" name="method" value="add" /> <input type="hidden"
			name="bid" value="${book.bid}" /> 数量：<input type="text" size="3"
			name="count" value="1" /> <h1 style="color:red;">${msg}</h1>
	</form>
	</div>
	<a href="javascript:document.getElementById('form').submit();"></a>
	</center>
</body>
</html>

