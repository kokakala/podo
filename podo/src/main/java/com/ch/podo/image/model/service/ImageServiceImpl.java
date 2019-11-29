package com.ch.podo.image.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.image.model.dao.ImageDao;

@Service("imageService")
public class ImageServiceImpl implements ImageService {
	
	@Autowired
	private ImageDao imageDao;
	
}
