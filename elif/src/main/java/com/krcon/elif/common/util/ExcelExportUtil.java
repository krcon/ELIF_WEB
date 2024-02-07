package com.krcon.elif.common.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import com.krcon.elif.vo.BoardDownload;
import com.krcon.elif.vo.Customer;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.ResponseEntity;

@Configuration
@PropertySource("classpath:system.properties")

public class ExcelExportUtil extends ExcelExport implements DownloadableFile {
	@Value("${sys.upload.path}")
    private String uploadPath;
	
	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;
	
	Logger log = LoggerFactory.getLogger(this.getClass());


    public ExcelExportUtil(int columns, int rows) {
        super(false);
        buildTest(columns, rows);
    }

    public ExcelExportUtil() {
        super(false);
    }
    
    
    /** 
     * @param columns
     * @param rows
     */
    private void buildTest(int columns, int rows) {
        addDataToWorkbook(getXSSFWorkbook(), columns, rows);
        addRichTextCell(getXSSFWorkbook());
    }
    
    
    /** 
     * @param dataList
     */
    public void build(List<Map<String, Object>> dataList) {
       
    }


    
    /** 
     * @param dataList
     * @param inquiry_type
     * @return ResponseEntity<byte[]>
     * @throws UnsupportedEncodingException
     */
    public ResponseEntity<byte[]> makeCustomer(List<Customer> dataList,String inquiry_type) throws UnsupportedEncodingException {
    	Row row = null;
        Cell cell = null;
        		
        Sheet dataSheet = getXSSFWorkbook().createSheet("Data");
        int rowIndex = 1;
    	
        /******************************** 헤더 설정 ************************************/
        
        String[] cellHeader = {"번호","이름", "국가","이메일","회사","연락처","직무","언어","답변상태","제목","문의내용","등록일시"};
        
        if(inquiry_type.equals("PRODUCT")){
            cellHeader = Stream.of("번호","이름", "국가","이메일","회사","연락처","직무","언어","답변상태","문의유형","관심 분야","제목","문의내용","등록일시").toArray(String[]::new);
        }else if(inquiry_type.equals("SAMPLE")){
            cellHeader = Stream.of("번호","이름", "국가","이메일","회사","도시","주소","연락처","직무","언어","답변상태","요청제품","제목","문의내용","등록일시").toArray(String[]::new);
        }
        row = dataSheet.createRow(0);
        CellStyle headerCellStyle = dataSheet.getWorkbook().createCellStyle();
        Font font = dataSheet.getWorkbook().createFont();
        font.setBold(Boolean.TRUE);
        headerCellStyle.setFont(font);
        setHeaderStyle(headerCellStyle);
        
        for (int h = 0; h < cellHeader.length; h++) {
            cell = row.createCell(h);
            cell.setCellStyle(headerCellStyle);
        	cell.setCellValue((cellHeader[h]));
        	dataSheet.autoSizeColumn(h);
        	dataSheet.setColumnWidth(h, 4000);
        }
        /******************************** 데이터 설정 ************************************/
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        CellStyle dataCellStyle = dataSheet.getWorkbook().createCellStyle();
        dataCellStyle.setAlignment(HorizontalAlignment.CENTER);
        setBodyLineStyle(dataCellStyle);
        int createCell = 0;
        for (Customer vo : dataList) {
            row = dataSheet.createRow(rowIndex);
            createCell = 0;
            // 컬럼셋팅
            cell = row.createCell(0);
        	cell.setCellStyle(dataCellStyle);
            cell.setCellValue(rowIndex++);
            // "번호","이름", "국가","이메일","회사","연락처","직무","언어","답변상태","문의유형","관심 분야","제목","문의내용","등록일시"
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getName());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getEmail());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getTel());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getDepartment());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getLang());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getReply_status_name());
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue(CommonUtils.getXssDecode((String)vo.getTitle()));
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getInquiry_content());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue(format.format(vo.getCrea_dtm()));
            

        }
        return super.getResponseEntity(getFilename("고객센터"+"_"+inquiry_type));
    }
    
    
    /** 
     * @param dataList
     * @return ResponseEntity<byte[]>
     */
    public ResponseEntity<byte[]> makeNewsletter(List<Customer> dataList) {
    	Row row = null;
        Cell cell = null;
        		
        Sheet dataSheet = getXSSFWorkbook().createSheet("Data");
        int rowIndex = 1;
    	
        /******************************** 헤더 설정 ************************************/
        String[] cellHeader = {"번호","이메일","이름","연락처","국가","회사", "직무","관심분야","등록일시"};
        int[] colSize = { 4500,4500, 4000, 3000, 7000, 7000, 7000, 7000, 7000};
        row = dataSheet.createRow(0);
        CellStyle headerCellStyle = dataSheet.getWorkbook().createCellStyle();
        Font font = dataSheet.getWorkbook().createFont();
        font.setBold(Boolean.TRUE);
        headerCellStyle.setFont(font);
        setHeaderStyle(headerCellStyle);
        
        for (int h = 0; h < cellHeader.length; h++) {
            cell = row.createCell(h);
            cell.setCellStyle(headerCellStyle);
        	cell.setCellValue((cellHeader[h]));
        	dataSheet.autoSizeColumn(h);
        	dataSheet.setColumnWidth(h, colSize[h]);
        }
        /******************************** 데이터 설정 ************************************/
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        CellStyle dataCellStyle = dataSheet.getWorkbook().createCellStyle();
        dataCellStyle.setAlignment(HorizontalAlignment.CENTER);
        setBodyLineStyle(dataCellStyle);
        for (Customer vo : dataList) {
            row = dataSheet.createRow(rowIndex);
            // 컬럼셋팅
            cell = row.createCell(0);
        	cell.setCellStyle(dataCellStyle);
            cell.setCellValue(rowIndex++);
            cell = row.createCell(1);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getEmail());
            cell = row.createCell(2);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getName());
            cell = row.createCell(3);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getTel());
            cell = row.createCell(4);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getDepartment());
            cell = row.createCell(5);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getInterest());
            cell = row.createCell(6);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue(format.format(vo.getCrea_dtm()));
        }
        return super.getResponseEntity(getFilename("관심고객리스트"));
    }
    
    
    /** 
     * @param dataList
     * @return ResponseEntity<byte[]>
     * @throws UnsupportedEncodingException
     */
    public ResponseEntity<byte[]> makeDataDownload(List<BoardDownload> dataList) throws UnsupportedEncodingException {
    	Row row = null;
        Cell cell = null;
        		
        Sheet dataSheet = getXSSFWorkbook().createSheet("Data");
        int rowIndex = 1;
    	
        /******************************** 헤더 설정 ************************************/
        String[] cellHeader = {"번호","언어","자료명", "회사","이메일","등록일시"};
        int[] colSize = {2500, 4500, 4000, 7000, 7000, 7000};
        row = dataSheet.createRow(0);
        CellStyle headerCellStyle = dataSheet.getWorkbook().createCellStyle();
        Font font = dataSheet.getWorkbook().createFont();
        font.setBold(Boolean.TRUE);
        headerCellStyle.setFont(font);
        setHeaderStyle(headerCellStyle);
        
        for (int h = 0; h < cellHeader.length; h++) {
            cell = row.createCell(h);
            cell.setCellStyle(headerCellStyle);
        	cell.setCellValue((cellHeader[h]));
        	dataSheet.autoSizeColumn(h);
        	dataSheet.setColumnWidth(h, colSize[h]);
        }
        /******************************** 데이터 설정 ************************************/
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        CellStyle dataCellStyle = dataSheet.getWorkbook().createCellStyle();
        dataCellStyle.setAlignment(HorizontalAlignment.CENTER);
        setBodyLineStyle(dataCellStyle);
        int createCell = 0;
        for (BoardDownload vo : dataList) {
            row = dataSheet.createRow(rowIndex);
            createCell = 0;
            row = dataSheet.createRow(rowIndex);
            // 컬럼셋팅
            cell = row.createCell(0);
        	cell.setCellStyle(dataCellStyle);
            cell.setCellValue(rowIndex++);
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getLang());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue(CommonUtils.getXssDecode((String)vo.getTitle()));
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getCompany());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue((String)vo.getEmail());
            createCell++;
            cell = row.createCell(createCell);
            cell.setCellStyle(dataCellStyle);
            cell.setCellValue(format.format(vo.getCrea_dtm()));

        }
        return super.getResponseEntity(getFilename("자료실다운로드내역"));
    }
    

    
    /** 
     * @return String
     */
    @Override
    public String getFilename() {
    	String fileName = "";
    	try {
			fileName = new String("관심고객등록 엑셀 다운로드".getBytes("UTF-8"),"ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return fileName + ".xlsx";
    }
    
    
    /** 
     * @param file
     * @return String
     */
    @Override
    public String getFilename(String file) {
    	String fileName = "";
    	try {
			fileName = new String(file.getBytes("UTF-8"),"ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        return fileName + ".xlsx";
    }
    
}