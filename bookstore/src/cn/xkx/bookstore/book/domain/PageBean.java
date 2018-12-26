package cn.xkx.bookstore.book.domain;

import java.util.List;

public class PageBean<T>{
	private int pc;//当前页码，page code
//	private int tp;//总页数,total page
	private int tr;//总记录数，total record
	private int ps;//每页的记录数 page size
	private List<T> beanList;//当前页的记录
	private String url;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getPc() {
		return pc;
	}
	public void setPc(int pc) {
		this.pc = pc;
	}
	/*
	 * 计算总页数
	 */
	public int getTp() {
		int tp = tr/ps;
		if(tp == 0) {
			return 1;
		}
		return tr%ps==0?tp:tp+1;
	}
	public int getTr() {
		return tr;
	}
	public void setTr(int tr) {
		this.tr = tr;
	}
	public int getPs() {
		return ps;
	}
	public void setPs(int ps) {
		this.ps = ps;
	}
	public List<T> getBeanList() {
		return beanList;
	}
	public void setBeanList(List<T> beanList) {
		this.beanList = beanList;
	}
	
}
