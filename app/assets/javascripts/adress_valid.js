$(document).on('turbolinks:load', function(){
  $(function(){
    var $form = $('#new_adress')
    $form.on('submit', function(e){
      e.preventDefault();
      reset();
      AdressNameValid();
      AdressKanaValid();
      PostalCordValid();
      PrefectureValid();
      CityValid();
      BlockValid();
      if($form.find('p').hasClass('sign-error')){
        $('#adress_submit_btn').removeAttr("data-disable-with");
      }else{
        $form.unbind('submit').submit();
      }
    });
  });
});

function reset(){
  $('.sign-error').remove();
  $('.error-box').removeClass('error-box');
};


function Empty($element){
  $element.addClass('error-box');
  $element.parent().append('<p class="sign-error">入力してください</p>');
};

function AdressNameValid(){
  var $family = $('#adress_family_name');
  var $first = $('#adress_first_name');
  var familyVal = $family.val();
  var firstVal = $first.val();
  if(familyVal == '' || firstVal == ''){
    $family.addClass('error-box');
    $first.addClass('error-box');
    $family.parent().append('<p class="sign-error">入力してください</p>');
  }
};

function AdressKanaValid(){
  var $family = $('#adress_family_name_kana');
  var $first = $('#adress_first_name_kana');
  var familyVal = $family.val();
  var firstVal = $first.val();
  if(familyVal == '' || firstVal == ''){
    $family.addClass('error-box');
    $first.addClass('error-box');
    $family.parent().append('<p class="sign-error">入力してください</p>');
  }else if(familyVal.match(/^[ァ-ヶー　]*$/) && firstVal.match(/^[ァ-ヶー　]*$/)){
    console.log("カナOK")
  }else{
    $family.addClass('error-box');
    $first.addClass('error-box');
    $family.parent().append('<p class="sign-error">カタカナで入力してください</p>');
  }
}

function PostalCordValid(){
  var $element = $('#adress_postal_code');
  var value = $element.val();
  if(value == ''){
    Empty($element);
  }else if(!value.match(/\d{3}-?\d{4}/)){
    $element.addClass('error-box');
    $element.parent().append('<p class="sign-error">正しい番号を入力してください</p>');
  }
};

function PrefectureValid(){
  var $element = $('#adress_prefecture_id');
  var value = $element.val();
  if(value == ''){
    Empty($element);
  }
};

function CityValid(){
  var $element = $('#adress_city');
  var value = $element.val();
  if(value == ''){
    Empty($element);
  }
};

function BlockValid(){
  var $element = $('#adress_block');
  var value = $element.val();
  if(value == ''){
    Empty($element);
  }
};