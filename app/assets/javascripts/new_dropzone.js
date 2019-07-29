$(document).on("turbolinks:load", function() {
  function buildImage(loadedImageUri){
    var html = `<li class="sell-upload-items">
                  <figure class="sell-upload-figure">
                    <img class="img1" src=${loadedImageUri}>
                  </figure>
                  <div class="sell-upload-button">
                    <a>削除</a>
                  </div>
                </li>`
                return html
  };

  var files_array = [];
  
  $('#upload-image').on("change", function(e){
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

    if (files_array.length == 5) {
      $('.sell_upload__drop').css({
        display: "none"
      });
      $('.sell_upload__box2').css({
        display: "flex"
      });
    }
  });

  $(".sell_upload__box2").on("change", "#upload-image2", function(e){
    var file = e.target.files[0];
    files_array.push(file)
    var reader = new FileReader();

    reader.onload = (function(file){
      return function(e){
        var loadedImageUri = e.target.result
        $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items2 ul")
      };
    })(file);
    reader.readAsDataURL(file);

    if (files_array.length == 10) {
      $('.sell_upload__drop2').css({
        display: "none"
      });
    }
  });

  $(document).on('click', '.sell-upload-button a', function(){
    var index = $(".sell-upload-button a").index(this);
    files_array.splice(index - 1, 1);
    $(this).parent().parent().remove();
  });

  $('#new_product').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData($(this).get(0));
    files_array.forEach(function(file){
      formData.append("images[url][]", file)
    });
    $("#submit").prop('disabled', false);
    $.ajax({
      url: '/products',
      type: "POST",
      data: formData,
      contentType: false,
      processData: false,
    })
  });

  $('#submit').click(function() {
    $('#submit').removeAttr("data-disable-with");
  })
});
