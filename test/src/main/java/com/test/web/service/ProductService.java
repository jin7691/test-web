package com.test.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


public interface ProductService {

	String getTest();
	
	Map<String, Object> getList(Map<String, String> map) throws Exception;
	
	int insert(Map<String, Object> map) throws Exception;
	
	int delete(Map<String,String> param) throws Exception;

}
