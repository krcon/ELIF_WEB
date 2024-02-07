var elif = elif || {};

elif = {

    common: function () {
        var $window = $(window);

        $(document).ready(function () {
            setTimeout(function () {
                $("#header").fadeIn(1500);
            });
        });

        var $body = $("body"),
            $header = $("#header"),
            $lnb = $(".lnb"); //var $visualArea = $(".visual_area");
        var menuToggle = true;
        var currentScrollTop = 0;

        if ($(".lnb").length > 0) {
            $(document).ready(function () {
                var stickyOffsetTop = $(".lnb")
                    .offset()
                    .top;
                $window.scroll(function () {
                    var scrollTop = $(this).scrollTop();
                    if (scrollTop > currentScrollTop) {
                        // downscroll code
                        $body.removeClass("scrollup");
                        $body.addClass("scrolldown");
                        $header.removeClass("fixed");
                    }
                    if (scrollTop < currentScrollTop) {
                        // upscroll code
                        $body.addClass("scrollup");
                        $body.removeClass("scrolldown");
                        $header.addClass("fixed");
                    }
                    currentScrollTop = scrollTop;
                    if (stickyOffsetTop > scrollTop) {
                        $body.removeClass("scrollup");
                        $body.removeClass("fixed");
                        $body.removeClass("scrolldown");
                        $lnb.removeClass("fixed");
                        if (!$header.is(".on")) {
                            $header.removeClass("on");
                        }
                    } else {
                        $body.addClass("fixed");
                        $lnb.addClass("fixed");
                    };
                    if ($($body).is(".fixed") === false) {
                        $header.removeClass("fixed");
                    };
                });
            });
        } else {
            $header.addClass("sticky_none");
        };

        // 링크 방지 var $mTxt = $('.lnb li a:contains("입주 예약"), .lnb li a:contains("사전점검 방문
        // 예약"), .btn_wrap a:contains("사전점검 방문 예약"), .btn_wrap a:contains("입주 예약 신청"),
        // .sub_menu_list a:contains("사전점검 방문 예약"), .sub_menu_list a:contains("입주
        // 예약")'); $($mTxt).click(function(){ 	alert('현재 해당 서비스는 준비중입니다.');
        // $(this).attr("href", "javascript:void(0);"); });

        function menuOn() {
            $(".gnb_bg")
                .stop()
                .animate({"height": 383});
            $(".gnb_cont")
                .stop()
                .animate({"height": 383});
            menuToggle = false;
        }
        function menuOff() {
            $(".gnb_bg")
                .stop()
                .animate({"height": 0});
            $(".gnb_cont")
                .stop()
                .animate({"height": 0});
            menuToggle = true;
        }
        $("#gnbMenuBtn").on("click", function () {
            $header.toggleClass("on");
            $(this).toggleClass("close");
            if (menuToggle == true) {
                menuOn();
            } else {
                menuOff();
            };
        });

        //ajax focus animation
        $(".btn_more button").on("click", function () {
            $("html, body")
                .stop()
                .animate({
                    scrollTop: $(this)
                        .offset()
                        .top
                }, 700);
        });

        //family site select
        $('.family select').each(function () {
            var $this = $(this),
                numberOfOptions = $(this)
                    .children('option')
                    .length;
            $this.addClass('select-hidden');
            $this.wrap('<div class="select"></div>');
            $this.after('<div class="select-styled"></div>');
            var $styledSelect = $this.next('div.select-styled');
            $styledSelect.text($this.children('option').eq(0).text());

            var $list = $('<ul />', {'class': 'select-options'}).insertAfter($styledSelect);

            for (var i = 0; i < numberOfOptions; i++) {
                var $a = $('<a/>', {
                    href: $this
                        .children('option')
                        .eq(i)
                        .val(),
                    text: $this
                        .children('option')
                        .eq(i)
                        .text()
                });
                var $li = $('<li />');
                $a.appendTo($li);
                $li.appendTo($list);
            }

            $('.select-hidden option').removeAttr('rel');
            $('.select-options li a').attr('target', '_blank');

            var $listItems = $list.find('a');
            $styledSelect.click(function (e) {
                e.stopPropagation();
                $('div.select-styled.active')
                    .not(this)
                    .each(function () {
                        $(this)
                            .removeClass('active')
                            .next('ul.select-options')
                            .hide();
                    });
                $(this)
                    .toggleClass('active')
                    .next('ul.select-options')
                    .toggle();
            });
            $listItems.click(function (e) {
                e.stopPropagation();
                $styledSelect
                    .text($(this).text())
                    .removeClass('active');
                $this.val($(this).attr('rel'));
                $list.hide();
            });
            $(document).click(function () {
                $styledSelect.removeClass('active');
                $list.hide();
            });
        });

        //pnote
        var $noteView = $(".pnote_view");
        var listLength = $noteView
            .find("li")
            .length;

        if ($("body").is(".index_w")) {
            $noteView
                .delay(2000)
                .animate({
                    "opacity": 1
                }, 500, "easeInOutCubic");
            setTimeout(function () {
                $noteView.css({visibility: "visible"})
            }, 1500);
            setTimeout(function () {
                $noteView.addClass("on")
            }, 2500);
        };
        $(".close").on("click", function () {
            setTimeout(function () {
                $noteView.removeClass("on")
            }, 300);
            setTimeout(function () {
                $noteView.removeClass("active")
            });
            $noteView
                .css({visibility: "visible", opacity: 1})
                .delay(600)
                .animate({
                    "opacity": 0,
                    visibility: "hidden"
                }, 300);
        });

        $(".btn_list").on("click", function () {
            $(this).hide();
            $noteView.toggleClass("active");
        });

        //3개까지 노출, 3개이상인 경우는 more버튼 노출
        if (listLength <= 4) {
            $(".more")
                .parent("li")
                .remove();
        } else if (listLength > 4) {
            $noteView
                .find(".hidden")
                .hide();
        };

        $(".more").on("click", function () {
            $noteView
                .find(".hidden")
                .show();
            $(".more")
                .parent("li")
                .remove();
        });

        $(".notification").each(function (index, item) {
            $(item).on("click", function (e) {
                e.preventDefault();
                if (listLength > 1) {
                    $(".btn_list").show();
                };
                $noteView
                    .css({visibility: "visible", opacity: 0})
                    .delay(100)
                    .animate({
                        "opacity": 1
                    }, 300);
                setTimeout(function () {
                    $noteView.addClass("on")
                }, 200);
            });
        });

        /* 팝업창 소스 */
        var $pNote = $(".pnote"),
            $pNoteView = $pNote.find(".pnote_view");

        $pNoteView
            .find('.btn_pop')
            .on("click", function (e) {
                e.preventDefault();
                $('.popup').show();
                $('body').append("<div class='dim'></div>");
                $('body').addClass('on');

                $('.dim').on("click", function () {
                    $('.popup').hide();
                    $('.dim').remove();
                    $('body').removeClass('on');
                });
            });

        $pNoteView
            .find('.btn_pop2')
            .on("click", function (e) {
                e.preventDefault();
                $('.popup2').show();
                $('body').append("<div class='dim'></div>");
                $('body').addClass('on');

                $('.dim').on("click", function () {
                    $('.popup2').hide();
                    $('.dim').remove();
                    $('body').removeClass('on');
                });
            });

        $pNoteView
            .find('.btn_pop3')
            .on("click", function (e) {
                e.preventDefault();
                $('.popup3').show();
                $('body').append("<div class='dim'></div>");
                $('body').addClass('on');

                $('.dim').on("click", function () {
                    $('.popup3').hide();
                    $('.dim').remove();
                    $('body').removeClass('on');
                });
            });

        $('.popup .btn_close').on("click", function () {
            $('.popup').hide();
            $('.dim').remove();
            $('body').removeClass('on');
        });
        $('.popup2 .btn_close').on("click", function () {
            $('.popup2').hide();
            $('.dim').remove();
            $('body').removeClass('on');
        });
        $('.popup3 .btn_close').on("click", function () {
            $('.popup3').hide();
            $('.dim').remove();
            $('body').removeClass('on');
        });

        // myElif 메뉴 클릭시, 로그인 창
        // window.onload = function () { // 서버 반영시 주석처리할 것
            $('.my_gnb .my_link').click(function (e) {
                $('header').removeClass("on");
                $('.dep2', this).hide();
                $('.my_nav_wrap').fadeToggle();
            });
            $('.nav_close_btn').click(function (e) {
                $('.my_nav_wrap').fadeToggle();
            });
        // };
    },

    /* 서브페이지 모션
	* @function elif.해당변수명
	*
	*/
    saleSearch: function () {
        var $filterBox = $(".filter_box");
        $("#btnFilter").click(function (e) {
            e.preventDefault();
            if ($(this).is(".on")) {
                $(this).removeClass("on");
                $filterBox
                    .stop()
                    .animate({"height": 0, "marginTop": 0});
                setTimeout(function () {
                    $(this).focus();
                }, 300);
            } else {
                $(this).addClass("on");
                $filterBox
                    .stop()
                    .animate({"height": 172, "marginTop": 10});
                setTimeout(function () {
                    $filterBox
                        .find("input")
                        .eq(0)
                        .focus();
                }, 300);
            }
        });
        // enter로 바로 검색
        $(".find input").keypress(function (e) {
            if (e.which == 13) {
                search();
                return false;
            }
        });

        // 체크박스 초기화 (지역별, 유형별, 진행상태별)
        $(".btn_reset").click(function () {
            $("input:checkbox[name*='Keyid']").prop("checked", false);
        });

        // 지역별 aKeyid 전체 체크박스
        $("#aKeyidall").click(function () {
            if ($("#aKeyidall").is(":checked")) 
                $("input[name=aKeyid]").prop("checked", true);
            else 
                $("input[name=aKeyid]").prop("checked", false);
            }
        );

        $("input[name=aKeyid]").click(function () {
            var total = $("input[name=aKeyid]").length;
            var checked = $("input[name=aKeyid]:checked").length;

            if (total != checked) 
                $("#aKeyidall").prop("checked", false);
            else 
                $("#aKeyidall").prop("checked", true);
            }
        );

        // 유형별 cKeyid 전체 체크박스
        $("#cKeyidall").click(function () {
            if ($("#cKeyidall").is(":checked")) 
                $("input[name=cKeyid]").prop("checked", true);
            else 
                $("input[name=cKeyid]").prop("checked", false);
            }
        );

        $("input[name=cKeyid]").click(function () {
            var total = $("input[name=cKeyid]").length;
            var checked = $("input[name=cKeyid]:checked").length;

            if (total != checked) 
                $("#cKeyidall").prop("checked", false);
            else 
                $("#cKeyidall").prop("checked", true);
            }
        );

        // 진행상태별 sKeyid 전체 체크박스
        $("#sKeyidall").click(function () {
            if ($("#sKeyidall").is(":checked")) 
                $("input[name=sKeyid]").prop("checked", true);
            else 
                $("input[name=sKeyid]").prop("checked", false);
            }
        );

        $("input[name=sKeyid]").click(function () {
            var total = $("input[name=sKeyid]").length;
            var checked = $("input[name=sKeyid]:checked").length;

            if (total != checked) 
                $("#sKeyidall").prop("checked", false);
            else 
                $("#sKeyidall").prop("checked", true);
            }
        );

    },

    datepicker: function () {
        $("#datepicker").datepicker({
            dateFormat: 'yy.mm.dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: [
                '1월',
                '2월',
                '3월',
                '4월',
                '5월',
                '6월',
                '7월',
                '8월',
                '9월',
                '10월',
                '11월',
                '12월'
            ],
            monthNamesShort: [
                '1월',
                '2월',
                '3월',
                '4월',
                '5월',
                '6월',
                '7월',
                '8월',
                '9월',
                '10월',
                '11월',
                '12월'
            ],
            dayNames: [
                '일',
                '월',
                '화',
                '수',
                '목',
                '금',
                '토'
            ],
            dayNamesShort: [
                '일',
                '월',
                '화',
                '수',
                '목',
                '금',
                '토'
            ],
            dayNamesMin: [
                '일',
                '월',
                '화',
                '수',
                '목',
                '금',
                '토'
            ],
            showMonthAfterYear: true,
            yearSuffix: '년',
            maxDate: 0, //오늘 이후 날짜 선택 불가
            yearRange: "2000:2021" //연도 범위
        });
    },

    // dataEffect
    dataEffect: function () {
        var $noEffBtn = $(".btn_detail");
        $noEffBtn.each(function (i) {
            var $noEffTxt = $('.color1:contains("공사예정"), .no-data');
            var $noEffHref = $(this)
                .attr("href")
                .trim();
            var $noEffHrefs = $noEffHref == "#" || $noEffHref.indexOf('javascript') > -1;
            if ($noEffHrefs) {
                $(this).attr('data-effect', 'none');
            } else if ($noEffTxt) {
                $noEffTxt
                    .closest($noEffBtn)
                    .attr('data-effect', 'none');
            };
        });
    },

    // 브랜드 > 스토리
    storyAll: function () {
        /* story slide */
        $('.brand-slide').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: false,
            nextArrow: false,
            dots: true,
            vertical: true,
            infinite: false,
            touchMove: false
        });

        $('.brand-slide').on('wheel', (function (e) {
            e.preventDefault();

            if (e.originalEvent.deltaY < 0) {
                $(this).slick('slickPrev');
            } else {
                $(this).slick('slickNext');
            }
        }));

        /* story motion */
        var storyArr = [];
        var storyCont = document.querySelectorAll('.cont_section_brand');
        for (var i = 0; i < storyCont.length; i++) {
            var posStr = storyCont[i].offsetTop;
            storyArr.push(posStr)
        }

        $(window).scroll(function () {
            var thispos = $(this).scrollTop();
            var posMid = storyArr[pos];
            for (var pos = 0; pos < storyArr.length; pos++) {

                if (thispos < posMid || thispos > storyArr[pos]) {
                    $('.brand_mivi').removeClass("active");
                    $('.cont_section_brand')
                        .eq(pos)
                        .addClass('on')
                        .siblings()
                        .removeClass('on');

                    if ($('.real_complete').hasClass('bisFixed') && $('.brand_intro_slider').hasClass('on') && !$('.bis_item').siblings().hasClass('bisactive')) {
                        $('.real_complete').addClass("bisactive");
                    }
                    if ($('.feature').hasClass('bisactive') && $('.bis_item').siblings().hasClass('bisactive')) {
                        $('.real_complete').removeClass("bisactive");
                    }
                    if (!$('.feature').hasClass('bottom_pos')) {
                        $('.story_last').removeClass("on");
                    }
                }
                if (thispos > 1300) {
                    $('.brand_mivi').addClass("active");
                }
                if (thispos == 0) {
                    $('.cont_section_brand').removeClass("on");
                }
            }
        });

        function initBrandIntroSlider() {
            var brandIntroSlider = $("section.brand_intro_slider");
            var bisCont = brandIntroSlider.find(".bis_item");
            var biscLen = bisCont.length;
            var biscPos = new Array();
            var biscIs = new Array();
            var bisIndicator = brandIntroSlider.find(".bis_indicator");
            var biBtn = bisIndicator.find("a")

            $(window).on("load resize", function () {
                brandIntroSlider.css({
                    "height": (bisCont.outerHeight() * biscLen) + (
                        window.screen.height * 0.2 * biscLen
                    ) + "px"
                })

                bisCont.each(function (k) {
                    biscPos[k] = brandIntroSlider
                        .offset()
                        .top + (bisCont.outerHeight() * k) + (window.screen.height * 0.1 * biscLen)
                    biscIs[k] = false;
                })

            });

            $(window).on("scroll", function () {
                if ($(window).scrollTop() >= brandIntroSlider.offset().top) {
                    bisCont.addClass("bisFixed");
                    bisIndicator.addClass("bisFixed");
                } else if ($(window).scrollTop() < brandIntroSlider.offset().top) {
                    bisCont.removeClass("bisFixed");
                    bisCont.removeClass("bisactive");
                    bisIndicator.removeClass("bisFixed");
                }

                if ($(window).scrollTop() >= brandIntroSlider.offset().top + brandIntroSlider.outerHeight() - $(window).height()) {
                    bisCont.removeClass("bisFixed");
                    bisCont.addClass("bottom_pos");
                    bisIndicator.removeClass("bisFixed");
                    bisIndicator.addClass("bottom_pos");
                } else if ($(window).scrollTop() < brandIntroSlider.offset().top + brandIntroSlider.outerHeight() - $(window).height()) {
                    bisCont.removeClass("bottom_pos");
                    bisIndicator.removeClass("bottom_pos");
                }

                bisCont.each(function (i) {
                    if ($(window).scrollTop() >= biscPos[i] - (window.screen.height * 0.1) && biscIs[i] == false) {
                        bisCont.removeClass("bisactive");
                        bisCont
                            .eq(i)
                            .addClass("bisactive");
                        biBtn.removeClass("bisactive");
                        biBtn
                            .eq(i)
                            .addClass("bisactive");

                        biscIs[i] = true;
                    } else if ($(window).scrollTop() < biscPos[i] - (window.screen.height * 0.1) && biscIs[i] == true) {
                        bisCont.removeClass("bisactive");
                        bisCont
                            .eq(i)
                            .addClass("bisactive");
                        biBtn.removeClass("bisactive");
                        biBtn
                            .eq(i)
                            .addClass("bisactive");

                        biscIs[i] = false;
                    }
                })
            });

            biBtn.on("click", function () {
                var tIndx = $(this).index();

                biBtn.removeClass("bisactive");
                biBtn
                    .eq(tIndx)
                    .addClass("bisactive");
                bisCont.removeClass("bisactive");
                bisCont
                    .eq(tIndx)
                    .addClass("bisactive");

                for (j in biscIs) {
                    biscIs[j] = false;
                }
                biscIs[tIndx] = true;

                $(window).scrollTop(biscPos[tIndx] - (window.screen.height * 0.1))
            });
        };

        $(document).ready(function () {
            initBrandIntroSlider()
        });

    },

    /* 공사/입주정보 > 공사단지 slide, > 입주단지 slide */
    slide: function (rand, forLength) {
        if (forLength < 5) {
            $('#' + rand + ' .slider-for').slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: false,
                fade: true,
                asNavFor: '.slider-nav',
                infinite: false,
                draggable: false
            });
        } else {
            $('#' + rand + ' .slider-for').slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: false,
                fade: true,
                asNavFor: '.slider-nav',
                infinite: false,
                draggable: false
            });
        };

        var navIndex = $('.slider-nav li');
        var navLength = navIndex.length;
        if (navLength < 5) {
            $('#' + rand + ' .slider-nav').css({margin: "0 -50px"});
            $('#' + rand + ' .slider-nav').slick({
                slidesToShow: 5,
                slidesToScroll: 1,
                asNavFor: '.slider-for',
                dots: false,
                focusOnSelect: true,
                arrows: false,
                centerMode: false,
                infinite: false,
                variableWidth: true,
                draggable: false
            });
        } else {
            $('#' + rand + ' .slider-nav').slick({
                slidesToShow: 5,
                slidesToScroll: 1,
                asNavFor: '.slider-for',
                dots: false,
                focusOnSelect: true,
                arrows: true,
                centerMode: true,
                infinite: true,
                variableWidth: true,
                draggable: false
            });
        }

        $('.image_area').slick({
            slidesToShow: 1, slidesToScroll: 1,
            // initialSlide: 0,
            dots: false,
            arrows: true
        });
    },

    /* 공사/입주정보 > 공사단지 snsShare*/
    snsShare: function () {

        var snsShareUrl = document.getElementById("ShareUrl");
        snsShareUrl.blur();
        snsShareUrl.value = window.document.location.href;
        snsShareUrl.select();
        $('.CopyUrl').click(function(){
            $(snsShareUrl).select();
            document.execCommand('copy');
            snsShareUrl.blur();
            alert("URL이 클립보드에 복사되었습니다"); 
        });

        $('.sns_wrap .sns_btn').click(function () {
            $('.sns_on').removeClass('hide');
        });
        $('.sns_close').click(function () {
            $('.sns_on').addClass('hide');
        });
    },

    /* 마이페이지 홈 popup */
    myAddPop: function () {
        $('.popup_close').click(function () {
            $('.mypage_popup').addClass('hide');
            $('body').removeClass('lock');
        });
        $('.popup_footer .push').click(function () {
            $('.content_box.box1').addClass('hide');
            $('.content_box.box2').removeClass('hide');
        });
        $('.popup_footer .clear').click(function () {
            $('body').removeClass('lock');
            $('.mypage_popup').addClass('hide');
        });
        $('.btn_add button').click(function () {
            $('.mypage_popup').removeClass('hide');
            $('body').addClass('lock');
            if ($('.content_box.box1').hasClass('hide')) {
                $('.content_box.box1').removeClass('hide');
                $('.content_box.box2').addClass('hide');
            }
        });
    },

    /* 브랜드 > 커뮤니티 체크박스*/
    communityCheckbox: function () {
        var commuChk1 = document.querySelector('#news');
        var commuChk2 = document.querySelector('#youtube');
        var commuChk3 = document.querySelector('#sns');

        $(commuChk1).click(function () {
        // if(commuChk1.checked == true) {
            commuChk1.checked = true;
            commuChk2.checked = false;
            commuChk3.checked = false;
            // }
        });
        $(commuChk2).click(function () {
        // if(commuChk2.checked == true) {
            commuChk1.checked = false;
            commuChk2.checked = true;
            commuChk3.checked = false;
            // }
        });
        $(commuChk3).click(function () {
        // if(commuChk3.checked == true) {
            commuChk1.checked = false;
            commuChk2.checked = false;
            commuChk3.checked = true;
            // }
        });
        // brand > community 체크박스 전체선택시,
        $('#all').click(function () {
            if ($('#all').is(":checked")) 
                $('input[data-tit=sub]').prop("checked", true);
            else 
                $('input[data-tit=sub]').prop("checked", false);
            $('.tab_txt').hide();
        });
        //일부키 선택시, 전체 선택 해제
        $("input[data-tit=sub]").click(function () {
            var total = $("input[data-tit=sub]").length;
            var checked = $("input[data-tit=sub]:checked").length;

            if (total != checked) 
                $("#all").prop("checked", false);
            else 
                $("#all").prop("checked", true);
            }
        );
    },

    /* 브랜드 커뮤니티 서브텍스트 추가 */
    brandSubText: function () {
        $("input[data-tit=sub]").click(function () {
            elif.brandSubTextFunc($(this));
        });
    },
    brandSubTextFunc: function(thisEle){

        var checkLenght = $("input[data-tit=sub]:checked").length;
        var txt = thisEle.val();
        var txt2 = $("input[data-tit=sub]:checked").val();
        var txtLenght = $('.tab_txt').length;
        console.log(thisEle.is(":checked"),txt);
        if (thisEle.is(":checked") == true) {
            $('.tab_txt:last-child').remove();
            if (txt == 'news') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">엘리프의 소식과 계룡건설의 <span>새로운 내용의 뉴스를 확인하세요</span></p>')
                );
            } else if (txt == 'youtube') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">엘리프의 소식과 계룡건설의 <span>이야기를 담은 영상 매거진</span></p>')
                );
            } else if (txt == 'sns') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">계룡그룹의 이야기를 <span>담은 소통형 웹진</span></p>')
                );
            }
        } else if (thisEle.is(":checked") == false) {
            if (txt2 == 'news') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">엘리프의 소식과 계룡건설의 <span>새로운 내용의 뉴스를 확인하세요</span></p>')
                );
            } else if (txt2 == 'youtube') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">엘리프의 소식과 계룡건설의 <span>이야기를 담은 영상 매거진</span> </p>')
                );
            } else if (txt2 == 'sns') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">계룡그룹의 이야기를 <span>담은 소통형 웹진</span></p>')
                );
            }
            if (txtLenght > 0) {
                $('.tab_txt:last-child').remove();
            }
        } else if (checkLenght == 0) {
            $('.tab_txt').remove();
        }
    },
    /* 분양정보 > 분양캘린더 : 리스트로보기/캘린더로보기 */
    saleCalendar: function () {
        $(".calendar_header .btn_toggle").on("click", function () {
            if ($(this).hasClass("list")) {
                $(this)
                    .removeClass("list")
                    .addClass("calendar")
                    .html("캘린더로 보기");
                $(".calendar_body .type_calendar").hide();
                $(".calendar_body .type_list").show();
            } else {
                $(this)
                    .removeClass("calendar")
                    .addClass("list")
                    .html("리스트로 보기");
                $(".calendar_body .type_calendar").show();
                $(".calendar_body .type_list").hide();
            }
        });
    },
    /* 마이 엘리프 > 분양 대금 조회 : 예상입금액 */
    paymentLookup: function () {
        $('.payment_lookup_selectbox_01').on('change', function (e) {
            var val = $('.payment_lookup_selectbox_01 option:selected').val();
            switch (val) {
                case '01': //예상 입금 차수 선택
                    $('.payment_lookup_inputbox').removeClass('on');
                    if($('.payment_lookup_selectbox_02 option').length>0){
                        $('.payment_lookup_selectbox_02').addClass('on');
                    }
                    
                    return;
                case '02': // 예상 입금액 선택
                    $('.payment_lookup_inputbox').addClass('on');
                    $('.payment_lookup_selectbox_02').removeClass('on');
                    return;
                default: // 선택값 없을 경우,
                    $('.payment_lookup_selectbox_02').removeClass('on');
                    $('.payment_lookup_inputbox').removeClass('on');
                    return;
            }
        });
    }
}
elif.common();