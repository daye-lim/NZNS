package org.dylim.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
// lombok�� �̿��ؼ� ������,getter/setter,toString()���� ������ ����� ����ϱ����� @Data������̼� ���
@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	private Long recommend;			// ��õ����
	
	private int replyCnt;			// �亯����
	
	private List<BoardAttachVO> attachList; 
	// �Խù� ��� �� �ѹ��� BoardAttachVO�� ó���� ���ֵ��� �߰�
}
