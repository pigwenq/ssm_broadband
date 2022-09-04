package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Orders;
import pojo.User;
import service.CreateUserService;
import service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService us;

	@Autowired
	CreateUserService cus;

	@GetMapping("user")
	public String toUser() {
		return "user";
	}

	@RequestMapping("getuser")
	@ResponseBody
	public List<User> toUser(String search, Model model) {
		List<User> list = us.getUserList(search, search);
		return list;
	}

	@RequestMapping("addUser")
	@ResponseBody
	public String addUser(@RequestBody User temp, HttpSession session) {
		if (us.getUserById(temp.getUserid()) != null) {
			return "����ʧ�ܣ��Ѱ����";
		}
		// user���󴴽�
		// ��ȡϵͳ��ǰʱ��
		Date date = new Date();
		long nowtime = date.getTime();
		java.sql.Date da = new java.sql.Date(nowtime);

		temp.setOpendate(da);

		// ���㵽��ʱ��
		long day = temp.getType() == 1 ? 30 : 365;
		long nexttime = nowtime + day * 24 * 60 * 60 * 1000;
		da = new java.sql.Date(nexttime);
		temp.setEndingdate(da);

		// ���ü��㣨һ��949��һ��45��
		double cost = temp.getType() == 1 ? 45 : 949;
		// ��������
		Orders order = new Orders();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String dat = sdf.format(nowtime);
		dat += nowtime;
		order.setId(dat);
		order.setUserid(temp.getUserid());
		order.setStartdate(temp.getOpendate());
		order.setCost(cost);
		order.setAdminname((String) session.getAttribute("loginName"));
		order.setTip("����");
		cus.createUser(temp, order);
		return "����ɹ�";
	}

	@GetMapping("delUser")
	@ResponseBody
	public String delUser(String userid, Model model) {
		if (us.delUser(userid) == 1)
			return "ɾ���ɹ�";
		else {
			return "ɾ��ʧ��";
		}
	}

	@GetMapping("selectUser")
	@ResponseBody
	public User selectUser(String userid, Model model) {
		User user = us.getUserById(userid);
		return user;
	}

	@RequestMapping("alterUser")
	@ResponseBody
	public String alterUser(@RequestBody User temp) {

		if (us.alterUser(temp) == 1)
			return "�޸ĳɹ�";
		else {
			return "�޸�ʧ��";
		}
	}

	@RequestMapping("selectOrder")
	@ResponseBody
	public Orders rechargeSelectUser(String userid, HttpSession session) {
		User user = us.getUserById(userid);
		Orders or = new Orders();
		if (user != null) {
			or.setStartdate(user.getEndingdate());
			or.setAdminname((String) session.getAttribute("loginName"));
			// ��������
			long day = user.getType() == 1 ? 30 : 365;
			long nexttime = user.getEndingdate().getTime() + day * 24 * 60 * 60 * 1000;
			java.sql.Date da = new java.sql.Date(nexttime);
			user.setEndingdate(da);
			or.setUser(user);
			if (user.getType() == 1) {
				or.setCost(45);
			} else {
				or.setCost(949);
			}
		}
		return or;
	}

	@RequestMapping("rechargeCommit")
	@ResponseBody
	public String rechargeCommit(@RequestBody Orders order) {
		  Date date = new Date(); 
		  long nowtime = date.getTime(); 
		  java.sql.Date da = new
		  java.sql.Date(nowtime); 
		  order.setStartdate(da);
		  
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String dat = sdf.format(nowtime);
			dat += nowtime;
			order.setId(dat);
		
		// ���㵽��ʱ��
		  order.getUser().setEndingdate(order.getUser().getEndingdate());
		  order.setTip("����");
		  cus.recharge(order.getUser(), order);
		return "���ѳɹ�";
	}
}
