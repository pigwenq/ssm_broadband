package pojo;

import java.sql.Date;
import java.util.List;

public class User {
	String userid;
	String username;
	String dorm;
	Date opendate;
	Date endingdate;
	int type;
	
	List<Orders> orders;

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDorm() {
		return dorm;
	}
	public Date getOpendate() {
		return opendate;
	}
	public void setOpendate(Date opendate) {
		this.opendate = opendate;
	}
	public Date getEndingdate() {
		return endingdate;
	}
	public void setEndingdate(Date endingdate) {
		this.endingdate = endingdate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public List<Orders> getOrders() {
		return orders;
	}
	public void setOrders(List<Orders> orders) {
		this.orders = orders;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserid() {
		return userid;
	}
	public void setDorm(String dorm) {
		this.dorm = dorm;
	}
	
}
