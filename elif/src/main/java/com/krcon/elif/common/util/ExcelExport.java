package com.krcon.elif.common.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;

public abstract class ExcelExport implements DownloadableFile {
    private static final Logger logger = LoggerFactory.getLogger(ExcelExport.class);
    // private static final Path EXCEL_TEMP_FILE_PATH;

    static {
        // EXCEL_TEMP_FILE_PATH = Paths.get(System.getProperty("user.dir")).resolve("upload/excelStaging");
        // logger.info("Excel temp file staging path set to->" + EXCEL_TEMP_FILE_PATH.toAbsolutePath());
        // if (!Files.exists(EXCEL_TEMP_FILE_PATH)) {
        //     try {
        //         Files.createDirectories(EXCEL_TEMP_FILE_PATH);
        //     } catch (IOException e) {
        //         logger.error("Could not create temp page", e);
        //     }
        // }
        // TempFile.setTempFileCreationStrategy(new DefaultTempFileCreationStrategy(EXCEL_TEMP_FILE_PATH.toFile()));
        // // 이전사용된 파일삭제
        // try {
        //     for (Path path : Files.list(EXCEL_TEMP_FILE_PATH).collect(Collectors.toList())) {
        //         logger.info("Deleting old Excel temp file->" + path.toAbsolutePath());
        //         Files.deleteIfExists(path);
        //     }
        // } catch (IOException e) {
        //     logger.error("Exception occurred during Excel temp file deletion", e);
        // }
    }

    protected final Font boldFont;
    protected final XSSFCellStyle boldStyle;
    private final Workbook workbook;

    public ExcelExport(boolean useStreaming) {
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        boldFont = xssfWorkbook.createFont();
        boldFont.setBold(true);
        boldStyle = xssfWorkbook.createCellStyle();
        boldStyle.setFont(boldFont);

        // 대용량 엑셀파일을 처리할 때는 스트리밍방식의 SXSSFWorkbook을 사용
        if (useStreaming) {
            workbook = new SXSSFWorkbook(xssfWorkbook, 100);
        } else {
            workbook = xssfWorkbook;
        }
    }

    
    /** 
     * @return byte[]
     */
    @Override
    public byte[] getBytes() {
        Long startTime = System.currentTimeMillis();
        logger.info("start getBytes for Excel");
        byte[] bytes;
        try (ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
            workbook.write(byteArrayOutputStream);
            bytes = byteArrayOutputStream.toByteArray();
            // 스트리밍 방식이 사용되었다면 해제
            if (workbook instanceof SXSSFWorkbook) {
                ((SXSSFWorkbook) workbook).dispose();
            }
        } catch (IOException e) {
            logger.error("Failed to convert Excel to byte array", e);
            throw new RuntimeException("Failed to convert Excel to byte array: " + e.getMessage());
        }
        Long endTime = System.currentTimeMillis();
        logger.info("end getBytes for Excel->" + (endTime - startTime) / 1000 + " seconds.");
        return bytes;
    }
    
    
    /** 
     * @param workbook
     * @return byte[]
     */
    @Override
    public byte[] getBytes(XSSFWorkbook workbook) {
        Long startTime = System.currentTimeMillis();
        logger.info("start getBytes for Excel");
        byte[] bytes;
        try (ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
            workbook.write(byteArrayOutputStream);
            bytes = byteArrayOutputStream.toByteArray();
        } catch (IOException e) {
            logger.error("Failed to convert Excel to byte array", e);
            throw new RuntimeException("Failed to convert Excel to byte array: " + e.getMessage());
        }
        Long endTime = System.currentTimeMillis();
        logger.info("end getBytes for Excel->" + (endTime - startTime) / 1000 + " seconds.");
        return bytes;
    }

    
    /** 
     * @return MediaType
     */
    @Override
    public MediaType getContentType() {
        return MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    }

    
    /** 
     * @return XSSFWorkbook
     */
    protected XSSFWorkbook getXSSFWorkbook() {
        return (XSSFWorkbook) workbook;
    }

    
    /** 
     * @return SXSSFWorkbook
     */
    protected SXSSFWorkbook getSXSSFWorkbook() {
        return (SXSSFWorkbook) workbook;
    }

    
    /** 
     * @param workbook
     * @param columns
     * @param rows
     */
    protected void addDataToWorkbook(Workbook workbook, int columns, int rows) {
        Long sheetStartTime = System.currentTimeMillis();
        logger.info("start sheet generation");
        Sheet dataSheet = workbook.createSheet("Data");
        for (int i = 0; i < rows; i++) {
            Row row = dataSheet.createRow(i);
            for (int j = 0; j < columns; j++) {
                Cell cell = row.createCell(j);
                cell.setCellValue(new CellReference(cell).formatAsString());
            }
        }
        Long endSheetTime = System.currentTimeMillis();
        logger.info("Total sheet generation time " + (endSheetTime - sheetStartTime) / 1000 + " seconds.");
    }
    
    
    /** 
     * @param workbook
     * @param dataList
     * @param HashMap<String
     * @param headerMap
     */
    protected void addDataToWorkbook(Workbook workbook, List<Map<String, Object>> dataList, HashMap<String, String[]> headerMap) {
        Long sheetStartTime = System.currentTimeMillis();
        logger.info("start sheet generation");
        Row row = null;
        Cell cell = null;
        		
        Sheet dataSheet = workbook.createSheet("Data");
        int rowIndex = 0;
   
        /******************************** 헤더 설정 ************************************/
        String [] cellHeader = headerMap.get("cellHeader");
        String [] dataColName = headerMap.get("dataColName");
//        String[] cellHeader = {"회사", "부서","이름","이메일","구독 언어","동록일시"};
//        String[] dataColName = {"COMPANY", "DEPARTMENT","NAME","EMAIL","LANG","CREA_DTM"};
        row = dataSheet.createRow(rowIndex++);
        CellStyle headerCellStyle = dataSheet.getWorkbook().createCellStyle();
        Font font = dataSheet.getWorkbook().createFont();
        headerCellStyle.setBorderBottom(BorderStyle.THIN);
        headerCellStyle.setBorderLeft(BorderStyle.THIN);
        headerCellStyle.setBorderRight(BorderStyle.THIN);
        headerCellStyle.setBorderTop(BorderStyle.THIN);
        headerCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
        font.setBold(Boolean.TRUE);
        headerCellStyle.setFont(font);
        for (int h = 0; h < cellHeader.length; h++) {
            cell = row.createCell(h);
            cell.setCellStyle(headerCellStyle);
        	cell.setCellValue((cellHeader[h]));
        	dataSheet.autoSizeColumn(h);
        	dataSheet.setColumnWidth(h, (dataSheet.getColumnWidth(h))+(short)2500);
        }
        /******************************** 데이터 설정 ************************************/
        CellStyle dataCellStyle = dataSheet.getWorkbook().createCellStyle();
        dataCellStyle.setBorderBottom(BorderStyle.THIN);
        dataCellStyle.setBorderLeft(BorderStyle.THIN);
        dataCellStyle.setBorderRight(BorderStyle.THIN);
        dataCellStyle.setBorderTop(BorderStyle.THIN);
        dataCellStyle.setAlignment(HorizontalAlignment.CENTER);
        for (Map<String, Object> rowDataMap : dataList) {
            row = dataSheet.createRow(rowIndex++);
            for (int j = 0; j < dataColName.length; j++) {
            	cell = row.createCell(j);
            	cell.setCellStyle(dataCellStyle);
                cell.setCellValue((String)rowDataMap.get(dataColName[j]));
            }
        }
        Long endSheetTime = System.currentTimeMillis();
        logger.info("Total sheet generation time " + (endSheetTime - sheetStartTime) / 1000 + " seconds.");
    }

    
    /** 
     * @param workbook
     */
    protected void addRichTextCell(Workbook workbook) {
        Sheet richTextSheet = workbook.createSheet("Rich Text Sheet");
        XSSFRichTextString richTextString = new XSSFRichTextString("Label: The label section should be bold.  This doesn't work when Streaming Excel is used though.");
        richTextString.applyFont(0, "Label:".length(), boldFont);
        Cell cell = richTextSheet.createRow(0).createCell(0);
        cell.setCellValue(richTextString);
    }
    
    
    /** 
     * @param cellStyle
     */
    public void setHeaderStyle(CellStyle cellStyle ) {
    	cellStyle.setBorderBottom(BorderStyle.THIN);
    	cellStyle.setBorderLeft(BorderStyle.THIN);
    	cellStyle.setBorderRight(BorderStyle.THIN);
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
    }
    
    
    /** 
     * @param cellStyle
     */
    protected void setBodyLineStyle(CellStyle cellStyle ) {
    	cellStyle.setBorderBottom(BorderStyle.THIN);
    	cellStyle.setBorderLeft(BorderStyle.THIN);
    	cellStyle.setBorderRight(BorderStyle.THIN);
    	cellStyle.setBorderTop(BorderStyle.THIN);
    }
    
}