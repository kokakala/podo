package com.ch.podo.detailFilm.model.service;

import java.util.ArrayList;

import com.ch.podo.detailFilm.model.vo.Actor;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.review.model.dto.Review;

public interface DetailFilmService {
	
	// 1. 영화 상세정보 보기 서비스	-- (영화 번호)
	DetailFilm selectDetailFilm(int filmId);
	
	// 1_2. 영화 상세정보 볼때 리뷰 리스트 -- (영화 번호)
	ArrayList<Review> selectReivewList(int filmId);
	
	// 1_3. 영화 상세정보 볼때 이미지 -- (영화 상세 번호)
	Image selectFilmImage(int id);
	
	// 2. 영화 상세정보 수정 자료 입력 -- (영화 상세 자료, userId)
	int detailFilmInsert(DetailFilm df, int uId);

	// 2_1. 영화 상세정보 배우 리스트 출력
	ArrayList<Actor> selectActorList(int id);
	
	// 2_2. 배우 등록 --(배우 번호, 영화 상세 번호)
	int addActor(int newActorId, int id);
	
	// 2_3. 배우 삭제 --(배우 번호, 영화 상세 번호)
	int deleteActor(int actorId, int id);

	// 2_4. 배우 검색 리스트 출력-- (영화 번호, 검색어)
	ArrayList<Actor> searchActorList(String searchName);
	
	// 2_5. 영화 포스터 수정 입력 -- (영화 포스터 이미지, 영화 상세번호)
	int filmImageInsert(String filmImage, int id, int filmId);

	// 2_6. 영화 배우 수정 입력 -- (배우 번호(String), 영화 상세번호)
	int actorInsert(String actorIdList);
	
	// 2_7. 영화 데이터 롤백 버튼 --(영화 번호)
	int detailFilmRollback(int filmId);

	
	
}
