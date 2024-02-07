<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
            <!-- [blockUi] 로딩시 class에 on -->
            <div id="blockUi"></div>
            <!-- //[blockUi] -->
            <!-- footer -->
            <footer>
                <div class="inner">
                    <div class="left">
                        <div class="footer_logo">
                            <a href="../index"><img src="/resources/web/images/logo_footer.png" alt="ELIF"></a>
                        </div>
                        <div class="fnb">
                            <ul>
                                <li>
                                    <a href="/etc/policies-privacy" class="btn_f1">개인정보처리방침</a>
                                </li>
                                <li>
                                    <a href="/etc/policies-terms" class="btn_f1">이용약관</a>
                                </li>
                                <li>
                                    <a href="/etc/policies-email" class="btn_f1">이메일무단수집거부</a>
                                </li>
                                <li>
                                    <a href="/etc/sitemap" class="btn_f1">사이트맵</a>
                                </li>
                                <li>
                                    <a href="/mypage/notice" class="btn_f1">공지사항</a>
                                </li>
                            </ul>
                        </div>
                        <div class="info">
                            <address>
                                <p>대전광역시 서구 문정로 48번길, 48 계룡건설산업㈜</p>
                                <p>Tel. 042-480-7114 | Fax. 042-483-1341</p>
                            </address>
                            <div class="copy">
                                <p>COPYRIGHT ⓒ 2021 BY KYERYONG CONSTRUCTION<br> INDUSTRIAL CO., LTD. ALL RIGHTS RESERVED.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="right">
                        <div class="family">
                            <label for="sch_f"></label>
                            <select id="sch_f">
                                <option value="hide" rel="hide">Family Site</option>
                                <option value="https://www.krcon.co.kr/"rel="javascript();" >계룡건설</option>
                                <option value="https://www.krindus.co.kr/" rel="javascript();">KR산업</option>
                                <option value="http://www.krsanup.co.kr/" rel="javascript();">계룡산업</option>
                            </select>
                        </div>
                        <nav class="map_link">
                            <dl>
                                <dt>분양 정보</dt>
                                <dd>
                                    <ul>
                                        <li class="tit"></li>
                                        <li><a href="/sale/complex">분양 단지</a></li>
                                        <li><a href="/sale/calendar">분양 캘린더</a></li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl>
                                <dt>공사/입주 정보</dt>
                                <dd>
                                    <ul>
                                        <li class="tit"></li>
                                        <li><a href="/build/construction">공사 단지</a></li>
                                        <li><a href="/build/movein">입주 단지</a></li>
                                    </ul>
                                </dd>
                            </dl>
                            <dl>
                                <dt>브랜드</dt>
                                <dd>
                                    <ul>
                                        <li class="tit"></li>
                                        <li><a href="/brand/story">브랜드 스토리</a></li>
                                        <li><a href="/brand/bi">BI</a></li>
                                        <li><a href="/brand/record">시공실적</a></li>
                                        <li><a href="/brand/community">커뮤니티</a></li>
                                    </ul>
                                </dd>
                            </dl>
                        </nav>
                    </div>
                </div>
            </footer>
            <!-- //footer -->

<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-8KHL5B9LYV"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-8KHL5B9LYV');
</script>