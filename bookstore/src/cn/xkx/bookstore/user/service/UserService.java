package cn.xkx.bookstore.user.service;

import cn.xkx.bookstore.book.domain.PageBean;
import cn.xkx.bookstore.user.dao.UserDao;
import cn.xkx.bookstore.user.domain.User;
/**
 * User业务层
 * @author XuKexiang
 *
 */
public class UserService {
	private UserDao userDao = new UserDao();
	/*
	 * 注册功能
	 */
	public void regist(User form) throws UserException
	{
		//校验用户名
		User user = userDao.findByUsername(form.getUsername());
		if(user != null) throw new UserException("此用户名已经被注册"); 
		//校验邮箱
	    user = userDao.findByEmail(form.getEmail());
		if(user != null) throw new UserException("此邮箱已经被注册"); 
		//插入用户到数据库
		userDao.add(form);
	}
	/*
	 * 激活功能
	 */
	public void active(String code) throws UserException
	{
		/*
		 * 使用code查询数据库，得到user
		 */
		User user = userDao.findByCode(code);
		/*
		 * 如果user不存在，说明激活码错误
		 */
		if(user == null) throw new UserException("激活码无效");
		/*
		 * 校验用户是否的状态是否为未激活状态，如果已经激活，说明重复激活，抛出异常
		 */
		if(user.isState()) throw new UserException("您已经激活过了");
		/*
		 * 修改用户状态 
		 */
		userDao.updateState(user.getUid(), true);
		
	}
	
	/*
	 * 登录功能
	 */
	public User login(User form) throws UserException
	{
		/*
		 * 1、用username查询，得到User
		 * 2、若username为null，抛出异常(用户名不存在)
		 * 3、比较form和user的密码，若不同，抛出异常（密码错误）
		 * 4、查看用户是否激活，若为false，抛出异常（未激活）
		 * 5、返回user
		 * 6、
		 */
		User user = userDao.findByUsername(form.getUsername());
		if(user == null) throw new UserException("用户名不存在");
		if(!user.getPassword().equals(form.getPassword())) 
			throw new UserException("密码错误,请重新输入");
		if(!user.isState()) throw new UserException("用户未激活");
		return user;
		
	}
	public PageBean<User> findAllUsers(int pc, int ps) {
		return userDao.findAllUsers(pc,ps);
	}
}
