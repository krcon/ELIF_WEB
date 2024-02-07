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
    <%@ include file="../include/head.jsp" %>
    <meta name="title" content="회원가입,엘리프"/> 
    <meta name="keywords" content="엘리프, 회원가입, 약관동의, 이용약관"/> 
    <meta name="description" content="엘리프 회원가입 페이지 입니다."/>
    <meta property="og:title" content="회원가입,엘리프">
    <meta property="og:description" content="엘리프 회원가입 페이지 입니다.">

    <title>회원가입 | 엘리프</title>
</head>

<body>
    <!-- wrap -->
    <div class="wrap">
        <a href="#header" class="skipNav">주메뉴 바로가기</a>
        <a href="#container" class="skipNav">본문바로가기</a>
        <!-- header -->
        <header id="header">
            <!-- gnb include -->
            <%@ include file="../include/header.jsp" %>
        </header>
        <!-- //header -->
        <main id="container">
            <div class="inner">
                <!-- Visual & Title -->
                <section class="visual member">
                    <h2>회원가입</h2>
                </section>
                <!-- //Visual & Title -->
                <!-- 페이지 위치 -->
                <section class="locator">
                    <ul>
                        <li><a href="/index"><i>home</i></a></li>
                        <li><span>회원가입</span></li>
                    </ul>
                </section>
                <!-- //페이지 위치 -->
                <div class="contents_wrap">
                    <section class="cont_section nomt">
                        <div class="guide_box">
                            <ul class="guide_list number">
                                <li><span class="num">1.</span>엘리프에서 제공하는 분양정보, 공사현장정보등을 문자, 이메일 등으로 제공 받으실 수 있습니다.</li>
                                <li><span class="num">2.</span>일반회원과 계약회원으로 구분됩니다. 일반회원은 분양정보를 등록하시면 계약회원으로 전환됩니다.</li>
                                <li><span class="num">3.</span>계약회원은 나의 분양정보를 통하여 중도금 납부 내역 조회 등의 서비스를 받으실 수 있습니다.</li>
                                <!-- <li><span class="num">4.</span>고객센터의 1:1상담서비스인 고객문의, A/S신청,당첨자 조회 등의 서비스를 받으실 수 있습니다.</li> -->
                            </ul>
                        </div>
                        <div class="step_list_wrap"> 
                            <ol class="step_list">
                                <li class="on"><span class="step">step1</span>약관 동의</li>
                                <li><span class="step">step2</span>본인 인증</li>
                                <li><span class="step">step3</span>개인정보입력</li>
                                <li><span class="step">step4</span>가입완료</li>
                            </ol>
                        </div>
                    </section>
                    <section class="cont_section">
                        <p class="title1">이용약관</p>
                        <div class="scroll_box">
                            <div class="scroll_inner term_box">
                                <!-- 제 1장 -->
                                <p class="term_tit1">제 1장 이용약관 및 이용계약</p>

                                <p class="term_tit2">제1조 (목 적)</p>
                                <p class="term_txt">본 약관은 계룡건설산업 주식회사(이하 '회사'라 한다) 가 제공하는 인터넷 서비스(이하 '서비스'라 한다)의 이용 조건 및 절차에 관한 기본적인 사항을 정함을 목적으로 합니다.</p>

                                <p class="term_tit2">제2조 (효력 및 변경)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>본 약관은 사이트에 게시하거나 <span>SNS 등 기타의 방법</span>으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
                                    <li><span class="num">②</span>회사는 합당한 사유가 발생될 경우에는 본 약관을 변경할 수 있으며, 변경된 경우에는 바로 이를 이용자에게 공지합니다. 이용자는 서비스의 수정, 또는 중지에 대해 회사가 이용자 또는 제3자에 대하여 어떠한 책임도 지지 않음에 동의합니다. </li>
                                    <li><span class="num">③</span>서비스 이용자가 변경된 약관 사항에 동의하지 않을 경우, 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 그러나 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주합니다.</li>
                                </ul>

                                <p class="term_tit2">제3조 (용어의 정의)</p>
                                <ul class="guide_list number">
                                    <li>
                                        <span class="num">①</span>본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
                                        <ol>
                                            <li>이용자는 서비스에 접속하여 본 약관에 따라 제공되는 서비스를 받는 <span>회원(일반회원/계약회원)</span> 및 비회원을 말합니다.</li>
                                            <li>일반회원이라 함은 회사와 계약관계가 없는 자로서, 회사에 개인정보를 제공하여 회원등록을 하고 회사의 정보를 지속적으로 제공받으며, 회사가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>
                                            <li><span>계약회원</span>이라 함은 회사와 계약관계가 있는 자로서, 일반회원이 이용할 수 있는 서비스와 함께 부가적인 서비스를 이용할 수 있는 자를 말합니다.</li>
                                            <li>비회원이라 함은 회원에 가입하지 않고 회사 제공하는 서비스를 이용하는 자를 말합니다.</li>
                                            <li>이용계약은 서비스 이용과 관련하여 회사와 이용자간에 체결하는 계약을 말합니다.</li>
                                            <li>회원 ID는 이용자의 식별과 이용자의 서비스 이용을 위하여 회원이 정하고 회사가 승인하는 문자와 숫자의 조합입니다.</li>
                                            <li>비밀번호는 이용자의 이용자ID와 일치된 이용자임을 확인하고 이용자의 권익보호를 위하여 이용자가 문자, 숫자, 그리고 특수문자의 조합을 말합니다.</li>
                                            <li>운영자는 서비스의 전반적인 관리와 원활한 운영을 위하여 회사에서 선정한 사람을 말합니다.</li>
                                            <li>해지라 함은 회사 또는 회원이 서비스 개통 후 이용계약을 해약하는 것을 말합니다.</li>
                                        </ol>
                                    </li>
                                    <li><span class="num">②</span>본 약관에서 사용하는 용어의 정의는 본 항에서 정하는 것을 제외하고는 관계법령과 서비스별 안내에서 정하는 바를 따릅니다.</li>
                                </ul>

                                <p class="term_tit2">제4조 (당사의 의무)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사는 특별한 사정이 없는 한 회원이 신청한 서비스 제공 개시일에 비추어 최대한 빠른 시일 내에 서비스를 이용 할 수 있도록 합니다.</li>
                                    <li><span class="num">②</span>회사는 약관에서 정한 바에 따라 서비스의 중단 등 부득이한 경우를 제외하고는 계속적, 안정적으로 서비스를 위해 최선을 다할 것입니다.</li>
                                    <li><span class="num">③</span>회사는 서비스 제공과 관련해서 알고 있는 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다. 단, <span>전기통신기본법 등</span> 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우에는 그러하지 않습니다.</li>
                                </ul>

                                <!-- 제 2장 -->
                                <p class="term_tit1">제 2장 회원가입</p>

                                <p class="term_tit2">제1조 (이용자ID 확인 및 변경)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사는 회원제 서비스 이용자에 대하여 약관에 정하는 바에 따라 이용자ID를 확인합니다.</li>
                                    <li><span class="num">②</span>회원은 이용자ID를 제3자에게 사용하게 할 수 없으며, 이용자ID 및 비밀번호 관리에 이용자 스스로가 주의를 다하여야 합니다.</li>
                                    <li><span class="num">③</span>기타 이용자ID의 관리 및 변경 등에 관한 사항은 서비스별 안내에 정하는 바에 의합니다.</li>
                                    <li><span class="num">④</span>이용자는 회원 정보가 변경되었을 경우는 변경내용을 수정 입력하셔야 합니다. 이용자의 수정된 정보 입력 지연에 따라 발생하는 제반 문제에 대하여는 회사는 하등의 책임이 없습니다.</li>
                                </ul>

                                <p class="term_tit2">제2조 (사용자계정, 비밀번호 및 보안)</p>
                                <ul class="guide_list number">
                                    <li>
                                        <span class="num">①</span>본 서비스의 등록 절차를 완료하면 이용자는 비밀번호와 사용자 계정을 지정받게 됩니다. 이용자는 비밀번호와 사용자 계정의 비밀을 유지할 책임이 있으며, 이용자의 비밀번호와 계정을 사용하여 발생하는 모든 결과에 대해 전적인 책임이 있습니다.
                                        <!-- <ol>
                                            <li>이용자의 승인 없이 비밀번호나 계정이 사용되었거나 또는 기타 보안 위반에 대하여 즉시 회사에 신고하며,</li>
                                            <li>매 접속 종료시 이용자 계정으로부터 확실히 사용 종료할 것을 확약합니다.</li>
                                        </ol> -->
                                    </li>
                                    <li class="list_user">
                                        <span class="user">이용자는</span>
                                        <ol>
                                            <li><span class="num">1)</span>이용자의 승인 없이 비밀번호나 계정이 사용되었거나 또는 기타 보안 위반에 대하여 즉시 회사에 신고하며,</li>
                                            <li><span class="num">2)</span>매 접속 종료시 이용자 계정으로부터 확실히 사용 종료할 것을 확약합니다.</li>
                                        </ol>
                                    </li>
                                    <li><span class="num">②</span>회사는 이용자가 본 조항을 이행하지 않음으로 인하여 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다.</li>
                                </ul>

                                <p class="term_tit2">제3조 (개인정보보호)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사는 이용자의 회원 가입시 회원관리에 필요한 최소한의 정보를 수집합니다.</li>
                                    <li><span class="num">②</span>이용자가 이용약관에 대한 '동의'버튼을 체크함으로써 본 약관에 동의한 것으로 간주합니다.</li>
                                    <li><span class="num">③</span>회사가 이용자의 개인식별이 가능한 개인정보를 수집하는 때에 당해 이용자의 동의는 등록신청을 함으로써 이에 동의한 것으로 간주합니다.</li>
                                    <li>
                                        <span class="num">④</span>제공된 개인정보는 당해 이용자의 동의 없이 목적외의 이용이나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 회사가 집니다. 다만, 다음의 경우에는 예외로 합니다.
                                        <ol>
                                            <li>배송업무상 배송업체에게 배송에 필요한 최소한의 이용자의 정보(성명, 주소, 전화번호)를 알려주는 경우</li>
                                            <li>통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우</li>
                                            <li>마케팅을 위하여 당사자에게 통지하는 경우</li>
                                        </ol>
                                    </li>
                                    <li><span class="num">⑤</span>회사가 전항 제2호과 제3호에 의해 이용자의 별도 동의를 받아야 하는 경우에는 미리 명시하거나 고지해야 하며 이용자는 언제든지 이에 대한 거부나 동의 철회를 할 수 있습니다.</li>
                                    <li><span class="num">⑥</span>이용자는 언제든지 회사가 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 회사는 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 회사는 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.</li>
                                </ul>

                                <p class="term_tit2">제4조 (회원의 탈퇴)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회원은 회사의 서비스에 언제든지 탈퇴를 요청할 수 있으며 회사는 즉시 회원탈퇴를 처리합니다.</li>
                                </ul>

                                <!-- 제 3장 -->
                                <p class="term_tit1">제 3장 서비스</p>

                                <p class="term_tit2">제1조 (서비스의 이용)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>서비스 이용은 당사의 업무상 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.</li>
                                    <li><span class="num">②</span>제1항의 이용시간은 정기 점검 등의 필요로 인하여 당사가 정한 날과 시간 그리고 기간 통신사업자가 전기통신 서비스를 중지했을 때, 국가 비상사태, 천재지변, 정전, 네트워크망 장애, 서비스 설비의 장애 또는 서비스 이용의 폭주, <span>기타 불가항력의 요소</span> 등으로 정상적인 서비스 이용에 지장이 있는 때는 그러하지 아니합니다.</li>
                                    <li><span class="num">③</span>이용자에게 통보된 이용자ID 및 비밀번호 등의 관리 및 이용은 이용자의 책임으로 하며 이용자의 부주의로 이용상의 과실 또는 제3자에 의한 부정 사용 등에 대한 모든 책임은 이용 고객에게 있습니다.</li>
                                    <li><span class="num">③</span>서비스를 제공 받는 이용 고객은 모든 관련법규에 의거, 하자 없는 범위 내에서 사용되어야 하며, 이에 대한 모든 책임은 이용자에게 있고, 그에 대해 당사는 법적, 경제적 책임을 지지 않습니다.</li>
                                </ul>

                                <p class="term_tit2">제2조 (정보의 제공)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사는 회원이 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서 전자우편, 유선매체, 서신우편, SMS, <span>카카오톡 및 기타 SNS 매체</span> 등의 방법으로 회원에게 제공할 수 있습니다.</li>
                                </ul>

                                <p class="term_tit2">제3조 (서비스의 보류 및 중지)</p>
                                <ul class="guide_list number">
                                    <li>
                                        <span class="num">①</span>회사는 다음 각 호에 해당하는 이용신청의 경우에 대하여는 승낙을 하지 않거나 서비스를 중시시킬 수 있습니다.
                                        <ol>
                                            <li>타인 명의로 신청한 경우</li>
                                            <li>회원가입 등록정보에 기재한 내용이 허위임이 밝혀졌을 경우</li>
                                            <li>미성년자가 신청한 경우</li>
                                            <li>기타 이용신청고객의 귀책사유로 이용승낙이 곤란한 경우</li>
                                            <li><span>회사의 이익에 해가 된다고 판단되는 경우</span></li>
                                        </ol>
                                    </li>
                                    <li>
                                        <span class="num">②</span>회사는 이용자의 이용신청이 다음 각 호에 해당하는 경우에는 그 신청에 대한 승낙 제한사유가 해소될 때까지는 승낙을 하지 않을 수 있습니다.
                                        <ol>
                                            <li>회사가 설비의 여유가 없는 경우</li>
                                            <li>회사가 기술상 지장이 있는 경우</li>
                                            <li>기타 회사의 사유로 이용승낙이 곤란한 경우</li>
                                        </ol>
                                    </li>
                                    <li><span class="num">③</span>회사는 전항의 규정에 의하여 이용신청이 불승낙 되거나 승낙을 제한하는 경우에는 이를 이용신청고객에게 알려야 한다.</li>
                                </ul>

                                <p class="term_tit2">제4조 (천재지변시 서비스 정지)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사는 전시, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간통신사업자가 전기통신 서비스를 중지하는 등 기타 부득이한 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.</li>
                                    <li><span class="num">②</span>회사는 전 항의 규정에 의하여 서비스의 이용을 제한하거나 정지한 때에는 그의 사유 및 제한기간 등을 지체 없이 이용자에게 공지합니다.</li>
                                </ul>

                                <p class="term_tit2">제5조 (회원의 서비스 중지)</p>
                                <ul class="guide_list number">
                                    <li>
                                        <span class="num">①</span>회사는 이용자의 서비스 이용 내용이 다음 각 호에 해당하는 경우에는 게시물을 삭제하거나 서비스의 전부 또는 일부의 이용을 제한하거나 중지할 수 있습니다.
                                        <ol>
                                            <li>이용자의 의무를 이행하지 아니한 경우</li>
                                            <li>회사의 안정적인 운영을 저해하는 경우</li>
                                            <li>수신자의 의사에 반하는 음란, 저속, 위협적인 내용이나 광고성 정보, 전자우편 등을 지속적으로 전송하는 경우</li>
                                            <li>정보통신 설비의 오 동작이나 정보 등의 파괴를 유발시키는 컴퓨터 바이러스 프로그램 등을 유포하는 경우</li>
                                            <li>타인의 지적재산권을 침해하는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 경우</li>
                                            <li>정보통신윤리위원회의 시정요구가 있거나 불법선거운동과 관련하여 선거관리위원회의 유권해석을 받은 경우</li>
                                            <li>타인의 아이디(ID) 와 비밀번호(PASSWORD)를 사용하는 경우</li>
                                            <li>서비스 정보를 이용하여 얻은 정보를 회사의 사전 승낙 없이 복제 또는 유통시키거나 상업적으로 이용하는 경우</li>
                                            <li>전기통신 관련법령 등에 위배되는 경우</li>
                                            <li>다른 사용자의 개인정보를 수집 또는 저장하는 경우</li>
                                            <li>회사의 승인을 받지 않고 광고, 판촉물, 정크메일, 스팸, 행운의 편지 등 기타 다른 형태의 권유를 게시, 게재, 전자메일 또는 기타 방법으로 전송하는 경우</li>
                                            <li>제3자의 권리를 침해하거나 타인을 비방하는 경우</li>
                                        </ol>
                                    </li>
                                    <li><span class="num">②</span>전 항의 규정에 의하여 이용자의 이용을 제한하는 경우에는 게시물 삭제 또는 제한의 종류 및 기간 등 구체적인 기준은 서비스별 안내에서 별도로 정하는바에 의합니다.</li>
                                </ul>
                                <p class="term_tit2">제5조 (서비스 이용 제한 및 해제)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사가 서비스 이용을 제한하고자 하는 경우 그 사유와 일시 등을 이용자에게 통지합니다. 다만, 회사가 긴급하게 이용을 정지할 필요가 있다고 인정하는 경우에는 바로 정지시킬 수 있습니다.</li>
                                    <li><span class="num">②</span>전 항의 규정에 의하여 이용정지를 통지 받은 이용자는 그 이용 정지의 통지에 대해 부당하다고 생각할 경우 이의신청을 할 수 있습니다.</li>
                                    <li><span class="num">③</span>회사는 전 항의 규정에 의한 이의신청에 대하여 그 확인을 위한 기간까지 이용정지를 일시 연기할 수 있으며, 그 경과와 결과를 이용 고객에게 통지합니다.</li>
                                    <li><span class="num">④</span>회사는 이용정지기간 중에 그 이용정지사유가 해소된 것이 확인된 경우에는 이용정지 조치를 즉시 해제합니다.</li>
                                </ul>

                                <!-- 제 4장 -->
                                <p class="term_tit1">제 4장 기타</p>

                                <p class="term_tit2">제1조 (링크조건 등)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사에 대한 링크는 운영자에게 사이트에 대한 정보 즉, 사이트 주소 및 운영자 E-Mail, 전화번호, 이름, 링크시작 일자, 용도를 통보한 후 확인은 받아야 링크를 할 수 있습니다.</li>
                                    <li><span class="num">②</span>링크시에는 회사 인터넷 서비스 사이트에 연결됨을 표시하고 배너를 사용할 경우에도 회사 인터넷 서비스 사이트에 연결됨을 표시하여야 하며 페이지를 프레임 안에 넣거나 미러링 할 수 없습니다.</li>
                                    <li><span class="num">③</span>회사 인터넷 서비스 사이트를 사적인 이익을 목적으로 사용할 수 없습니다.</li>
                                    <li><span class="num">④</span>회사 인터넷 서비스 사이트를 링크한다고 해서 추천 사이트나 혹은 제휴를 하고 있는 사이트를 뜻하는 것은 아니며 그러한 용도로 사용할 수 없습니다.</li>
                                    <li><span class="num">⑤</span>회사 인터넷 서비스 사이트를 훼손하거나, 비방, 또는 불건전한 목적으로 사용할 수 없습니다. 또한 어떠한 법률이나 규칙을 위배하며 사용해서도 안 되며,</li>
                                    <li><span class="num">⑥</span>회사는 본 고려사항과 전제조건을 따르지 않고 회사 인터넷 서비스 사이트의 권리를 침해하거나 명예를 훼손하는 사이트에 대해서는 링크를 금지하거나 수정 조치할 수 있는 권리를 가집니다.</li>
                                    <li><span class="num">⑦</span>회사 인터넷 서비스 사이트를 링크하는 것과 관련하여 이용자가 부담하게 될 지도 모르는 모든 법률적인 사항에 대하여 회사는 어떠한 책임도 지지 않습니다.</li>
                                </ul>

                                <p class="term_tit2">제2조 (이용종료)</p>
                                <ul class="guide_list number">
                                    <li>
                                        <span class="num">①</span>회사는 이용자가 다음 각 호의 행위에 의하여 서비스를 이용할 경우 이용자ID 삭제 등 서비스를 이용하지 못하도록 할 수 있습니다.
                                        <ol>
                                            <li>정보통신윤리위원회의 심의세칙 제7조에 어긋나는 음란물을 게재한 경우</li>
                                            <li>반국가적 행위의 수행을 목적으로 하는 내용을 포함한 경우</li>
                                            <li><span>기타 법률위반, 사회적 이익을 해하는 경우</span></li>
                                        </ol>
                                    </li>
                                    <li><span class="num">②</span>본 약관에 명시 되지 않은 서비스의 이용종료에 관한 기준은 관계 법령 및 서비스별 안내에서 정하는 바에 의합니다.</li>
                                </ul>

                                <p class="term_tit2">제3조 (손해배상에 대한 면제)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사는 이용자가 회사의 서비스 제공으로부터 기대되는 이익을 얻지 못하였거나 서비스 자료에 대한 취사선택 또는 이용으로 발생하는 손해 등에 대해서는 책임이 면제됩니다.</li>
                                    <li><span class="num">②</span>회사는 이용자의 귀책사유로 인하여 서비스 이용의 장애가 발생한 경우에는 책임이 면제됩니다.</li>
                                    <li><span class="num">③</span>회사는 이용자가 게시 또는 전송한 자료의 내용에 대해서는 책임이 면제됩니다.</li>
                                    <li><span class="num">④</span>회사는 이용자 상호간 또는 이용자와 제3자 상호간에 서비스를 매개로 하여 물품거래 등을 한 경우에는 책임이 면제됩니다.</li>
                                    <li><span class="num">⑤</span>회사는 모든 서비스의 자료 보관 및 전송에 관한 책임이 없으며 자료의 손실이 있는 경우에도 책임이 면제됩니다.</li>
                                    <li><span class="num">⑥</span>본 조에 정하지 않은 이용자에게 발생한 손해에 대하여는 각 서비스별 이용 규칙에 따라 회사의 책임이 면제됩니다.</li>
                                </ul>
                                
                                <p class="term_tit2">제4조 (재판권 및 준거법)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>회사와 이용자간에 발생한 분쟁에 관한 소송의 관할법원인 <span>대전지방법원</span>에 제기합니다.</li>
                                    <li><span class="num">②</span>회사와 이용자간에 제기된 소송에는 한국법을 적용합니다.</li>
                                </ul>
                                <div>
                                    <p class="term_txt2">부 칙 본 약관은 공개일부터 시행하며, 기존약관을 대신합니다.</p>
                                </div> <!-- [D] 1021 : g 이용약관 수정 -->
                            </div>
                        </div>
                        <div class="agree_area">
                            <span class="radio-wrap">
                                <input type="radio" name="agree01" value="Y" id="ok01" ><label for="ok01">동의</label>
                            </span>
                            <span class="radio-wrap">
                                <input type="radio" name="agree01" id="no01"><label for="no01">미동의</label>
                            </span>
                        </div>
                    </section>
                    <section class="cont_section">
                        <p class="title1">개인정보 처리 및 이용​</p>
                        <div class="scroll_box">
                            <div class="scroll_inner term_box">
                                <p class="term_tit2">제1조 (목 적)</p>
                                <p class="term_txt">본 약관은 계룡건설 주식회사(이하 '회사'라 한다)이(가) 제공하는 인터넷 서비스 (이하 '서비스'라 한다)의 이용 조건 및 절차에 관한 기본적인 사항을 정함을 목적으로 합니다</p>
                                <p class="term_tit2">제2조 (효력 및 변경)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>본 약관은 사이트에 게시하거나 기타의 방법으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
                                    <li><span class="num">②</span>회사는 합당한 사유가 발생될 경우에는 본 약관을 변경할 수 있으며, 변경된 경우에는 바로 이를 이용자에게 공지합니다. 이용자는 서비스의 수정, 또는 중지에 대해 회사가 이용자 또는 제3자에 대하여 어떠한 책임도 지지 않음에 동의합니다.</li>
                                    <li><span class="num">③</span>서비스 이용자가 변경된 약관 사항에 동의하지 않을 경우, 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 그러나 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주합니다.</li>
                                </ul>
                                <p class="term_tit2">제1조 (목 적)</p>
                                <p class="term_txt">본 약관은 계룡건설 주식회사(이하 '회사'라 한다)이(가) 제공하는 인터넷 서비스 (이하 '서비스'라 한다)의 이용 조건 및 절차에 관한 기본적인 사항을 정함을 목적으로 합니다</p>
                                <p class="term_tit2">제2조 (효력 및 변경)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>본 약관은 사이트에 게시하거나 기타의 방법으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
                                    <li><span class="num">②</span>회사는 합당한 사유가 발생될 경우에는 본 약관을 변경할 수 있으며, 변경된 경우에는 바로 이를 이용자에게 공지합니다. 이용자는 서비스의 수정, 또는 중지에 대해 회사가 이용자 또는 제3자에 대하여 어떠한 책임도 지지 않음에 동의합니다.</li>
                                    <li><span class="num">③</span>서비스 이용자가 변경된 약관 사항에 동의하지 않을 경우, 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 그러나 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주합니다.</li>
                                </ul>
                                <p class="term_tit2">제1조 (목 적)</p>
                                <p class="term_txt">본 약관은 계룡건설 주식회사(이하 '회사'라 한다)이(가) 제공하는 인터넷 서비스 (이하 '서비스'라 한다)의 이용 조건 및 절차에 관한 기본적인 사항을 정함을 목적으로 합니다</p>
                                <p class="term_tit2">제2조 (효력 및 변경)</p>
                                <ul class="guide_list number">
                                    <li><span class="num">①</span>본 약관은 사이트에 게시하거나 기타의 방법으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
                                    <li><span class="num">②</span>회사는 합당한 사유가 발생될 경우에는 본 약관을 변경할 수 있으며, 변경된 경우에는 바로 이를 이용자에게 공지합니다. 이용자는 서비스의 수정, 또는 중지에 대해 회사가 이용자 또는 제3자에 대하여 어떠한 책임도 지지 않음에 동의합니다.</li>
                                    <li><span class="num">③</span>서비스 이용자가 변경된 약관 사항에 동의하지 않을 경우, 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 그러나 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주합니다.</li>
                                </ul>
                            </div>
                        </div>
                        <div class="agree_area">
                            <span class="radio-wrap">
                                <input type="radio" name="agree02" value="Y" id="ok02" ><label for="ok02">동의</label>
                            </span>
                            <span class="radio-wrap">
                                <input type="radio" name="agree02" id="no02"><label for="no02">미동의</label>
                            </span>
                        </div>
                        <div class="btn_area">
                            <a href="javascript:;" onclick="fn_Step01(this)" class="btn green">다음</a>
                        </div>
                    </section>
                    
                </div><!-- //contents_wrap -->
            </div><!-- //inner -->
        </main>
        <!-- //container -->
            <%@ include file="../include/footer.jsp" %>
    </div>
    <%@ include file="../include/javascript.jsp" %>
    <script>
    function fn_Step01(obj){
        if($('[name=agree01]:checked').val()!="Y"){
            alert("이용약관에 동의해 주세요.");
            return;
        }
        if($('[name=agree02]:checked').val()!="Y"){
            alert("개인정보 처리 및 이용에 동의해 주세요.");
            return;
        }
        
        var comSubmit = new ComSubmit();
        comSubmit.setUrl("/member/join-02");
        comSubmit.setMethod("post");
        comSubmit.addParam("_csrf", $('meta[name="_csrf"]').attr('content'));
        comSubmit.addParam("agree01", "Y");
        comSubmit.addParam("agree02", "Y");
        comSubmit.submit();
        
    }
    </script>
</body>

</html>