<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户列表</title>

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
	<h1 style="font-size: 35px;color: maroon;" align="center">
		<b>用户列表</b>
	</h1>

	<table class="imagetable" align="center">
		<tr>
		    <th>用户Id</th>
			<th>用户名称</th>
			<th>邮箱</th>
		</tr>

		<c:forEach items="${pb.beanList}" var="user">
			<tr>
			    <td>${user.uid}</td>
				<td>${user.username}</td>
				<td>${user.email}</td>
			</tr>
		</c:forEach>
	</table>
		<center>
			<hr>
			<a href="<c:url value='/admin/AdminUserServlet?method=findAllUsers'/>"><font
				color="blue">首页</font></a>
			<c:if test="${pb.pc > 1}">
				<a href="<c:url value="/admin/AdminUserServlet?pc=${pb.pc-1}&method=findAllUsers"/>"><font
					color="blue">上一页</font></a>
			</c:if>

			<%--显示页码 --%>
			<c:choose>
				<%--当总页数不足10页时，全部显示出来 --%>
				<c:when test="${pb.tp < 10}">
					<c:set var="begin" value="1" />
					<c:set var="end" value="${pb.tp}" />
				</c:when>
				<%--当总页数大于10页时，用公式计算出页码 --%>
				<c:otherwise>
					<c:set var="begin" value="${pb.pc-5}" />
					<c:set var="end" value="${pb.pc+4}" />
					<%--头溢出 --%>
					<c:if test="${begin<1}">
						<c:set var="begin" value="1" />
						<c:set var="end" value="10" />
					</c:if>
					<%--尾溢出 --%>
					<c:if test="${end>tp}">
						<c:set var="begin" value="${tp-9}" />
						<c:set var="end" value="${tp}" />
					</c:if>
				</c:otherwise>
			</c:choose>


			<c:forEach var="i" begin="${begin}" end="${end}">
				<c:choose>
					<c:when test="${i eq pb.pc}">
						<font color="blue"> [${i}] </font>
					</c:when>
					<c:otherwise>
						<a href="<c:url value="/admin/AdminUserServlet?pc=${i}&method=findAllUsers"/>"><font
							color="blue">[${i}]</font> </a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${pb.pc < pb.tp}">
				<a href="<c:url value="/admin/AdminUserServlet?pc=${pb.pc+1}&method=findAllUsers"/>"><font
					color="blue">下一页</font></a>
			</c:if>
			<a href="<c:url value="/admin/AdminUserServlet?pc=${pb.tp}&method=findAllUsers"/>"><font
				color="blue">尾页</font></a>

		</center>
</body>
</html>