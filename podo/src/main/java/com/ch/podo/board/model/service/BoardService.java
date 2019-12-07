package com.ch.podo.board.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.report.model.vo.Report;

public interface BoardService {
	
	// 게시판 총 개수 조회
	int getBoardCount();
	
	// 현재 페이지에 보여지는 게시글 리스트 조회
	ArrayList<Board> selectBoardList(PageInfo pi);
	
	// 게시판 작성
	int insertBoard(Board board);
	
	// 게시판 상세 조회
	Board selectBoard(int id);
	
	// 수정 및 삭제하고자 하는 게시판 조회
	Board selectUpdateBoard(int id);
	
	Image selectUpdateBoardFile(int id);
	
	// 게시판 삭제
	int deleteBoard(int id);
	
	// 게시판 수정
	int updateBoard(Board b);
	
	int updateBoardFile(Image i);
	
	
	// --- 댓글 ---
	// 댓글 리스트
	ArrayList<Comment> selectCommentList(int id);
	
	// 댓글 작성
	int insertComment(Comment c);
	
	// 댓글 수정
	int updateComment(int id, String content);
	
	// 댓글 삭제
	int deleteComment(int id);

	// 메인 홈 자유게시판 리스트
	ArrayList<Board> selectboardListHome();
	
	
	// 게시물 신고
	int insertInappro(Report r);
	
	
}
