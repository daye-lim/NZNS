package org.dylim.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString

// �����ڸ� �����ϰ� Criteria�� ��ü�����ͼ�(total)�� �Ķ���ͷ� ����
// ������ ��ȣ�� ȭ�鿡 ǥ���ϱ� ���� �����ϴ� ����

public class PageDTO {
	

	  private int startPage;
	  private int endPage;
	  private boolean prev, next; // ������ư�� ������ư ���� ����(true�̸� ����, false�̸� ����X)

	  private int total;			// ��ü�����ͼ�
	  private Criteria cri;			// ���� ��������ȣ(pageNum), �� �������� ��� �����͸� ��������(amount)

	  public PageDTO(Criteria cri, int total) { // ������

	    this.cri = cri;
	    this.total = total;
//	    			(������ ����ȯ)	(����� �ø�(����ڰ���������������ȣ / 10.0))*10
	    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;

	    this.startPage = this.endPage - 9;

	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

	   // realEnd �� this.endPage ���� ũ�� false, {} ����X .
	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;

	    this.next = this.endPage < realEnd;
	  }
	  

}
