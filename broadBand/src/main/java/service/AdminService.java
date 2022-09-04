package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdminDao;
import pojo.Admin;

@Service
public class AdminService {
	
	@Autowired
	AdminDao dao;
	
	public Admin getAdminByName(String name) {
		return dao.getAdminByName(name);
	}
	
	public int insertAdmin(String name,String password,int type) {
		return dao.insertAdmin(name, password, type);
	}
	
	public List<Admin> getAdminList(String name){
		return dao.getAdminList(name);
	}
	public boolean alterPower(String name,Boolean power) {
		return dao.alterPower(name,power)==1?true:false;
	}
}
