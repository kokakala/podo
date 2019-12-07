package com.ch.podo.notice.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Notice {
	
	private int id;
	private String title;
	private String content;
	private int viewCount;
	private Date createDate;
	private Date modifyDate;	
	private String status;
	
	private int imageId;
	private int adminId;
	
	private String imageName;
	private String nickName;


}
