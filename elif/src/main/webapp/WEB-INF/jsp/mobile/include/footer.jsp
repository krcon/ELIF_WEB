<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
        <!-- footer -->
        <footer>
            <button type="button" class="btn_top" title="페이지 맨위로 이동">TOP</button> <!-- 어느 정도 아래로 내려오면 scroll-end 추가 -->
            <div class="inner">
                <div class="footer_logo">
                    <a href="/mobile/index"><img src="/resources/mobile/images/logo_footer.svg" alt="ELIF"></a>
                </div>
                <div class="footer_link">
                    <label for="sch_f2"></label>
                    <select id="sch_f2">
                        <option value="hide" hidden>Family Site</option>
                        <option value="https://www.krcon.co.kr/">계룡건설</option>
                        <option value="https://www.krindus.co.kr/">KR산업</option>
                        <option value="http://www.krsanup.co.kr/">계룡산업</option>
                    </select>
                    <!-- <a href="https://www.krcon.co.kr/" target="_blank">계룡건설 바로가기</a> -->
                </div>
                <div class="info">
                    <a href="tel:042-480-7114" target="_blank" class="btn_tel">Tel. 042-480-7114</a>
                    <address>
                        <p>대전광역시 서구 문정로 48번길, 48 계룡건설산업㈜</p>
                        <p>Fax. 042-483-1341</p>
                    </address>
                    <div class="copy">
                        <p>COPYRIGHT ⓒ 2021 BY KYERYONG CONSTRUCTION<br> INDUSTRIAL CO., LTD. ALL RIGHTS RESERVED.
                        </p>
                    </div>
                </div>
            </div>
        </footer>
        <script>
            $('.footer_link select').each(function(){
            var $this = $(this), numberOfOptions = $(this).children('option').length;
            $this.addClass('select-hidden'); 
            $this.wrap('<div class="select"></div>');
            $this.after('<div class="select-styled"></div>');
            var $styledSelect = $this.next('div.select-styled');
            $styledSelect.text($this.children('option').eq(0).text());

			var $list = $('<ul />', {
				'class': 'select-options'
			  }).insertAfter($styledSelect);
			
			  for (var i = 0; i < numberOfOptions; i++) {
					var $a = $('<a/>', {
				  	href: $this.children('option').eq(i).val(),
				 	text: $this.children('option').eq(i).text(),
				});
				var $li = $('<li />');
				$a.appendTo($li);
				$li.appendTo($list);
			}

			$('.select-hidden option').removeAttr('rel');
			$('.select-options li a').attr('target', '_blank');

            var $listItems = $list.find('a');
            $styledSelect.click(function(e) {
                e.stopPropagation();
                $('div.select-styled.active').not(this).each(function(){
                    $(this).removeClass('active').next('ul.select-options').hide();
                });
                $(this).toggleClass('active').next('ul.select-options').toggle();
            });
            $listItems.click(function(e) {
                e.stopPropagation();
                $styledSelect.text($(this).text()).removeClass('active');
                $this.val($(this).attr('rel'));
                $list.hide();
            });
            $(document).click(function() {
                $styledSelect.removeClass('active');
                $list.hide();
            });
        });
        </script>
        <!-- //footer -->

<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-8KHL5B9LYV"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-8KHL5B9LYV');
</script>