package com.thoughtWorks.web;

import com.thoughtWorks.entity.Result;
import com.thoughtWorks.entity.StudentByUpdata;
import com.thoughtWorks.entity.StudentFamily;
import com.thoughtWorks.service.TaskService;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * @program: EUTWStudio
 * @author: MaoLW
 * @create: 2018-08-20 11:15
 **/

@Component
@RequestMapping("/test")
public class TimedTask {
    @Autowired
    private TaskService taskService;

    // 更新学生成绩信息
    @RequestMapping("/test")
    public void updateGrade() {
        HttpGet httpRequst = new HttpGet("http://10.50.0.202:8000/eupdc/openws/gzXgAnalyze.xsodata/gzScore");// 创建对象（接口地址）

        HttpClient httpclient = new DefaultHttpClient();

        try {
            httpRequst.addHeader("Accept", "application/json");
            httpRequst.addHeader("Authorization", "Basic T1BFTldTOk9XczEyMzQ1"); // 凭证信息
            HttpResponse reponse = httpclient.execute(httpRequst);//请求数据
            HttpEntity entity = reponse.getEntity();//获取数据
            if (entity == null) {
                System.out.println("None");
            }
            if (entity != null) {
                String result = IOUtils.toString(entity.getContent(), "UTF-8");
                JSONObject jsonObject = new JSONObject(result);
                JSONObject jsonObjectResult = new JSONObject(jsonObject.get("d").toString());
                JSONArray jsonObjects = jsonObjectResult.getJSONArray("results");
                List<Result> resultList = new ArrayList<>();
                int count = 1;
                // 执行前清空以前的成绩信息
                taskService.deleteData();
                for (int i = 0; i < jsonObjects.length(); i++) {
                    Result result1 = new Result();
                    JSONObject jsonObjectItem = new JSONObject(jsonObjects.get(i).toString());
                    result1.setNo(jsonObjectItem.get("STU_ID").toString());
                    result1.setName(jsonObjectItem.get("NAME").toString());
                    result1.setLevel(Integer.parseInt(jsonObjectItem.get("GRADE").toString()));
                    result1.setCourseCode(jsonObjectItem.get("COURSE_ID").toString());
                    result1.setCourseName(jsonObjectItem.get("COURSE_NAME").toString());
                    result1.setScore(jsonObjectItem.get("SCORE").toString());
                    if (jsonObjectItem.get("CLOP_GOTCREDIT").toString() == "null") {
                        result1.setCredit(0.0);
                    } else {
                        result1.setCredit(Double.valueOf(jsonObjectItem.get("CLOP_GOTCREDIT").toString()));
                    }
                    String date = jsonObjectItem.get("TESTIN_TIME").toString();
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Long time = new Long((date.substring(date.indexOf("(") + 1, date.indexOf(")"))));
                    result1.setTestEntityTime(format.parse(format.format(time)));
                    result1.setNature(Integer.parseInt(jsonObjectItem.get("ISMAINCLASS").toString()) == 0 ? 1 : 0);
                    if (jsonObjectItem.get("ISPASS").toString() == "null") {
                        result1.setIsPass(0);
                    } else {
                        result1.setIsPass(Integer.parseInt(jsonObjectItem.get("ISPASS").toString()));
                    }
                    result1.setMethod(jsonObjectItem.get("CLASS_TYPE").toString());
                    resultList.add(result1);
                    if ((i + 1) % 10000 == 0 || i == jsonObjects.length() - 1) {
                        System.out.println("第" + count++ + "段数据正在执行中");
                        Thread.sleep(1000 * 10);
                        taskService.insertBatch(resultList);
                        resultList = new ArrayList<>();
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("发现异常，请检查接口地址是否正确");
        }
        System.out.println("学生成绩信息更新完毕");
    }

    // 更新学生家庭成员信息
    @Transactional
    @RequestMapping("/testFamily")
    public void updateStudentFamily() {
        HttpGet httpRequst = new HttpGet("http://10.50.0.202:8000/eupdc/openws/gzXgAnalyze.xsodata/gzFamily");// 创建对象（接口地址）

        HttpClient httpclient = new DefaultHttpClient();

        try {
            httpRequst.addHeader("Accept", "application/json");
            httpRequst.addHeader("Authorization", "Basic T1BFTldTOk9XczEyMzQ1"); // 凭证信息
            HttpResponse reponse = httpclient.execute(httpRequst);//请求数据
            HttpEntity entity = reponse.getEntity();//获取数据
            if (entity == null) {
                System.out.println("None");
            }
            if (entity != null) {
                String result = IOUtils.toString(entity.getContent(), "UTF-8");
                JSONObject jsonObject = new JSONObject(result);
                JSONObject jsonObjectResult = new JSONObject(jsonObject.get("d").toString());
                JSONArray jsonObjects = jsonObjectResult.getJSONArray("results");
                List<StudentFamily> resultList = new ArrayList<>();
                int count = 1;
                // 执行前清空缓存数据库中的数据
                taskService.deleteDataByStuFamily();
                for (int i = 0; i < jsonObjects.length(); i++) {
                    StudentFamily studentFamily = new StudentFamily();
                    JSONObject jsonObjectItem = new JSONObject(jsonObjects.get(i).toString());
                    studentFamily.setNo(jsonObjectItem.get("STU_ID").toString());
                    // 因为格式问题暂不更新
//                    studentFamily.setPhone(jsonObjectItem.get("PHONE").toString());
                    studentFamily.setStaff(jsonObjectItem.get("OCCUPATION").toString());
                    studentFamily.setRelationship(jsonObjectItem.get("RELATIONSHIP").toString());
                    studentFamily.setName(jsonObjectItem.get("RE_NAME").toString());
                    resultList.add(studentFamily);
                    if ((i + 1) % 5000 == 0 || i == jsonObjects.length() - 1) {
                        System.out.println("第" + count++ + "段数据正在执行中");
                        Thread.sleep(1000 * 5);
                        taskService.insertBatchByStuFamily(resultList);
                        resultList = new ArrayList<>();
                    }
                }

            }
            // 从缓存表中更新到正式表中
            taskService.updateStuFamily();
            System.out.println("学生家庭成员信息更新完毕");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("发现异常，请检查接口地址是否正确");
        }
    }

    // 更新学生信息
    @Transactional
    @RequestMapping("/testStudent")
    public void updateStudent() {
        HttpGet httpRequst = new HttpGet("http://10.50.0.202:8000/eupdc/openws/gzXgAnalyze.xsodata/gzStudents");// 创建对象（接口地址）

        HttpClient httpclient = new DefaultHttpClient();

        try {
            httpRequst.addHeader("Accept", "application/json");
            httpRequst.addHeader("Authorization", "Basic T1BFTldTOk9XczEyMzQ1"); // 凭证信息
            HttpResponse reponse = httpclient.execute(httpRequst);//请求数据
            HttpEntity entity = reponse.getEntity();//获取数据
            if (entity == null) {
                System.out.println("None");
            }
            if (entity != null) {
                String result = IOUtils.toString(entity.getContent(), "UTF-8");
                JSONObject jsonObject = new JSONObject(result);
                JSONObject jsonObjectResult = new JSONObject(jsonObject.get("d").toString());
                JSONArray jsonObjects = jsonObjectResult.getJSONArray("results");
                List<StudentByUpdata> resultList = new ArrayList<>();
                int count = 1;
                // 执行前清空缓存数据库中的数据
                taskService.deleteDataByStudent();
                for (int i = 0; i < jsonObjects.length(); i++) {
                    StudentByUpdata studentByUpdata = new StudentByUpdata();
                    JSONObject jsonObjectItem = new JSONObject(jsonObjects.get(i).toString());
                    studentByUpdata.setNo(jsonObjectItem.get("STU_ID").toString());
                    studentByUpdata.setName(jsonObjectItem.get("NAME").toString());
                    studentByUpdata.setGender(jsonObjectItem.get("GENDER").toString());
                    studentByUpdata.setLevel(Integer.valueOf(jsonObjectItem.get("GRADE").toString()));
                    studentByUpdata.setOriginProfession(jsonObjectItem.get("MAJOR").toString());
                    studentByUpdata.setIdcard(jsonObjectItem.get("ID_CODE").toString());
                    studentByUpdata.setProfessionId(Integer.valueOf(jsonObjectItem.get("MAJOR_ID").toString()));
                    studentByUpdata.setPoliticalStatus(jsonObjectItem.get("PARTY").toString());

                    resultList.add(studentByUpdata);
                    if ((i + 1) % 5000 == 0 || i == jsonObjects.length() - 1) {
                        System.out.println("第" + count++ + "段数据正在执行中");
                        Thread.sleep(1000 * 5);
                        taskService.insertBatchByStudent(resultList);
                        resultList = new ArrayList<>();
                    }
                }

            }
            // 从缓存表中更新到正式表中
            taskService.updateStudent();
            System.out.println("学生信息更新完毕");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("发现异常，请检查接口地址是否正确");
        }
    }

}
