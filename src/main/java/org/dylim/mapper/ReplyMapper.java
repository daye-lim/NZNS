package org.dylim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.dylim.domain.Criteria;
import org.dylim.domain.ReplyVO;

public interface ReplyMapper {
	
	// insert
	public int insert(ReplyVO vo);
	
	// select(조회)
	public ReplyVO read(Long bno);
	
	// delete
	public int delete (long rno);
	
	// update
	public int update(ReplyVO reply);
	
	// 페이징 처리
	public List<ReplyVO> getListWithPaging( @Param("cri") Criteria cri, @Param("bno") Long bno);
	
	// bno게시물의 전체댓글수
	public int getCountByBno(Long bno);
	

}