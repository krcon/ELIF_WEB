package com.krcon.elif.service;

import java.util.List;

import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.ComplexConstChild;
import com.krcon.elif.vo.ComplexFile;
import com.krcon.elif.vo.ComplexConstFile;
import com.krcon.elif.vo.ComplexGuide;

public interface ComplexService {

    // ! 단지 관리
    int selectComplexPjtCount(Complex complexVO) throws Exception;
    List<Complex> selectComplexPjtList(Complex complexVO) throws Exception;
    Complex selectComplexPjtDetail(Complex complexVO) throws Exception;
    int insertComplexPjt(Complex complexVO) throws Exception;
    int updateComplexPjt(Complex complexVO) throws Exception;
    int updateComplexPjtStatus(Complex complexVO) throws Exception;
    int deleteComplexPjt(Complex complexVO) throws Exception;

    List<Integer> selectComplexSalesYear(Complex complexVO) throws Exception;


    int updateComplexPjtSales(Complex complexVO) throws Exception;
    int updateComplexPjtSalesStatus(Complex complexVO) throws Exception;
    int deleteComplexPjtSales(Complex complexVO) throws Exception;
    int updateComplexPjtConst(Complex complexVO) throws Exception;
    int updateComplexPjtConstStatus(Complex complexVO) throws Exception;
    int updateComplexPjtSortDtm(Complex complexVO) throws Exception;
    int deleteComplexPjtConst(Complex complexVO) throws Exception;
    int updateComplexPjtOccupancy(Complex complexVO) throws Exception;
    int updateComplexPjtOccupancyStatus(Complex complexVO) throws Exception;
    int deleteComplexPjtOccupancy(Complex complexVO) throws Exception;
    
    // ! 공사단지 상세정보 리스트
    int selectComplexPjtConstChildCount(ComplexConstChild ComplexConstChildVO) throws Exception;
    List<ComplexConstChild> selectComplexPjtConstChildList(ComplexConstChild ComplexConstChildVO) throws Exception;
    ComplexConstChild selectComplexPjtConstChildDetail(ComplexConstChild ComplexConstChildVO) throws Exception;
    int insertComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception;
    int updateComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception;
    int updateComplexPjtConstChildStatus(ComplexConstChild ComplexConstChildVO) throws Exception;
    int deleteComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception;

    // ! 단지 관리 파일
    int selectComplexPjtFileCount(ComplexFile complexFileVO) throws Exception;
    List<ComplexFile> selectComplexPjtFileList(ComplexFile complexFileVO) throws Exception;
    ComplexFile selectComplexPjtFileDetail(ComplexFile complexFileVO) throws Exception;
    int insertComplexPjtFile(ComplexFile complexFileVO) throws Exception;
    int updateComplexPjtFile(ComplexFile complexFileVO) throws Exception;
    int deleteComplexPjtFile(ComplexFile complexFileVO) throws Exception;


    // ! 공사단지 상세정보 파일
    int selectComplexPjtConstFileCount(ComplexConstFile complexConstFileVO) throws Exception;
    List<ComplexConstFile> selectComplexPjtConstFileList(ComplexConstFile complexConstFileVO) throws Exception;
    ComplexConstFile selectComplexPjtConstFileDetail(ComplexConstFile complexConstFileVO) throws Exception;
    int insertComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception;
    int updateComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception;
    int deleteComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception;



    // ! 공사단지 상세정보 파일
    int selectComplexGuideCount(ComplexGuide complexGuideVO) throws Exception;
    List<ComplexGuide> selectComplexGuideList(ComplexGuide complexGuideVO) throws Exception;
    ComplexGuide selectComplexGuideDetail(ComplexGuide complexGuideVO) throws Exception;
    int insertComplexGuide(ComplexGuide complexGuideVO) throws Exception;
    int updateComplexGuide(ComplexGuide complexGuideVO) throws Exception;
    int updateComplexGuideStatus(ComplexGuide complexGuideVO) throws Exception;
    int deleteComplexGuide(ComplexGuide complexGuideVO) throws Exception;

}