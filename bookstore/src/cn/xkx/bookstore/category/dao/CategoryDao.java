package cn.xkx.bookstore.category.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.junit.Test;

import cn.itcast.jdbc.TxQueryRunner;
import cn.xkx.bookstore.category.domain.Category;

public class CategoryDao {
	private QueryRunner qr = new TxQueryRunner();

	/**
	 * 查询所有分类
	 * 
	 * @return
	 */
	public List<Category> findAll() {
		String sql = "select * from category";
		try {
			List<Category> categories = (List<Category>) qr.query(sql, new BeanListHandler<Category>(Category.class));
			return categories;
		} catch (SQLException e) {
			throw new RuntimeException();
		}
	}

	/**
	 * 添加分类
	 * 
	 * @param category
	 */
	public void add(Category category) {
		String sql = "insert into category values(?,?)";
		try {
			qr.update(sql, (int)(1+Math.random()*10) , category.getCname());
		} catch (SQLException e) {
			throw new RuntimeException();
		}
	}

	/**
	 * 删除分类
	 * @param cid
	 */
	public void delete(String cid) {
		String sql = "delete from category where cid=?";
		try {
			qr.update(sql, cid);
		} catch (SQLException e) {
			throw new RuntimeException();
		}
	}

	/**
	 * 修改分类之前的加载方法
	 * @param cid
	 * @return
	 */
	public Category load(String cid) {
		System.out.println("cid="+cid);
		String sql = "select * from category where cid=?";
		try {
			return qr.query(sql, new BeanHandler<Category>(Category.class),cid);
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		
	}

	public void edit(Category category) {
		String sql = "update category set cname=? where cid=?";
		try {
			qr.update(sql,category.getCname(),category.getCid());
		} catch (SQLException e) {
			throw new RuntimeException();
		}
	}
}
