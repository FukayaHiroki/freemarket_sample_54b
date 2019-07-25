$(document).on('turbolinks:load', function(){
  $(function() {
    $(".photo__block--image").hover(function() {
      var subImage = ($(this).attr("src"));
      $(".item__body__photo--image").attr("src", subImage);
    });
  });
});