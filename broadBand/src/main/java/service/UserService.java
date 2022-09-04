package service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import pojo.User;

@Service
public class UserService {
	@Autowired
	UserDao ud;
	
	public List<User> getUserList(String username,String id){
		return ud.getUserList(username, id);
	}
	public User getUserById(String id) {
		return ud.getUserById(id);
	}
	public int insertUser(User user1) {
		return ud.insertUser(user1);
	}
	public List<User> getUserOverDate(Date endingdate){
		return ud.getUserOverDate(endingdate);
	}
	public int delUser(String userid) {
		return ud.delUser(userid);
	}
	public int alterUser(User user) {
		return ud.updateUser(user);
	}
}
