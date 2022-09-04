package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Admin;
import pojo.User;
import service.AdminService;

@Controller
public class LoginManageController {
	
	@Autowired
	AdminService as;
	
	@RequestMapping("loginManage")
	public String toLoginManage() {
		return "loginManage";
		
	}
	
	@RequestMapping("getLogin")
	@ResponseBody
	public List<Admin> getLogin(String name){
		name=name==null?"":name;
		List<Admin> list = as.getAdminList(name);
		return list;
	}
	
	
	@RequestMapping("alterPower")
	@ResponseBody
	public boolean alterPower(String name){
		boolean power = as.getAdminByName(name).isPower();
		return as.alterPower(name,!power);
	}
	
	@RequestMapping("addAdmin")
	@ResponseBody
	public String addAdmin(@RequestBody Admin admin) {
		
		if(as.getAdminByName(admin.getName())!=null) {
			return "账号已存在";
		}else {
			if(as.insertAdmin(admin.getName(),admin.getPassword(), 2)==1) {
				return "添加成功";
			}else {
				return "添加失败";
			}
		}
	}
}
