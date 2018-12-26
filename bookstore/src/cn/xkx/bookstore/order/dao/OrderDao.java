package cn.xkx.bookstore.order.dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;
import cn.xkx.bookstore.book.domain.Book;
import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.order.domain.Order;
import cn.xkx.bookstore.order.domain.OrderItem;

public class OrderDao {
	private QueryRunner qr = new TxQueryRunner();

	/**
	 * 添加订单
	 * 
	 * @param order
	 */
	public void addOrder(Order order) {
		try {
			String sql = "insert into orders values(?,?,?,?,?,?)";
			/*
			 * 处理util的Date转换为sql的Timestamp
			 */
			Timestamp timestamp = new Timestamp(order.getOrdertime().getTime());
			Object[] params = { order.getOid(), timestamp, order.getTotal(), order.getState(),
					order.getOwner().getUid(), order.getAddress() };
			qr.update(sql, params);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 插入订单条目
	 * 
	 * @param orderItemList
	 */
	public void addOrderItemList(List<OrderItem> orderItemList) {

		try {
			String sql = "insert into orderitem values(?,?,?,?,?)";
			/*
			 * 把orderItemList转换成二维数组 把一个OrderItem对象转换成一个一维数组
			 * 
			 */
			Object[][] params = new Object[orderItemList.size()][];
			// 循环遍历orderItemList,使用每个orderItem对象为params中每一个一维数组赋值
			for (int i = 0; i < orderItemList.size(); i++) {
				OrderItem orderItem = orderItemList.get(i);
				params[i] = new Object[] { orderItem.getIid(), orderItem.getCount(), orderItem.getSubtotal(),
						orderItem.getOrder().getOid(), orderItem.getBook().getBid() };
			}
			qr.batch(sql, params);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 查询用户订单
	 * 
	 * @param uid
	 * @return
	 */
	public List<Order> findByUid(String uid) {
		/*
		 * 1、通过uid查询出当前用户的全部订单 2、循环遍历每个Order，为其加载它的所有orderItem
		 */
		try {
			/*
			 * 查询当前用户的全部订单
			 */
			String sql = "select * from orders where userid =?";
			List<Order> orderList = qr.query(sql, new BeanListHandler<Order>(Order.class), uid);
			System.out.println(orderList);
			/*
			 * 循环遍历每个order为其加载它自己所有的订单条目
			 */
			for (Order order : orderList) {
				loadOrderItems(order);
			}
			return orderList;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 加载指定的订单的所有条目
	 * 
	 * @param order
	 * @throws SQLException
	 */
	private void loadOrderItems(Order order) throws SQLException {

		// 查询两张表: orderItem、book
		String sql = "select * from orderitem i , book b where i.bid=b.bid and oid=?";
		/*
		 * 一行结果集对应的不是一个javabean，不能使用BeanHandlerList,要使用MapListHandler
		 */
		List<Map<String, Object>> mapList = qr.query(sql, new MapListHandler(), order.getOid());
		/*
		 * mapList是多个map，每个map对应一个结果集，就是一行
		 * 
		 * 用一个map生成两个对象，就是book和orderItem，然后建立两者的关系,把Book设置给orderItems
		 */
		/*
		 * 循环遍历每个Map，使用map生成两个对象，然后建立关系(最终结果为一个OrderItem)，把Orderitem保存起来
		 */

		List<OrderItem> orderItemList = toOrderItemList(mapList);
		order.setOrderItemList(orderItemList);
	}

	/**
	 * 把mapList中的每个Map转换成两个对象，并建立关系
	 * 
	 * @param mapList
	 * @return
	 */
	private List<OrderItem> toOrderItemList(List<Map<String, Object>> mapList) {
		List<OrderItem> orderItemList = new ArrayList<OrderItem>();
		for (Map<String, Object> map : mapList) {
			OrderItem item = toOrderItem(map);
			orderItemList.add(item);
		}
		return orderItemList;
	}

	/**
	 * 把一个Map转换成一个OrderItem对象,并建立关系
	 * 
	 * @param map
	 * @return
	 */
	private OrderItem toOrderItem(Map<String, Object> map) {
		OrderItem orderItem = CommonUtils.toBean(map, OrderItem.class);
		Book book = CommonUtils.toBean(map, Book.class);
		orderItem.setBook(book);
		return orderItem;
	}

	/**
	 * 加载订单
	 * 
	 * @param oid
	 * @return
	 */
	public Order load(String oid) {
		try {

			/*
			 * 查询指定订单
			 */
			String sql = "SELECT * FROM orders WHERE oid=?";
			Order order = qr.query(sql, new BeanHandler<Order>(Order.class), oid);

			/*
			 * 加载订单条目
			 */
			loadOrderItems(order);

			/*
			 * 返回订单
			 */
			return order;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 通过oid查询订单状态
	 * 
	 * @param oid
	 * @return
	 */
	public int getStateByOid(String oid) {
		try {
			String sql = "select state from orders where oid=?";
			return (Integer) qr.query(sql, new ScalarHandler(), oid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 修改订单状态
	 * 
	 * @param oid
	 * @param state
	 */
	public void update(String oid, int state) {
		try {
			String sql = "update orders set state=? where oid=?";
			qr.update(sql, state, oid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public PageBean<Order> findAllOrders(Integer state, int pc, int ps) {
		try {
			String sql;
			PageBean<Order> pb = new PageBean<Order>();

			pb.setPc(pc);
			pb.setPs(ps);

			String tr_sql = "select count(*) from orders where state = ?";
			Number number = (Number) qr.query(tr_sql, new ScalarHandler(), state);
			int tr = number.intValue();
			pb.setTr(tr);
			if (state == 0) {
				sql = "select * from orders limit ? ,?";
				Object[] params = { ps * (pc - 1), ps };
				List<Order> beanList = qr.query(sql, new BeanListHandler<Order>(Order.class), params);

				for (Order order : beanList) {
					loadOrderItems(order);
				}
				pb.setBeanList(beanList);
			} else {
				sql = "select * from orders where state = ? limit ? ,?";
				Object[] params = { state, ps * (pc - 1), ps };
				List<Order> beanList = qr.query(sql, new BeanListHandler<Order>(Order.class), params);
				for (Order order : beanList) {
					loadOrderItems(order);
				}
				pb.setBeanList(beanList);
			}

			return pb;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
