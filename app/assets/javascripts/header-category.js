$(document).on('turbolinks:load', function(){
  $('.w2').hover(function(){
    $(this).addClass('active');
    var hideItem = $('.active').children('.header-category-list');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-category-list').hide();
  });
  
  $('.parent-category').hover(function(){
    $(this).addClass('active');
    var hideItem = $('.active').children('.header-category-children');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-category-children').hide();
  });

  $('.child-category').hover(function(){
    $(this).addClass('active');
    var hideItem = $('.active').children('.header-category-grandchildren');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-category-grandchildren').hide();
  });
});