package org.dylim.service;

import java.util.List;


import org.dylim.domain.Criteria;
import org.dylim.domain.NoticeVO;
import org.dylim.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor	
public class NoticeServiceImpl implements NoticeService{
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
	
	// 게시물 등록
	public void NoticeRegister(NoticeVO notice) {
		
		log.info("register.........." + notice);
		mapper.insertSelectKey(notice);
		
	}

	@Override
	// 게시물 조회
	public NoticeVO NoticeGet(Long nno) {
		
		log.info("get.........." + nno);
		return mapper.read(nno);
		
	}

	@Transactional
	@Override
	// 게시물 수정
	public boolean NoticeModify(NoticeVO notice) {
		
		log.info("modify..........." + notice);
		

		boolean modifyResult = mapper.update(notice) == 1;	// 반환된 값이 1이면 정상적으로 수정완료	

		return modifyResult;
	}

	@Transactional
	@Override
	// 게시물 삭제
	public boolean NoticeRemove(Long nno) {
		
		log.info("remove................."+nno);
		return mapper.delete(nno) == 1;				// 반환된 값이 1이면 정상적으로 삭제완료
	}
	


	@Override
	// 게시물 목록 조회 (페이징)
	public List<NoticeVO> NoticeGetList(Criteria cri) {
		log.info("get List With Criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	// 전체 게시물의 수(total)를 구하는 메서드 구현
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}




}
