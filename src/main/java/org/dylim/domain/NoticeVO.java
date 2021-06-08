package org.dylim.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private Long nno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;

}

