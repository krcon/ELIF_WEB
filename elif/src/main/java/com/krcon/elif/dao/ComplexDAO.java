package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.ComplexConstChild;
import com.krcon.elif.vo.ComplexFile;
import com.krcon.elif.vo.ComplexConstFile;
import com.krcon.elif.vo.ComplexGuide;
 
@Repository("complexDao")
public class ComplexDAO extends AbstractDAO{

    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	// ! 단지 관리
    public int selectComplexPjtCount(Complex complexVO) throws Exception{
	    return (int) selectOne("complex.selectComplexPjtCount", complexVO);
	}
	
	/** 
	 * @param complexVO
	 * @return List<Complex>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
    public List<Complex> selectComplexPjtList(Complex complexVO) throws Exception{
	    return (List<Complex>) selectList("complex.selectComplexPjtList", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return Complex
	 * @throws Exception
	 */
	public Complex selectComplexPjtDetail(Complex complexVO) throws Exception{
	    return (Complex) selectOne("complex.selectComplexPjtDetail", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjt(Complex complexVO) throws Exception{
	    return (int) insert("complex.insertComplexPjt", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjt(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjt", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtStatus(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtStatus", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjt(Complex complexVO) throws Exception{
	    return (int) update("complex.deleteComplexPjt", complexVO);
	}
	
	/** 
	 * @param complexVO
	 * @return List<Integer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
    public List<Integer> selectComplexSalesYear(Complex complexVO) throws Exception{
	    return (List<Integer>) selectList("complex.selectComplexSalesYear",complexVO);
	}

    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtSales(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtSales", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtSalesStatus(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtSalesStatus", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtSales(Complex complexVO) throws Exception{
	    return (int) update("complex.deleteComplexPjtSales", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConst(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtConst", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstStatus(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtConstStatus", complexVO);
	}
	
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtSortDtm(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtSortDtm", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtConst(Complex complexVO) throws Exception{
	    return (int) update("complex.deleteComplexPjtConst", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtOccupancy(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtOccupancy", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtOccupancyStatus(Complex complexVO) throws Exception{
	    return (int) update("complex.updateComplexPjtOccupancyStatus", complexVO);
	}
    
	/** 
	 * @param complexVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtOccupancy(Complex complexVO) throws Exception{
	    return (int) update("complex.deleteComplexPjtOccupancy", complexVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	// ! 공사단지 상세정보 리스트
    public int selectComplexPjtConstChildCount(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) selectOne("complex.selectComplexPjtConstChildCount", ComplexConstChildVO);
	}
	
	/** 
	 * @param ComplexConstChildVO
	 * @return List<ComplexConstChild>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
    public List<ComplexConstChild> selectComplexPjtConstChildList(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (List<ComplexConstChild>) selectList("complex.selectComplexPjtConstChildList", ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return ComplexConstChild
	 * @throws Exception
	 */
	public ComplexConstChild selectComplexPjtConstChildDetail(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (ComplexConstChild) selectOne("complex.selectComplexPjtConstChildDetail", ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) update("complex.insertComplexPjtConstChild", ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) update("complex.updateComplexPjtConstChild", ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstChildStatus(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) update("complex.updateComplexPjtConstChildStatus", ComplexConstChildVO);
	}
    
	/** 
	 * @param ComplexConstChildVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtConstChild(ComplexConstChild ComplexConstChildVO) throws Exception{
	    return (int) update("complex.deleteComplexPjtConstChild", ComplexConstChildVO);
	}

    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	// ! 단지 관리 파일
    public int selectComplexPjtFileCount(ComplexFile complexFileVO) throws Exception{
	    return (int) selectOne("complex.selectComplexPjtFileCount", complexFileVO);
	}
	
	/** 
	 * @param complexFileVO
	 * @return List<ComplexFile>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
    public List<ComplexFile> selectComplexPjtFileList(ComplexFile complexFileVO) throws Exception{
	    return (List<ComplexFile>) selectList("complex.selectComplexPjtFileList", complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return ComplexFile
	 * @throws Exception
	 */
	public ComplexFile selectComplexPjtFileDetail(ComplexFile complexFileVO) throws Exception{
	    return (ComplexFile) selectOne("complex.selectComplexPjtFileDetail", complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjtFile(ComplexFile complexFileVO) throws Exception{
	    return (int) update("complex.insertComplexPjtFile", complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtFile(ComplexFile complexFileVO) throws Exception{
	    return (int) update("complex.updateComplexPjtFile", complexFileVO);
	}
    
	/** 
	 * @param complexFileVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtFile(ComplexFile complexFileVO) throws Exception{
	    return (int) update("complex.deleteComplexPjtFile", complexFileVO);
	}
	

	
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	// ! 공사단지 상세정보 파일
	public int selectComplexPjtConstFileCount(ComplexConstFile complexConstFileVO) throws Exception{
		return (int) selectOne("complex.selectComplexPjtConstFileCount", complexConstFileVO);
	}
	
	/** 
	 * @param complexConstFileVO
	 * @return List<ComplexConstFile>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ComplexConstFile> selectComplexPjtConstFileList(ComplexConstFile complexConstFileVO) throws Exception{
		return (List<ComplexConstFile>) selectList("complex.selectComplexPjtConstFileList", complexConstFileVO);
	}
	
	/** 
	 * @param complexConstFileVO
	 * @return ComplexConstFile
	 * @throws Exception
	 */
	public ComplexConstFile selectComplexPjtConstFileDetail(ComplexConstFile complexConstFileVO) throws Exception{
		return (ComplexConstFile) selectOne("complex.selectComplexPjtConstFileDetail", complexConstFileVO);
	}
	
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception{
		return (int) update("complex.insertComplexPjtConstFile", complexConstFileVO);
	}
	
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception{
		return (int) update("complex.updateComplexPjtConstFile", complexConstFileVO);
	}
	
	/** 
	 * @param complexConstFileVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexPjtConstFile(ComplexConstFile complexConstFileVO) throws Exception{
		return (int) update("complex.deleteComplexPjtConstFile", complexConstFileVO);
	}

    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	// ! 공사단지 상세정보 파일
    public int selectComplexGuideCount(ComplexGuide complexGuideVO) throws Exception{
	    return (int) selectOne("complexGuide.selectComplexGuideCount", complexGuideVO);
	}
	
	/** 
	 * @param complexGuideVO
	 * @return List<ComplexGuide>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
    public List<ComplexGuide> selectComplexGuideList(ComplexGuide complexGuideVO) throws Exception{
	    return (List<ComplexGuide>) selectList("complexGuide.selectComplexGuideList", complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return ComplexGuide
	 * @throws Exception
	 */
	public ComplexGuide selectComplexGuideDetail(ComplexGuide complexGuideVO) throws Exception{
	    return (ComplexGuide) selectOne("complexGuide.selectComplexGuideDetail", complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int insertComplexGuide(ComplexGuide complexGuideVO) throws Exception{
	    return (int) update("complexGuide.insertComplexGuide", complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexGuide(ComplexGuide complexGuideVO) throws Exception{
	    return (int) update("complexGuide.updateComplexGuide", complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int updateComplexGuideStatus(ComplexGuide complexGuideVO) throws Exception{
	    return (int) update("complexGuide.updateComplexGuideStatus", complexGuideVO);
	}
    
	/** 
	 * @param complexGuideVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteComplexGuide(ComplexGuide complexGuideVO) throws Exception{
	    return (int) update("complexGuide.deleteComplexGuide", complexGuideVO);
	}



}