package org.dylim.service;

import java.util.List;


import org.dylim.domain.BoardAttachVO;
import org.dylim.domain.BoardVO;
import org.dylim.domain.Criteria;

public interface BoardService {
	
	// 게시글 등록
	public void register(BoardVO board);
	
	// 게시글 조회
	public BoardVO get(Long bno);			// returnType=BoardVO
	
	// 게시글 수정
	public boolean modify(BoardVO board);
	
	// 게시글 삭제
	public boolean remove(Long bno);
	
	// 게시글 추천
	public void recommend(Long bno);
	
	// 게시물 목록 조회
//	public List<BoardVO> getList();			// returnType=List<BoardVO>
	
	// 게시물 목록 조회 (페이징)
	public List<BoardVO> getList(Criteria cri);
	
	// 전체 게시물의 수(total)를 구하는 메서드
	public int getTotal(Criteria cri);
	
	// 게시물 첨부파일 목록 조회
	public List<BoardAttachVO> getAttachList(Long bno);
	
	
	// 게시물 목록 조회
	public List<BoardVO> BestReviews();			// returnType=List<BoardVO>

}
