$(window).on("load",function(){
    // main only
    var visualSwiper = null, 
        maingRolling = null,
        $vdo = $("#mainstory");

    // intro-skip
    $('#skipBtn').click(function(){
        $(".intro").remove();
        $(".main-container").css("opacity","1");
        $('body').removeClass('lock');	
            
        startSwiper();
        $(window).trigger("resize");
    });

    // 영상 종료 후
    $("#video").on("ended",function(){
        // 영상 줄어드는 효과 적용
        $(".intro").addClass("hide");
        $('body').removeClass('lock');

        // 1초 후
        setTimeout(function(){
            // 비디오 영역 숨김, main-containe opacity
            $(".main-container").css("opacity","1");
            $(".video_wrap").css({"opacity":0, "visibility":"hidden"});
            $(window).trigger("resize");
        }, 1000);

        setTimeout(function(){
            // 인트로 삭제 후 슬라이드 실행
            $('body').removeClass('lock');	
            $(".intro").remove();
            startSwiper();
        }, 2000);
    });

    // slide animation arr
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
        .fromTo(".bg1", 6, {backgroundPosition: "0 0",ease: Linear.easeNone}, {backgroundPosition: "0 -160px",ease: Linear.easeNone})
        .pause();

    var tlbg2 = new TimelineMax();
    tlbg2
        .fromTo(".bg2", 6, {scale: 1.2}, {scale: 1.05,ease: Power1.ease0ut})
        .pause();

    var tlbg3 = new TimelineMax();
    tlbg3
        .fromTo(".bg3", 6, {scale: 1.05}, {scale: 1.2,ease: Power1.ease0ut})
        .pause();

    /*
        slide 모션 수정시 Timeline, css 두 영역 수정 필요!!!!!!!
    */
    // slide1 motion
    var tl = new TimelineLite();
    tl
        .fromTo(".slide1 .box", 1, {opacity: '0'}, {opacity: '1'}, .5)
        .fromTo(".slide1 .left1 .box2", 1, {left: '45%',width: '5%'}, {left: '0',width: '100%'}, 1.5)
        .fromTo(".slide1 .left2 .box2", 1, {left: '45%',width: '5%'}, {left: '0',width: '100%'}, 1.6)
        .fromTo(".slide1 .left .line", .5, {width: '0'}, {width: '73%'})
        .fromTo(".slide1 .right1 .box2", 1, {left: '46%',width: '1%'}, {left: '47%',width: '100%'}, 1.7)
        .fromTo(".slide1 .right2 .box2", 1, {left: '45%',width: '5%'}, {left: '47%',width: '100%'}, 1.8)
        .fromTo(".slide1 .right .line", .5, {width: '0'}, {width: '40%'}, 2.8)
        .pause();

    // slide2 motion
    var tl2 = new TimelineLite()
    tl2
        .fromTo(".slide2 .box", 1, {opacity: '0'}, {opacity: '1'}, .5)
        .fromTo(".slide2 .left1 .box2", 1, { left: '45%',width: '5%'}, {left: '0',width: '100%'}, 1.5)
        .fromTo(".slide2 .left2 .box2", 1, {left: '45%',width: '5%'}, {left: '0',width: '100%'}, 1.6)
        .fromTo(".slide2 .left .line", .5, {width: '0'}, {width: '35%'})
        .fromTo(".slide2 .right1 .box2", 1, {left: '46%',width: '1%'}, {left: '65%',width: '100%'}, 1.7)
        .fromTo(".slide2 .right2 .box2", 1, {left: '45%',width: '5%'}, {left: '65%',width: '100%'}, 1.8)
        .fromTo(".slide2 .right .line", .5, {width: '0'}, {width: '58%'}, 2.8)
        .pause();

    // slide3 motion
    var tl3 = new TimelineLite()
    tl3
        .fromTo(".slide3 .box", 1, {opacity: '0'}, {opacity: '1'}, .5)
        .fromTo(".slide3 .left1 .box2", 1, {left: '46%',width: '5%'}, {left: '0',width: '100%'}, 1.5)
        .fromTo(".slide3 .left2 .box2", 1, {left: '46%',width: '5%'}, {left: '0', width: '100%'}, 1.6)
        .fromTo(".slide3 .left .line", .5, {width: '0'}, {width: '43%'})
        .fromTo(".slide3 .right1 .box2", 1, {left: '47%',width: '1%'}, {left: '58%',width: '100%'}, 1.7)
        .fromTo(".slide3 .right2 .box2", 1, {left: '46%',width: '5%'}, {left: '58%',width: '100%'}, 1.8)
        .fromTo(".slide3 .right .line", .5, {width: '0'}, {width: '52%'}, 2.8)
        .pause();

    // arr push
    expandTweens.push([tl, tlbg1]) // slide1
    expandTweens.push([tl2, tlbg2]) // slide2
    expandTweens.push([tl3, tlbg3]) // slide3

    $('.no-data').click(function (e) {
        $(this).css({"cursor": "default"});
        e.preventDefault();
    });

    function startSwiper() {
        var visualSwiper = new Swiper(".visual_slide", {
            effect: "fade",
            speed: 2000,
            autoplay: {
                delay: 6000,
                disableOnInteraction: false
            },
            autoplayDisableOnInteraction: false,
            allowTouchMove: false,
            slidesPerView: 1,
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
    };

    function txtFlow(){
        maingRolling = anime({
            //targets: wrapper.get(0),
            targets: '.text-roller-wrapper',
            translateX: {
                // value: '-=' + span_width + 'px',
                value:'-687px',
                duration: 12000,
            },
            loop: true,
            easing: 'linear'
        });
    };
    txtFlow();
});

var _main = {
    mainBnn: function () {
        function setCookie(name, value, expirehours) {
            var todayDate = new Date();
            todayDate.setHours(todayDate.getHours() + expirehours);
            document.cookie = name + "=" + escape(value) + "; path=/; expires=" +
                    todayDate.toGMTString() + ";"
        }
        function closeWin(id, checkbox) {
            if (checkbox.checked) {
                setCookie(id, "done", 1);
            }
            $(this)
                .closest('.banner')
                .fadeOut();
        }
        cookiedata = document.cookie;
        // popup0
        if (cookiedata.indexOf("popup0=done") < 0) {
            $("#popup0").fadeIn();
        } else {
            $("#popup0").fadeOut();
            $(this)
                .closest('.banner')
                .fadeOut();
        }
        // popup1
        if (cookiedata.indexOf("popup1=done") < 0) {
            $("#popup1").fadeIn();
        } else {
            $("#popup1").fadeOut();
            $(this)
                .closest('.banner')
                .fadeOut();
        }
        // popup2
        if (cookiedata.indexOf("popup2=done") < 0) {
            $("#popup2").fadeIn();
        } else {
            $("#popup2").fadeOut();
            $(this)
                .closest('.banner')
                .fadeOut();
        }
        //  popup3
        if (cookiedata.indexOf("popup3=done") < 0) {
            $("#popup3").fadeIn();
        } else {
            $("#popup3").fadeOut();
            $(this)
                .closest('.banner')
                .fadeOut();
        }
        // common-clz
        $('.bye').click(function (e) {
            $(this)
                .closest('.banner')
                .fadeOut();
            e.preventDefault();
        });
    },

    mainLine: function () {
        $('.lineClose').click(function (e) {
            $(this)
                .closest('div')
                .hide();
            e.preventDefault();
        });
    },

    mainSlide: function () {
        $('.slider-front').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            fade: true,
            infinite: true,
            autoplay: true,
            autoplaySpeed: 6000,
            pauseOnHover: false,
            draggable: false,
            arrows: false,
            dots: false
        });
        $('.slider-for').slick({
            slidesToShow: 1.68,
            // slidesToShow: 1.54,
            slidesToScroll: 1,
            speed: 280,
            dots: true,
            arrows: true,
            //infinite: true,
            //centerMode: true,
            centerPadding: '0',
            focusOnSelect: true,
            accessibility: true,
            prevArrow: "<button type='button' class='slick-prev'>Previous</button>",
            nextArrow: "<button type='button' class='slick-next'>Next</button>",
            asNavFor: '.slider-nav',
        });
        $('.slider-nav').slick({
            asNavFor: '.slider-for',
            slidesToShow: 1,
            slidesToScroll: 1,
            speed: 280,
            dots: false,
            arrows: false,
            //infinite: true,
            //centerMode: true,
            focusOnSelect: false,
            fade: true,
        });
    },

    mainHead: function () {
        var front5 = $('#front5 ul');
        var McurrentScrollTop = 0;
        if ($('#container').hasClass("main-container")) {
            $("#header").removeClass("sticky_none");
            $("#header").addClass("sticky");
            $(document).ready(function () {
                $(window).scroll(function () {

                    var MscrollTop = $(this).scrollTop();
                    if (MscrollTop > McurrentScrollTop) {
                        // downscroll code
                        $("body").removeClass("scrollup");
                        $("body").addClass("scrolldown");
                        $("#header").addClass("fixed");
                    }
                    if (MscrollTop < McurrentScrollTop) {
                        // upscroll code
                        $("body").addClass("scrollup");
                        $("body").removeClass("scrolldown");
                    }
                    if (MscrollTop > 2300) {
                        front5.addClass("active");
                    }
                    if (MscrollTop < 2500) {
                        front5.removeClass("active");
                    }
                    if (MscrollTop == 0) {
                        $("body").removeClass("scrollup");
                        $("body").removeClass("scrolldown");
                        $("#header").removeClass("fixed");
                    }
                    McurrentScrollTop = MscrollTop;
                });
            });
        };
    }
};

_main.mainBnn();
_main.mainLine();
_main.mainSlide();
_main.mainHead();
