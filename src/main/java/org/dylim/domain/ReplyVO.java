package org.dylim.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private Long rno;			// ��� ��ȣ
	private Long bno;			// �Խù� ��ȣ
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
