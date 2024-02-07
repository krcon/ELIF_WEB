$(function($){
    // true, false 로 return 하여 이벤트 한번만 실행
    var section01Active = false;
    var section02Active = false;

    // section01 swiper
    var swiper01 = new Swiper('.swiper01', {
        effect: "fade",
        speed: 1000,
        loop:false,
        observer:true,
        observeParents:true,
    });

    // fullpage 
    new fullpage("#fullpage", {
        verticalCentered: false,
        scrollBar:false,
        scrollOverflow: true,
        licenseKey: '498CFFC8-84564252-8A0832C7-81EE6C6B',
        
        // section 이동할대
        onLeave: function(origin, destination, direction) {
            // fullpageSticky(false);
            // section01에서 내릴때
            if(origin.index == 0 && direction == 'down') {
                // section01
                if (section01Active === false){
                    // 스크롤 내리는 시점과 동시에 페이지 이동이 되어
                    // 그 부분을 제어 하기 위해서 setTimeout 안에 true를 선언.
                    setTimeout(function(){
                        section01Active = true;
                        
                    },200);
                };
                // section01Acitve true 값을 반환
                return section01Active;
            }

            // section02에서 내릴때
            if(origin.index == 1 && direction == 'down') {

                // section02
                TweenMax.to("[data-animationNum2='2']", 1, {
                    y:-150
                });
                TweenMax.to("[data-animationNum2='3']", 1, {
                    y:-150
                });
                $("[data-animationNum2='4']").css({"transform":"translateY(300px) rotate(.001deg)"});
                TweenMax.to("[data-animationNum2='1']", 0.3, {
                    css: {        
                        backgroundPosition: "bottom",
                    }
                });

                // section03
                TweenMax.to("[data-animationNum3='1']", 0.6, {
                    ease:Power1.easeOut,
                    delay:0.3,
                    y:0
                });
                TweenMax.to("[data-animationNum3='2']", 0.8, {
                    ease:Power1.easeOut,
                    delay:0.4,
                    y:0
                });
            }
            // section03에서 올릴때
            if(origin.index == 2 && direction == 'up') {

                // section02
                TweenMax.to("[data-animationNum2='2']", 1, {
                    y:0
                });
                TweenMax.to("[data-animationNum2='3']", 1, {
                    y:0
                });
                $("[data-animationNum2='4']").css({"transform":"translateY(0) rotate(.001deg)"});
                TweenMax.to("[data-animationNum2='1']", 0.3, {
                    css: {        
                        backgroundPosition: "top",
                    }
                });
                
                // section03
                TweenMax.to("[data-animationNum3='1']", 0.6, {
                    ease:Power1.easeOut,
                    delay:0.3,
                    y:350
                });
                TweenMax.to("[data-animationNum3='2']", 0.8, {
                    ease:Power1.easeOut,
                    delay:0.4,
                    y:350
                });
            };
            // section03에서 내릴때
            if (origin.index == 2 && direction == 'down'){
                slideAnimationStart();
            }
            // section05에서 올릴때
            if (origin.index == 4 && direction == 'up'){
                slideAnimationEnd();
            }
        },
        // section 도달했을때
        afterLoad: function (anchorLink, index, direction) {
            // fullpageSticky(false)
            // section02
            if (index.index == 1){
                if (section02Active === false){
                    $("[data-animationNum2='1']").css({"transform":"scale(1.08) rotate(.001deg)"});
                    var t2 = new TimelineMax();
                    t2.to("[data-animationNum2='2']", 0.6, {
                        delay:0.5,
                        ease:Power1.easeOut,
                        opacity:1,
                        y:0
                    }).to("[data-animationNum2='3']", 0.6, {
                        delay:0.5,
                        ease:Power1.easeOut,
                        opacity:1,
                        y:0
                    }).add(function(){
                        section02Active = true;
                    });
                }
                return section02Active;
            };

            // section04
            if (index.index == 3){
                // fullpageSticky(true)
                if (direction == 'down'){
                    
                    if( !($(".slide_item").eq(1).hasClass('active')) ){
                        slideAnimationReset(slide01);
                    };
                    
                    slideAnimationStart();
                };
                if (direction == 'up'){
                    slideAnimationEnd();
                }
            }
            // section05
            if (index.index == 4){
                TweenMax.to("[data-animationNum5='1']", 0.7, {
                    opacity:1,
                    y:0
                });
                TweenMax.to("[data-animationNum5='2']", 0.7, {
                    delay:0.2,
                    opacity:1,
                    y:0
                });
            }
        },
    });
    fullpage_api.setKeyboardScrolling(false); 
    // 페이지 진입시 section01 애니메이션
    function section01Animation(){
        var t1 = new TimelineMax();
        t1.to("[data-animationNum1='1']", 0.6, {
            ease:Power1.easeOut,
            opacity:1,
            y:0
        }).to("[data-animationNum1='2']", 0.6, {
            ease:Power1.easeOut,
            opacity:1,
            y:0
        },"-=0.4").to("[data-animationNum1='3']", 0.6, {
            ease:Power1.easeOut,
            opacity:1,
            y:0
        },"-=0.4").to("[data-animationNum1='4']", 1, {
            ease:Power1.easeOut,
            opacity:1,
        }).to("[data-animationNum1='5']", 0.8, {
            ease:Power1.easeOut,
            width:100+'%',
        }).to("[data-animationNum1='5']", 0.6, {
            ease:Power2.easeOut,
            height:256,
            marginBottom:-70,
        })
        .add(function(){
            swiper01.slideTo(0)
        })
        .to("", 0,{
            delay:3
        })
        .add(function(){
            swiper01.slideTo(1)
        })
        .to("", 0,{
            delay:3
        })
        .add(function(){
            swiper01.slideTo(2)
        })
    };
    ///// 2021-11-17 수정 /////
    // 슬라이드01 애니메이션
    function slide01Animation(){
        $("[data-animationSlide1='3']").css({
            opacity:0,
            width:0,
            height:0,
        });
        TweenMax.set("[data-animationSlide1='3']", {
            opacity:0,
            width:0,
            height:0,
        });
        slide01 = new TimelineMax({paused:true});
        slide01.to("[data-animationSlide1='4']", 0.1, {
            opacity:1,
        },"-=0.1").to("[data-animationSlide1='3']", 1.2, {
            ease:Power1.easeOut,
            opacity:1,
            width:"624px",
            height:"624px"
        })
        .to("[data-animationSlide1='1']", 0.5, {
            opacity:1,
            y:0
        },0.1)
        .to("[data-animationSlide1='2']", 0.5, {
            delay:0.2,
            opacity:1,
            y:0,
            onComplete:flagEnd,
        },0.2)
            
    };
    // 슬라이드01-1 애니메이션
    function slide01_1Animation(){
        slide01_1 = new TimelineMax({paused:true});
        slide01_1.to("[data-animationSlide1='4']", 0.3, {
            opacity:0,
        }).to("[data-animationSlide1='3']", 0.8, {
            ease:Power2.easeOut,
            width:"250%",
            height:"250%"
        }).staggerTo("[data-animationSlide1-1='5']", 1, {
            ease:Power1.easeOut,
            width:"100%",
            height:"100%",
            opacity:1,
        },0.2)
        .staggerTo("[data-animationSlide1-1='6']", 1, {
            delay:0.2,
            ease:Power1.easeOut,
            opacity:1,
        },0.2,"-=1.4")
        .staggerTo("[data-animationSlide1-1='7']", 1, {
            delay:0.4,
            ease:Power1.easeOut,
            height:56,
            opacity:1,
        },0.2,"-=1.8")
        .staggerTo("[data-animationSlide1-1='8']", 1, {
            delay:0.6,
            ease:Power1.easeOut,
            opacity:1,
        },0.2,"-=1.8")
        .to("[data-animationSlide1-1='9']", 0.5, {
            opacity:1,
            onComplete:flagEnd,
        },"-=0.8");
    };
    // 슬라이드02 애니메이션
    function slide02Animation(){
        slide02 = new TimelineMax({paused:true});
        slide02.to("[data-animationSlide2='1']",1, {
            ease:Power4.easeOut,
            delay:0.2,
            height:"150px",
            opacity:1,
        })
        .to("[data-animationSlide2='3']",1.5, {
            ease:Power1.easeOut,
            opacity:1
        },1.4)
        .to("[data-animationSlide2='4']",1.2, {
            ease:Power3.easeOut,
            y:"0",
            opacity:1,
            onComplete:flagEnd,
        },1.1);
        
    };
    // 슬라이드03 애니메이션
    function slide03Animation(){
        slide03 = new TimelineMax({paused:true});
        slide03.to("[data-animationSlide3='1']",1, {
            ease:Power4.easeOut,
            delay:0.2,
            height:"150px",
            opacity:1,
        })
        .to("[data-animationSlide3='2']",1.2, {
            ease:Power3.easeOut,
            height:180
        },0.2)
        .to("[data-animationSlide3='3']",1.5, {
            ease:Power1.easeOut,
            opacity:1
        },1.4)
        .to("[data-animationSlide3='4']",1.2, {
            ease:Power3.easeOut,
            y:"0",
            opacity:1,
            onComplete:flagEnd,
        },1.1);
    };
    // 슬라이드04 애니메이션
    function slide04Animation(){
        slide04 = new TimelineMax({paused:true});
        slide04.to("[data-animationSlide4='1']",1, {
            ease:Power4.easeOut,
            delay:0.2,
            height:"150px",
            opacity:1,
        })
        .to("[data-animationSlide4='2']",1.2, {
            ease:Power3.easeOut,
            height:180
        },0.2)
        .to("[data-animationSlide4='3']",1.5, {
            ease:Power1.easeOut,
            opacity:1
        },1.4)
        .to("[data-animationSlide4='4']",1.2, {
            ease:Power3.easeOut,
            y:"0",
            opacity:1,
            onComplete:flagEnd,
        },1.1);
    };
    // 슬라이드05 애니메이션
    function slide05Animation(){
        slide05 = new TimelineMax({paused:true});
        slide05.to("[data-animationSlide5='1']",1, {
            ease:Power4.easeOut,
            delay:0.2,
            height:"150px",
            opacity:1,
        })
        .to("[data-animationSlide5='2']",1.2, {
            ease:Power3.easeOut,
            height:180
        },0.2)
        .to("[data-animationSlide5='3']",1.5, {
            ease:Power1.easeOut,
            opacity:1
        },1.4)
        .to("[data-animationSlide5='4']",1.2, {
            ease:Power3.easeOut,
            y:"0",
            opacity:1,
            onComplete:flagEnd,
        },1.1)
    };
    // 슬라이드 공통 애니메이션
    function slideCommonAnimation(){
        slideCommon = new TimelineMax();
        slideCommon.to("[data-animationCommon='1']",1.2, {
            ease:Power3.easeOut,
            height:180
        },0.2)
        .to("[data-animationCommon='2']",0.8, {
            ease:Power1.easeOut,
            opacity:1
        },0.7)
    }
    // set
    section01Animation();
    slide01Animation();
    slide01_1Animation();
    slide02Animation();
    slide03Animation();
    slide04Animation();
    slide05Animation();
    slideCommonAnimation();


    // 슬라이드 애니메이션 리셋
    function slideAnimationReset(slideNum){
        slideNum.restart();
    };

    // 풀페이지 스크롤 제어 
    function slideAnimationStart(){
        // fullpage_api.setAllowScrolling(true, 'up');
        // fullpage_api.setAllowScrolling(false, 'down');
    };
    function slideAnimationEnd(){
        // fullpage_api.setAllowScrolling(true, 'down');
        // fullpage_api.setAllowScrolling(false, 'up');
    };
    function fullpageSticky(get){
        // if (get == true){
        //     fullpage_api.setAllowScrolling(false);
        // } else{
        //     fullpage_api.setAllowScrolling(true);
        // }
    };
    function flagEnd(){
        wheelD = false;
    }

    $(".slideup_slider").junSlider({
        slideAutoplaySpeed: 3000,
        slideSpeed: 1000,
        slideMouseWheel:false,
        autoplay:false,
        pager:true,
        arrows:true,
        loop:false,
        mode:'slideUp',
        slideChange: function(idx, idxPrev){ 
            // fullpageSticky(true);

            if (idx === 0){
                // 1번
                slideAnimationReset(slide01);
                $(".fixed_box").hide();
        
            } else if ( idx === 1){
                // 1-1번
                slideAnimationReset(slide01_1);
                $(".fixed_box").hide();
        
            } else if ( idx === 2){
                // 2번
                slideAnimationReset(slide02);
                $(".fixed_box").fadeIn(500);
                slideCommonAnimation();
        
            } else if ( idx === 3){
                // 3번
                slideAnimationReset(slide03);
                $(".fixed_box").fadeIn(500);
                slideCommonAnimation();
        
            } else if ( idx === 4){
                // 4번
                slideAnimationReset(slide04);
                $(".fixed_box").fadeIn(500);
                slideCommonAnimation();
        
            }else if ( idx === 5){
                // 5번
                slideAnimationReset(slide05);
                $(".fixed_box").fadeIn(500);
                slideCommonAnimation();
            }
        },
        slideChangeEnd: function(idx, idxPrev){
            if (idx === 0){
                slideAnimationStart();
            } else if ( idx === 5){
                slideAnimationEnd();

            }
        },
        init: function(idx, idxPrev){
            $(".fixed_box").hide();
        }
    });
},jQuery);
