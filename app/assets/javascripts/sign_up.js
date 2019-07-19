$(function(){
  $("#register-btn").on('click', function(e){
    e.preventDefault();
    var id = 'nickname'
    signValidate(id);
  });

  function signValidate(id){
    var element = document.getElementById(id);
    var value = $(element).val();
    console.log('からだよ！');
    $(element).css("background", "red");
  };

});