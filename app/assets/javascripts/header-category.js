$(document).on('turbolinks:load', function(){
  // HACK:同じ様なことをしているので、リファクタリング可能
  $('.w2').hover(function(){
    var hideItem = $(this).children('.header-category-list');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-category-list').hide();
  });
  
  $('.parent-category').hover(function(){
    var hideItem = $(this).children('.header-category-children');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-category-children').hide();
  });

  $('.child-category').hover(function(){
    var hideItem = $(this).children('.header-category-grandchildren');
    hideItem.show();
  },function(){
    $(this).removeClass('active');
    $(this).children('.header-category-grandchildren').hide();
  });
});