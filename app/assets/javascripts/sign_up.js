$(function(){
  $("#register-btn").on('click', function(e){
    e.preventDefault();
    var nickname = $("#nickname").val();
    $("#nickname").css("background", "red");
    console.log(`${nickname}だよ！`);
    // signValidate(nickname);
  });

  // function signValidate(nickname){
  //   var value = $(`#${nickname}`).val();
  //   console.log(value);
  // };

});