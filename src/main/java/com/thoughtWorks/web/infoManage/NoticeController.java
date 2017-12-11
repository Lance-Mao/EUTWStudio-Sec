package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dao.TrainModuleDao;
import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.Classes;
import com.thoughtWorks.entity.Notice;
import com.thoughtWorks.service.NoticeService;
import com.thoughtWorks.service.TrainModuleService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/notice")
public class NoticeController {
    @Resource
    private NoticeService noticeService;

    @RequestMapping()
    public String index() {
        return "infoManage/notice/list";
    }

    @RequestMapping("add")
    @ResponseBody
    public Result addManual(Notice notice) {
        try {
            noticeService.addNotice(notice);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list() {
        try {
            List<Map<String, Object> >   list = noticeService.list();
            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Result.failure(null,Constant.SEARCH_FAILURE);
    }
    @RequestMapping("delete")
        @ResponseBody
        public Result delete(int id) {
            try {
                noticeService.delete(id);
                return Result.success(null, Constant.DELETE_SUCCESS);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return Result.failure(null,Constant.DELETE_FAILURE);
        }


}
