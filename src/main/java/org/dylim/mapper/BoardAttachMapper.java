package org.dylim.mapper;

import java.util.List;

import org.dylim.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	// ÷������ �߰�
	public void insert(BoardAttachVO vo);
	
	// ÷������ ���� (ȭ�鿡�� ����)
	public void delete(String uuid);

	// �Խù� ��ȣ�� ÷������ ã�� �۾�
	public List<BoardAttachVO> findByBno(Long bno);
	
	// ÷������  ���� ó�� 	
	public void deleteAll(Long bno);
	
	// ÷�����ϸ�� ��ȸ
	public List<BoardAttachVO> getOldFiles();
	
}
