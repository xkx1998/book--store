package cn.xkx.bookstore.category.service;

import java.util.List;

import cn.xkx.bookstore.book.dao.BookDao;
import cn.xkx.bookstore.category.dao.CategoryDao;
import cn.xkx.bookstore.category.domain.Category;
import cn.xkx.bookstore.category.web.servlet.admin.CategoryException;

public class CategoryService {
	private CategoryDao categoryDao = new CategoryDao();
	private BookDao bookDao = new BookDao();
	public List<Category> findAll() {
		return categoryDao.findAll();
	}

	public void add(Category category) {
		categoryDao.add(category);
	}

	public void delete(String cid) throws CategoryException {
		int count = bookDao.getCountByCid(cid); //获取该分类下的图书的数量
		if(count > 0) throw new CategoryException("该分类下有图书，不能删除");  //若该分类下有图书，则跑出异常
		
		categoryDao.delete(cid);
	}

	public Category load(String cid) {
		
		return categoryDao.load(cid);
	}

	public void edit(Category category) {
		categoryDao.edit(category);
	}
}
