package org.dylim.domain;

import lombok.Data;

@Data
public class member_iVO {
	private String id;			// ����ȸ�� id
	private String password;	// ����ȸ�� pw
	private String name;		// ����ȸ�� �̸�
	private String birth;		// ����ȸ�� �������
	private String email;		// ����ȸ�� �̸���
	private String phone;		// ����ȸ�� �޴�����ȣ
	private int adminCk;		// ������üũ (0: �Ϲ�ȸ��, 1:������)
}
