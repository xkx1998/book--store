<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>购物车列表</title>

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
* {
	font-size: 13pt;
}

body {
background: url(<c:url value='/images/backgound2.jpg'/>) no-repeat;
}

div {
	margin: 20px;
	width: 150px;
	height: 150px;
	text-align: center;
}

li {
	margin: 10px;
}

#buy {
	background: url(<c:url value='/images/all.png'/>) no-repeat;
	display: inline-block;
	background-position: 0 -902px;
	margin-left: 30px;
	height: 36px;
	width: 146px;
}

#buy:HOVER {
	background: url(<c:url value='/images/all.png'/>) no-repeat;
	display: inline-block;
	background-position: 0 -938px;
	margin-left: 30px;
	height: 36px;
	width: 146px;
}

a {
	text-decoration: none;
	color: blue;
	font-weight: bold;
}
</style>
</head>

<body>
	<h1 align="center" style="font-size: 20pt">我的购物车</h1>
	<c:choose>
		<c:when
			test="${empty sessionScope.cart or fn:length(sessionScope.cart.cartItems) eq 0}">
			<center>
				<h2 align="center" style="color: blue;">空车</h2>
				<img src="<c:url value='/images/cart.jpg' />" />
			</center>
		</c:when>
		<c:otherwise>
			<table border="1" width="100%" cellspacing="0" background="black">
				<tr>
					<th>图片</th>
					<th>书名</th>
					<th>作者</th>
					<th>单价</th>
					<th>数量</th>
					<th>小计</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${cart.cartItems}" var="cartItem">
					<tr>
						<td align="center"><div>
								<img src="<c:url value='/${cartItem.book.image}'/>" />
							</div></td>
						<td align="center">${cartItem.book.bname}</td>
						<td align="center">${cartItem.book.author}</td>
						<td align="center">${cartItem.book.price}</td>
						<td align="center"><a href="<c:url value='/CartServlet?method=addOne&bid=${cartItem.book.bid}'/>" style="color: green;">+</a>&nbsp;&nbsp;${cartItem.count}&nbsp;&nbsp;<a href="<c:url value='/CartServlet?method=deleteOne&bid=${cartItem.book.bid}'/>" style="color: red;">-</a></td>
						<td align="center">${cartItem.subtotal}</td>
						<td align="center"><a
							href="<c:url value='/CartServlet?method=delete&bid=${cartItem.book.bid}'/>">删除</a></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="7" align="right"
						style="font-size: 15pt; font-weight: 900">合计：${cart.total}</td>
				</tr>
				<tr align="right">
					<td colspan="7" align="right"
						style="font-size: 12pt; font-weight: 900;"><a
						href="<c:url value='/CartServlet?method=clear'/> ">清空购物车</a></td>
				</tr>
				<tr>
					<td colspan="7" align="right"
						style="font-size: 15pt; font-weight: 900"><a id="buy"
						href="<c:url value='/OrderServlet?method=add'/>"></a></td>
				</tr>
				</table>
		</c:otherwise>
	</c:choose>
</body>
</html>
