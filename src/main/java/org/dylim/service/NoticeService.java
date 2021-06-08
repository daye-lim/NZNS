package org.dylim.service;

import java.util.List;

import org.dylim.domain.Criteria;
import org.dylim.domain.NoticeVO;

public interface NoticeService {
	// �������� ���
	public void NoticeRegister(NoticeVO notice);

	// �������� ��ȸ
	public NoticeVO NoticeGet(Long nno);
	
	// �������� ����
	public boolean NoticeModify(NoticeVO notice);
	
	// �������� ����
	public boolean NoticeRemove(Long nno);
	

	// �Խù� ��� ��ȸ (����¡)
	public List<NoticeVO> NoticeGetList(Criteria cri);
	
	// ��ü �Խù��� ��(total)�� ���ϴ� �޼���
	public int getTotal(Criteria cri);
	
	// �Խù� ÷������ ��� ��ȸ
	//public List<NoticeAttachVO> getAttachList(Long bno);
}
