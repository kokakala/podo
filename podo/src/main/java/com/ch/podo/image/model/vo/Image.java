package com.ch.podo.image.model.vo;

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
public class Image {
	
	private int id;				// 이미지 번호
	private String path;		// 경로명
	private String originalName;// 원본 파일명
	private String changeName;	// 수정된 파일명
	private int type;			// 타입(자유게시판, 공지사항)이런식
	
	
	

}
