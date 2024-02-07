var elif = elif || {};

elif = {
    common: function () {
        var $window = $(window);
        var pageTitle = $("title").text();

        //title
        $window.focus(function () {
            document.title = pageTitle;
        });
        $window.blur(function () {
            document.title = 'ELIF';
        });

        var $body = $("body"),
            $header = $("#header"); 
        var menuToggle = true;
        var currentScrollTop = 0;

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

        // topState
        function topState() {
            var upLimit = $('.header').height();
            var scrollTop = 0;
            var goTop = $('.btn_top');
            $(window).on('scroll', function (e) {
                scrollTop = $(window).scrollTop();
                innerHeight = $('.inner').height();
                innerScroll = innerHeight / 1.49;
                if (scrollTop > upLimit) {
                    goTop
                        .css('display', 'block')
                        .removeClass('scroll-end');
                    if (innerScroll < scrollTop) {
                        goTop.addClass('scroll-end');
                    } else {
                        goTop
                            .css('display', 'block')
                            .removeClass('scroll-end');
                    }
                } else {
                    goTop.css('display', 'none');
                }
            })
        }
        topState();

        //  topState - btn
        $(".btn_top").click(function () {
            $("html, body").animate({
                "scrollTop": 0
            }, 300);
        });

        var accItem = $('.acc_list > .acc_item');
        accItem.on('click', function (e) {
            $(this).toggleClass('on');
        });

        function lnbMotion() {
            var lnb = $('.lnb');
            if ($("body").find(lnb)) {
                var totalW = Array
                    .prototype
                    .reduce
                    .call(lnb.find('li'), function (total, item) {
                        return total + $(item).width();
                    }, 0)
                var maxX = totalW - lnb.outerWidth();
                var onItem = lnb
                    .find('li > a')
                    .filter('.on')
                    .closest('li');
                var checkPosX = onItem
                    .position()
                    .left;
                var goX = 0;
                if (lnb.outerWidth() <= checkPosX + onItem.width()) {
                    goX = Math.ceil(
                        (maxX < checkPosX)
                            ? maxX
                            : checkPosX
                    );
                };
                lnb
                    .find('ul')
                    .scrollLeft(goX);
            } //if

        }
        lnbMotion();

        // footer_link site select 추가
        $('.footer_link select').each(function () {
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

        /* 마이페이지 메인 팝업 */
        $('.btn_add .btn_pop').click(function (e) {
            e.preventDefault();
            $('.popupAdd').show();
            $('body').append("<div class='dim'></div>");
            $('body').addClass('lock');
            $('.dim').on("click", function () {
                $('.popup').hide();
                $('.dim').remove();
                $('body').removeClass('lock');
            });
        });
        $('.popupAdd .popCls').on("click", function () {
            $('.popupAdd').hide();
            $('.dim').remove();
            $('body').removeClass('lock');
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
                    .animate({"height": 0});
                setTimeout(function () {
                    $(this).focus();
                }, 300);
            } else {
                $(this).addClass("on");
                $filterBox
                    .stop()
                    .animate({"height": 550});
                setTimeout(function () {
                    $filterBox
                        .find("input")
                        .eq(0)
                        .focus();
                }, 300);
            }
        });

        // enter로 바로 검색 가능
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

    storyAll: function () {
        /* 브랜드 슬라이드. */
        $('.brand-slide').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: false,
            nextArrow: false,
            dots: true,
            vertical: false,
            infinite: false,
            touchMove: false
        });

        /* 모션 스크립트. */
        $(window).scroll(function () {
            $('.cont_section').each(function (i) {
                var bottom_of_object = $(this)
                    .offset()
                    .top + $(this).outerHeight();
                var bottom_of_window = $(window).scrollTop() + $(window).height();
                if (bottom_of_window > bottom_of_object - 150) {
                    $(this).addClass('active');
                } else {
                    $(this).removeClass('active');
                }
            });

            $('.cont_section.brand_mission .mivi').each(function (i) {
                var bottom_of_object = $(this)
                    .offset()
                    .top + $(this).outerHeight();
                var bottom_of_window = $(window).scrollTop() + $(window).height();
                if (bottom_of_window > bottom_of_object - 150) {
                    $(this).addClass('active');
                } else {
                    $(this).removeClass('active');
                }
            });
        })
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
    brandSubTextFunc: function (thisEle) {
        var checkLenght = $("input[data-tit=sub]:checked").length;
        var txt = thisEle.val();
        var txt2 = $("input[data-tit=sub]:checked").val();
        var txtLenght = $('.tab_txt').length;
        if (thisEle.is(":checked") == true) {
            $('.tab_txt:last-child').remove();
            if (txt == 'news') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">엘리프의 소식과 계룡건설의 <span>새로운 내용의 뉴스를 확인하세요</span></p>')
                );
            } else if (txt == 'youtube') {
                $('.tab_linker').after(
                    $('<p class="tab_txt">엘리프의 소식과 계룡건설의 <span>이야기를 담은 영상 매거진</span> </p>')
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
        } else if (txt == 4) {}
    },

    /* 공사/입주정보 > 공사단지 slide */
    slide: function () {
        $('.slider-for').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            draggable: true,
            arrows: true,
            fade: false,
            dots: true,
            customPaging: function (slider, i) {
                return (i + 1) + '/' + slider.slideCount;
            }
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
        
        var $panel = $(".sns_panel");
        $(".sns_btn").on("click", function (e) {
            $('body').addClass('no_scroll');
            $panel.fadeIn();
        });
        // 팝업 닫기 이벤트 정의
        $("#sns_close").on("click", popupClose);
        $panel
            .find(".sns_panel_dim")
            .on("click", popupClose);
        function popupClose(e) {
            $panel.fadeOut();
            $('body').removeClass('no_scroll');
            e.preventDefault();
        }
    },

    /* 공사단지 공사예정일 경우 no-data */
    saleNoData: function () {
        $('.sale_list li')
            .find('.no-data')
            .parents('dt')
            .next('dd')
            .find('.btn_detail')
            .css('display', 'none');
    },

    /* 마이페이지 main LNB dropdown */
    lnbDrop: function () {
        $('.myBtn').on('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            $(this)
                .parents('.myLnb')
                .find('.myDrop')
                .slideToggle(100);
            $(this)
                .children('.ico.ico_t')
                .toggleClass('ico_b');
        });
        $(document).click(function () {
            $('.myDrop').hide();
            $(this)
                .children('.ico.ico_b')
                .toggleClass('ico_t');
        });
    },

    myPopup: function () {
        $(".btn_add .btn_pop").on("click", function (e) {
            e.preventDefault();
            $('.popupAdd').show();
            $('.progress').show();
            $('.Finished').hide();
            $('body').addClass('no_scroll');
        });
        $('.popupAdd .popCls').on("click", function () {
            $('.popupAdd').hide();
            $('body').removeClass('no_scroll');
        });
        // $(".progress .btn_area a").on("click", function (e) {
        //     e.preventDefault();
        //     $('.progress').hide();
        //     $('.Finished').show();
        // });
    }
}
elif.common();