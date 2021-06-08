package org.dylim.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString

// 생성자를 정의하고 Criteria와 전체데이터수(total)을 파라미터로 지정
// 페이지 번호를 화면에 표시하기 위해 존재하는 필통

public class PageDTO {
	

	  private int startPage;
	  private int endPage;
	  private boolean prev, next; // 이전버튼과 다음버튼 생성 여부(true이면 생성, false이면 생성X)

	  private int total;			// 전체데이터수
	  private Criteria cri;			// 현재 페이지번호(pageNum), 한 페이지당 몇개의 데이터를 보여줄지(amount)

	  public PageDTO(Criteria cri, int total) { // 생성자

	    this.cri = cri;
	    this.total = total;
//	    			(정수로 형변환)	(결과값 올림(사용자가선택한페이지번호 / 10.0))*10
	    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;

	    this.startPage = this.endPage - 9;

	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

	   // realEnd 가 this.endPage 보다 크면 false, {} 실행X .
	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;

	    this.next = this.endPage < realEnd;
	  }
	  

}
