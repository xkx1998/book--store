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
   box-sizing: border-box;
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

 /*搜索框1*/
        .bar1 {background: url(<c:url value='/images/backgound.jpg'/>) no-repeat;}
        .bar1 input {
            border: 2px solid #7BA7AB;
            border-radius: 5px;
            background: #F9F0DA;
            color: #9E9C9C;
        }
        .bar1 button {
            top: 0;
            right: 0;
            background: #7BA7AB;
            border-radius: 0 5px 5px 0;
        }
        .bar1 button:before {
            content: "\f002";
            font-family: FontAwesome;
            font-size: 16px;
            color: #F9F0DA;
        }
        
         #container {
            width: 500px;
            height: 820px;
            margin: 0 auto;
        }
        div.search {padding: 30px 0;}

        form {
            position: relative;
            width: 300px;
            margin: 0 auto;
        }

        input, button {
            border: none;
            outline: none;
        }

        input {
            width: 100%;
            height: 42px;
            padding-left: 13px;
        }

        button {
            height: 42px;
            width: 42px;
            cursor: pointer;
            position: absolute;
        }
</style>
</head>

<body>
	<div style="height:25px;">
		<h1 style="text-align: center;color:white;">图书商城</h1>
	</div>
	<div class="search bar1" style="height:10px;top: 0">
        <form action="<c:url value='/BookServlet'/>" target="body">
            <input type="hidden" name="method" value="searchBooks">
            <input type="text" placeholder="请输入您要搜索的图书..." name="bookName">
            <button type="submit"></button>
        </form>
    </div>
	<div align="left">
		<ul>
			<c:choose>
				<c:when test="${empty session_user}">
					<li><a href="<c:url value="/jsps/user/login.jsp"/>"
						target="_parent">登录</a></li>
					<li>&nbsp;&nbsp;|</li>
					<li>&nbsp;&nbsp;</li>
					<li><a href="<c:url value="/jsps/user/regist.jsp"/>"
						target="_parent">注册</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>

				</c:when>
				<c:otherwise>
					<li>当前用户：${sessionScope.session_user.username}</li>
					<li><a href="<c:url value='/UserServlet?method=quit&userType=${session_user.userType}'/>"
						target="_parent">注销</a></li>
				</c:otherwise>
			</c:choose> 
		</ul>
	</div>
	
	<br>
	<br>

	<div id='content' align="center">
		<ul>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li style="background-color: red;"><a
				href="<c:url value='/BookServlet?method=findAll'/>" target="body">商城首页
					></a></li>
			<li style="background-color:black; ;"><a
				href="<c:url value='/jsps/cart/list.jsp'/>" target="body">我的购物车></a></li>
			<%-- <li style="background-color:green;"><a
				href="<c:url value='/OrderServlet?method=myOrders'/>" target="body">我的订单></a></li> --%>
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
