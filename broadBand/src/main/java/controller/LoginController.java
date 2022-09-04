package controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Admin;
import pojo.User;
import service.AdminService;
import service.UserService;

@Controller
public class LoginController {

	@Autowired
	AdminService as;
	@Autowired
	UserService us;
	
	@GetMapping("login")
	public String toLogin() {
		return "login";
	}
	
	@PostMapping("login")
	@ResponseBody
	public String login(@RequestBody Admin ad,HttpSession session) {
		Admin admin=as.getAdminByName(ad.getName());
		if(admin==null) {
			return "账户不存在";
		}else if(!admin.getPassword().equals(ad.getPassword())) {
			return "密码不正确";
		}else if(admin.isPower()==false) {
			return "账号已停用";
		}
		session.setAttribute("isLogin", "true");
		session.setAttribute("loginName", ad.getName());
		//查找快到期用户（近两个月）
		String tip = new String();
		//获取系统当前时间
		Date date=new Date();
		long overtime = date.getTime()+(long)60*24*60*60*1000;
		java.sql.Date da= new java.sql.Date(overtime);
		List<User> listuser=us.getUserOverDate(da);
		Integer index=1;
		for(User user:listuser) {
			tip+=index.toString();
			tip+=":用户'"+user.getUsername()+"'距离到期还有 "
			+(da.getTime()-user.getEndingdate().getTime())/(24*60*60*1000);
			tip+=" 天 ";
			tip+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			index++;
		}
		session.setAttribute("tip", tip);
		session.setAttribute("type", admin.getType());
		return "true";
	}
	
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:login";
	}
}
