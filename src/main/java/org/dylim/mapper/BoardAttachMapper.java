package org.dylim.mapper;

import java.util.List;

import org.dylim.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	// 첨부파일 추가
	public void insert(BoardAttachVO vo);
	
	// 첨부파일 삭제 (화면에서 삭제)
	public void delete(String uuid);

	// 게시물 번호로 첨부파일 찾는 작업
	public List<BoardAttachVO> findByBno(Long bno);
	
	// 첨부파일  삭제 처리 	
	public void deleteAll(Long bno);
	
	// 첨부파일목록 조회
	public List<BoardAttachVO> getOldFiles();
	
}
