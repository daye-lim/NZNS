package org.dylim.domain;

import lombok.Data;

// SQL 을 처리하기 위해 파라미터를 한꺼번에 담아서 보내기 위한 클래스(필통)
@Data
public class BoardAttachVO {
// 첨부파일 보관하는 테이블의 파라미터
	
	private String uuid; 		// uuid가 포함된 이름을 PK로 하는 uuid칼럼
	private String uploadPath;	// 실제 파일이 업로드 된 경로
	private String fileName;	// 파일 이름
	private boolean fileType;	// 이미지 파일 여부를 판단
	
	private Long bno;			// 해당 게시물 번호를 저장

}
