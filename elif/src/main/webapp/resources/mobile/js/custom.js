

$('[type=number][max]').on('keyup',function(){
  var thisNum = parseInt($(this).val());
  var maxNum = parseInt($(this).attr('max'));
  if(thisNum>=maxNum){
    $(this).val(maxNum);
  }
});
  function logout(){
    if(confirm("로그아웃 하시겠습니까?")){
      window.location.href="/mobile/logout"
    }
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
    alert('비밀번호는 8자 이상 14자 이내로 입력하여 주십시오')
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
  } else if (pwdnow=='Y') {
    return nowPwdCheck(userid,pwd);
  }
  return true;
}

function nowPwdCheck(userid,pwd){
  var search_bool = true;
  $.ajax({
    type : "POST",
    url : "/member/pwdSearch",
    cache : false,
    async: false,
    data : {'user_id':userid,'pwd':pwd},
    success : function(datakey, statuskey){
      if(datakey.result==false){
        alert('현재 비밀번호와 변경 비밀번호가 동일합니다.');
        search_bool = false;
      }
    },
    error : function(data,status){
      // alert( "관리자에게 문의하시기 바랍니다." );
    }
  });
  return search_bool;
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
  $(document).on('click','[type=checkbox].readonly,[type=radio].readonly',function(){
    return false;
  });