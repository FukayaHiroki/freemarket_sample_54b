$(document).ready(function(){
  $('.header-bottom__right--todolist').hover(function(){
    $(this).addClass('active');
    var hideItem = $('.active').children('.header-hide-item');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-hide-item').hide();
  });
});