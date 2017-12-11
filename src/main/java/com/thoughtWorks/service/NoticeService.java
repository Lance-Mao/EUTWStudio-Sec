package com.thoughtWorks.service;

import com.thoughtWorks.entity.Notice;

import java.util.List;
import java.util.Map;


public interface NoticeService {
    void addNotice(Notice notice);

    List<Map<String, Object> > list();

    void delete(int id);
}
