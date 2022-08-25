package com.spring.javagreenS_pjp.pagination;

import lombok.Data;

public @Data class PageVO {
	private int pag;
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo; 

	private int blockSize ;
	private int curBlock ;
	private int lastBlock ;
	
	private String part;
}
