package org.hdcd.mapper;

import java.util.List;

import org.hdcd.domain.Notice;

public interface NoticeMapper {

	public void create(Notice notice) throws Exception;

	public Notice read(Long noticeNo) throws Exception;

	public void update(Notice notice) throws Exception;

	public void delete(Long noticeNo) throws Exception;

	public List<Notice> list() throws Exception;
	
}
