/**
 * @author SargerasWang
 */
package utilTest.excelUtil;


import com.thoughtWorks.util.excelUtil.ExcelUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Collection;
import java.util.Map;

/**
 * The <code>TestImportMap</code>	
 * 
 * @author SargerasWang
 * Created at 2014年9月21日 下午5:06:17
 */
public class TestImportMap {
  @SuppressWarnings("rawtypes")
  public static void main(String[] args) throws FileNotFoundException {
    File f=new File("/home/acey/Documents/Book1.xlsx");
    InputStream inputStream= new FileInputStream(f);

    Collection<Map> importExcel = ExcelUtil.importExcel(Map.class, f, "yyyy/MM/dd HH:mm:ss",  0);

    for(Map m : importExcel){
      System.out.println(m);
    }
  }
}
