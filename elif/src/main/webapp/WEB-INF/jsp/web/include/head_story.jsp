<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
    <meta charset="utf8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=1280">
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <!-- <link href="/resources/web/css/jquery-ui.css" rel="stylesheet"> -->
    <!-- <link href="/resources/web/css/sub.css" rel="stylesheet"> -->
    <!-- stoy area -->
    <link href="/resources/web/css/sub.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/web/css/story/fullpage.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/web/css/story/reset.css">
    <link rel="stylesheet" type="text/css" href="/resources/web/css/story/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css"/>
    <!-- // story area -->
    <link rel="shortcut icon" type="image/x-icon" href="/resources/web/images/common/favicon.ico" sizes="16x16">
    <meta property="og:image" content="https://elif.krcon.co.kr/resources/web/images/common/og_elif.png" />
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <script src="/resources/web/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
    <script type="text/javascript">
    if(!wcs_add) var wcs_add = {};
    wcs_add["wa"] = "69a033ff688ccc";
    if(window.wcs) {
    wcs_do();
    }
    </script>
    <script>
    /*<![CDATA[*/
        /* 
            <!-- 페북 카카오 관련 메타 -->
            $("meta[property='og:url']").attr('content', snsUrl);
            $("meta[property='og:title']").attr('content', snsTitle);
            $("meta[property='og:description']").attr('content', snsDescription);
            $("meta[property='og:image']").attr('content', snsImage);
            $("meta[property='og:type']").attr('content', "website");
        
            <!-- 트위터 관련 메타 -->
            $("meta[name='twitter:url']").attr('content', snsUrl);
            $("meta[name='twitter:title']").attr('content', snsTitle);
            $("meta[name='twitter:description']").attr('content', snsDescription);
            $("meta[name='twitter:image']").attr('content', snsImage);
        */
    /*]]>*/
    </script>