$(document).on('turbolinks:load', function(){
  $(function(){
    $('.g-recaptcha').attr("data-callback","onCheck");
    window.onCheck = onCheck;
    var $form = $('#register-container').children('#new_user');
    $form.on('submit', function(e){
      e.preventDefault();
      reset();
      EmailValid();
    });

    var $phoneForm = $('#phone-container').children('#new_user');
    $phoneForm.on('submit', function(e){
      e.preventDefault();
      reset();
      var $element = $('#phone');
      var value = $element.val();
      if(value == ''){
        Empty($element);
        $('#sms_btn').removeAttr("data-disable-with");
      }else if(value.match(/0[89]0-?\d{4}-?\d{4}/)){
        $phoneForm.unbind('submit').submit();
      }else{
        $element.addClass('error-box');
        $element.parent().append('<p class="sign-error">正しい電話番号を入力してください</p>');
        $('#sms_btn').removeAttr("data-disable-with");
      }
    });

    function reset(){
      $('.sign-error').remove();
      $('.error-box').removeClass('error-box');
    };
    

    function Empty($element){
      $element.addClass('error-box');
      $element.parent().append('<p class="sign-error">空だよ</p>');
    };

    function OtherValid(){
      NickNameValid();
      PassValid();
      PassComfirmValid();
      NameValid();
      KanaValid();
      DayValid();
      reCaptchaValid();
    }


    function NickNameValid(){
      var $element = $('#nickname');
      var value = $element.val();
      if(value == ''){
        Empty($element);
      }
    };

    function PassValid(){
      var $element = $('#password');
      var value = $element.val();
      if(value == ''){
        Empty($element);
      }else if(value.length < 6 || value.length > 128){
        $element.addClass('error-box');
        $element.parent().append('<p class="sign-error">6文字以上にしてください</p>');
      }
    };

    function PassComfirmValid(){
      var $element = $('#password_confirmation');
      var value = $element.val();
      var subValue = $('#password').val();
      if(value == ''){
        Empty($element);
      }else if(value.length < 6 || value.length > 128){
        $element.addClass('error-box');
        $element.parent().append('<p class="sign-error">6文字以上にしてください</p>');
      }else if(value != subValue){
        $element.addClass('error-box');
        $element.parent().append('<p class="sign-error">パスワードが一致していません</p>');
      }
    };

    function NameValid(){
      var $family = $('#family_name');
      var $first = $('#first_name');
      var familyVal = $family.val();
      var firstVal = $first.val();
      if(familyVal == '' || firstVal == ''){
        $family.addClass('error-box');
        $first.addClass('error-box');
        $family.parent().append('<p class="sign-error">空だよ</p>');
      }
    }

    function KanaValid(){
      var $family = $('#family_name_kana');
      var $first = $('#first_name_kana');
      var familyVal = $family.val();
      var firstVal = $first.val();
      if(familyVal == '' || firstVal == ''){
        $family.addClass('error-box');
        $first.addClass('error-box');
        $family.parent().append('<p class="sign-error">空だよ</p>');
      }else if(familyVal.match(/^[ァ-ヶー　]*$/) && firstVal.match(/^[ァ-ヶー　]*$/)){
        console.log("カナOK")
      }else{
        $family.addClass('error-box');
        $first.addClass('error-box');
        $family.parent().append('<p class="sign-error">カタカナで入力してください</p>');
      }
    }

    function DayValid(){
      var today = new Date();
      today.setHours(0);
      today.setMinutes(0);
      today.setSeconds(0);
      today.setMilliseconds(0);
      var $element = $('#birthday');
      var value = $element.val();
      var valueArray = value.split("-");
      var birthday = new Date(valueArray[0],(valueArray[1] - 1),valueArray[2]); 
      if(birthday < today){
        console.log("OK!");
      }else if (value == ""){
        Empty($element);
      }else{
        $element.addClass('error-box');
        $element.parent().append('<p class="sign-error">正しい日付を入力してください</p>');
      }
    }

    function onCheck(){
      var $element = $('.g-recaptcha');
      $element.parent().append('<p id="recaptcha-check" style="display: none">OK!</p>');
    };

    function reCaptchaValid(){
      var $element = $('#recaptcha-check');
      if($element.length){
        console.log("OK");
      }else{
        $('.g-recaptcha').find('iframe').addClass('error-box');
        $('.g-recaptcha').parent().append('<p class="sign-error">チェックしてください</p>');
      }
    };

    function EmailValid(){
      var $element = $('#email');
      var value = $element.val();
      if(value == ''){
        Empty($element);
        OtherValid();
        $('#register-btn').removeAttr("data-disable-with");
      }else if (value.match(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/)){
        $('#register-btn').removeAttr("data-disable-with");
        $.ajax({
          type: 'get',
          url: "/users/email_valid",
          data: {email: value},
          dataType: 'json'
        })
        .done(function(user){
          if(user.email != null){
            $element.addClass('error-box');
            $element.parent().append('<p class="sign-error">すでに存在しているメールアドレスです</p>');
          }
          OtherValid();
          if($form.find('p').hasClass('sign-error')){
            $('#register-btn').removeAttr("data-disable-with");
          }else{
            $form.unbind('submit').submit();
          }
        });
      }else{
        $element.addClass('error-box');
        $element.parent().append('<p class="sign-error">正しいメールアドレスを入力してください</p>');
        OtherValid();
        $('#register-btn').removeAttr("data-disable-with");
      }
    };
    
  });
});