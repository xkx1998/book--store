package cn.xkx.bookstore.book.web.servlet.admin;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.itcast.commons.CommonUtils;
import cn.xkx.bookstore.book.domain.Book;
import cn.xkx.bookstore.book.service.BookService;
import cn.xkx.bookstore.category.domain.Category;

public class AdminAddBookServlet extends HttpServlet {
	private BookService bookService = new BookService();
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		/*
		 * 上传3步
		 */
		//创建工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//得到解析器
		ServletFileUpload sfu = new ServletFileUpload(factory);
		//解析request对象,得到List<FileItem>
		try {
			List<FileItem> fileItemList = sfu.parseRequest(request);
			/*
			 * 把fileItemList中的数据封装到Book对象中
			 *  >先把普通的表单项放到Map中
			 *  >再把Map中的数据放到Book对象中
			 */
			Map<String, String> map = new HashMap<String, String>();
			for(FileItem fileItem : fileItemList){
				if(fileItem.isFormField()) {
					map.put(fileItem.getFieldName(), fileItem.getString("UTF-8"));
				}
			}
			//封装表单数据
			Book book = CommonUtils.toBean(map, Book.class);
			
			Category category = CommonUtils.toBean(map, Category.class);
			 
			book.setCategory(category);
			
			book.setBid(CommonUtils.uuid());
			/*
			 * 保存上传文件
			 *  >保存的目录
			 *  >保存的文件名称
			 */			
			//保存文件目录
			String savepath = this.getServletContext().getRealPath("book_img");
			 //得到文件名
			String filename = CommonUtils.uuid() + "_" + fileItemList.get(1).getName();
			//用文件目录和文件名创建目标文件
			File destFile = new File(savepath, filename);
			//把上传文件放在指定的目录下
			fileItemList.get(1).write(destFile);
			
			/*
			 * 设置Book对象的image属性(相对路径)
			 */
			book.setImage("book_img/" + filename);
			
			/*
			 * 调用bookService保存book
			 */
			bookService.add(book);
			
			/*
			 * 访问AdminBookServlet的findAll方法显示全部图书
			 */
			request.getRequestDispatcher("/admin/AdminBookServlet?method=findAll").forward(request, response);
			
		} catch (Exception e) {
		}
	}

}
