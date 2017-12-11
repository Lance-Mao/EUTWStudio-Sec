package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.Course;
import com.thoughtWorks.service.TrainModuleService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.ImgUtil;
import com.thoughtWorks.util.PageUtil;
import com.thoughtWorks.util.excelUtil.ExcelUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/course")
public class CourseController {
    @Resource
    private TrainModuleService trainModuleService;

    @RequestMapping()
    public String index() {
        return "infoManage/course/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page, SearchDto searchDto) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> courses = trainModuleService.queryCoursesLikes(page, searchDto);
            List<Map<String, String>> modules = trainModuleService.queryAllTrainModules();
            List<Map<String, Object>> testMethods = trainModuleService.queryAllTestMethod(page);
            data.put("courses", courses);
            data.put("modules", modules);
            data.put("testMethods", testMethods);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(Course course) {
        try {
            trainModuleService.addCourse(course);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(Course course) {
        try {
            trainModuleService.updateCourse(course);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("delete")
    @ResponseBody
    public Result delete(String id) {
        try {
            trainModuleService.deleteCourse(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("importExcel")
    @ResponseBody
    public Result importExcel(MultipartFile file, HttpServletRequest request) {
        try {
            String imgPath = ImgUtil.saveImg(file, request.getServletContext().getRealPath("/images") + Constant.TEMP_IMAGE_PATH);
            Collection<Map> maps = ExcelUtil.importExcel(Map.class, new File(imgPath), "yyyy-MM-dd HH:mm:ss", 0);
            for(Map m : maps){
                System.out.println(m);
            }
            return Result.success(imgPath, Constant.UPLOAD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
}
