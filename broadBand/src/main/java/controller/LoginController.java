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
			return "�˻�������";
		}else if(!admin.getPassword().equals(ad.getPassword())) {
			return "���벻��ȷ";
		}else if(admin.isPower()==false) {
			return "�˺���ͣ��";
		}
		session.setAttribute("isLogin", "true");
		session.setAttribute("loginName", ad.getName());
		//���ҿ쵽���û����������£�
		String tip = new String();
		//��ȡϵͳ��ǰʱ��
		Date date=new Date();
		long overtime = date.getTime()+(long)60*24*60*60*1000;
		java.sql.Date da= new java.sql.Date(overtime);
		List<User> listuser=us.getUserOverDate(da);
		Integer index=1;
		for(User user:listuser) {
			tip+=index.toString();
			tip+=":�û�'"+user.getUsername()+"'���뵽�ڻ��� "
			+(da.getTime()-user.getEndingdate().getTime())/(24*60*60*1000);
			tip+=" �� ";
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
