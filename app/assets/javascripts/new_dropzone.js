$(function() {
  $('upload-image').on('change', 'input[type="file"]', function(e){
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $("#preview");
        t = this;

    

    if(file.type.index0f("image") < 0){
      alert("画像ファイルを指定してください。");
      return false;
    }

    reader.onload = (function(file){
      console.log(reader)
      return function(e){
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "150px",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
    console.log(reader)

  });
});
