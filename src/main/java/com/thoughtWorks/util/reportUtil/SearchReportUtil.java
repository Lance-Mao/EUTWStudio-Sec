package com.thoughtWorks.util.reportUtil;

import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import org.apache.poi.hssf.usermodel.*;

import java.util.List;
import java.util.Map;

public class SearchReportUtil extends ExcelReportUtil {
    @Override
    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {
        HSSFRow row = sheet.createRow(1);

        String[] keys = {"index", "department", "level", "direction", "classesName","no", "name", "courseCode","courseName","score"};
        int columnIndex = 0;
        for (String key : keys) {
            HSSFCell cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(headers.get(key)));
        }
    }

    @Override
    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        try {
            String[] keys = {"departmentName", "level", "directionName", "classesName","no", "studentName", "courseCode","courseName","score"};
            sheet.setColumnWidth((short) 1, (short) 5000);//第二列宽度5000
            sheet.setColumnWidth((short) 4, (short) 5000);
            sheet.setColumnWidth((short) 5, (short) 5000);
            sheet.setColumnWidth((short) 8, (short) 5000);
            int rowIndex = 2;

            setSheetRowData(sheet, dataset, keys, rowIndex);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
