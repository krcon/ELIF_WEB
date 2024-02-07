<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=1280">
    <meta name="title" content="MGMT ERROR"/> 
    <meta name="keywords" content="MGMT ERROR"/> 
    <meta name="description" content="MGMT ERROR"/>
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="No-Cache">
    <meta property="og:title" content="엘리프">
    <meta property="og:description" content="ELIF MGMT ERROR PAGE">
    <link href="/resources/web/css/sub.css" rel="stylesheet">
    <!-- <link rel="shortcut icon" href="/resources/web/images/common/favicon.ico" /> -->
    <meta property="og:image" content="" /> <!-- ../resources/web/images/common/og_img.jpg -->
    <title>ERROR | ELIF 관리자</title>
</head>

<body>
    <!-- wrap -->
    <div class="wrap">
        <a href="#gnb" class="skipNav">주메뉴 바로가기</a>
        <a href="#container" class="skipNav">본문바로가기</a>
        <main id="container">
            <div class="inner">
                <div class="error_box ">
                    <i class="ico">
                        <img src="/resources/web/images/error_ico.svg" alt="">
                    </i>
                    <p class="tit">요청하신 페이지를 표시할 수 없습니다.</p>
                    <p class="box_txt">잘못된 경로로 접근하셨거나,​<br>현재 운영되지 않는 페이지입니다.</p>
                    <div class="btn_area">
                        <a href="/mgmt/home" class="btn green">메인으로 돌아가기​</a>
                    </div>
                </div>
            </div><!-- //inner -->
        </main>
        <!-- //container -->
    </div>
</body>

</html>