package com.test.web.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.web.dao.MainDao;
import com.test.web.service.MainService;

@Service
public class MainImpl implements MainService {
	
	@Autowired
	MainDao mainDao;

	@Override
	public Map<String, Object> getList(Map<String, String> map) throws Exception{
		return mainDao.getList(map);
		
	}

	@Override
	public int insert(Map<String, Object> list) throws Exception {
		// TODO Auto-generated method stub
		return mainDao.insert(list);
	}
	
	@Override
	public int delete(Map<String,String> param) throws Exception {
		return mainDao.delete(param);
	}

}
