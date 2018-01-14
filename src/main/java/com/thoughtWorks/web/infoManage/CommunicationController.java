package com.thoughtWorks.web.infoManage;


import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.*;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.FileToolkit;
import com.thoughtWorks.util.PageUtil;
import com.thoughtWorks.util.ZipUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Component
@RequestMapping("/communication")
public class CommunicationController {

    @Resource
    private PersonService personService;

    @RequestMapping()
    public String index() {
        return "infoManage/communication/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(SearchDto searchDto, PageUtil page) {
        Map<String, Object> data = new HashMap<>();

        try {
            List<Map<String, String>> allProfessionList = personService.queryAllStudentsProfessionList();
            List<Map<String, String>> student = personService.queryStudentsByTeacherHasClasses(searchDto, page);

            data.put("student", student);
            data.put("allProfessionList", allProfessionList);
            data.put("result", true);
            data.put("page", page);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(CommunicationContent communicationContent) {
        try {
            ActiveUser user = (ActiveUser) SecurityUtils.getSubject().getPrincipal();
            communicationContent.setTeacherId(user.getUserName());
            personService.addCommunication(communicationContent);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("communication")
    @ResponseBody
    public Result communication(String studentNo) {
        try {
            List<Map<String, Object>> communication = personService.queryCommunicationByStudentId(studentNo);
            List<Map<String, Object>> student = personService.queryStudentInfoById(studentNo);
            communication.addAll(student);
            return Result.success(communication, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("updateContent")
    @ResponseBody
    public Result updateContent(CommunicationContent communicationContent) {
        try {
            personService.updateCommunicationContent(communicationContent);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("queryDirectionByDepartmentId")
    @ResponseBody
    public Result queryDirectionByDepartmentId(int departmentId) {
        try {
            List<Direction> list = personService.queryDirectionByDepartmentId(departmentId);
            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryDirectionByDepartment")
    @ResponseBody
    public Result queryDirectionByDepartment() {
        try {
            List<Direction> list = personService.queryDirectionByDepartment();

            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryClass")
    @ResponseBody
    public Result queryClass() {
        try {
            List<Classes> list = personService.queryClass();

            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryClassByDepartmentId")
    @ResponseBody
    public Result queryClassByDepartmentId(int departmentId) {
        try {
            List<Classes> list = personService.queryClassByDepartmentId(departmentId);

            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

//    @RequestMapping("UploadAction")
//    @ResponseBody
//    public Result UploadAction(@RequestParam("fileselect[]") CommonsMultipartFile[] ajaxuploadfile, HttpServletRequest request, HttpServletResponse response) {
//        try {
//
//            String path = request.getSession().getServletContext().getRealPath("upload");
////            String fileName = ajaxuploadfile[1].getOriginalFilename();
//            System.out.println("路径信息："+path);
//            for(int i = 0;i<ajaxuploadfile.length;i++){
//                System.out.println("fileName---------->" + ajaxuploadfile[i].getOriginalFilename());
//
//                if(!ajaxuploadfile[i].isEmpty()){
//                    int pre = (int) System.currentTimeMillis();
//                    System.out.println("0000000000000000000000000000000000");
//                    try {
//                        //拿到输出流，同时重命名上传的文件
//                        FileOutputStream os = new FileOutputStream("D:/" + new Date().getTime() + ajaxuploadfile[i].getOriginalFilename());
//                        //拿到上传文件的输入流
//                        FileInputStream in = (FileInputStream) ajaxuploadfile[i].getInputStream();
//
//                        //以写字节的方式写文件
//                        int b = 0;
//                        while((b=in.read()) != -1){
//                            os.write(b);
//                        }
//                        os.flush();
//                        os.close();
//                        in.close();
//                        int finaltime = (int) System.currentTimeMillis();
//                        System.out.println(finaltime - pre);
//
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                        System.out.println("上传出错");
//                    }
//                }
//            }
//            return Result.success(null, Constant.SEARCH_SUCCESS);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return Result.failure(null, Constant.SEARCH_FAILURE);
//    }


    @RequestMapping(value = "/UploadAction", method = RequestMethod.POST)
    @ResponseBody
    public Result UploadAction(@ModelAttribute Student student, HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        //创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        String xyPath = "";
        //判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            //转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                //记录上传过程起始时的时间，用来计算上传时间
                int pre = (int) System.currentTimeMillis();
                //取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    //取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if (myFileName.trim() != "") {
                        System.out.println(myFileName);
                        //重命名上传后的文件名
                        String fileName = UUID.randomUUID().toString().replaceAll("-", "") + myFileName.substring(myFileName.lastIndexOf("."));
                        //定义上传路径
                        String path = request.getServletContext().getRealPath("") + fileName;
                        File localFile = new File(path);
                        String locPath = request.getServletContext().getRealPath("images") + "/zyUpload";
                        file.transferTo(localFile);
                        FileToolkit.moveFile(localFile.getCanonicalPath(), locPath);
                        xyPath = "/images/zyUpload/" + fileName;
                    }
                }
            }

        }

        return Result.success(xyPath, Constant.UPLOAD_SUCCESS);
    }

    @RequestMapping(value = "/uploadActionAjax", method = RequestMethod.POST)
    @ResponseBody
    public Result uploadActionAjax(Student student) {

        try {
            personService.uploadActionAjax(student);
            return Result.success(null, Constant.UPLOAD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Result.failure(null, Constant.UPLOAD_FAILURE);
    }


    @RequestMapping(value = "/downloadZyFile", method = RequestMethod.POST)
    public void downloadZyFile(@RequestParam("fileNames") String fileNames, HttpServletRequest request, HttpServletResponse response) {

        try {
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment;filename=zyFile.zip");
            String path = request.getServletContext().getRealPath("");
            String[] pathItem = fileNames.split("###");


            ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
            for (String filename : pathItem) {
                File fileItem = new File(path + "/" + filename);
                if (fileItem.exists()) {
                    ZipUtils.doCompress(path + "/" + filename, zos);
                    continue;
                }
                response.flushBuffer();
            }
            zos.flush();
            zos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
