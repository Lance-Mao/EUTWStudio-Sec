package com.thoughtWorks.util.reportUtil;

import com.thoughtWorks.entity.StudentInfoReportStatistic;
import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import org.apache.poi.hssf.record.ObjRecord;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StudentInfoReportUtil extends ExcelReportUtil {
    private HSSFSheet sheet;
    private HSSFRow row;
    private HSSFCell cell;
    private int rowIndex;
    private String[] types = {"班级人数", "休学", "退学", "留级", "流失", "复学", "入伍", "欠费", "合作企业", "自主实习", "创新创业", "专升本", "其它", "在读"};
    private Map<String, Integer> TotalCount;
    private Map<String, Integer> SubtotalCount;

    public StudentInfoReportUtil() {
        TotalCount = new HashMap<>();
        for (String type : types)
            TotalCount.put(type, 0);
    }
    @Override
    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {
        this.sheet = sheet;
        row = sheet.createRow(1);

        int columnIndex = 0;
        for (String key : headers.keySet()) {
            HSSFCell cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(headers.get(key)));
        }
        setDefaultRowHeight(sheet, 18);
    }

    @Override
    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        try {
            rowIndex = 2;
            sheet.setColumnWidth((short) 0, (short) 3000);
            sheet.setColumnWidth((short) 2, (short) 3000);
            sheet.setColumnWidth((short) 3, (short) 4000);

            for (Map<String, Object> department : dataset) {
                SubtotalCount = new HashMap<>();
                for (String type : types) {
                    SubtotalCount.put(type, 0);
                }
                row = sheet.createRow(rowIndex);
                cell = row.createCell(0);
                cell.setCellValue(new HSSFRichTextString(department.get("departmentName").toString()));

                int rowspan = getDepartmentRowspan(department);
                mergeRows(rowspan, 0, 0);
                    fillDepartmentLevels((List<Map<String, Object>>) department.get("levels"));

                //统计小计
                row = sheet.createRow(rowIndex);
                cell = row.createCell(0);
                cell.setCellValue("小计");
                for(int i = 0;i<types.length;i++){
                    for (String key : SubtotalCount.keySet()) {
                        if (key.equals(types[i])) {
                            cell = row.createCell(i+5);
                            cell.setCellValue(SubtotalCount.get(key));
                            CellStyle cellStyle = workbook.createCellStyle();//创建样式
                            cellStyle.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);//设置单元格水平方向对其方式
                            cell.setCellStyle(cellStyle);
                            break;
                        }
                    }
                }
                setAlignmentCenter(createCellStyle(), cell);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex,rowIndex,0,4));
                rowIndex++;
            }
            //统计总数
            row = sheet.createRow(rowIndex);
            cell = row.createCell(0);
            cell.setCellValue("总计");
            for(int i = 0;i<types.length;i++){
                for (String key : TotalCount.keySet()) {
                    if (key.equals(types[i])) {
                        cell = row.createCell(i+5);
                        cell.setCellValue(TotalCount.get(key));
                        CellStyle cellStyle = workbook.createCellStyle();//创建样式
                        cellStyle.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);//设置单元格水平方向对其方式
                        cell.setCellStyle(cellStyle);
                        break;
                    }
                }
            }
            sheet.addMergedRegion(new CellRangeAddress(rowIndex,rowIndex,0,4));
            setAlignmentCenter(createCellStyle(), cell);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void fillTheProfessionalMentor(List<Map<String, Object>> dataset) {
        for (Map<String, Object> teacherName : dataset) {
            row = sheet.createRow(rowIndex);
            cell = row.createCell(4);
            cell.setCellValue(new HSSFRichTextString(teacherName.get("teacherName").toString()));
            setAlignmentCenter(createCellStyle(), cell);
            int rowspan = 4;
            mergeRows(rowspan, 4, 4);
        }
    }

    private void fillDepartmentLevels(List<Map<String, Object>> levels) {
        for (Map<String, Object> level : levels) {
            if (((List) (level.get("directions"))).size() == 0) continue;
            cell = row.createCell(1);
            cell.setCellValue(new HSSFRichTextString(level.get("level").toString()));
            setAlignmentCenter(createCellStyle(), cell);
            int rowspan = getLevelRowspan(level);
            mergeRows(rowspan, 1, 1);

            fillLevelDirection((List<Map<String, Object>>) level.get("directions"));
        }
    }

    private void fillLevelDirection(List<Map<String, Object>> directions) {

        for (Map<String, Object> direction : directions) {
            if (((List) (direction.get("classess"))).size() == 0) continue;
            cell = row.createCell(2);
            cell.setCellValue(new HSSFRichTextString(direction.get("directionName").toString()));
            setAlignmentCenter(createCellStyle(), cell);
            int rowspan = getDirectionRowspan(direction);
            mergeRows(rowspan, 2, 2);

            fillDirectionClassess((List<Map<String, Object>>) direction.get("classess"));
        }
    }

    private void fillDirectionClassess(List<Map<String, Object>> classess) {

        for (Map<String, Object> classes : classess) {
            int column = 3;
            cell = row.createCell(column++);
            cell.setCellValue(new HSSFRichTextString(classes.get("classesName").toString()));
            cell = row.createCell(column++);
            if (null != classes.get("teacherName")) {
                cell.setCellValue(new HSSFRichTextString(classes.get("teacherName").toString()));
            }else{
                cell.setCellValue(new HSSFRichTextString(""));

            }
            Map<String, Integer> reportCount = ((StudentInfoReportStatistic) classes.get("reportCount")).getStatisticCount();
            for (String key : types) {
                cell = row.createCell(column++);
                cell.setCellValue(new HSSFRichTextString((reportCount.get(key) == 0 ? "":reportCount.get(key) .toString())));
            }

            for (String key : TotalCount.keySet()) {
                for (String key2 : reportCount.keySet()) {
                    if (key.equals(key2)) {
                        int count = (int) TotalCount.get(key);
                        TotalCount.put(key, reportCount.get(key2)+count);
                        break;
                    }
                }
            }
            for (String key : SubtotalCount.keySet()) {
                for (String key2 : reportCount.keySet()) {
                    if (key.equals(key2)) {
                        int count = (int) SubtotalCount.get(key);
                        SubtotalCount.put(key, reportCount.get(key2)+count);
                        break;
                    }
                }
            }
            row = sheet.createRow(++rowIndex);
        }
    }

    private void mergeRows(int rowspan, int firstCol, int lastCol) {
        if (rowspan >= 2)
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex + rowspan - 1, firstCol, lastCol));
    }

    private int getDepartmentRowspan(Map<String, Object> department) {
        int result = 0;

        for (Map<String, Object> level : (List<Map<String, Object>>) department.get("levels"))
            result += getLevelRowspan(level);

        return result;
    }

    private int getLevelRowspan(Map<String, Object> level) {
        int result = 0;

        for (Map<String, Object> direction : (List<Map<String, Object>>) level.get("directions"))
            result += getDirectionRowspan(direction);

        return result;
    }

    private int getDirectionRowspan(Map<String, Object> direction) {
        return ((List) (direction.get("classess"))).size();
    }

    private int getTeacherRowspan(Map<String, Object> teacherName) {
        int result = 0;

        return ((List) (teacherName.get("teacherName"))).size();
    }


}
