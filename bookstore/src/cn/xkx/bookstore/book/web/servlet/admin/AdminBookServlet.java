package cn.xkx.bookstore.book.web.servlet.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.servlet.BaseServlet;
import cn.xkx.bookstore.book.domain.Book;
import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.book.service.BookException;
import cn.xkx.bookstore.book.service.BookService;
import cn.xkx.bookstore.category.domain.Category;
import cn.xkx.bookstore.category.service.CategoryService;

public class AdminBookServlet extends BaseServlet {
	private BookService bookService = new BookService();
	private CategoryService categoryService = new CategoryService();

	/**
	 * 查看所有图书
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取当前页码
		int pc = getPc(request);

		// 设置一页的记录数
		int ps = 10;

		// 得到PageBean
		PageBean<Book> pb = bookService.findAll(pc, ps);
		request.setAttribute("pb", pb);
		request.setAttribute("bookList", bookService.findAll(pc, ps));
		
		return "f:/adminjsps/admin/book/list.jsp";
	}

	public String delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String bid = request.getParameter("bid");
		try {
			bookService.delete(bid);
		} catch (BookException e) {
			request.setAttribute("msg", e.getMessage());
			return "f:/adminjsps/msg.jsp";
		}
		return findAll(request, response);
	}
	
	/**
	 * 加载图书
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String load(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 加载指定图书
		 */
		String bid = request.getParameter("bid");

		/*
		 * 查询所有分类
		 */
		List<Category> categoryList = categoryService.findAll();
		/*
		 * 存放到requeset域中
		 */
		request.setAttribute("categoryList", categoryList);
		request.setAttribute("book", bookService.load(bid));

		return "f:/adminjsps/admin/book/desc.jsp";
	}

	/**
	 * 添加图书之前的方法
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String addPre(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * 查询所有分类
		 */
		request.setAttribute("categoryList", categoryService.findAll());
		return "f:/adminjsps/admin/book/add.jsp";
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
