package org.dylim.service;

import java.util.List;


import org.dylim.domain.BoardAttachVO;
import org.dylim.domain.BoardVO;
import org.dylim.domain.Criteria;

public interface BoardService {
	
	// �Խñ� ���
	public void register(BoardVO board);
	
	// �Խñ� ��ȸ
	public BoardVO get(Long bno);			// returnType=BoardVO
	
	// �Խñ� ����
	public boolean modify(BoardVO board);
	
	// �Խñ� ����
	public boolean remove(Long bno);
	
	// �Խñ� ��õ
	public void recommend(Long bno);
	
	// �Խù� ��� ��ȸ
//	public List<BoardVO> getList();			// returnType=List<BoardVO>
	
	// �Խù� ��� ��ȸ (����¡)
	public List<BoardVO> getList(Criteria cri);
	
	// ��ü �Խù��� ��(total)�� ���ϴ� �޼���
	public int getTotal(Criteria cri);
	
	// �Խù� ÷������ ��� ��ȸ
	public List<BoardAttachVO> getAttachList(Long bno);
	
	
	// �Խù� ��� ��ȸ
	public List<BoardVO> BestReviews();			// returnType=List<BoardVO>

}
