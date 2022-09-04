package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import pojo.Orders;
import pojo.User;

@Repository
public interface OrderDao {
	@Insert("insert into Orders values(#{id},#{userid},#{startdate},#{cost},#{adminname},#{tip})")
	public int insertOrder(Orders order);
	
	public List<Orders> getOrderList(User user);
	
	@Delete("delete from orders where id = #{id}")
	public int delOrder(String id);
}
