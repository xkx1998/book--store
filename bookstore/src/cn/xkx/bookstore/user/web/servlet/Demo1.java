package cn.xkx.bookstore.user.web.servlet;

import java.text.MessageFormat;

import org.junit.Test;

public class Demo1 {
	@Test
	public void fun1()
	{
		String string = MessageFormat.format("<a href=http://localhost:8080/bookstore/UserServlet?method=active&code={0}>点击这里完成激活</a>","xx");
		System.out.println(string);
	}
}
