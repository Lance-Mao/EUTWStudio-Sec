package com.thoughtWorks.dao;

import com.thoughtWorks.entity.Notice;

import java.util.List;
import java.util.Map;

public interface NoticeDao {

    void addNotice(Notice notice);

    List<Map<String, Object> > list();

    void delete(int id);
}
