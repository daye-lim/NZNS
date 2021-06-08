package org.dylim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.dylim.domain.Criteria;
import org.dylim.domain.ReplyVO;

public interface ReplyMapper {
	
	// insert
	public int insert(ReplyVO vo);
	
	// select(��ȸ)
	public ReplyVO read(Long bno);
	
	// delete
	public int delete (long rno);
	
	// update
	public int update(ReplyVO reply);
	
	// ����¡ ó��
	public List<ReplyVO> getListWithPaging( @Param("cri") Criteria cri, @Param("bno") Long bno);
	
	// bno�Խù��� ��ü��ۼ�
	public int getCountByBno(Long bno);
	

}