package org.dylim.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor  // �� �̿��ؼ� replyCnt�� list�� �������� �Ķ���ͷ� ó��
@Getter
public class ReplyPageDTO {
	
	private int replyCnt;			// ��ü ��� ��
	private List<ReplyVO> list;		// ��� ���

}
