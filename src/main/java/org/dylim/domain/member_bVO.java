package org.dylim.domain;

import lombok.Data;

@Data
public class member_bVO {
	private String id;			// ����Ͻ�ȸ�� id
	private String password;	// ����Ͻ�ȸ�� pw
	private String name;		// ��ȣ
	private String owner_name;	// ��ǥ��
	private String cor_num;		// ����ڵ�Ϲ�ȣ
	private String email;		// ����Ͻ�ȸ�� �̸���
	private String postcode;	// �����ȣ
	private String address1;	// �繫�� �ּ�
	private String address2;	// �繫�� �ּ�
	private String tel;			// ����Ͻ�ȸ�� �޴�����ȣ
	private boolean files;		// �������� ÷�� ����
	private int adminCk;		// ������üũ (0: �Ϲ�ȸ��, 1:������)
}
