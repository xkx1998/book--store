<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>订单列表</title>

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
	font-size: 11pt;
}

body {
	font-size: 10pt;
	background: url(<c:url value='/images/backgound2.jpg'/>) no-repeat;
	background-size: 100%;
}

div {
	border: solid 2px gray;
	width: 100px;
	height: 100px;
	text-align: center;
}

li {
	margin: 10px;
}

#buy {
	background: url(< c : url value = '/images/all.png'/ >) no-repeat;
	display: inline-block;
	background-position: 0 -902px;
	margin-left: 30px;
	height: 36px;
	width: 146px;
}

#buy:HOVER {
	background: url(< c : url value = '/images/all.png'/ >) no-repeat;
	display: inline-block;
	background-position: 0 -938px;
	margin-left: 30px;
	height: 36px;
	width: 146px;
}

a {
	text-decoration: none;
}
</style>
</head>

<body>
	<h1 style="font-size: 35px;color: maroon;" align="center">
		<b>订单列表</b>
	</h1>

	<table border="1" width="100%" cellspacing="0"
		style="background: orange;">
		<c:forEach items="${pb.beanList}" var="order">
			<tr bgcolor="green" bordercolor="gray">
				<td colspan="6"><b>订单编号：${order.oid}</b> <pre></pre>成交时间：${order.ordertime}
					<font color="red"><b>￥:${order.total}</b></font> 订单状态: <c:choose>
						<c:when test="${order.state eq 1}">
							<font color="pink">未付款</font>
						</c:when>
						<c:when test="${order.state eq 2}">
							<a
								href="<c:url value='/admin/AdminOrderServlet?method=send&oid=${order.oid}&state=${state}'/>">发货</a>
						</c:when>
						<c:when test="${order.state eq 3}">
					             待确认收货
					   </c:when>
						<c:when test="${order.state eq 4}">
					              交易成功
					   </c:when>
					</c:choose></td>
			</tr>
			<c:forEach items="${order.orderItemList}" var="orderItem">
				<tr bordercolor="gray" align="center">
					<td width="15%">
						<div style="border: none;">
							<img src="<c:url value='/${orderItem.book.image}'/>" height="100" />
						</div>
					</td>
					<td>书名：${orderItem.book.bname}</td>
					<td>单价：${orderItem.book.price}元</td>
					<td>作者：${orderItem.book.author}</td>
					<td>数量：${orderItem.count}</td>
					<td>小计：${orderItem.subtotal}元</td>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
</body>
</html>