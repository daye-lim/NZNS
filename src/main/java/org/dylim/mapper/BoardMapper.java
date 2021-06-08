package org.dylim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.dylim.domain.BoardVO;
import org.dylim.domain.Criteria;

public interface BoardMapper {
	
	// ��ü ��� ��ȸ 
	public List<BoardVO> getList();
	
	// ��ü ��� ��ȸ (����¡)
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// ��ü �Խù��� ��(total)�� ���ϴ� �޼���
	public int getTotalCount(Criteria cri);
	
	// �۾��� (insert-PK�� ���ʿ�X)
	public void insert(BoardVO board);
	
	//  (insert-PK�� ���ʿ�O)
	public void insertSelectKey(BoardVO board);
	
	
	// ����ȸ (select)
	public BoardVO read(Long bno);
	
	// �ۻ��� (delete)
	public int delete(Long bno);	// ���������� ������ ���� �� 1�̻��� ���� ���� (��� �����Ͱ� �����Ǿ�����)
	
	// �ۼ��� (update)
	public int update(BoardVO board);	// ��� �����Ͱ� �����Ǿ����� ó�� ������ intŸ�� �޼���
	
	// �Խñ���õ
	public void recommend(Long bno);
	
	// ��۰� ��� ���� ���� ó��
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	
	public List<BoardVO> BestReviews();


}
