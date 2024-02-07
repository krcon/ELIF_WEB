package com.krcon.elif.common.util;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

public interface DownloadableFile {
    byte[] getBytes();

    byte[] getBytes(XSSFWorkbook workbook);
    
    MediaType getContentType();

    String getFilename();

    String getFilename(String file);
    
    default ResponseEntity<byte[]> getResponseEntity() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(getContentType());
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(getFilename())
                .build());
        return new ResponseEntity<>(getBytes(), headers, HttpStatus.OK);
    }
    
    default ResponseEntity<byte[]> getResponseEntity(String fileName) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(getContentType());
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(fileName)
                .build());
        return new ResponseEntity<>(getBytes(), headers, HttpStatus.OK);
    }
    
    default ResponseEntity<byte[]> getResponseEntity(String fileName, XSSFWorkbook workbook) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(getContentType());
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(fileName)
                .build());
        return new ResponseEntity<>(getBytes(workbook), headers, HttpStatus.OK);
    }
}
