package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.OrderDao;
import pojo.Orders;
import pojo.User;

@Service
public class OrderService {
	
	@Autowired
	OrderDao dao; 
	
	public List<Orders> getOrderList(User user){
		return dao.getOrderList(user);
	}
	
	public boolean delOrder(String id) {
		return dao.delOrder(id)==1?true:false;
	}
}
