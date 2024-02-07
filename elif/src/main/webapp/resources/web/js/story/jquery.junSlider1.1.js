/*
*   hi.!!
*   junSlider.js
*
*/
var wheelD = true;
(function($){
    /* 기본 옵션 세팅 */
    var defaults = {
        // 기본값
        startSlide: 0,
        slideAutoplaySpeed: 3000,
        slideSpeed: 300,
        autoplay:false,
        slideHoverStop: true,
        slideMouseWheel: true,
        pager:true,
        arrows:true,
        loop:true,
        mode:'slide',
        
        
        // class
        containerClass: '.slide_container',
        itemClass: ".slide_item",
        pagingClass: ".paging",
        prevClass: ".prev",
        nextClass: ".next",

        // 콜백
        slideChange: function(idx, idxPrev){ return true; },
        slideChangeEnd: function(idx, idxPrev){ return true; },
        init: function(idx, idxPrev){ return true; },
    };

    /* 플러그인 시작 */
    $.fn.junSlider = function(options){ 

        /******************
            슬라이드 네임스페이스 생성
        ******************/
        //// 변수
        var _this = this;
        
        var slider = {};
        slider.settings = $.extend({}, defaults, options);
        slider.active = {index:slider.settings.startSlide};

        //// 옵션 변수
        var _startSlide = slider.settings.startSlide;
        var _slideAutoplaySpeed = slider.settings.slideAutoplaySpeed;
        var _slideSpeed = slider.settings.slideSpeed;
        var _autoplay = slider.settings.autoplay;
        var _slideHoverStop = slider.settings.slideHoverStop;
        var _slideMouseWheel = slider.settings.slideMouseWheel;
        var _loop = slider.settings.loop;
        var _pager = slider.settings.pager;
        var _arrows = slider.settings.arrows;
        var _mode = slider.settings.mode;
        
        //// 선택자 변수
        var $slideContainer = _this.find(slider.settings.containerClass);
        var $slideItem = _this.find(slider.settings.itemClass);

        var prependClone = $slideItem.slice(0,1).clone().addClass('clone front');
        var appendClone = $slideItem.slice(-1).clone().addClass('clone front');
        var totalSlide = $slideItem.length;    
        var slideWidth = $slideItem.width();
        var cnt = slider.active.index;
        var cntPrev;
        var moveCheck = false;

        //// 초기화전에 slider 실행 방지
        var init = false; 

        //// 슬라이드가 없을 경우
        if (_this.length === 0){
            return _this;
        };

        //// 다중 슬라이드 처리
        if (_this.length > 1){
            _this.each(function(){
                $(_this).junSlider(options);
            });
            return _this;
        };

        /******************
            생성함수
        ******************/

        //// clone 생성
        var cloneAdd = function(){
            $slideContainer.prepend(appendClone).append(prependClone);
        };

        //// pager 생성
        var pagingAdd = function(){
            var pagingDot = '';
            for (var i = 0; i < totalSlide; i++) {
                pagingDot += "<li class='dot";
                pagingDot += (i == _startSlide) ? " active" : "";
                pagingDot += "'>"+i+"</li>"
            };
            _this.append("<div class="+slider.settings.pagingClass.split('.')[1]+">"+pagingDot+"</div>")
            // _this.find(slider.settings.pagingClass).find('li').click(function(e){
            //     if (moveCheck == false){
            //         moveCheck = true;
            //         cnt = $(e.target).index();

            //         if (_mode == 'slide'){
            //             moveSet(_slideSpeed,-(slideWidth * (cnt+1)));
            //         } else if (_mode == 'fade' || _mode == 'slideUp'){
            //             moveSet(_slideSpeed,cnt)
            //         }
            //         // 이벤트 함수 - slideChange
            //         slider.settings.slideChange(cnt, cntPrev);
                    
            //         // 이벤트 함수 - slideChangeEnd
            //         setTimeout(function(){
            //             moveCheck = false;
            //             slider.settings.slideChangeEnd(cnt, cntPrev);
            //         },_slideSpeed);
                    
            //         activeClass();
            //     }
            // });
        };

        //// arrows 생성
        var arrowsAdd = function(){
            var arrowHtml = '';
            arrowHtml += "<div class='arrows slide0'>";
            arrowHtml += "<div class="+slider.settings.prevClass.split('.')[1]+">prev</div>";
            arrowHtml += "<div class="+slider.settings.nextClass.split('.')[1]+">next</div>";
            arrowHtml += "</div>";
            _this.append(arrowHtml)
            _this.find(slider.settings.prevClass).on('click', function(){
                if (wheelD == false ){
                    wheelD = true;
                    slideMovePrev();
                };
            });
            _this.find(slider.settings.nextClass).on('click', function(){
                if (wheelD == false ){
                    wheelD = true;
                    slideMoveNext();
                };
            });
        };
        
        /******************
            바인딩
        ******************/
        var mouseWheel = function(){
            _this.on('mousewheel', function(e){
                var wheelUpCheck;
                var wheelDownCheck;
                if (wheelD == false ){
                    wheelD = true;
                    if (e.originalEvent.wheelDelta > 0){
                        clearTimeout(wheelUpCheck);
                        wheelUpCheck = setTimeout(function(){
                            slideMovePrev();
                        }, 1);
                    } else{
                        clearTimeout(wheelDownCheck);
                        wheelDownCheck = setTimeout(function(){
                            slideMoveNext();
                        }, 1);
                    }
                }
            });
        };


        /******************
            컨트롤
        ******************/

        //// 컨트롤 함수 - 자동재생
        var autoplay = function(playGet){
            if(playGet == true){
                autoSlider = setInterval(slideMoveNext, _slideAutoplaySpeed);
            } 
            else if(playGet == false){
                if (_autoplay){
                    clearInterval(autoSlider);
                }
            }
        };

        //// 컨트롤 함수 - 슬라이드 이동
        var moveSet = function(timer,animate){
            if (totalSlide > 1){
                if (_mode == 'slide'){
                    $slideContainer.css({"transition":timer+"ms"});
                    $slideContainer.css({"left":animate+"px"});
                } else if (_mode == 'fade'){
                    $slideItem.fadeOut(300);
                    $slideItem.eq(animate).fadeIn(timer);
                } else if (_mode == 'slideUp'){
                    $slideItem.find('.bg_wrap').css({"transition":"0ms"});
                    $slideItem.find('.bg_wrap').eq(animate).css({"transition":timer+"ms"});
                };
            };
        };
        
        //// 컨트롤 함수 - 슬라이드 다음
        var slideMoveNext = function(){
            if (moveCheck == false){
                // loop
                if (_loop == false){
                    if (cnt === totalSlide - 1){
                        return false;
                    } else{
                        moveCheck = true;
                    }
                } else{
                    moveCheck = true;
                }
                
                if (_mode == 'slide'){

                    // 진행중 
                    if (cnt <= totalSlide - 1) {
                        moveSet(_slideSpeed,-(slideWidth * (cnt + 2)))
                    };

                    // 같을때
                    if (cnt === totalSlide - 1) {
                        setTimeout(function(){
                            moveSet(0,-slideWidth);
                        },_slideSpeed);
                        cnt = -1;
                    };

                } else if (_mode == 'fade' || _mode =='slideUp'){

                    // 같을때
                    if (cnt === totalSlide-1) {
                        cnt = -1;
                    };

                    moveSet(_slideSpeed,cnt+1)

                };
                    cnt++;
                activeClass();
                
                // 이벤트 함수 - slideChange
                slider.settings.slideChange(cnt, cntPrev);
                // 이벤트 함수 - slideChangeEnd
                setTimeout(function(){
                    moveCheck = false;
                    slider.settings.slideChangeEnd(cnt, cntPrev);
                },_slideSpeed);
            };
        };

        //// 컨트롤 함수 - 슬라이드 이전
        var slideMovePrev = function(){
            if (moveCheck == false){
                // loop
                if (_loop == false){
                    if (cnt === 0){
                        return false;
                    } else{
                        moveCheck = true;
                    }
                } else{
                    moveCheck = true;
                }

                if (_mode == 'slide'){

                    // 진행중 
                    if (cnt >= 0) {
                        moveSet(_slideSpeed,-(slideWidth * cnt));
                    };

                    // 같을때
                    if (cnt === 0) {
                        setTimeout(function(){
                            moveSet(0,-(slideWidth * totalSlide));
                        },_slideSpeed);
                        cnt = totalSlide;
                    };

                } else if (_mode == 'fade' || _mode == 'slideUp'){

                    // 같을때
                    if (cnt === 0) {
                        cnt = totalSlide;
                    };

                    moveSet(_slideSpeed,cnt-1)

                };;

                cnt--;
                activeClass();

                // 이벤트 함수 - slideChange
                slider.settings.slideChange(cnt, cntPrev);

                // 이벤트 함수 - slideChangeEnd
                setTimeout(function(){
                    moveCheck = false; 
                    slider.settings.slideChangeEnd(cnt, cntPrev);
                },_slideSpeed);
            }
        };

        //// 컨트롤 함수 - 클래스
        var activeClass = function(){
            if (_mode == 'slide'){
                cntPrev = $slideItem.filter(".active").index()-1;
            } else if (_mode == 'fade' || _mode == 'slideUp'){
                cntPrev = $slideItem.filter(".active").index();
            }
            $slideItem.removeClass('active').eq(cnt).addClass('active');
            _this.find(slider.settings.pagingClass).find('li').removeClass('active').eq(cnt).addClass('active');
            $slideItem.eq(cntPrev).addClass('delay-active');
            $(".arrows").removeClass("slide"+cntPrev).addClass("slide"+cnt)

            setTimeout(function(){
                $slideItem.removeClass('delay-active');
            },_slideSpeed);
        };


        /******************
            초기화
        ******************/
        var init = function(){
            /**
            필수 세팅값
            **/
            if (totalSlide > 1){
                if (_mode == 'slide'){
                    $slideContainer.width(slideWidth * (totalSlide+2) + "px");
                    $slideContainer.css({"left":-(slideWidth * (_startSlide + 1))});
                } else if (_mode == 'fade'){
                    $slideItem.hide();
                    $slideItem.eq(_startSlide).show();
                }
            } else{
                $slideContainer.width(slideWidth * totalSlide + "px");
                $slideContainer.css({"left":-(slideWidth * _startSlide)});
            }            

            $slideItem.eq(_startSlide).addClass('active');
            
            /**
            선택 세팅값
            **/
            if (_autoplay == true){
                autoplay(true);
            };
            if (_pager == true){
                pagingAdd();
            };
            if (_arrows == true){
                arrowsAdd();
            }
            if (_slideHoverStop == true){
                _this.hover(function() {
                    autoplay(false);
                }, function() {
                    if (_autoplay){
                        autoplay(true);
                    };
                });
            };
            if (_slideMouseWheel == true){
                mouseWheel();
            }
            if (_mode == 'slide'){
                _this.addClass('slide_mode');
                if (totalSlide > 1){
                    cloneAdd();
                }
            } else if (_mode == 'fade'){
                _this.addClass('fade_mode');
            } else if (_mode == 'slideUp'){
                _this.addClass('slideUp_mode');
            }

            slider.settings.init(cnt);
        }
        init();
    };
})(jQuery);