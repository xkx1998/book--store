<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>图书列表</title>

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

.icon {
	margin: 10px;
	width: 160px;
	height: 180px;
	text-align: center;
	float: left;
}

a {
	text-decoration: none;
	color: black;
}
</style>
</head>

<body>
	<c:forEach items="${pb.beanList}" var="book">
			<div class="icon">
				<a href="<c:url value='/BookServlet?method=load&bid=${book.bid}'/>"><img
					src="<c:url value='/${book.image}'/>" border="0" /></a> <br /> <a
					href="<c:url value='/BookServlet?method=load&bid=${book.bid}'/>"><b>${book.bname}</b></a>
					<br/>
					<a href="<c:url value='/admin/AdminBookServlet?method=delete&bid=${book.bid}&pc=${pb.pc}'/>"><font color="green">删除图书</font></a>
			</div>
	</c:forEach>
	<div style="position:absolute;left:450px;top:425px">
	<center>
	<hr>
		<a href="<c:url value='/admin/AdminBookServlet?method=findAll'/>"><font color="blue">首页</font></a>
		<c:if test="${pb.pc > 1}">
			<a href="<c:url value="/admin/AdminBookServlet?pc=${pb.pc-1}&method=findAll"/>"><font color="blue">上一页</font></a>
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
					<a href="<c:url value="/admin/AdminBookServlet?pc=${i}&method=findAll"/>"><font color="blue">[${i}]</font>
					</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${pb.pc < pb.tp}">
			<a href="<c:url value="/admin/AdminBookServlet?pc=${pb.pc+1}&method=findAll"/>"><font color="blue">下一页</font></a>
		</c:if>
		<a href="<c:url value="/admin/AdminBookServlet?pc=${pb.tp}&method=findAll"/>"><font color="blue">尾页</font></a>

	</center>
	</div>
</body>

</html>

