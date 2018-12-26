package cn.xkx.bookstore.cart.domain;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
	private Map<String, CartItem> map = new LinkedHashMap<String, CartItem>();

	/**
	 * 计算总金额
	 * 
	 * @return
	 */
	public double getTotal() {
		double total = 0;
		for (CartItem cartItem : map.values()) {
			total += cartItem.getSubtotal();
		}
		return total;
	}

	/**
	 * 添加条目到车中
	 * 
	 * @param cartItem
	 */
	public void add(CartItem cartItem) {
		if (map.containsKey(cartItem.getBook().getBid())) // 判断购物车中是否存在该条目
		{
			CartItem _cartItem = map.get(cartItem.getBook().getBid()); // 得到原来的条目
			_cartItem.setCount(_cartItem.getCount() + cartItem.getCount());
			map.put(cartItem.getBook().getBid(), _cartItem);
		} else {
			map.put(cartItem.getBook().getBid(), cartItem);
		}
	}

	public void addOne(String bid) {
		if (map.containsKey(bid)) // 判断购物车中是否存在该条目
		{
			CartItem _cartItem = map.get(bid); // 得到原来的条目
			_cartItem.setCount(_cartItem.getCount() + 1);
			map.put(bid, _cartItem);
		}
	}

	public void deleteOne(String bid) {
		if (map.containsKey(bid)) // 判断购物车中是否存在该条目
		{
			CartItem _cartItem = map.get(bid); // 得到原来的条目
			if (_cartItem.getCount() == 1) {
				delete(bid);
			} else {
				_cartItem.setCount(_cartItem.getCount() - 1);
				map.put(bid, _cartItem);
			}
		}
	}

	/**
	 * 清空购物车
	 */
	public void clear() {
		map.clear();
	}

	/**
	 * 删除条目
	 * 
	 * @param bid
	 */
	public void delete(String bid) {
		map.remove(bid);
	}

	/**
	 * 获取所有条目
	 * 
	 * @return
	 */
	public Collection<CartItem> getCartItems() {
		return map.values();
	}
}
