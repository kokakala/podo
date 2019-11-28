package com.ch.podo.collection.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.collection.model.dao.CollectionDao;

@Service("collectionService")
public class CollectionServiceImpl implements CollectionService{

	@Autowired
	private CollectionDao collectionDao;
	
}
