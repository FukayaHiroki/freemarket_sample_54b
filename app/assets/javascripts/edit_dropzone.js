$(window).on("turbolinks:load", function() {
  function buildImage(loadedImageUri){
    var html = `<li class="sell-upload-item">
                  <figure class="sell-upload-figure">
                    <img class="img1" src=${loadedImageUri}>
                  </figure>
                  <div class="sell-upload-button2">
                    <a>削除</a>
                  </div>
                </li>`
                return html
  };

  var files_array = [];
  var new_image_files = [];
  var good_image = gon.images_binary_datas.slice(0, 5);
  $.each(good_image, function(index, image) {
    binary_data = good_image[index]
    var loadedImageUri =  "data:image/jpeg;base64," + binary_data
    $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
    $('a').addClass('delete_btn');
    files_array.push(loadedImageUri)
    if (files_array.length == 5) {
      $('.sell_upload__box').css({
        "flex-wrap": "wrap"
      });
    }
  })
  
  var good_image2 = gon.images_binary_datas.slice(5);
  $.each(good_image2, function(index, image) {
    binary_data = good_image2[index]
    var loadedImageUri =  "data:image/jpeg;base64," + binary_data
    $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items2 ul")
    files_array.push(loadedImageUri)
    $('.sell_upload__box').css({
      "flex-wrap": "wrap"
    });
    $('.sell_upload__drop').css({
      width: `calc(100% - (24% * ${files_array.length - 5}))`
    });
    
    

    
    $('a').addClass('delete_btn');
  })

  $('#add-image').on("change", function(e){
    var file = e.target.files[0];
    new_image_files.push(file)
    var reader = new FileReader();
    
    reader.onload = (function(file){
      return function(e){
        var loadedImageUri = e.target.result
        files_array.push(loadedImageUri)
        if (files_array.length < 5) {
          $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
        }else {
          $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items2 ul")
          $('.sell_upload__drop').css({
            width: `calc(100% - (24% * ${files_array.length - 5}))`
          });
        }
        $('a').addClass('delete_btn');
      };
    })(file);
    reader.readAsDataURL(file);

    if (files_array.length == 5) {
      $('.sell_upload__box').css({
        "flex-wrap": "wrap"
      });
    }
    if(files_array.length == 9){
      $('.sell_upload__drop').css({
        "display": "none"
      });
    }
  });

  // $(document).on('click', 'delete_btn', function(){
  //   var imageId = 
  //   $.ajax({
  //     url: '',
  //     type: "POST",
  //     data: {},
  //     dataType: 'json'
  //   })
  // })

  $(document).on('click', '.sell-upload-button2 a', function(){
    var index = $(".sell-upload-button2 a").index(this)
    files_array.splice(index -1, 1);
    $(this).parent().parent().remove();

    if(files_array.length < 5) {
      $('.sell-upload-items ul').empty();
      $('.sell-upload-items2 ul').empty();
      files_array.forEach(function(image, index){
        var loadedImageUri =  files_array[index]
        $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
      })
      $('.sell_upload__drop').css({
        "display": "block"
      });
    }else {
      var pickup_image = files_array.slice(0, 5);
      $('.sell-upload-items ul').empty();
      $('.sell-upload-items2 ul').empty();
      pickup_image.forEach(function(image, index){
        var loadedImageUri =  pickup_image[index]
        $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items ul")
      })
      var pickup_image2 = files_array.slice(5);
      pickup_image2.forEach(function(image, index){
        var loadedImageUri =  pickup_image[index]
        $(buildImage(loadedImageUri,)).appendTo(".sell-upload-items2 ul")
      })
      $('.sell_upload__drop').css({
        "display": "block"
      });
    }
  });

  $('#edit_prodcut').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData($(this).get(0));
    new_image_files.forEach(function(file){
      formData.append("images[url][]", file)
    });
    $.ajax({
      url: '/products/' + gon.product.id,
      type: "PATCH",
      data: formData,
      contentType: false,
      processData: false,
    })
  });
});

