$(function() {
	$(function() {
		$(document).on('keyup', '#sell_center', function() {
			moneyCalc();
		});
	});
	function moneyCalc() {
		let inputNum = $('#sell_center').val();
		let Input = parseInt(inputNum);
		if (Input < 300 || Input > 1000000 || inputNum == ""){
			$(".sales-commission").text("-");
			$(".sales-profit").text("-");
			console.log(Input)
		}else{
			let fee = parseInt(Input / 10);
			$('.sales-commission').text('¥' + fee.toLocaleString());
			$('.sales-profit').text('¥' + (Input - fee).toLocaleString());
		};
	};
});
