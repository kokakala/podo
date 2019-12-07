package com.ch.podo.notice.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.notice.model.vo.Notice;

public interface NoticeService {
	
	// 공지사항 총 개수 조회
	int getNoticeCount();
	
	// 현재 페이지에 보여질 리스트 조회
	Notice selectNoticeList();
	
	// 공지사항 작성
	int insertNotice(Notice n);
	
	// 공지사항 상세 조회
	Notice selectNotice(int id);
	
	// 수정 및 삭제 하려는 공지사항 조회
	Notice selectUpdateNotice(int id);
	
	// 공지사항 삭제
	int deleteNotice(int id);
	
	// 공지사항 수정
	int updateNotice(Notice n);
	
}
