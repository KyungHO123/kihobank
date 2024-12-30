package kr.jkh.khbank.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Criteria {
	
	private int page = 1;//현재 페이지 : 기본값 - 1
	private int perPageNum = 3;//한 페이지에서 컨텐츠 개수 : 기본값 - 5
	private String search = ""; //검색어 : 기본값 - 빈문자열 => 전체 검색
	private String type = "all"; //검색 타입 : 기본값 - 전체검색
	private String order = "po_num";
	
	public Criteria(int page) {
		this.page = page;
	}
	public Criteria(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
	}
	public Criteria(int page, int perPageNum, String type, String search) {
		this(page, perPageNum);
		this.type = type == null ? "all" : type;
		this.search = search == null ? "" : search;
	}
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}

}