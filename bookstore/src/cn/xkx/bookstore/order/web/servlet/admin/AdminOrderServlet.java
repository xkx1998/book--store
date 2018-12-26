package cn.xkx.bookstore.order.web.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.servlet.BaseServlet;
import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.order.domain.Order;
import cn.xkx.bookstore.order.service.OrderException;
import cn.xkx.bookstore.order.service.OrderService;

public class AdminOrderServlet extends BaseServlet {
	OrderService orderService = new OrderService();
	public String findAllOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 获取当前页码
		int pc = getPc(request);

		// 设置一页的记录数
		int ps = 5;

		String s = request.getParameter("state");
		Integer state = Integer.valueOf(s);
		// 得到PageBean
		PageBean<Order> pb = orderService.findAllOrders(state , pc, ps);
		request.setAttribute("pb", pb);
		request.setAttribute("state", state);
		return "f:/adminjsps/admin/order/list.jsp";
	}

	/**
	 * 发货
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String send(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 获取oid参数 调用service方法 如有异常，保存异常转发到msg.jsp
		 */

		String oid = request.getParameter("oid");
		try {
			orderService.send(oid);
			request.setAttribute("msg", "发货成功");
		} catch (OrderException e) {
			request.setAttribute("msg", e.getMessage());
		}
		return findAllOrders(request, response);
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
