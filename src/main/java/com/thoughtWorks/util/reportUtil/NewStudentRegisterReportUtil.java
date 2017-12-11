package com.thoughtWorks.util.reportUtil;

import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.*;

public class NewStudentRegisterReportUtil extends ExcelReportUtil {
    @Override
    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {
        HSSFRow row = sheet.createRow(1);
        Map<String, String> params = new LinkedHashMap<>();
        params.put("fenyuan", "分院：");
        params.put("professionName", "专业：");
        params.put("classesName", "班级：");
        params.put("no", "学号：");
        params.put("in_school", "入学时间：");
        Set<String> keys = params.keySet();
        int columnIndex = 0;
        for (String key : keys) {
            HSSFCell cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(params.get(key)));
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(headers.get(key)));
        }


    }

    @Override
    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        try {
            sheet.setColumnWidth((short) 1, (short) 3000);
            sheet.setColumnWidth((short) 3, (short) 3000);
            sheet.setColumnWidth((short) 5, (short) 4000);
            sheet.setColumnWidth((short) 7, (short) 4500);
            sheet.setColumnWidth((short) 9, (short) 4800);
            sheet.setColumnWidth((short) 10, (short) 3000);

            setBasicInformation(sheet, dataset, workbook);

            setOwnExperience(sheet, dataset);

            setFamilyInformation(sheet, dataset);

            setDefaultRowHeight(sheet,20);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void setFamilyInformation(HSSFSheet sheet, List<Map<String, Object>> dataset) {
        List<Map<String, String>> familys = (List<Map<String, String>>) dataset.get(0).get("family");
        HSSFCell cell;
        int rowIndex = 14;
        HSSFRow row = sheet.createRow(rowIndex);

        cell = row.createCell(0);
        cell.setCellValue(new HSSFRichTextString("直系亲属或主要社会关系情况"));
        CellStyle cellStyle = createCellStyle();
        cellStyle = setAlignmentCenter(cellStyle,cell);
        setCellFontStyle(cellStyle,cell, (short)14);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0, 10));
        Map<String, String> params = new LinkedHashMap<>();
        params.put("relationship", "称呼");
        params.put("name", "姓名");
        params.put("political_status", "政治面貌");
        params.put("staff", "职务");
        params.put("work_place", "工作单位");
        params.put("phone", "联系电话");
        Set<String> keys = params.keySet();
        row = sheet.createRow(++rowIndex);
        int columnIndex = 0;
        for (String key : keys) {
            cell = row.createCell(columnIndex);
            cell.setCellValue(new HSSFRichTextString(params.get(key)));
            if ("work_place".equals(key)) {
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 5));
                columnIndex += 6;
            } else {
                ++columnIndex;
            }
        }
        for (Map<String, String> family : familys) {
            row = sheet.createRow(++rowIndex);
            columnIndex = 0;
            for (String key : keys) {
                cell = row.createCell(columnIndex);
                cell.setCellValue(new HSSFRichTextString(family.get(key)));
                if ("work_place".equals(key)) {
                    sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 5));
                    columnIndex += 6;
                } else {
                    ++columnIndex;
                }
            }
        }
    }

    private void setOwnExperience(HSSFSheet sheet, List<Map<String, Object>> dataset) {
        List<Map<String, Object>> experiences = (List<Map<String, Object>>) dataset.get(0).get("experience");
        HSSFCell cell;
        int rowIndex = 8;
        HSSFRow row = sheet.createRow(rowIndex);

        cell = row.createCell(0);
        cell.setCellValue(new HSSFRichTextString("本人学历及社会经历(从小学起)"));
        CellStyle cellStyle = createCellStyle();
        cellStyle = setAlignmentCenter(cellStyle,cell);
        setCellFontStyle(cellStyle,cell, (short)14);
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0, 10));

        Map<String, String> params = new LinkedHashMap<>();
        params.put("start_time", "自何年何月");
        params.put("end_time", "至何年何月");
        params.put("work_place", "在何地何校或和单位学习或工作，任何职");
        params.put("witness", "证明人");
        Set<String> keys = params.keySet();
        row = sheet.createRow(++rowIndex);

        int columnIndex = 0;
        for (String key : keys) {
            cell = row.createCell(columnIndex);
            if ("work_place".equals(key)) {
                cell.setCellValue(new HSSFRichTextString(params.get(key)));
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 5));
                columnIndex += 6;
            } else if ("witness".equals(key)) {
                cell.setCellValue(new HSSFRichTextString(params.get(key)));
                ++columnIndex;
            } else {
                cell.setCellValue(new HSSFRichTextString(params.get(key)));
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 1));
                columnIndex += 2;
            }
        }
        for (Map<String, Object> experience : experiences) {
            row = sheet.createRow(++rowIndex);
            columnIndex = 0;
            for (String key : keys) {
                cell = row.createCell(columnIndex);
                if ("work_place".equals(key)) {
                    cell.setCellValue(new HSSFRichTextString(experience.get(key) + "" + experience.get("staff")));
                    sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 5));
                    columnIndex += 6;
                } else if ("witness".equals(key)) {
                    cell.setCellValue(new HSSFRichTextString(experience.get(key) + ""));
                    ++columnIndex;
                } else {
                    cell.setCellValue(new HSSFRichTextString(experience.get(key) + ""));
                    sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 1));
                    columnIndex += 2;
                }
            }
        }
    }

    private void setBasicInformation(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        Map<String, Object> data = (Map<String, Object>) dataset.get(0).get("basicStudentInfo");
        int rowIndex = 2;

        setHeadImage(sheet, data, workbook);

        // the second row data
        Map<String, String> params = new LinkedHashMap<>();
        params.put("studentName", "姓名:");
        params.put("gender", "性别:");
        params.put("born", "出生年月:");
        params.put("famous_family", "民族:");
        params.put("is_marry", "婚否:");
        setBasicInformationRows(sheet, rowIndex, params, data);

        // the third row data
        ++rowIndex;
        params.clear();
        params.put("origin_address", "籍贯:");
        params.put("political_status", "政治面貌:");
        params.put("culture_high", "文化程度:");
        params.put("student_classify", "学生类别:");
        setBasicInformationThirdRow(sheet, rowIndex, params, data);

        // the forth row data
        ++rowIndex;
        params.clear();
        params.put("actual_address", "家庭住址:");
        params.put("family_zip_code", "邮政编码:");
        params.put("family_phone", "电话:");
        setBasicInformationForthRow(sheet, rowIndex, params, data);

        // the forth-Fifth row data
        ++rowIndex;
        params.clear();
        params.put("pre_school_work", "来校前毕业学校或工作单位:");
        params.put("pre_school_staff", "任何职务:");
        params.put("health_status", "健康状况:");
        params.put("idcard", "身份证号码:");
        setBasicInformationForthAndFifthRow(sheet, rowIndex, params, data);


        // the fifth row data
        ++rowIndex;
        params.clear();
        params.put("own_experience", "何时何地经何人介绍加入何党派或团体组织:");
        setBasicInformationFifthOrSixthRow(sheet, rowIndex, params, data);

        // the sixth row data
        ++rowIndex;
        params.clear();
        params.put("own_punishment", "何时何地因何原因受过何奖励或处分:");
        setBasicInformationFifthOrSixthRow(sheet, rowIndex, params, data);
    }

    private void setBasicInformationForthAndFifthRow(HSSFSheet sheet, int rowIndex, Map<String, String> params, Map<String, Object> dataset) {
        HSSFCell cell;
        int columnIndex = 0;
        Set<String> keys = params.keySet();
        HSSFRow row = sheet.createRow(rowIndex);

        for (String key : keys) {
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(params.get(key)));
            if ("pre_school_work".equals(key)) {
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex - 1, columnIndex));
                cell = row.createCell(++columnIndex);
                cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 1));
                columnIndex += 2;
            } else {
                cell = row.createCell(columnIndex++);
                cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
            }

        }
    }

    private void setHeadImage(HSSFSheet sheet, Map<String, Object> data, HSSFWorkbook workbook) {
        BufferedImage bufferImg;
        try {
            ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
            bufferImg = ImageIO.read(new File(data.get("head_image").toString()));
            ImageIO.write(bufferImg, "jpg", byteArrayOut);

            HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
            HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 0, 0, (short) 10, 1, (short) 11, 6);
            patriarch.createPicture(anchor, workbook.addPicture(byteArrayOut.toByteArray(), HSSFWorkbook.PICTURE_TYPE_JPEG));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void setBasicInformationFifthOrSixthRow(HSSFSheet sheet, int rowIndex, Map<String, String> params, Map<String, Object> dataset) {
        HSSFCell cell;
        String key = params.keySet().iterator().next();
        HSSFRow row = sheet.createRow(rowIndex);

        cell = row.createCell(0);
        cell.setCellValue(new HSSFRichTextString(params.get(key)));
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 0, 4));
        cell = row.createCell(5);
        cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
        sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 5, 10));
    }

    private void setBasicInformationForthRow(HSSFSheet sheet, int rowIndex, Map<String, String> params, Map<String, Object> dataset) {
        HSSFCell cell;
        int columnIndex = 0;
        Set<String> keys = params.keySet();
        HSSFRow row = sheet.createRow(rowIndex);

        for (String key : keys) {
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(params.get(key)));
            if ("actual_address".equals(key)) {
                cell = row.createCell(columnIndex);
                cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex, columnIndex + 4));
                columnIndex += 5;
            } else {
                cell = row.createCell(columnIndex++);
                cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
            }

        }
    }

    private void setBasicInformationThirdRow(HSSFSheet sheet, int rowIndex, Map<String, String> params, Map<String, Object> dataset) {
        HSSFCell cell;
        int columnIndex = 0;
        Set<String> keys = params.keySet();
        HSSFRow row = sheet.createRow(rowIndex);

        for (String key : keys) {
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(params.get(key)));
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
            if ("culture_high".equals(key)) cell.setCellValue(new HSSFRichTextString("高中"));
            if ("origin_address".equals(key) || "student_classify".equals(key)) {
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, columnIndex - 1, columnIndex));
                ++columnIndex;
            }
        }
    }

    private void setBasicInformationRows(HSSFSheet sheet, int rowIndex, Map<String, String> params, Map<String, Object> dataset) {
        HSSFCell cell;
        int columnIndex = 0;
        HSSFRow row = sheet.createRow(rowIndex);

        Set<String> keys = params.keySet();
        for (String key : keys) {
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(params.get(key)));
            cell = row.createCell(columnIndex++);
            cell.setCellValue(new HSSFRichTextString(dataset.get(key) == null ? "" : dataset.get(key) + ""));
        }
    }


}
