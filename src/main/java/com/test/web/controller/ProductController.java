package com.test.web.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.test.web.service.ProductService;
import com.test.web.service.Impl.ProductImpl;

@Controller
public class ProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	ProductImpl productService;
	
	
	Gson gson = new Gson();
	ObjectMapper mapper = new ObjectMapper();

	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public ModelAndView product() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("product");
		mv.addObject("menu", "product");
		return mv;
	}
	
	@RequestMapping(value = "/product2", method = RequestMethod.GET)
	public ModelAndView product2() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("product2");
		mv.addObject("menu", "product");
		return mv;
	}
	
	
	
	@RequestMapping(value ="/productList.do", method =RequestMethod.POST, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public Object productList(@RequestBody String param , HttpServletRequest request) throws Exception {
		
		//map.put("resultList", productService.getList());
		System.out.println("pram ==" + URLDecoder.decode(param, "UTF-8"));
		System.out.println("pram ==" + URLDecoder.decode(param , "EUC-KR"));
		Map<String, String> map = new HashMap<String, String>();
		if(param != null && !"".equals(param)) {
			map = mapper.readValue(param, Map.class);
		}
		System.out.println("map1 ==" + map);
		//Gson gson = new Gson();
        //JsonObject json = gson.toJsonTree(map).getAsJsonObject();
        JsonObject json = gson.toJsonTree(productService.getList(map)).getAsJsonObject();
        System.out.println("json ==" + json);
		//List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		//list.add(map);
        
		return json.toString();
	}
	
	@RequestMapping(value ="/productUpdate.do", method =RequestMethod.POST, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public Object productUpdate(@RequestBody String param , HttpServletRequest request) throws Exception {
		System.out.println("asdasdsaddsasa");
		
		// json ���� map���� ����
		ObjectMapper mapper = new ObjectMapper();
		//map.put("resultList", productService.getList());
		System.out.println("pram ==" + URLDecoder.decode(param , "UTF-8"));
		System.out.println("pram ==" + URLDecoder.decode(param , "EUC-KR"));
		System.out.println("productUpdate param ==" + param);
		List<Map<String, Object>> list = mapper.readValue(param, List.class);
		//Map<String, Object> map  = mapper.readValue(param, List.class);
		
		System.out.println("insert list  ==" + list);
		
		List<Map<String, Object>> failList = new ArrayList<Map<String,Object>>(); 
		
		for(int i=0;i<list.size();i++) {
			int result = 0;
			result = productService.insert(list.get(i));
			if(result <= 0) {
				failList.add(list.get(i));
			}
		}
		
        JsonArray json = gson.toJsonTree(failList).getAsJsonArray();
        System.out.println("json ==" + json);
        
		return json.toString();
		
	}
	
	@RequestMapping(value ="/productDelete.do", method =RequestMethod.POST, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public Object productDelete(@RequestBody String param) throws Exception {
		System.out.println("productDelete parma == " + param );
		
		
		List<String> list = mapper.readValue(param, List.class);
		List<String> failList = new ArrayList<String>(); 
		for(int i=0;i<list.size();i++) {
			int result = 0;
			Map<String,String> map = new HashMap<String, String>();
			map.put("param", list.get(i));
			result = productService.delete(map);
			if(result <= 0) {
				failList.add(list.get(i));
			}
		}
		
		JsonArray json = gson.toJsonTree(failList).getAsJsonArray();
		
		return json.toString();
	}

	
}
