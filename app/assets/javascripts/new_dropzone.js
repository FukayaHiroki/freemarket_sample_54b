$(function() {
  $(document).on("change",'input[type= "file"].upload-image', function(e){
    var file = e.target.files[0];
    var reader = new FileReader();
    

    // if(file.type.index0f("image") < 0){
    //   alert("画像ファイルを指定してください。");
    //   return false;
    // }

    reader.onload = (function(file){
      console.log(this)
      return function(e){
        $("#preview").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);

  });
});
