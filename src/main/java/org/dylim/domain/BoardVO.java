package org.dylim.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
// lombok을 이용해서 생성자,getter/setter,toString()등을 만들어내는 방식을 사용하기위해 @Data어노테이션 사용
@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	private Long recommend;			// 추천개수
	
	private int replyCnt;			// 답변개수
	
	private List<BoardAttachVO> attachList; 
	// 게시물 등록 시 한번에 BoardAttachVO를 처리할 수있도록 추가
}
