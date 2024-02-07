<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:bundle basename="system">
<fmt:message key="sys.profile" var="sysprofile"/>
</fmt:bundle>
<form id="commonForm" name="commonForm" method="get"></form>
<script src="/resources/mobile/js/jquery-3.6.0.min.js"></script>
<script src="/resources/mobile/js/common.js"></script>
<script src="/resources/mobile/js/slick.min.js"></script>
<script src="/resources/mobile/js/anime.min.js"></script>
<script src="/resources/mobile/js/jquery.alphanum.js"></script>
<script src="/resources/mobile/js/custom.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<script>
// gnb
var header = $('#header');
var logo = $('h1');
$('#myElifBtn').on('click', function(e){
        e.preventDefault();
        mainGnbAdd();
        $('body').addClass('no_scroll');
        if(header.hasClass('gnb_open')){
        menuClose();
        header.removeClass('gnb_open');
        mainGnbRemove();
        setTimeout(function(){
                header.addClass('my_open');
                mainGnbAdd();
        }, 320);
        }else{
        header.addClass('my_open')
        }
});

$('#gnbMenuBtn').on('click', function(e){ // toggle
        e.preventDefault();
        if(header.hasClass('gnb_open')){
        header.removeClass('gnb_open');
        menuClose();
        $('body').removeClass('no_scroll');
        mainGnbRemove();
        }else if(header.hasClass('my_open')){
        menuClose();
        header.removeClass('my_open');
        setTimeout(function(){
                mainGnbRemove();
        }, 200);
        setTimeout(function(){
                header.addClass('gnb_open');
                deviceWidthCheck();
                mainGnbAdd();
        }, 320);
        }
        else{
        header.addClass('gnb_open');
        deviceWidthCheck();
        $('body').addClass('no_scroll');
        mainGnbAdd();
        }
});

header.find('.my_nav .close_btn').on('click', function(e){
        e.preventDefault();
        menuClose();
        $('body').removeClass('no_scroll');
        setTimeout(function(){
                mainGnbRemove();
        }, 320);
});

header.find('.dim').on('click', function(e){
        e.preventDefault();
        if(header.hasClass("my_open")){
        setTimeout(function(){
                mainGnbRemove();
        }, 320);
        }else{
        mainGnbRemove();
        };
        menuClose();
        $('body').removeClass('no_scroll');
});

var menuClose = function(){
        header.attr('class', '');
        if(logo.hasClass('white')){
        logo.removeClass('white');
        };
};

var deviceWidthCheck = function(){
        var breakP = 414;
        ($(window).innerWidth() <= breakP) && logo.addClass('white');
};
// scrollBehavior

var mainHeader = $('main')
var mainGnbAdd = function(){
        mainHeader.hasClass('.main-container');
        if(mainHeader.hasClass('main-container')){
        $('.header').addClass('r');
        };
};
var mainGnbRemove = function(){
        if(mainHeader.hasClass('main-container')){
        $('.header').removeClass('r');
        };
};


// family Site Link
$(".family_select").change(function(){
var fLink = $("select option:selected").val();
if(fLink != ""){
        window.open("about:blank").location.href = fLink;
}
})

</script>
<script type="text/javascript">
        // SDK 사용할 앱 JavaScript 키 설정
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