package org.dylim.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor  // 를 이용해서 replyCnt와 list를 생성자의 파라미터로 처리
@Getter
public class ReplyPageDTO {
	
	private int replyCnt;			// 전체 댓글 수
	private List<ReplyVO> list;		// 댓글 목록

}
