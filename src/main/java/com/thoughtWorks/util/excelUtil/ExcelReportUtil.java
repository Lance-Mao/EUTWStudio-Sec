package com.thoughtWorks.util.excelUtil;

import com.thoughtWorks.util.DateUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;

import java.io.*;
import java.util.*;

public class ExcelReportUtil {
    private HSSFWorkbook workbook;

    /**
     * @param headers 表格属性列名数组
     * @param dataset 需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象。此方法支持的
     *                javabean属性的数据类型有基本数据类型及String,Date,String[],Double[]
     * @param title   大标题
     */
    public void exportExcel(Map<String, String> headers, List<Map<String, Object>> dataset,
                            File file, String title) throws FileNotFoundException {
        OutputStream out = new FileOutputStream(file);

        // 声明一个工作薄
        workbook = new HSSFWorkbook();
        // 生成一个表格
        HSSFSheet sheet = workbook.createSheet();
        write2Sheet(sheet, headers, dataset, title, workbook);

        try {
            workbook.write(out);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     * 每个sheet的写入
     *
     * @param sheet   页签
     * @param headers 表头
     * @param dataset 数据集合
     * @param title   大标题
     */
    protected void write2Sheet(HSSFSheet sheet, Map<String, String> headers, List<Map<String, Object>> dataset,
                               String title, HSSFWorkbook workbook) {
        HSSFCellStyle titleStyle = createTitleStyle(workbook);
        writeTitle(sheet, title, titleStyle);

        writeHeaders(sheet, headers);

        writeCellData(sheet, dataset, workbook);

    }

    protected void writeTitle(HSSFSheet sheet, String title, HSSFCellStyle titleStyle) {
        HSSFRow rowTitle = sheet.createRow(0);

        HSSFCell cell = rowTitle.createCell(0);
        cell.setCellStyle(titleStyle);
        cell.setCellValue(new HSSFRichTextString(title));

        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));
        cell = rowTitle.createCell(8);
        cell.setCellValue(DateUtil.nowDateToYMDSMS());

    }

    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {


    }

    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {

    }

    protected HSSFCellStyle createTitleStyle(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle = workbook.createCellStyle();

        HSSFFont hssfFont = workbook.createFont();
        hssfFont.setFontHeightInPoints((short) 20);
        hssfFont.setFontName("楷体");
        hssfFont.setBoldweight(Font.BOLDWEIGHT_BOLD);

        cellStyle.setFont(hssfFont);
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        return cellStyle;
    }

    protected void setSheetRowData(HSSFSheet sheet, List<Map<String, Object>> dataset, String[] keys, int rowIndex) {
        for (int i = 0; i < dataset.size(); ++i) {
            HSSFRow row = sheet.createRow(rowIndex++);

            //设置序号
            HSSFCell cell = row.createCell(0);
            cell.setCellValue(new HSSFRichTextString(String.valueOf(rowIndex - 2)));

            int columnIndex = 1;
            for (String key : keys) {
                cell = row.createCell(columnIndex++);
                cell.setCellValue(new HSSFRichTextString(dataset.get(i).get(key) + ""));
            }
        }
    }

    protected CellStyle createCellStyle() {
        return workbook.createCellStyle();
    }

    private void setFontSize(CellStyle cellStyle, short size) {
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints(size);
        cellStyle.setFont(font);
    }

    protected CellStyle setAlignmentCenter(CellStyle cellStyle, HSSFCell cell) {
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cell.setCellStyle(cellStyle);

        return cellStyle;
    }

    protected CellStyle setCellFontStyle(CellStyle cellStyle, HSSFCell cell, short fontSize) {
        setFontSize(cellStyle, fontSize);
        cell.setCellStyle(cellStyle);

        return cellStyle;
    }

    protected void setDefaultRowHeight(HSSFSheet sheet, Integer height) {
        Iterator<Row> rowIterator = sheet.rowIterator();
        rowIterator.next();
        while (rowIterator.hasNext()) {
            rowIterator.next().setHeightInPoints(height);
        }
    }
}
