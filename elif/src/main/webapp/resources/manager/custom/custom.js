
/* Sidebar Menu active class */
$(function () {
  var url = window.location;
  if ($('body>.wrapper').data('menu') != null) {
    url = $('body>.wrapper').data('menu');
  }

  if (String(url).indexOf("#") > -1) {
    url = String(url).substring(0, String(url).indexOf("#"));
  }
  $('.sidebar-wrapper a.nav-link').filter(function () {
    var targeturl = $(this).attr('href');//$(this).data('menu');
    return targeturl == url;
  }).parents('.nav-item').addClass('active').parents('.collapse').addClass('show');
});

if($('.card-header.card-header-icon.card-header-rose').length>0){
  var headerFirst = $('.card-header.card-header-icon.card-header-rose').eq(0);
  $(document).attr("title",headerFirst.find('.card-title').html()+" | "+$(document).attr("title"));
}
$('[type=number][max]').on('keyup',function(){
  var thisNum = parseInt($(this).val());
  var maxNum = parseInt($(this).attr('max'));
  if(thisNum>=maxNum){
    $(this).val(maxNum);
  }
});

$('form#write,form#user_submit').find('[required]:not([disabled]),.required').each(function(){
  $(this).closest('.row').find('label.col-form-label span').addClass('required').html('*')
});
$('.imgpopup').simpleLightbox();
custom = {
  initDateTimePicker: function () {
    $('.datetimepicker').datetimepicker({
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-chevron-up",
        down: "fa fa-chevron-down",
        previous: 'fa fa-chevron-left',
        next: 'fa fa-chevron-right',
        today: 'fa fa-screenshot',
        clear: 'fa fa-trash',
        close: 'fa fa-remove'
      }
    });
  },


  initPickColor: function () {
    $('.pick-class-label').click(function () {
      var new_class = $(this).attr('new-class');
      var old_class = $('#display-buttons').attr('data-class');
      var display_div = $('#display-buttons');
      if (display_div.length) {
        var display_buttons = display_div.find('.btn');
        display_buttons.removeClass(old_class);
        display_buttons.addClass(new_class);
        display_div.attr('data-class', new_class);
      }
    });
  },


  showSwal: function (type, title, text) {
    if (type == 'basic') {
      swal({
        title: title,
        buttonsStyling: false,
        confirmButtonClass: "btn btn-success"
      }).catch(swal.noop)

    } else if (type == 'title-and-text') {
      swal({
        title: title,
        text: text,
        buttonsStyling: false,
        confirmButtonClass: "btn btn-info"
      }).catch(swal.noop)

    } else if (type == 'success-message') {
      swal({
        title: title,
        text: text,
        buttonsStyling: false,
        confirmButtonClass: "btn btn-success",
        type: "success"
      }).catch(swal.noop)

    } else if (type == 'warning-message-and-confirmation') {
      swal({
        title: title,
        text: text,
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        confirmButtonText: '삭제 되었습니다.',
        buttonsStyling: false
      }).then(function () {
        swal({
          title: title,
          text: text,
          type: 'success',
          confirmButtonClass: "btn btn-success",
          buttonsStyling: false
        })
      }).catch(swal.noop)
    } else if (type == 'warning-message-and-cancel') {
      swal({
        title: title,
        text: text,
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: '네!',
        cancelButtonText: '아니오!',
        confirmButtonClass: "btn btn-success",
        cancelButtonClass: "btn btn-danger",
        buttonsStyling: false
      }).then(function () {
        swal({
          title: title,
          text: text,
          type: 'success',
          confirmButtonClass: "btn btn-success",
          buttonsStyling: false
        }).catch(swal.noop)
      }, function (dismiss) {
        // dismiss can be 'overlay', 'cancel', 'close', 'esc', 'timer'
        if (dismiss === 'cancel') {
          swal({
            title: 'Cancelled',
            text: '삭제를 쥐소하셨습니다.',
            type: 'error',
            confirmButtonClass: "btn btn-info",
            buttonsStyling: false
          }).catch(swal.noop)
        }
      })

    } else if (type == 'custom-html') {
      swal({
        title: title,
        buttonsStyling: false,
        confirmButtonClass: "btn btn-success",
        html: text
      }).catch(swal.noop)

    } else if (type == 'auto-close-text') {
      swal({
        title: title,
        html: '<span style="font-size:13px;">이 창은 3초후에 자동으로 닫힙니다.</span>',
        timer: 3000,
        confirmButtonClass: "btn btn-success btn-sm",
        showConfirmButton: true
      }).catch(swal.noop)
    } else if (type == 'auto-close-text-reload') {
      swal({
        title: title,
        html: '<span style="font-size:13px;">이 창은 3초후에 자동으로 닫힙니다.</span>',
        timer: 3000,
        confirmButtonClass: "btn btn-success btn-sm",
        showConfirmButton: true
      }).then(function (result) {
        window.location.reload();
      }).catch(swal.noop)
    } else if (type == 'auto-close') {
      swal({
        title: title,
        timer: 3000,
        confirmButtonClass: "btn btn-success btn-sm",
        showConfirmButton: true
      }).catch(swal.noop)
    } else if (type == 'input-field') {
      swal({
        title: title,
        html: '<div class="form-group">' +
          '<input id="input-field" type="text" class="form-control" />' +
          '</div>',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        buttonsStyling: false
      }).then(function (result) {
        swal({
          type: 'success',
          html: 'You entered: <strong>' +
            $('#input-field').val() +
            '</strong>',
          confirmButtonClass: 'btn btn-success',
          buttonsStyling: false

        })
      }).catch(swal.noop)
    }
  },
}
function gfn_isNull(str) {
  if (str == null) return true;
  if (str == "NaN") return true;
  if (new String(str).valueOf() == "undefined") return true;
  var chkStr = new String(str);
  if (chkStr.valueOf() == "undefined") return true;
  if (chkStr == null) return true;
  if (chkStr.toString().length == 0) return true;
  return false;
}
function ComSubmit(opt_formId) {
  this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
  this.url = "";
  this.method = "get";
  if (this.formId == "commonForm") {
    $("#commonForm")[0].reset();
  }

  this.setUrl = function setUrl(url) {
    this.url = url;
  };

  this.setMethod = function setMethod(method) {
    this.method = method;
  };

  this.addParam = function addParam(key, value) {
    if ($("#" + this.formId).find('[name="' + key + '"]').val()) {
      $("#" + this.formId).find('[name="' + key + '"]').val(value).attr('id', key);
    } else {
      $("#" + this.formId).append($("<input type='hidden' name='" + key + "' id='" + key + "' value='" + value + "' >"));
    }

  };
  this.removeParam = function removeParam(key) {
    if ($("#" + this.formId).find('[name="' + key + '"]').val()) {
      $("#" + this.formId).find('[name="' + key + '"]').remove();
    }
  };


  this.submit = function submit() {
    var frm = $("#" + this.formId)[0];
    frm.action = this.url;
    frm.method = this.method;
    frm.submit();
  };
}
function validateEmail(email) {
  if (email.length < 4) {
    return false;
  }
  var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
  return re.test(email);
}
function checkValidation(frm) {
  var result = false;
  if ($('form#' + frm).find('[required]').length > 0) {
    $('form#' + frm).find('[required]').each(function () {
      if ($(this).val() === '') {
        alert($(this).data('title') + ' 입력해주세요.');
        result = false;
        $(this).focus();
        return false;
      }
      if ($(this).attr('type') === 'email') {
        if(!validateEmail($(this).val())){
          alert('정확한 이메일 주소를 입력해주세요.');
          result = false;
          $(this).focus();
          return false;
        }
      }
      if ($(this).val().length < $(this).attr('minlength')) {
        alert($(this).data('title') + ' ' + $(this).attr('minlength') + '자 이상 입력해주세요.');
        result = false;
        return false;
      }
      if ($(this).val().length > $(this).attr('maxlength')) {
        alert($(this).data('title') + ' ' + $(this).attr('maxlength') + '자 이하로 입력해주세요.');
        result = false;
        return false;
      }
      if ($(this).is('[equalTo]')) {
        if ($(this).val() !== $('#' + $(this).attr('equalTo')).val()) {
          alert('입력하신 ' + $(this).attr('title') + '가(이) 일치하지 않습니다.');
          result = false;
          return false;
        }
      }
      result = true;
    });

  } else {
    result = true;
  }
  return result;
}
var snOptions = {
  toolbar: [
    // [groupName, [list of button]]
    ['style', ['style']],
    ['fontname', ['fontname']],
    ['fontsize', ['fontsize']],
    ['color', ['color']],
    ['font', ['bold', 'underline', 'clear']],
    ['para', ['ul', 'ol', 'paragraph']],
    ['table', ['table']],
    ['insert', ['link', 'picture', 'video']],
    ['view', ['fullscreen', 'codeview', 'help']],
    ['height', ['height']]
  ],
  popover: {
    image: [
      ['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
      ['float', ['floatLeft', 'floatRight', 'floatNone']],
      ['remove', ['removeMedia']]
    ],
    link: [
      ['link', ['linkDialogShow', 'unlink']]
    ],
    table: [
      ['add', ['addRowDown', 'addRowUp', 'addColLeft', 'addColRight']],
      ['delete', ['deleteRow', 'deleteCol', 'deleteTable']],
    ],
    air: [
      ['color', ['color']],
      ['font', ['bold', 'underline', 'clear']],
      ['para', ['ul', 'paragraph']],
      ['table', ['table']],
      ['insert', ['link', 'picture']]
    ]
  },
  fontSizes: ['8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '50', '60'],
  fontNames: ['돋움', '돋움체', '굴림', '굴림체', '바탕', '바탕체', 'Noto Sans KR', 'Nanum Gothic', 'NanumSquare', 'NanumBarunGothic', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],
  fontNamesIgnoreCheck: ['돋움', '돋움체', 'Noto Sans KR', 'Nanum Gothic', 'NanumSquare', 'NanumBarunGothic'],
  height: 250,
  lang: 'ko-KR',
  callbacks: {
    onImageUpload: function (files) {
      uploadSummernoteImageFile(files[0], this);
    }
  }
}
function uploadSummernoteImageFile(file, editor) {
  data = new FormData();
  data.append("file", file);
  $.ajax({
    data: data,
    type: "POST",
    url: "/uploadSummernoteImageFile",
    contentType: false,
    processData: false,
    success: function (data) {
      //항상 업로드된 파일의 url이 있어야 한다.
      $(editor).summernote('insertImage', data.url);
    }
  });
}

$('.datepicker').datetimepicker({
  format: 'YYYY-MM-DD',
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});
$('.datefulltimepicker').datetimepicker({
  format: 'YYYY-MM-DD HH:mm:ss',
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});
$('.datetimepicker').datetimepicker({
  format: 'YYYY-MM-DD HH:mm:00',
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});

$('.sdate').datetimepicker({
  format: 'YYYY-MM-DD HH:mm:ss',
  maxDate: $('.edate').val(),
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});

$('.edate').datetimepicker({
  useCurrent: false,
  format: 'YYYY-MM-DD HH:mm:ss',
  minDate: $('.sdate').val(),
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});

$('.sdatepicker').datetimepicker({
  format: 'YYYY-MM-DD',
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});

$('.edatepicker').datetimepicker({
  useCurrent: false,
  format: 'YYYY-MM-DD',
  icons: {
    time: "fa fa-clock-o",
    date: "fa fa-calendar",
    up: "fa fa-chevron-up",
    down: "fa fa-chevron-down",
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-screenshot',
    clear: 'fa fa-trash',
    close: 'fa fa-remove'
  }
});

$(".sdatepicker").on("dp.change", function (e) {
  $('.edatepicker').data("DateTimePicker").minDate(e.date);
});
$(".edatepicker").on("dp.change", function (e) {
  $('.sdatepicker').data("DateTimePicker").maxDate(e.date);
});

$('.selectpicker.multiple').change(function(){
  var selMulti = $.map($(this), function (el, i) {
      return $(el).val();
  });
  $("[name="+$(this).data('formname')+"] [name="+$(this).data('inputname')+"]").val(selMulti.join(","));
});
$(".sdate").on("dp.change", function (e) {
  $('.edate').data("DateTimePicker").minDate(e.date);
});
$(".edate").on("dp.change", function (e) {
  $('.sdate').data("DateTimePicker").maxDate(e.date);
});

$(".username").alphanum({
  allow: '',
  allowNumeric: true,
  allowUpper: true,
  allowLower: true,
  allowCaseless: true,
  allowSpace: false
}).on("blur keyup", function () {
  $(this).val($(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, ''));
});
$(".numberonly").numeric({maxDecimalPlaces: 0});
$(".nameonly").on("blur keyup", function () {
  $(this).val( $(this).val().replace(/[^ㄱ-힣a-zA-Z]/gi,"") );
});

/**
 * 비밀번호 사용규칙
 */

function checkPwd(pwd,pwdcon,pwdnow, userid) {
  var srt = pwInputValueCheck(pwd);
  var pattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
  if (pwd != pwdcon) {
    alert('비밀번호와 비밀번호 확인이 맞지 않습니다.')
    return false;
  } else if (pwd.length < 8 || pwd.length > 20) {
    alert('비밀번호는 8자 이상 20자 이내로 입력하여 주십시오')
    return false;
  } else if (pwcheck(pwd)) {
    alert("비밀번호에 허용되지 않는 특수문자(<, >, ', /, |)가 있습니다.");
    return false;
  } else if (checkPwdEnd(pwd)) {
    alert('비밀번호는 영문, 숫자, 특수문자의 조합으로 구성되어야 하며\n최소 1자리 이상의 특수문자가 포함되어야 합니다')
    return false;
  } else if (pwContinue(pwd)) {
    alert("비밀번호에 3자리 이상 연속된 문자(예:abc)는 사용할 수 없습니다.");
    return false;
  } else if (pwSame(pwd)) {
    alert("비밀번호에 3자리 이상 연속된 동일한 문자(예:aaa)는 사용할 수 없습니다.");
    return false;
  } else if (idValuePw(userid, pwd)) {
    alert("비밀번호가 아이디와 동일하거나 3자리 이상 일치할 경우 사용할 수 없습니다.");
    return false;
  } else if (srt != null) {
    alert("비밀번호에 \"" + srt + "\" 라는 문자는 사용할 수 없습니다.");
    return false;
  } else if (pwd == userid) {
    alert('비밀번호는 아이디와 동일할 수 없습니다');
    return false;
  } else if (pwd == pwdnow) {
    alert('현재 비밀번호와 변경 비밀번호가 동일합니다.');
    return false;
  }
  return true;
}
// 비밀번호에 허용되지 않는 특수문자(<, >, ', /, |)가 있습니다.
function pwcheck(valpw) {
  digits = "\`~!@#$%^&*()-=\\_+,.?;:\"[]{}0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  j = 0;
  for (i = 0; i < valpw.length; i++) {
    if (digits.indexOf(valpw.charAt(i)) < 0) {
      j = j + 1;
    }
  }
  if (j > 0) {
    return true;
  }
  return false;
}
// 비밀번호는 영문, 숫자, 특수문자의 조합으로 구성되어야 하며\n최소 1자리 이상의 특수문자가 포함되어야 합니다
function checkPwdEnd(valpwd) {
  var flag = false;
  var intCount = 0;
  var charCount = 0;
  var varcharCount = 0;
  intCount = IntCount(valpwd);
  charCount = CharCount(valpwd);
  varcharCount = VarCharCount(valpwd);
  if ((intCount == 0 || charCount == 0 || varcharCount == 0)) {
    flag = true;
  }
  return flag;
}
function IntCount(aInputBox) {  // aInputBox에 있는 숫자의 갯수 return
  var comp = "1234567890";
  var aInputBoxValue = aInputBox;
  var len = aInputBoxValue.length;
  var count = 0;
  if (len > 0) {
    for (var i = 0; i < len; i++) {
      if (comp.indexOf(aInputBoxValue.substring(i, i + 1)) != -1) {
        count++;
      }
    }
  }
  return count;
}
function CharCount(aInputBox) {  // aInputBox에 있는 문자의 갯수 return
  var comp = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  var aInputBoxValue = aInputBox;
  var len = aInputBoxValue.length;
  var count = 0;
  if (len > 0) {
    for (var i = 0; i < len; i++) {
      if (comp.indexOf(aInputBoxValue.substring(i, i + 1)) != -1) {
        count++;
      }
    }
  }
  return count;
}
function VarCharCount(aInputBox) {  // aInputBox에 있는 특수문자의 갯수 return
  var comp = "\`~!@#$%^&*-_+=\\,./?:;\"{[}]";
  var aInputBoxValue = aInputBox;
  var len = aInputBoxValue.length;
  var count = 0;
  if (len > 0) {
    for (var i = 0; i < len; i++) {
      if (comp.indexOf(aInputBoxValue.substring(i, i + 1)) != -1) {
        count++;
      }
    }
  }
  return count;
}
// 비밀번호에 3자리 이상 연속된 문자(예:abc)는 사용할 수 없습니다.
function pwContinue(validpw) {   //연속된 문자, 숫자 체크(3자리)
  var cnt = 0;
  var cnt2 = 0;
  var tmp = "";
  var tmp2 = "";
  var tmp3 = "";
  for (i = 0; i < validpw.length; i++) {
    tmp = validpw.charAt(i);
    tmp2 = validpw.charAt(i + 1);
    tmp3 = validpw.charAt(i + 2);

    if (tmp.charCodeAt(0) - tmp2.charCodeAt(0) == 1 && tmp2.charCodeAt(0) - tmp3.charCodeAt(0) == 1) {
      cnt = cnt + 1;
    }
    if (tmp.charCodeAt(0) - tmp2.charCodeAt(0) == -1 && tmp2.charCodeAt(0) - tmp3.charCodeAt(0) == -1) {
      cnt2 = cnt2 + 1;
    }
  }
  if (cnt > 0 || cnt2 > 0) {
    return true;
  } else {
    return false;
  }
}
// 비밀번호에 3자리 이상 연속된 동일한 문자(예:aaa)는 사용할 수 없습니다.
function pwSame(validpw) {   //동일 문자, 숫자 체크(3자리)
  var tmp = "";
  var cnt = 0;
  for (i = 0; i < validpw.length; i++) {
    tmp = validpw.charAt(i);
    if (tmp == validpw.charAt(i + 1) && tmp == validpw.charAt(i + 2)) {
      cnt = cnt + 1;
    }
  }
  if (cnt > 0) {
    return true;
  } else {
    return false;
  }
}
// 비밀번호가 아이디와 동일하거나 3자리 이상 일치할 경우 사용할 수 없습니다.
function idValuePw(validid, validpw) {
  var tmp = "";
  var cnt = 0;
  for (i = 0; i < validid.length - 2; i++) {
    tmp = validid.charAt(i) + validid.charAt(i + 1) + validid.charAt(i + 2);
    if (validpw.indexOf(tmp) > -1) {
      cnt = cnt + 1;
    }
  }
  if (cnt > 0) {
    return true;
  } else {
    return false;
  }
}
// "비밀번호에 \"" + srt + "\" 라는 문자는 사용할 수 없습니다."
function pwInputValueCheck(validpw) {  //특정문자 체크
  var InputValue = ["love", "happy", "qwer", "asdf", "zxcv", "test", "gpin", "ipin"];
  for (i = 0; i < InputValue.length; i++) {
    if (validpw.indexOf(InputValue[i]) >= 0) {
      return InputValue[i];
    }
  }
  return null;
}
function IsJsonString(str) {
  try {
    var json = JSON.parse(str);
    return (typeof json === 'object');
  } catch (e) {
    return false;
  }
}
$('[data-toggle=tooltip]').tooltip();
function numberWithCommas(thisinp) {
  x = $(thisinp).val();
  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
  x = x.replace(/,/g,'');          // ,값 공백처리
  $(thisinp).val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
}
function formatBytes(bytes, decimals) {
  if(!decimals){
    decimals = 2;
  }
  if (bytes === 0) return '0 Bytes';

  const k = 1024;
  const dm = decimals < 0 ? 0 : decimals;
  const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

  const i = Math.floor(Math.log(bytes) / Math.log(k));

  return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}
/*
$(document).ready(function() {
  $(window.document).on("contextmenu", function(event){return false;});	//우클릭방지
  $(window.document).on("selectstart", function(event){
    if (!$(event.target).is("textarea,.note-editor,.note-editable")) {
    return false;
    }
  });	//더블클릭을 통한 선택방지
  $(window.document).on("dragstart"	, function(event){return false;});	//드래그
}); 
*/

$(document).on('click','[type=checkbox].readonly,[type=radio].readonly',function(){
  return false;
});

$(document).on('click','.app-file-remove',function(){
  $(this).closest('.item-file').find('.upload-name').val('');
  $(this).closest('.item-file').find('.upload-display').remove();
});