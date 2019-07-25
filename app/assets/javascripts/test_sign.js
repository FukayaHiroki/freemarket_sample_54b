// $(function(){
//   $('#new_user').on('submit', function(){
    
//     reset();
//     NameValid();
//     EmailValid();
//     PassValid();
//     PassComfirmValid();
//     if($(this).find('input').hasClass('error-box')){
//       console.log("エラーあるで！");
//       return false;
//     }
//   });


//   function reset(){
//     $('.sign-error').remove();
//     $('.error-box').removeClass('error-box');
//   };

//   function Empty($element){
//     $element.addClass('error-box');
//     $element.parent().append('<p class="sign-error">空だよ</p>');
//   };

//   function NameValid(){
//     var $element = $('#nickname');
//     var value = $element.val();
//     if(value == ''){
//       Empty($element);
//     }
//   };

//   function EmailValid(){
//     var $element = $('#email');
//     var value = $element.val();
//     if(value == ''){
//       Empty($element);
//     }else if (value.match(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/)){
//       $.ajax({
//         type: 'get',
//         url: "/users/email_valid",
//         data: {email: value},
//         dataType: 'json',
//       })
//       .done(function(user){
//         console.log("OK!")
//         $element.addClass('error-box');
//         $element.parent().append('<p class="sign-error">すでに存在しているメールアドレスです</p>');
//       });
//     }else{
//       $element.addClass('error-box');
//       $element.parent().append('<p class="sign-error">正しいメールアドレスを入力してください</p>');
//     }
//   };

//   function PassValid(){
//     var $element = $('#password');
//     var value = $element.val();
//     if(value == ''){
//       Empty($element);
//     }else if(value.length < 6 || value.length > 128){
//       $element.addClass('error-box');
//       $element.parent().append('<p class="sign-error">6文字以上にしてください</p>');
//     }
//   };

//   function PassComfirmValid(){
//     var $element = $('#password_confirmation');
//     var value = $element.val();
//     var subValue = $('#password').val();
//     if(value == ''){
//       Empty($element);
//     }else if(value.length < 6 || value.length > 128){
//       $element.addClass('error-box');
//       $element.parent().append('<p class="sign-error">6文字以上にしてください</p>');
//     }else if(value != subValue){
//       $element.addClass('error-box');
//       $element.parent().append('<p class="sign-error">パスワードが一致していません</p>');
//     }
//   };
  
// });