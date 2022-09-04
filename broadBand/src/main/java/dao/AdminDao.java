package dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import pojo.Admin;

@Repository
public interface AdminDao {
	@Select("select * from admin where name=#{name}")
	public Admin getAdminByName(String name);
	
	@Insert("insert into admin(name,password,type) values(#{arg0},#{arg1},#{arg2})")
	public int insertAdmin(String name,String password, int type);
	
	@Select("select * from admin where name like concat('%',#{name},'%') and type = 2")
	public List<Admin> getAdminList(String name);

	@Update("update admin set power=#{arg1} where name =#{arg0}")
	public int alterPower(String name,Boolean power) ;
}