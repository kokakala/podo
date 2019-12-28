package com.ch.podo.common;

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
	
	private int id;					// 이미지 번호
	private String path;			// 경로명
	private String originalName;	// 원본 파일명
	private String changeName;		// 수정된 파일명
	private int type;				// 타입(자유게시판, 공지사항)이런식
	private int boardId; 			// 참조 게시판 번호
	private int noticeId; 			// 참조 공지사항 번호
	private int detailFilmId;		// 영화 상세정보 ID
	private int filmId;	// 영화 번호
}
