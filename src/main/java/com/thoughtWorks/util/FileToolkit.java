package com.thoughtWorks.util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.*;

import java.io.*;

public final class FileToolkit {

    public static void main(String[] args) {
        //待测方法.....
    }

    /**
     * 复制文件或者目录,复制前后文件完全一样。
     *
     * @author tw 2009-07-16
     * @param resFilePath
     *            源文件路径
     * @param distFolder
     *            目标文件夹
     * @IOException 当操作发生异常时抛出
     */
    public static void copyFile(String resFilePath, String distFolder)
            throws IOException {
        File resFile = new File(resFilePath);
        File distFile = new File(distFolder);
        if (resFile.isDirectory()) { // 目录时
            FileUtils.copyDirectoryToDirectory(resFile, distFile);
        } else if (resFile.isFile()) { // 文件时
            // FileUtils.copyFileToDirectory(resFile, distFile, true);
            FileUtils.copyFileToDirectory(resFile, distFile);
        }
    }

    /**
     * 删除一个文件或者目录
     *
     * @author tw 2009-07-16
     * @param targetPath
     *            文件或者目录路径
     * @IOException 当操作发生异常时抛出
     */
    public static void deleteFile(String targetPath) throws IOException {
        File targetFile = new File(targetPath);
        if (targetFile.isDirectory()) {
            FileUtils.deleteDirectory(targetFile);
        } else if (targetFile.isFile()) {
            targetFile.delete();
        }
    }

    /**
     * 移动文件或者目录,移动前后文件完全一样,如果目标文件夹不存在则创建。
     *
     * @param resFilePath
     *            源文件路径
     * @param distFolder
     *            目标文件夹
     * @IOException 当操作发生异常时抛出
     */
    public static void moveFile(String resFilePath, String distFolder)
            throws IOException {
        File resFile = new File(resFilePath);
        File distFile = new File(distFolder);
        if (resFile.isDirectory()) {
             FileUtils.moveDirectoryToDirectory(resFile, distFile,true);
        } else if (resFile.isFile()) {
             FileUtils.moveFileToDirectory(resFile, distFile, true);
        }
    }

    /**
     * 重命名文件或文件夹
     *
     * @param resFilePath
     *            源文件路径
     * @param newFileName
     *            重命名
     * @return 操作成功标识
     */
//    public static boolean renameFile(String resFilePath, String newFileName) {
//        // 格式化路径
//        String newFilePath = StringToolkit.formatPath(StringToolkit
//                .getParentPath(resFilePath)
//                + "/" + newFileName);
//        File resFile = new File(resFilePath);
//        File newFile = new File(newFilePath);
//        return resFile.renameTo(newFile);
//    }

    /**
     * 读取文件或者目录的大小
     *
     * @param distFilePath
     *            目标文件或者文件夹
     * @return 文件或者目录的大小，如果获取失败，则返回-1
     */
    public static long genFileSize(String distFilePath) {
        File distFile = new File(distFilePath);
        if (distFile.isFile()) {
            return distFile.length();
        } else if (distFile.isDirectory()) {
            return FileUtils.sizeOfDirectory(distFile);
        }
        return -1L;
    }

    /**
     * 判断一个文件是否存在
     *
     * @param filePath
     *            文件路径
     * @return 存在返回true，否则返回false
     */
    public static boolean isExist(String filePath) {
        return new File(filePath).exists();
    }

    /**
     * 本地某个目录下的文件列表（不递归）
     *
     * @param folder
     *            ftp上的某个目录
     * @param suffix
     *            文件的后缀名（比如.mov.xml)
     * @return 文件名称列表
     */
    public static String[] listFilebySuffix(String folder, String suffix) {
        IOFileFilter fileFilter1 = new SuffixFileFilter(suffix);
        IOFileFilter fileFilter2 = new NotFileFilter(
                DirectoryFileFilter.INSTANCE);
        FilenameFilter filenameFilter = new AndFileFilter(fileFilter1,
                fileFilter2);
        return new File(folder).list(filenameFilter);
    }

    /**
     * 将字符串写入指定文件(当指定的父路径中文件夹不存在时，会最大限度去创建，以保证保存成功！)
     *
     * @param res
     *            原字符串
     * @param filePath
     *            文件路径
     * @return 成功标记
     */
    public static boolean string2File(String res, String filePath) {
        boolean flag = true;
        BufferedReader bufferedReader = null;
        BufferedWriter bufferedWriter = null;
        try {
            File distFile = new File(filePath);
            if (!distFile.getParentFile().exists()) {// 不存在时创建
                distFile.getParentFile().mkdirs();
            }
            bufferedReader = new BufferedReader(new StringReader(res));
            bufferedWriter = new BufferedWriter(new FileWriter(distFile));
            char buf[] = new char[1024]; // 字符缓冲区
            int len;
            while ((len = bufferedReader.read(buf)) != -1) {
                bufferedWriter.write(buf, 0, len);
            }
            bufferedWriter.flush();
            bufferedReader.close();
            bufferedWriter.close();
        } catch (IOException e) {
            flag = false;
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 文本文件转换为指定编码的字符串
     *
     * @param file
     *            文本文件
     * @param encoding
     *            编码类型 没有编码方式,传入NULL既可,将使用默认的编码方式
     * @return 转换后的字符串
     * @throws IOException
     */
    public static String file2String(File file, String encoding) {
        InputStreamReader reader = null;
        StringWriter writer = new StringWriter();
        try {
            if (encoding == null || "".equals(encoding.trim())) {
                reader = new InputStreamReader(new FileInputStream(file),
                        encoding);
            } else {
                reader = new InputStreamReader(new FileInputStream(file));
            }
            // 将输入流写入输出流
            char[] buffer = new char[1024*1024];
            int n = 0;
            while (-1 != (n = reader.read(buffer))) {
                writer.write(buffer, 0, n);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        // 返回转换结果
        if (writer != null)
            return writer.toString();
        else
            return null;
    }

}
