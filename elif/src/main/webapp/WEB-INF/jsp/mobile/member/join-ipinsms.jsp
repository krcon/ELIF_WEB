<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<c:choose>
    <c:when test="${is_bool}">
    	<script>
		parent.opener.parent.document.vnoform.DI.value = "${returnObj.DI }";
		parent.opener.parent.document.vnoform.sName.value = "${returnObj.sName }";
		parent.opener.parent.document.vnoform.sGender.value = "${returnObj.sGender }";
		parent.opener.parent.document.vnoform.sBirthDate.value = "${returnObj.sBirthDate }";
		parent.opener.parent.document.vnoform.sMobileNo.value = "${returnObj.sMobileNo }";
		
		parent.opener.parent.document.vnoform.target = "Parent_window";
		parent.opener.parent.document.vnoform.submit();
		console.log(self);
		var host=window.opener;
		window.focus(); /* solves the iPad3 problem */
		window.close(); /* the actual closing we want to achieve... */
		/* makes the focus go back to opener on iPad2, fails silently on iPad3 */
		try { host.focus(); } catch(e) {} 

		</script>
    </c:when>
    <c:otherwise>
		<script>
		alert('${returnObj.sMessage }');
		// opener.location.reload();
		var host=window.opener;
		window.focus(); /* solves the iPad3 problem */
		window.close(); /* the actual closing we want to achieve... */
		/* makes the focus go back to opener on iPad2, fails silently on iPad3 */
		try { host.focus(); } catch(e) {} 
		</script>
    </c:otherwise>
</c:choose>