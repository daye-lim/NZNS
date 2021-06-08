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
	
	
	// �Խù� ���
	public void NoticeRegister(NoticeVO notice) {
		
		log.info("register.........." + notice);
		mapper.insertSelectKey(notice);
		
	}

	@Override
	// �Խù� ��ȸ
	public NoticeVO NoticeGet(Long nno) {
		
		log.info("get.........." + nno);
		return mapper.read(nno);
		
	}

	@Transactional
	@Override
	// �Խù� ����
	public boolean NoticeModify(NoticeVO notice) {
		
		log.info("modify..........." + notice);
		

		boolean modifyResult = mapper.update(notice) == 1;	// ��ȯ�� ���� 1�̸� ���������� �����Ϸ�	

		return modifyResult;
	}

	@Transactional
	@Override
	// �Խù� ����
	public boolean NoticeRemove(Long nno) {
		
		log.info("remove................."+nno);
		return mapper.delete(nno) == 1;				// ��ȯ�� ���� 1�̸� ���������� �����Ϸ�
	}
	


	@Override
	// �Խù� ��� ��ȸ (����¡)
	public List<NoticeVO> NoticeGetList(Criteria cri) {
		log.info("get List With Criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	// ��ü �Խù��� ��(total)�� ���ϴ� �޼��� ����
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}




}
