$(document).on("turbolinks:load", function() {
  $('#new_item .sell_upload__box').on("change", 'input[type="file"].upload-image', function(e){
    var file = e.target.files[0];
    console.log(file)
    var reader = new FileReader();

    reader.onload = (function(file){
      return function(e){
        $("#img1").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);
  });
});
