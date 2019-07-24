$(document).on("turbolinks:load", function() {
  function buildImage(loadedImageUri){
    var html = `<li class="sell-upload-items">
                  <figure class="sell-upload-figure">
                    <img class="img1" src=${loadedImageUri}>
                  </figure>
                  <div class="sell-upload-button">
                    <a href="#">編集</a>
                    <a href="#">削除</a>
                  </div>
                </li>`
                return html
  };

  var files_array = [];

  $('#new_item .sell_upload__box').on("change", 'input[type="file"].upload-image', function(e){
    var file = e.target.files[0];
    
    files_array.push(file)
    var reader = new FileReader();

    reader.onload = (function(file){
      return function(e){
        var loadedImageUri = e.target.result
        $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
      };
    })(file);
    reader.readAsDataURL(file);

    
  });
});

