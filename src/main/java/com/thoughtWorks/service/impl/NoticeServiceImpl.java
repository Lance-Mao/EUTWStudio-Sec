package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.NoticeDao;
import com.thoughtWorks.entity.Notice;
import com.thoughtWorks.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeDao noticeDao ;

    @Override
    public void addNotice(Notice notice) {
        noticeDao.addNotice(notice);
    }

    @Override
    public List<Map<String, Object> > list() {
       return noticeDao.list();
    }

    @Override
    public void delete(int id) {
        noticeDao.delete(id);
    }
}
