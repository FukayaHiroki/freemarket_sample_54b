$(document).on('turbolinks:load', function() {
  var $form = $("#charge-form");
  Payjp.setPublicKey('pk_test_19264dd500666ba93f0a5706');

  $form.on("click", "#token_submit", function(e) {
    e.preventDefault();
    $form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: parseInt($("#card_number").val()),
        cvc: parseInt($("#cvc").val()),
        exp_month: parseInt($("#exp_month").val()),
        exp_year: parseInt($("#exp_year").val())
    };
    Payjp.createToken(card, function(status, response) {
      if (status == 200) {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");

        var token = response.id;
        $("#charge-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
        $("#charge-form").get(0).submit();

      }
      else {
        alert("入力内容に誤りがあります")
        $form.find("#token_submit").removeAttr("data-disable-with");
        $form.find("#token_submit").prop('disabled', false);
      }
    });
  });
});