package org.dylim.domain;

import lombok.Data;

// �Ʒ��� �������� �ϳ��� ��� �����ϴ� �뵵�� Ŭ����

@Data
public class AttachFileDTO {
	
	private String fileName;	// ���� ������ �̸�
	private String uploadPath;	// ���ε� ���
	private String uuid;		// UUID��
	private boolean image;		// �̹��� ����

}
