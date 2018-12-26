package cn.xkx.bookstore.user.web.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.servlet.BaseServlet;
import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.user.domain.User;
import cn.xkx.bookstore.user.service.UserService;

public class AdminUserServlet extends BaseServlet {
	private UserService userService = new UserService();
	public String findAllUsers(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取当前页码
		int pc = getPc(request);

		// 设置一页的记录数
		int ps = 10;

		// 得到PageBean
		PageBean<User> pb = userService.findAllUsers(pc, ps);
		request.setAttribute("pb", pb);
		return "f:/adminjsps/admin/user/list.jsp";
	}

	/**
	 * 获取当前页码
	 * 
	 * @param request
	 * @return
	 */
	public int getPc(HttpServletRequest request) {
		/*
		 * 1.得到pc 如果pc参数不存在，说明pc=1 如果pc参数存在，需要转换为int类型即可
		 */
		String value = request.getParameter("pc");
		if (value == null || value.trim().isEmpty()) {
			return 1;
		}
		return Integer.parseInt(value);
	}
}
