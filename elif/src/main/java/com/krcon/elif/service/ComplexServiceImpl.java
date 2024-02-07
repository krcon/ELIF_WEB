package com.krcon.elif.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.krcon.elif.dao.ComplexDAO;
import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.ComplexConstChild;
import com.krcon.elif.vo.ComplexFile;
import com.krcon.elif.vo.ComplexConstFile;
import com.krcon.elif.vo.ComplexGuide;

@Configuration
@PropertySource("classpath:system.properties")

@Service("complexService")
public class ComplexServiceImpl implements ComplexService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.mail.address}")
    private String mailFrom;
	
	@Autowired
    public JavaMailSender mailSender;
	
    @Resource(name="complexDao")
    private ComplexDAO complexDao;

    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	// ! 단지 관리
    public int selectComplexPjtCount(Complex complexVO) throws Exception{
	    return (int) complexDao.selectComplexPjtCount(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return List<Complex>
	 * @throws Exception
	 */
	public List<Complex> selectComplexPjtList(Complex complexVO) throws Exception{
	    return complexDao.selectComplexPjtList(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return Complex
	 * @throws Exception
	 */
	public Complex selectComplexPjtDetail(Complex complexVO) throws Exception{
	    return complexDao.selectComplexPjtDetail(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjt(Complex complexVO) throws Exception{
	    return (int) complexDao.insertComplexPjt(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjt(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjt(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtStatus(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtStatus(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjt(Complex complexVO) throws Exception{
	    return (int) complexDao.deleteComplexPjt(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return List<Integer>
	 * @throws Exception
	 */
	public List<Integer> selectComplexSalesYear(Complex complexVO) throws Exception{
	    return complexDao.selectComplexSalesYear(complexVO);
	}


    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtSales(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtSales(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtSalesStatus(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtSalesStatus(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtSales(Complex complexVO) throws Exception{
	    return (int) complexDao.deleteComplexPjtSales(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConst(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtConst(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstStatus(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtConstStatus(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtSortDtm(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtSortDtm(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtConst(Complex complexVO) throws Exception{
	    return (int) complexDao.deleteComplexPjtConst(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtOccupancy(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtOccupancy(complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtOccupancyStatus(Complex complexVO) throws Exception{
	    return (int) complexDao.updateComplexPjtOccupancyStatus(complexVO);
	}
	
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtOccupancy(Complex complexVO) throws Exception{
	    return (int) complexDao.deleteComplexPjtOccupancy(complexVO);
	}
	
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	// ! 공사단지 상세정보 리스트
    public int selectComplexPjtConstChildCount(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) complexDao.selectComplexPjtConstChildCount(ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return List<ComplexConstChild>
	 * @throws Exception
	 */
	public List<ComplexConstChild> selectComplexPjtConstChildList(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return complexDao.selectComplexPjtConstChildList(ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return ComplexConstChild
	 * @throws Exception
	 */
	public ComplexConstChild selectComplexPjtConstChildDetail(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return complexDao.selectComplexPjtConstChildDetail(ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) complexDao.insertComplexPjtConstChild(ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) complexDao.updateComplexPjtConstChild(ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstChildStatus(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) complexDao.updateComplexPjtConstChildStatus(ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) complexDao.deleteComplexPjtConstChild(ComplexConstChildVO);
	}

    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	// ! 단지 관리 파일
    public int selectComplexPjtFileCount(ComplexFile complexFileVO) throws Exception{
	    return (int) complexDao.selectComplexPjtFileCount(complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return List<ComplexFile>
	 * @throws Exception
	 */
	public List<ComplexFile> selectComplexPjtFileList(ComplexFile complexFileVO) throws Exception{
	    return complexDao.selectComplexPjtFileList(complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return ComplexFile
	 * @throws Exception
	 */
	public ComplexFile selectComplexPjtFileDetail(ComplexFile complexFileVO) throws Exception{
	    return complexDao.selectComplexPjtFileDetail(complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjtFile(ComplexFile complexFileVO) throws Exception{
	    return (int) complexDao.insertComplexPjtFile(complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtFile(ComplexFile complexFileVO) throws Exception{
	    return (int) complexDao.updateComplexPjtFile(complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtFile(ComplexFile complexFileVO) throws Exception{
	    return (int) complexDao.deleteComplexPjtFile(complexFileVO);
	}
	
	
    
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	// ! 공사단지 상세정보 파일
    public int selectComplexPjtConstFileCount(ComplexConstFile complexConstFileVO) throws Exception{
	    return (int) complexDao.selectComplexPjtConstFileCount(complexConstFileVO);
	}
    
	/** 
	 * @param complexConstFileVO
	 * @return List<ComplexConstFile>
	 * @throws Exception
	 */
	public List<ComplexConstFile> selectComplexPjtConstFileList(ComplexConstFile complexConstFileVO) throws Exception{
	    return complexDao.selectComplexPjtConstFileList(complexConstFileVO);
	}
    
	/** 
	 * @param complexConstFileVO
	 * @return ComplexConstFile
	 * @throws Exception
	 */
	public ComplexConstFile selectComplexPjtConstFileDetail(ComplexConstFile complexConstFileVO) throws Exception{
	    return complexDao.selectComplexPjtConstFileDetail(complexConstFileVO);
	}
    
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception{
	    return (int) complexDao.insertComplexPjtConstFile(complexConstFileVO);
	}
    
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception{
	    return (int) complexDao.updateComplexPjtConstFile(complexConstFileVO);
	}
    
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception{
	    return (int) complexDao.deleteComplexPjtConstFile(complexConstFileVO);
	}


    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	// ! 분양 가이드
    public int selectComplexGuideCount(ComplexGuide complexGuideVO) throws Exception{
	    return (int) complexDao.selectComplexGuideCount(complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return List<ComplexGuide>
	 * @throws Exception
	 */
	public List<ComplexGuide> selectComplexGuideList(ComplexGuide complexGuideVO) throws Exception{
	    return complexDao.selectComplexGuideList(complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return ComplexGuide
	 * @throws Exception
	 */
	public ComplexGuide selectComplexGuideDetail(ComplexGuide complexGuideVO) throws Exception{
	    return complexDao.selectComplexGuideDetail(complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexGuide(ComplexGuide complexGuideVO) throws Exception{
	    return (int) complexDao.insertComplexGuide(complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexGuide(ComplexGuide complexGuideVO) throws Exception{
	    return (int) complexDao.updateComplexGuide(complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexGuideStatus(ComplexGuide complexGuideVO) throws Exception{
	    return (int) complexDao.updateComplexGuideStatus(complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexGuide(ComplexGuide complexGuideVO) throws Exception{
	    return (int) complexDao.deleteComplexGuide(complexGuideVO);
	}
}	
