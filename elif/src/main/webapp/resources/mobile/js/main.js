$(window).on('load', function () {

    // 메인 비주얼 영역 브라우저 상하단 바 상관없이 height 변경
    var $visualSec = $(".visual_sec"),
        $viewportSize = $("#viewportSizeCheck"),
        viewHeight = $viewportSize.height();

    $visualSec.css("height",viewHeight);
    // 메인 비주얼 영역 브라우저 상하단 바 상관없이 height 변경//

    var introClear = setTimeout(function () {
        $(".intro").fadeOut();
        $('body').removeClass('lock');
        startSwiper();
    }, 4800);

    $('#skipBtn').click(function () {
        $(".intro").fadeOut();
        $('body').removeClass('lock');
        clearTimeout(introClear);
        startSwiper();
    });

    var expandTweens = [];

    function loopPlay(idx) {
        for (var i = 0, length = expandTweens[idx].length; i < length; i++) {
            expandTweens[idx][i].play(0);
        };
    };

    function loopPause() {
        for (var i = 0; i < 3; i++) { // 슬라이드 length
            for (var j = 0; j < 2; j++) { // 슬라이드 내의 텍스트 length
                expandTweens[i][j].pause(0);
            };
        };
    };

    /*
            bg 모션 수정 시
        */
    // bg motion
    var tlbg1 = new TimelineMax();

    tlbg1
        .fromTo(".bg1", 3, {
            scale: 1.2
        }, {
            scale: 1.005,
            ease: Power1.ease0ut
        })
        .pause();

    var tlbg2 = new TimelineMax();
    tlbg2
        .fromTo(".bg2", 3, {
            scale: 1.005
        }, {
            scale: 1.2,
            ease: Power1.ease0ut
        })
        .pause();

    var tlbg3 = new TimelineMax();
    tlbg3
        .fromTo(".bg3", 3, {
            scale: 1.2
        }, {
            scale: 1.005,
            ease: Power1.ease0ut
        })
        .pause();

    /* slide 모션 수정시 Timeline, css 두 영역 수정 필요!!!!!!!*/
    // slide1 motion
    var tl = new TimelineLite();
    tl.fromTo(".slide1 .box", 1, {opacity: '0'}, {opacity: '1'}, .5)
        .fromTo(".slide1 .left1 .box2", 1, {left: '47%', width: '21px'},{left: '0',width: '100%'}, 1.5)
        .fromTo(".slide1 .left2 .box2", 1, {left: '47%',width: '21px'}, {left: '0',width: '100%'}, 1.6)
        .fromTo(".slide1 .left .line", .5, {width: '0'}, {width: '193px'})
        .fromTo(".slide1 .right1 .box2", 1, {left: '5%', width: '140px'}, {left: '0%',width: '100%'}, 1.7)
        .fromTo(".slide1 .right2 .box2", 1, {left: '3.5%',width: '150px'}, {left: '0%',width: '100%'}, 1.8)
        .fromTo(".slide1 .right .line", .5, {width: '0'}, {width: '110px'}, 2.8)
        .pause();

    // slide2 motion
    var tl2 = new TimelineLite()
    tl2.fromTo(".slide2 .box", 1, {opacity: '0'}, {opacity: '1'}, .5)
        .fromTo(".slide2 .left1 .box2", 1, {left: '43%',width: '32px'}, {left: '0',width: '100%'}, 1.5)
        .fromTo(".slide2 .left2 .box2", 1, {left: '43%',width: '32px'}, {left: '0',width: '100%'}, 1.6)
        .fromTo(".slide2 .left .line", .5, {width: '0'}, {width: '83px'})
        .fromTo(".slide2 .right1 .box2", 1, {left: '-11.5%',width: '188px'}, {left: '0%',width: '100%'}, 1.7)
        .fromTo(".slide2 .right2 .box2", 1, {left: '-13%',width: '197px'}, {left: '0%',width: '100%'}, 1.8)
        .fromTo(".slide2 .right .line", .5, {width: '0'}, {width: '150px'}, 2.8)
        .pause();

    // slide3 motion
    var tl3 = new TimelineLite()
    tl3.fromTo(".slide3 .box", 1, {opacity: '0'}, {opacity: '1'}, .5)
        .fromTo(".slide3 .left1 .box2", 1, {left: '44%',width: '28px'}, {left: '0',width: '100%'}, 1.5)
        .fromTo(".slide3 .left2 .box2", 1, {left: '44%',width: '28px'}, {left: '0',width: '100%'}, 1.6)
        .fromTo(".slide3 .left .line", .5, {width: '0'}, {width: '108px'})
        .fromTo(".slide3 .right1 .box2", 1, {left: '-6%',width: '172px'}, {left: '0%',width: '100%'}, 1.7)
        .fromTo(".slide3 .right2 .box2", 1, {left: '-7%',width: '178px'}, {left: '0',width: '100%'}, 1.8)
        .fromTo(".slide3 .right .line", .5, {width: '0'}, {width: '135px'}, 2.8)
        .pause();

    // arr push
    expandTweens.push([tl, tlbg1]) // slide1
    expandTweens.push([tl2, tlbg2]) // slide2
    expandTweens.push([tl3, tlbg3]) // slide3

    function startSwiper() {
        var visualSwiper = new Swiper(".visual_slide", {
            effect: "fade",
            speed: 2000,
            autoplay: {
                delay: 6000,
                disableOnInteraction: false
            },
            //  autoplay:false,
            autoplayDisableOnInteraction: false,
            allowTouchMove: false,
            slidesPerView: 1,
            pagination: {
                el: '.swiper-pagination',
                type: 'bullets',
                clickable: true
            },
            on: {
                init: function () {
                    var cntIdx = this.realIndex;

                    setTimeout(function () {
                        loopPlay(cntIdx);
                    }, 1000);
                },
                slideChangeTransitionEnd: function () {
                    var cntIdx = this.realIndex;
                    loopPause();
                    loopPlay(cntIdx);
                }
            }
        });
    }

    /* 메인 헤더 스크롤 */
    function mainHeader() {
        var headerHei = $('.header').height();
        var scrollTop = 0;
        var goTop = $('.header');
        $(window).on('scroll', function (e) {
            scrollTop = $(window).scrollTop();
            if (scrollTop > headerHei) {
                goTop.removeClass('w');
                $("h1 a img").attr("src", "/resources/mobile/images/logo.png");
            } else {
                goTop.addClass('w');
                $("h1 a img").attr("src", "/resources/mobile/images/logo_w.png");
            };
        });
    };
    mainHeader();

    //scroll lock
    if (!$('.intro').hasClass('on')) {
        $('body').addClass('lock');
    };

    $('.no-data').click(function (e) {
        $(this).css({"cursor": "default"});
        e.preventDefault();
    });

    // main header class w
    if (!$('main').hasClass('.main-container')) {
        $('.header').addClass('w');
        $("h1 a img").attr("src", "/resources/mobile/images/logo_w.png");
    };

    

});
var _main = {

    mainBnn: function () {
        //배너 닫기
        $('.bnn_close').click(function (e) {
            $(this).parent().hide();
            e.preventDefault();
        });
    },

    mainSlide: function () {
        $('.slider-front').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            fade: true,
            draggable: false,
            arrows: false,
            dots: true,
            autoplay: true,
            autoplaySpeed: 4000,
            loop: true,
        });
        $('.slider-for').slick(
            {slidesToShow: 1.18, slidesToScroll: 1, arrows: false, dots: true, infinite: false}
        );
    },
    textRoller: function () {

        var maingRolling = anime({
            //targets: wrapper.get(0),
            targets: '.text-roller-wrapper',
            translateX: {
                // value: '-=' + span_width + 'px',
                value: '-687px',
                duration: 12000
            },
            loop: true,
            easing: 'linear'
        });
    }

};
_main.mainBnn();
_main.mainSlide();
_main.textRoller();