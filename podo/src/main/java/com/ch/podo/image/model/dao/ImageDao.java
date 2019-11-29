package com.ch.podo.image.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("imageDao")
public class ImageDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
}
