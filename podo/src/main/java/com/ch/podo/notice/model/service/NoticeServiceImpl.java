package com.ch.podo.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.notice.model.dao.NoticeDao;
import com.ch.podo.notice.model.vo.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int getNoticeCount() {
		return noticeDao.getNoticeCount();
	}

	@Override
	public Notice selectNoticeList() {
		return noticeDao.selectNoticeList();
	}

	@Override
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(n);
	}

	@Override
	public Notice selectNotice(int id) {
		
		int result = noticeDao.updateCount(id);
		
		if(result > 0) {
			return noticeDao.selectNotice(id);
		}else {
			return null;
		}
	}

	@Override
	public Notice selectUpdateNotice(int id) {
		return noticeDao.selectNotice(id);
	}

	@Override
	public int deleteNotice(int id) {
		return noticeDao.deleteNotice(id);
	}

	@Override
	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(n);
	}

	
	
}
