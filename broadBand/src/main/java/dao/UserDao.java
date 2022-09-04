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
	
	//���ڹ����û�
	@Select("select * from user where endingdate < #{endingdate}")
	public List<User> getUserOverDate(Date endingdate);
	
	//ɾ���û�
	@Delete("delete from user where userid = #{userid}")
	public int delUser(String userid);
	
	//�޸��û�
	@Update("update user set username=#{username},dorm=#{dorm},type=#{type} where userid=#{userid}")
	public int updateUser(User user);
	
	//�޸�����
	@Update("update user set endingdate=#{endingdate} where userid=#{userid}")
	public int updateDateUser(User user);
}
