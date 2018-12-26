package cn.xkx.bookstore.cart.domain;

import cn.xkx.bookstore.book.domain.Book;

/**
 * 购物车条目类
 * @author XuKexiang
 *
 */
public class CartItem {
	private Book book; //商品
	private int count; //数量
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	//小计，没有对应的成员
	public double getSubtotal()
	{
		return book.getPrice()*count;
	}
	@Override
	public String toString() {
		return "CartItem [book=" + book + ", count=" + count + "]";
	}
	
}
