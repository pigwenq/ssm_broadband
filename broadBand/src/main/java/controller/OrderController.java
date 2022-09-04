package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Orders;
import pojo.User;
import service.OrderService;

@Controller
public class OrderController {

	@Autowired
	OrderService os;
	
	@GetMapping("order")
	public String toOrder() {
		return "order";
	}
	
	@PostMapping("order")
	@ResponseBody
	public List<Orders> getOrder(@RequestBody User user){
		List<Orders> list= os.getOrderList(user);
		return list;
	}
	
	@GetMapping("delOrder")
	@ResponseBody
	public boolean delOrder(String id) {
		return os.delOrder(id);
		
	}
}
