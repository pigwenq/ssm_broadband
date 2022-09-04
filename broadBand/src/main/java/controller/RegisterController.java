package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Admin;
import service.AdminService;

@Controller
public class RegisterController {
	
	@Autowired
	AdminService as;
	
	@GetMapping("register")
	public String toRegister(){
		return "register";
	}
	
	@PostMapping("register")
	@ResponseBody
	public String check(@RequestBody Admin admin) {
		if(as.getAdminByName(admin.getName())!=null) {
			return "�˺��Ѵ���";
		}else {
			if(as.insertAdmin(admin.getName(), admin.getPassword(), 1)==1) {
				return "ע��ɹ�";
			}else {
				return "ע��ʧ��";
			}
		}
	}
}
