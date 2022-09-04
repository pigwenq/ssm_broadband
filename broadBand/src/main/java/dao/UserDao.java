package dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import pojo.User;

@Repository
public interface UserDao {
	
	@Select("select * from user where username like concat('%',#{arg0},'%') "
			+ " or userid like concat('%',#{arg1},'%') order by opendate desc")
	public List<User> getUserList(String username,String userid);
	
	@Select("select * from user where userid=#{userid}")
	public User getUserById(String userid);
	
	@Insert("insert into user values(#{userid},#{username},#{dorm},#{opendate},#{endingdate},#{type})")
	public int insertUser(User user);
	
	//近期过期用户
	@Select("select * from user where endingdate < #{endingdate}")
	public List<User> getUserOverDate(Date endingdate);
	
	//删除用户
	@Delete("delete from user where userid = #{userid}")
	public int delUser(String userid);
	
	//修改用户
	@Update("update user set username=#{username},dorm=#{dorm},type=#{type} where userid=#{userid}")
	public int updateUser(User user);
	
	//修改日期
	@Update("update user set endingdate=#{endingdate} where userid=#{userid}")
	public int updateDateUser(User user);
}
