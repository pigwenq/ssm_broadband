package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import dao.OrderDao;
import dao.UserDao;
import pojo.Orders;
import pojo.User;

@Service
public class CreateUserService {
	@Autowired
	UserDao ud;
	@Autowired
	OrderDao od;
	
	@Transactional(propagation = Propagation.REQUIRED,
            isolation = Isolation.DEFAULT)
	public void createUser(User user,Orders order) {
		ud.insertUser(user);
		od.insertOrder(order);
	}
	
	@Transactional
	public void recharge(User user,Orders order) {
		ud.updateDateUser(user);
		od.insertOrder(order);
	}
}
