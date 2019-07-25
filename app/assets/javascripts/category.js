$(document).on('turbolinks:load', function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class= 'sell_form_box__tab' id= 'children_wrapper'>
                        <div class= 'select-wrap'>
                          <select class= 'select-default' id= "child_category" name= "category_id">
                            <option value= "---" data-category= "---">---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.sell_detail').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class= 'sell_form_box__tab' id= 'grandchildren_wrapper'>
                              <div class= 'select-wrap'>
                                <select class= 'select-default' id= "grandchild_category" name= "product[category_id]">
                                  <option value= "---" data-category= "---">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.sell_detail').append(grandchildSelectHtml);
  }

  $("#parent-category").on("change", function() {
    var parentCategory = document.getElementById('parent-category').value;
    if (parentCategory != "---"){
      $.ajax({
        url: 'get_category_children',
        type: "GET",
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption (child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });

  $(".sell_detail").on("change", "#child_category", function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
      $.ajax({
        url: 'get_category_grandchildren',
        type: "GET",
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
    }
  })
});