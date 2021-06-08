package org.dylim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.dylim.domain.BoardVO;
import org.dylim.domain.Criteria;

public interface BoardMapper {
	
	// 전체 목록 조회 
	public List<BoardVO> getList();
	
	// 전체 목록 조회 (페이징)
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 전체 게시물의 수(total)를 구하는 메서드
	public int getTotalCount(Criteria cri);
	
	// 글쓰기 (insert-PK값 알필요X)
	public void insert(BoardVO board);
	
	//  (insert-PK값 알필요O)
	public void insertSelectKey(BoardVO board);
	
	
	// 글조회 (select)
	public BoardVO read(Long bno);
	
	// 글삭제 (delete)
	public int delete(Long bno);	// 정상적으로 데이터 삭제 시 1이상의 값을 가짐 (몇개의 데이터가 삭제되었는지)
	
	// 글수정 (update)
	public int update(BoardVO board);	// 몇개의 데이터가 수정되었는지 처리 가능한 int타입 메서드
	
	// 게시글추천
	public void recommend(Long bno);
	
	// 댓글과 댓글 수에 대한 처리
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	
	public List<BoardVO> BestReviews();


}
