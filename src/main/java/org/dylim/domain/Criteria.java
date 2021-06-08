package org.dylim.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString

// pageNum,amount,type,keyword 값을 같이 전달하는 용도의 클래스
// 검색 조건을 유지
// 생성자를 통해 기본값을 1페이지, 10개로 지정해서 처리한다
public class Criteria {

	private int pageNum;
	private int amount;				// 한 페이지당 몇개의 데이터를 보여줄지
	
	private String type;
	private String keyword;
	
	
	public Criteria() {		// 생성자 (인스턴스 변수 초기화)
		this(1,10);			// 1페이지에 10개 게시물
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
// 검색 조건 처리를 위한 배열 생성
// getTypeArr은 검색 조건이 각 글자(T,C,W)로 구성되어있으므로 검색 조건을 배열로 만들어서 한번에 처리하기 위함
// getTypeArr()를 이용해서 MyBatis동적태그를 활용할수있음
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
		}
	
// 링크를 생성하는 기능 추가
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
// queryParam() 메서드를 이용해서 파라미터 전송에 필요한 문자열 손쉽게 추가 가능		
		return builder.toUriString();
	}
}
