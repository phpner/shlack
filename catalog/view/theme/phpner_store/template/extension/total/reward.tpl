<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title"><a href="#collapse-reward" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $heading_title; ?> <i class="fa fa-caret-down"></i></a></h4>
  </div>
  <div id="collapse-reward" class="panel-collapse collapse">
    <div class="panel-body">
      <div class="input-group">
        <input type="text" name="reward" value="<?php echo $reward; ?>" placeholder="<?php echo $entry_reward; ?>" id="input-reward" class="form-control" />
        <span class="input-group-btn">
        <input type="submit" value="<?php echo $button_reward; ?>" id="button-reward" data-loading-text="<?php echo $text_loading; ?>"  class="phpner_-button" />
        </span></div>
      <script type="text/javascript"><!--
$('#button-reward').on('click', function() {
	$.ajax({
		url: 'index.php?route=extension/total/reward/reward',
		type: 'post',
		data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-reward').button('loading');
		},
		complete: function() {
			$('#button-reward').button('reset');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				$('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}

			if ($('.fastorder-panel-default').length) {
				$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
			} else {
				if (json['redirect']) {
					location = json['redirect'];
				}
			}
		}
	});
});
//--></script>
    </div>
  </div>
</div>