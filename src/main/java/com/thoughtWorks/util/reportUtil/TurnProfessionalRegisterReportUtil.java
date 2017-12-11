package com.thoughtWorks.util.reportUtil;

import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;

import java.util.List;
import java.util.Map;

public class TurnProfessionalRegisterReportUtil extends ExcelReportUtil {
    private String[] keys = {"index", "no", "name", "arrangement", "originProfession", "originProfessionId", "profession", "professionId"};

    @Override
    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {

        int rowIndex = 1;
        HSSFRow row = sheet.createRow(rowIndex++);//创建行
        HSSFCell cell = row.createCell(0);
        cell.setCellValue(new HSSFRichTextString("分院：高职学院"));

        row = sheet.createRow(rowIndex);

        int columnIndex = 0;
        for (String key : keys) {
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(headers.get(key)));
        }
    }

    @Override
    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        try {
            sheet.setColumnWidth((short) 1, (short) 5000);
            sheet.setColumnWidth((short) 2, (short) 4500);
            sheet.setColumnWidth((short) 3, (short) 3500);
            sheet.setColumnWidth((short) 4, (short) 5200);
            sheet.setColumnWidth((short) 5, (short) 4000);
            sheet.setColumnWidth((short) 6, (short) 5200);
            sheet.setColumnWidth((short) 7, (short) 4000);

            HSSFCell cell;
            int rowIndex = 3;

            for (int j = 0; j < dataset.size(); ++j) {
                HSSFRow row = sheet.createRow(rowIndex++);//创建行
                Map<String, Object> student = dataset.get(j);
                for (int i = 0; i < keys.length; ++i) {
                    String key = keys[i];
                    if ("index".equals(key)) {
                        setSerialNumber(rowIndex, row);
                        continue;
                    }
                    cell = row.createCell(i);
                    if ("arrangement".equals(key)) {
                        cell.setCellValue(new HSSFRichTextString("大专"));
                        continue;
                    }
                    cell.setCellValue(new HSSFRichTextString(student.get(key).toString()));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private HSSFCell setSerialNumber(int rowIndex, HSSFRow row) {
        //序号
        HSSFCell cell = row.createCell(0);
        cell.setCellValue(new HSSFRichTextString(String.valueOf(rowIndex - 3)));

        return cell;
    }
}
