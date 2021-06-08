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
@Service	// ���� ������ �ַ� ����Ͻ� ������ ����ϴ� ��ü���� ǥ���ϱ� ���� ���
			// Service�� �ϴ� �ڹ��������� ����
@AllArgsConstructor	// ��� �Ķ���͸� �̿��ϴ� �����ڸ� ������ִ� ������̼�

public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	// �Խù� ���
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
	// �Խù� ��ȸ
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Transactional
	@Override
	// �Խù� ����
	public boolean modify(BoardVO board) {
		attachMapper.deleteAll(board.getBno());	// ÷������ ��ü ���� �� �ٽ� �߰�
		boolean modifyResult = mapper.update(board) == 1;	// ��ȯ�� ���� 1�̸� ���������� �����Ϸ�	
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
	// �Խù� ����
	public boolean remove(Long bno) {
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;				// ��ȯ�� ���� 1�̸� ���������� �����Ϸ�
	}
	
	

	@Override
	// �Խñ� ��õ
	public void recommend(Long bno) {
		mapper.recommend(bno);
		
	}


	@Override
	// �Խù� ��� ��ȸ (����¡)
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	// ��ü �Խù��� ��(total)�� ���ϴ� �޼��� ����
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	// �Խù� ÷������ ��� ��ȸ
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<BoardVO> BestReviews() {
		return mapper.BestReviews();
	}




}
