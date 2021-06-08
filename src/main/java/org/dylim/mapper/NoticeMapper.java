package org.dylim.mapper;

import java.util.List;


import org.dylim.domain.Criteria;
import org.dylim.domain.NoticeVO;

public interface NoticeMapper {
	// 전체 목록 조회 
	public List<NoticeVO> getList();
	
	// 전체 목록 조회 (페이징)
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	// 전체 게시물의 수(total)를 구하는 메서드
	public int getTotalCount(Criteria cri);
	
	// 글쓰기 (insert-PK값 알필요X)
	public void insert(NoticeVO notice);
	
	//  (insert-PK값 알필요O)
	public void insertSelectKey(NoticeVO notice);
	
	
	// 글조회 (select)
	public NoticeVO read(Long nno);
	
	// 글삭제 (delete)
	public int delete(Long nno);	// 정상적으로 데이터 삭제 시 1이상의 값을 가짐 (몇개의 데이터가 삭제되었는지)
	
	// 글수정 (update)
	public int update(NoticeVO notice);	// 몇개의 데이터가 수정되었는지 처리 가능한 int타입 메서드
	


}
