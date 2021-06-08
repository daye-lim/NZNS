package org.dylim.domain;

import lombok.Data;

// 아래의 정보들을 하나로 묶어서 전달하는 용도의 클래스

@Data
public class AttachFileDTO {
	
	private String fileName;	// 원본 파일의 이름
	private String uploadPath;	// 업로드 경로
	private String uuid;		// UUID값
	private boolean image;		// 이미지 여부

}
