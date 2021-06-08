package org.dylim.service;

import java.util.List;

import org.dylim.domain.Criteria;
import org.dylim.domain.NoticeVO;

public interface NoticeService {
	// 공지사항 등록
	public void NoticeRegister(NoticeVO notice);

	// 공지사항 조회
	public NoticeVO NoticeGet(Long nno);
	
	// 공지사항 수정
	public boolean NoticeModify(NoticeVO notice);
	
	// 공지사항 삭제
	public boolean NoticeRemove(Long nno);
	

	// 게시물 목록 조회 (페이징)
	public List<NoticeVO> NoticeGetList(Criteria cri);
	
	// 전체 게시물의 수(total)를 구하는 메서드
	public int getTotal(Criteria cri);
	
	// 게시물 첨부파일 목록 조회
	//public List<NoticeAttachVO> getAttachList(Long bno);
}
