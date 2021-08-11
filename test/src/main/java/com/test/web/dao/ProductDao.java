package com.test.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSession sqlSession;

	public String getTest() {
		// TODO Auto-generated method stub
		System.out.println(sqlSession.selectList("ProductMapper.getTest"));
		return "";
	}
	
	public Map<String,Object> getList(Map<String, String> param){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("result", sqlSession.selectList("ProductMapper.getList", param));
		return map;
	}

	public int insert(Map<String, Object> list) {
		// TODO Auto-generated method stub
		return sqlSession.insert("ProductMapper.insert", list);
	}
	
	public int delete(Map<String,String> param) {
		return sqlSession.delete("ProductMapper.delete", param);
	}
	
	

}
