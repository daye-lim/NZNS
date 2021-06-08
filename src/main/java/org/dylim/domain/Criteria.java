package org.dylim.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString

// pageNum,amount,type,keyword ���� ���� �����ϴ� �뵵�� Ŭ����
// �˻� ������ ����
// �����ڸ� ���� �⺻���� 1������, 10���� �����ؼ� ó���Ѵ�
public class Criteria {

	private int pageNum;
	private int amount;				// �� �������� ��� �����͸� ��������
	
	private String type;
	private String keyword;
	
	
	public Criteria() {		// ������ (�ν��Ͻ� ���� �ʱ�ȭ)
		this(1,10);			// 1�������� 10�� �Խù�
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
// �˻� ���� ó���� ���� �迭 ����
// getTypeArr�� �˻� ������ �� ����(T,C,W)�� �����Ǿ������Ƿ� �˻� ������ �迭�� ���� �ѹ��� ó���ϱ� ����
// getTypeArr()�� �̿��ؼ� MyBatis�����±׸� Ȱ���Ҽ�����
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
		}
	
// ��ũ�� �����ϴ� ��� �߰�
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
// queryParam() �޼��带 �̿��ؼ� �Ķ���� ���ۿ� �ʿ��� ���ڿ� �ս��� �߰� ����		
		return builder.toUriString();
	}
}
