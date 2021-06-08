package org.dylim.service;

import java.util.List;

import org.dylim.domain.Criteria;
import org.dylim.domain.ReplyPageDTO;
import org.dylim.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	// ´ñ±Û°ú ´ñ±Û ¼ö Ã³¸®
	public ReplyPageDTO getListPage(Criteria cri, Long bno);

}
