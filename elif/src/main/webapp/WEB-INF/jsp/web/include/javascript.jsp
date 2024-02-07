<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:bundle basename="system">
<fmt:message key="sys.profile" var="sysprofile"/>
</fmt:bundle>

        <!-- //wrap -->
        <form id="commonForm" name="commonForm" method="get"></form>
        <script src="/resources/web/js/jquery-3.6.0.min.js"></script>
        <script src="/resources/web/js/jquery-ui.js"></script>
        <script src="/resources/web/js/common.js"></script>
        <script src="/resources/web/js/slick.min.js"></script>
        <script src="/resources/web/js/jquery.alphanum.js"></script>
        <script src="/resources/web/js/custom.js"></script>
        <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
        <script>
            elif.saleSearch();
        </script>
        <script>
            $(document).ready(function () {
                setTimeout(function() { 
                    $("#header").fadeIn(5000);
                });
            }); 
            /* header load 완료되면 시작 */

            setTimeout(function(){
                scrollBehavior()
            }, 1000)

            function scrollBehavior(){
                    var lnbs = $('.lnb');
                    var headers = $('#header');
                    var prevScroll = 0;
                    var scrollTopBh;
                    
                    var lnbsTop = 0;
                    if(lnbs.length>0){
                        lnbsTop = lnbs.offset().top;
                    }
                
                    $(window).scroll(function(e){
                        scrollTopBh = $(window).scrollTop();
                        var scrollState = (prevScroll - scrollTopBh <= 0)? 'down' : 'up';

                        if(lnbs.length>0){
                            if(lnbsTop <= scrollTopBh){
                                lnbs.addClass('fixed');
                                // lnbsTop
                            }else if(lnbsTop  > scrollTopBh + headers.height()){
                                lnbs.removeClass('fixed');
                            }
                        }
                        if(headers.height() <= scrollTopBh && scrollState === 'down'){
                            headers.addClass('fixed');
                        }else if(scrollTopBh === 0 && scrollState === 'up'){
                            headers.removeClass('fixed')
                        }
                        
                        if(scrollState == 'up' && headers.hasClass('fixed')){
                            headers.addClass('show');
                        }else{
                            headers.removeClass('show');
                        }
                        prevScroll = scrollTopBh;
                    });
                }
        </script>
        <script>
            //nav-depth2
                var depth0 = $('#header');
                var depth1 = $('.elif_gnb .gnb_list');
                var depth2 = $('.dep2');
                depth1.on('mouseenter', function(e){
                    e.preventDefault();
                    $("header").addClass("on");
                });
                depth0.on('mouseleave', function(e){
                    e.preventDefault();
                    $("header").removeClass("on");
                });

                // a:hover
                $(".dep2 li a").on('mouseenter', function(e){
                    $(this).parents(".gnb_list > li").children("a").addClass("on");
                });
                $(".dep2 li a").on('mouseleave', function(e){
                    $(this).parents(".gnb_list > li").children("a").removeClass("on");
                });
        </script>
        <script type="text/javascript">
            <c:choose>
            <c:when test="${sysprofile=='dev'}">
            Kakao.init('692b71c92ead2598642051cba1148ffc'); //testLocal -JavaScript키
            </c:when>
            <c:otherwise>
            Kakao.init('24f352b85e683359facbbc82eca591e1'); //OfficialELIF -JavaScript키
            </c:otherwise>
            </c:choose>

            // SDK 초기화 확인
            console.log(Kakao.isInitialized());
            function shareTalk() {
                Kakao.Link.sendScrap( {
                requestUrl: location.href
                } );
            };
            function shareKakao() {
                Kakao.Link.sendDefault({
                    objectType: 'feed',
                    content: {
                        title: document.title,                                                 // 공유 시 타이틀
                        description: $( 'meta[property="og:description"]' ).attr( 'content' ), // 공유 시 설명
                        imageUrl: '${img_row.path_name}${img_row.stored_file_name}',           // 공유 시 썸네일 이미지 경로
                        link: {                                                                // 공유 시 클릭 후 이동 경로
                            mobileWebUrl: encodeURIComponent(location.href),
                            webUrl: encodeURIComponent(location.href),
                            // mobileWebUrl: 'window.location.href',
                            // webUrl: 'window.location.href',
                            // mobileWebUrl: 'http://localhost:${port}',
                            // webUrl: 'http://localhost:${port}',
                        },
                    },
                    buttons: [{
                        title: '웹으로 보기',
                        link: {                                                               // 공유 시 클릭 후 이동 경로
                            mobileWebUrl: encodeURIComponent(location.href),
                            webUrl: encodeURIComponent(location.href),
                            // mobileWebUrl: 'window.location.href',
                            // webUrl: 'window.location.href',
                            // mobileWebUrl: 'http://localhost:${port}',
                            // webUrl: 'http://localhost:${port}',
                            },
                        },],
                    // 카카오톡 미설치 시 카카오톡 설치 경로이동
                    installTalk: true,
                })
            };
            function shareStory() { 
                Kakao.Story.share({
                    // container: '#kakaostory-share-button',
                    url: encodeURIComponent(location.href),
                    text: $( 'meta[property="og:title"]' ).attr( 'content' ),
                });
            };
            function shareLine() { 
                var line_title = $( 'meta[property="og:title"]' ).attr( 'content' );
                var line_summary = $( 'meta[property="og:description"]' ).attr( 'content' ); 
                var line_br = "\n" ;
                var line_link = encodeURIComponent(location.href); 
                var line_img = "" ;
                var url = "http://line.me/R/msg/text/?" + encodeURIComponent(line_title + line_br + line_summary + line_br + line_link);
                window.open(url);
            };
            // function shareBand() { };
            function shareBlog() { 
                var url = encodeURI(encodeURIComponent(location.href));
                var title = encodeURI($( 'meta[property="og:title"]' ).attr( 'content' ));
                var shareURL = "https://share.naver.com/web/shareView?url=" + url + "&title=" + title;
                document.location = shareURL;
            };
            function shareFacebook() { 
                var url = encodeURIComponent(location.href);
                window.open("http://www.facebook.com/share.php?u=" + encodeURIComponent(location.href));
            };
            function shareTwitter() {
                var url = encodeURIComponent(location.href);
                var descr = $( 'meta[property="og:description"]' ).attr( 'content' );
                window.open('http://twitter.com/share?url='+url+'&text='+descr);
                // window.open(`http://twitter.com/share?url=${url}&text=${descr}`);
            };
        </script>
        <c:if test="${not empty SITE_ALERT}">
        <script>
        alert("${sessionScope["SITE_ALERT"]}");
        <c:remove var="SITE_ALERT" scope="session" />
        </script>
        </c:if>