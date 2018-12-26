package cn.xkx.bookstore.book.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.itcast.servlet.BaseServlet;
import cn.xkx.bookstore.book.domain.Book;
import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.book.service.BookService;

public class BookServlet extends BaseServlet {
	private BookService bookService = new BookService();

	/**
	 * 查找图书
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String searchBooks(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取图书名称
		String bookName = request.getParameter("bookName");

		// 获取当前页码
		int pc = getPc(request);

		// 设置一页的记录数
		int ps = 12;

		// 得到PageBean
		PageBean<Book> pb = bookService.searchBooks(bookName, pc, ps);
		request.setAttribute("pb", pb);
		return "/jsps/book/list.jsp";

	}

	// 查询所有图书
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取当前页码
		int pc = getPc(request);

		// 设置一页的记录数
		int ps = 12;

		// 得到PageBean
		PageBean<Book> pb = bookService.findAll(pc, ps);
		request.setAttribute("pb", pb);
		return "/jsps/book/list.jsp";
	}

	/**
	 * 按分类查询图书
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String findByCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid = request.getParameter("cid");
		// 获取当前页码
		int pc = getPc(request);

		// 设置一页的记录数
		int ps = 12;

		// 得到PageBean
		PageBean<Book> pb = bookService.findByCategory(cid, pc, ps);
		request.setAttribute("pb", pb);
		request.setAttribute("cid", cid);
		return "/jsps/book/listByCategory.jsp";
	}

	/**
	 * 显示图书的详细信息
	 */
	public String load(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 得到参数bid 查询book 保存转发到desc.jsp
		 */
		request.setAttribute("book", bookService.load(request.getParameter("bid")));
		return "/jsps/book/desc.jsp";
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
