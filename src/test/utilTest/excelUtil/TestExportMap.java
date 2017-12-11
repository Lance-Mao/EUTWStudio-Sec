/**
 * @author SargerasWang
 */
package utilTest.excelUtil;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * The <code>TestExportMap</code>
 *
 * @author SargerasWang
 *         Created at 2014年9月21日 下午4:38:42
 */
public class TestExportMap {
    public static void main(String[] args) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> map = new LinkedHashMap<>();
        List<Map<String, String>> childrens = new ArrayList<>();
        Map<String, String> children = new HashMap<>();
        children.put("oldProfession", "财务管理");
        children.put("oldNum", "2");
        children.put("turnIn", "1");
        children.put("turnOut", "2");
        children.put("turnOut", "3");
        children.put("nowProfession", "财务管理");
        children.put("nowNumber", "2");
        children.put("remark", "备注");

        Map<String, String> children1 = new HashMap<>();
        children1.put("oldProfession", "财务管理");
        children1.put("oldNum", "2");
        children1.put("turnIn", "1");
        children1.put("turnOut", "2");
        children1.put("turnOut", "3");
        children1.put("nowProfession", "财务管理");
        children1.put("nowNumber", "2");
        children1.put("remark", "备注");

        childrens.add(children);
        childrens.add(children1);
        map.put("name", "金融系2222222222222222222222");
        map.put("children", childrens);

        Map<String, String> map1 = new LinkedHashMap<>();
        map1.put("index", "序号");
        map1.put("name", "系名");
        map1.put("oldProfession", "原录取专业");
        map1.put("oldNum", "人数");
        map1.put("turnIn", "转入");
        map1.put("turnOut", "转出");
        map1.put("turnOut", "转出");
        map1.put("nowProfession", "现专业");
        map1.put("nowNumber", "人数");
        map1.put("remark", "备注");
        list.add(map);
        File f = new File("/home/acey/Documents//ass.xls");
        OutputStream out = new FileOutputStream(f);
//        ExcelReportUtil.exportExcel(map1, list, f, "专业报表");
        out.close();
    }
}
