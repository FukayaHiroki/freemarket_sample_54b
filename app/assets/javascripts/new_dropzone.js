$(document).on("turbolinks:load", function() {
  function buildImage(loadedImageUri){
    var html = `<li class="sell-upload-item">
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
        if (files_array.length <= 5) {
          $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
        }else {
          $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items2 ul")
        }
      };
    })(file);
    reader.readAsDataURL(file);

    if (files_array.length == 5) {
      $('.sell_upload__box').css({
        "flex-wrap": "wrap"
      });
    } else if (files_array.length >= 6){
      $('.sell_upload__drop').css({
        width: `calc(100% - (24% * ${files_array.length - 5}))`
      });
    } 

    if(files_array.length == 10){
      $('.sell_upload__drop').css({
        "display": "none"
      });
    }
  });


  $(document).on('click', '.sell-upload-button a', function(){
    var index = $(".sell-upload-button a").index(this);
    files_array.splice(index - 1, 1);
    $(this).parent().parent().remove();

    if(files_array.length <= 5) {
      $('.sell-upload-items ul').empty();
      $('.sell-upload-items2 ul').empty();
      files_array.forEach(function(image, index){
        var file = files_array[index]
        var reader = new FileReader();

        reader.onload = (function(file){
          return function(e){
            var loadedImageUri = e.target.result
              $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
         };
        })(file);
      reader.readAsDataURL(file);
      })
      $('.sell_upload__drop').css({
        "display": "block"
      });
    }else {
      var pickup_image = files_array.slice(0, 5);
      $('.sell-upload-items ul').empty();
      $('.sell-upload-items2 ul').empty();
      pickup_image.forEach(function(image, index){
        var file = pickup_image[index]
        var reader = new FileReader();

        reader.onload = (function(file){
          return function(e){
            var loadedImageUri = e.target.result
              $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
          };
        })(file);
      reader.readAsDataURL(file);

      })

      var pickup_image2 = files_array.slice(5);
      pickup_image2.forEach(function(image, index){
        var file = pickup_image2[index]
        var reader = new FileReader();

        reader.onload = (function(file){
          return function(e){
            var loadedImageUri = e.target.result
              $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items2 ul")
          };
        })(file);
      reader.readAsDataURL(file);
      })
      $('.sell_upload__drop').css({
        "display": "block"
      });
    }
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
    .fail(function(){
      alert('未入力の項目があります。');
    })
  });

  $('#submit').click(function() {
    $('#submit').removeAttr("data-disable-with");
  })
});
