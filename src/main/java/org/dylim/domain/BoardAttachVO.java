package org.dylim.domain;

import lombok.Data;

// SQL �� ó���ϱ� ���� �Ķ���͸� �Ѳ����� ��Ƽ� ������ ���� Ŭ����(����)
@Data
public class BoardAttachVO {
// ÷������ �����ϴ� ���̺��� �Ķ����
	
	private String uuid; 		// uuid�� ���Ե� �̸��� PK�� �ϴ� uuidĮ��
	private String uploadPath;	// ���� ������ ���ε� �� ���
	private String fileName;	// ���� �̸�
	private boolean fileType;	// �̹��� ���� ���θ� �Ǵ�
	
	private Long bno;			// �ش� �Խù� ��ȣ�� ����

}
