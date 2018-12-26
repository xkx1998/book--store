<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>分类列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
body {
	font-size: 10pt;
	background: url(<c:url value='/images/backgound2.jpg'/>) no-repeat;
	background-size: 100%;
}
table.imagetable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-width: 1px;
	border-color: #999999;
	border-collapse: collapse;
}

table.imagetable th {
	background: #b5cfd2 url('cell-blue.jpg');
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #999999;
}

table.imagetable td {
	background: #dcddc0 url('cell-grey.jpg');
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #999999;
}
</style>
</head>

<body>
<div align="center">
		<h3>分类列表</h3>
	</div>

	<table class="imagetable" align="center">
		<tr>
		    <th>分类Id</th>
			<th>分类名称</th>
			<th>操作</th>
		</tr>

		<c:forEach items="${categoryList}" var="category">
			<tr>
			    <td>${category.cid}</td>
				<td>${category.cname}</td>
				<td>
				<a href="<c:url value='/admin/AdminCategoryServlet?method=editPre&cid=${category.cid}'/>">修改</a> |
				<a onclick="return confirm('您真要删除该分类吗？')" href = "<c:url value='/admin/AdminCategoryServlet?method=delete&cid=${category.cid}'/>">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
