package org.dylim.mapper;

import java.util.List;


import org.dylim.domain.Criteria;
import org.dylim.domain.NoticeVO;

public interface NoticeMapper {
	// ��ü ��� ��ȸ 
	public List<NoticeVO> getList();
	
	// ��ü ��� ��ȸ (����¡)
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	// ��ü �Խù��� ��(total)�� ���ϴ� �޼���
	public int getTotalCount(Criteria cri);
	
	// �۾��� (insert-PK�� ���ʿ�X)
	public void insert(NoticeVO notice);
	
	//  (insert-PK�� ���ʿ�O)
	public void insertSelectKey(NoticeVO notice);
	
	
	// ����ȸ (select)
	public NoticeVO read(Long nno);
	
	// �ۻ��� (delete)
	public int delete(Long nno);	// ���������� ������ ���� �� 1�̻��� ���� ���� (��� �����Ͱ� �����Ǿ�����)
	
	// �ۼ��� (update)
	public int update(NoticeVO notice);	// ��� �����Ͱ� �����Ǿ����� ó�� ������ intŸ�� �޼���
	


}
