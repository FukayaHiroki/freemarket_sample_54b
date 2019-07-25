// // TODO: あとで記述追加します
// $(function(){
//   $('#new_user').on('submit', function(e){
//     e.preventDefault();
//     reset();
//     EmailValid();
//   });


//   function reset(){
//     $('.sign-error').remove();
//     $('.error-box').removeClass('error-box');
//   };

//   function OtherValid(){
//     NameValid();
//     PassValid();
//     PassComfirmValid();
//   }

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

//   function EmailValid(){
//     var $element = $('#email');
//     var value = $element.val();
//     if(value == ''){
//       Empty($element);
//       OtherValid();
//       console.log('からだべ');
//       $('#register-btn').removeAttr("data-disable-with");
//     }else if (value.match(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/)){
//       $.ajax({
//         type: 'get',
//         url: "/users/email_valid",
//         data: {email: value},
//         dataType: 'json'
//       })
//       .done(function(user){
//         if(user.email != null){
//           $element.addClass('error-box');
//           $element.parent().append('<p class="sign-error">すでに存在しているメールアドレスです</p>');
//         }
//         OtherValid();
//         if($('#new_user').find('input').hasClass('error-box')){
//           console.log("エラーあるで！");
//           $('#register-btn').removeAttr("data-disable-with");
//         }else{
//           console.log("送れるで！")
//           $('#new_user').unbind('submit').submit();
//         }
//       });
//     }else{
//       $element.addClass('error-box');
//       $element.parent().append('<p class="sign-error">正しいメールアドレスを入力してください</p>');
//       OtherValid();
//       console.log("まちがいだゔぇ")
//       $('#register-btn').removeAttr("data-disable-with");
//     }
//   };

  
// });