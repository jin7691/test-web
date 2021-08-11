package com.test.web.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.test.web.dao.ProductDao;
import com.test.web.service.ProductService;

@Service
public class ProductImpl implements ProductService {
	
	@Autowired
	ProductDao productDao;

	@Override
	public String getTest() {
		
		return productDao.getTest();
	}
	
	@Override
	public Map<String, Object> getList(Map<String, String> map) throws Exception{
		return productDao.getList(map);
		
	}

	@Override
	public int insert(Map<String, Object> list) throws Exception {
		// TODO Auto-generated method stub
		return productDao.insert(list);
	}
	
	@Override
	public int delete(Map<String,String> param) throws Exception {
		return productDao.delete(param);
	}
	
	

}
