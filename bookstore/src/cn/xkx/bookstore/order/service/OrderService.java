package cn.xkx.bookstore.order.service;

import java.sql.SQLException;
import java.util.List;

import cn.itcast.jdbc.JdbcUtils;
import cn.xkx.bookstore.book.domain.Book;
import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.order.dao.OrderDao;
import cn.xkx.bookstore.order.domain.Order;

public class OrderService {
	private OrderDao orderDao = new OrderDao();
	
	/**
	 * 添加订单
	 * 需要处理的事务
	 * @param order
	 */
	public void addOrder(Order order)
	{
		try {
			//开始事务
			JdbcUtils.beginTransaction();
			orderDao.addOrder(order); //插入订单
			orderDao.addOrderItemList(order.getOrderItemList());  //插入订单的所有条目
			//提交事务
			JdbcUtils.commitTransaction();
		} catch (Exception e) {
			//回滚事务
			try {
				JdbcUtils.rollbackTransaction();
			} catch (SQLException e1) {
			}
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 我的订单
	 * @param uid
	 * @return
	 */
	public List<Order> myOrders(String uid) {
		return orderDao.findByUid(uid);
	}

	/**
	 * 加载订单
	 * @param parameter
	 * @return
	 */
	public Order load(String oid) {
		return orderDao.load(oid);
	}
	
	/**
	 * 确认收货
	 * @param oid
	 * @throws OrderException
	 */
	public void confirm(String oid) throws OrderException
	{
		/*
		 * 校验订单状态，如果不是，抛出异常
		 */
		int state = orderDao.getStateByOid(oid); //获取订单状态
		if(state!=3)
		{
			throw new OrderException("确认收货失败!");
		}
		else {
			orderDao.update(oid, 4);
		}
	}
	
	/**
	 * 发货
	 * @param oid
	 * @throws OrderException
	 */
	public void send(String oid) throws OrderException
	{
		/*
		 * 校验订单状态，如果不是，抛出异常
		 */
		int state = orderDao.getStateByOid(oid); //获取订单状态
		if(state!=2)
		{
			throw new OrderException("发货失败!");
		}
		else {
			orderDao.update(oid, 3);
		}
	}
	
	/**
	 * 支付方法
	 * @param oid
	 */
	public void zhiFu(String oid)
	{
		/*
		 * 判断订单的状态是否为1
		 *  为1则修改订单状态
		 *  不为1什么也不用做
		 */
		int state = orderDao.getStateByOid(oid);
		if(state == 1)
		{
			/*
			 * 修改订单状态
			 */
			orderDao.update(oid, 2);
			
		}
	}

	public PageBean<Order> findAllOrders(Integer state, int pc, int ps) {
		return orderDao.findAllOrders(state,pc , ps);
	}
}
