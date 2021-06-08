package org.dylim.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.dylim.domain.BoardAttachVO;
import org.dylim.domain.BoardVO;
import org.dylim.domain.Criteria;
import org.dylim.mapper.BoardAttachMapper;
import org.dylim.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service	// 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용
			// Service를 하는 자바파일임을 선언
@AllArgsConstructor	// 모든 파라미터를 이용하는 생성자를 만들어주는 어노테이션

public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	// 게시물 등록
	public void register(BoardVO board) {
		
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	// 게시물 조회
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Transactional
	@Override
	// 게시물 수정
	public boolean modify(BoardVO board) {
		attachMapper.deleteAll(board.getBno());	// 첨부파일 전체 삭제 후 다시 추가
		boolean modifyResult = mapper.update(board) == 1;	// 반환된 값이 1이면 정상적으로 수정완료	
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
		
			board.getAttachList().forEach(attach -> {
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	// 게시물 삭제
	public boolean remove(Long bno) {
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;				// 반환된 값이 1이면 정상적으로 삭제완료
	}
	
	

	@Override
	// 게시글 추천
	public void recommend(Long bno) {
		mapper.recommend(bno);
		
	}


	@Override
	// 게시물 목록 조회 (페이징)
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	// 전체 게시물의 수(total)를 구하는 메서드 구현
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	// 게시물 첨부파일 목록 조회
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<BoardVO> BestReviews() {
		return mapper.BestReviews();
	}




}
