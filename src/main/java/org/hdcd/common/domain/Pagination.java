package org.hdcd.common.domain;

public class Pagination {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;

	private int displayPageNum = 10;

	private PageRequest pageRequest;

	public void setPageRequest(PageRequest pageRequest) {
		this.pageRequest = pageRequest;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;

		calcData();
	}

	private void calcData() {
		endPage = (int) (Math.ceil(pageRequest.getPage() / (double) displayPageNum) * displayPageNum);

		startPage = (endPage - displayPageNum) + 1;

		int lastPage = (int) (Math.ceil(totalCount / (double) pageRequest.getSizePerPage()));

		if (endPage > lastPage) {
			endPage = lastPage;
		}

		prev = startPage == 1 ? false : true;

		next = endPage * pageRequest.getSizePerPage() >= totalCount ? false : true;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public PageRequest getPageRequest() {
		return pageRequest;
	}

}
