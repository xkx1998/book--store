package cn.xkx.bookstore.book.service;

import java.util.List;

import cn.xkx.bookstore.book.dao.BookDao;
import cn.xkx.bookstore.book.domain.Book;
import cn.xkx.bookstore.book.domain.PageBean;

public class BookService {
	private BookDao bookDao = new BookDao();

	/**
	 * 查找所有图书
	 * 
	 * @return
	 */
	public PageBean<Book> findAll(Integer pc, Integer ps) {
		return bookDao.findAll(pc, ps);
	}

	/**
	 * 查找指定分类下的图书
	 * 
	 * @param cid
	 * @return
	 */
	public PageBean<Book> findByCategory(String cid, Integer pc, Integer ps) {
		return bookDao.findByCategory(cid, pc, ps);
	}

	/**
	 * 加载图书
	 * 
	 * @param bid
	 * @return
	 */
	public Book load(String bid) {
		return bookDao.findByBid(bid);
	}

	/**
	 * 添加图书
	 * 
	 * @param book
	 */
	public void add(Book book) {
		bookDao.add(book);
	}

	public void delete(String bid) throws BookException {
		boolean bool = bookDao.delete(bid);
		if (bool == false) {
			throw new BookException("该图书已在用户订单中，删除失败!");
		}
	}

	public PageBean<Book> searchBooks(String bookName, int pc, int ps) {
		return bookDao.searchBooks(bookName,pc,ps);
	}
}
