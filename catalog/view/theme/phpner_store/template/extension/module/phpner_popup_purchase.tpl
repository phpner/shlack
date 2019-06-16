<div id="oneclick-popup" class="white-popup mfp-with-anim middle-popup">
  <h2 class="popup-header"><?php echo $heading_title; ?></h2>
  <?php if ($stock_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $stock_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($minimum > 1) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if (!$stock_warning) { ?>
  <form method="post" enctype="multipart/form-data" id="purchase-form" class="popup-form-box">
    <div class="col-md-6 text-center">
      <input name="product_id" value="<?php echo $product_id; ?>" style="display: none;" type="hidden" />
      <?php if ($phpner_popup_purchase_data['image']) { ?>
      <?php if ($special) { ?>
      <span id="you-save" class="price-tax">-<?php echo $economy; ?>%</span>
      <?php } ?>
      <?php if ($thumb) { ?>
      <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
      <?php } ?>
      <div class="popup-text">
        <h3 class="popup-h3 blue"><?php echo $product_name; ?></h3>
        <?php if ($price) { ?>
        <div class="product-price">
          <?php if (!$special) { ?>
          <span id="main-price" class="oneclick-main-price"><?php echo $price; ?></span>
          <?php } else { ?>
          <span id="main-price" class="phpner_-price-old"><?php echo $price; ?></span>
          <span id="special-price" class="phpner_-price-new"><?php echo $special; ?></span>
          <?php } ?>
          <?php if ($tax) { ?>
          <?php echo $text_tax; ?> <span id="main-tax"><?php echo $tax; ?></span><br/>
          <?php } ?>
          <?php if ($points) { ?>
          <?php echo $text_points; ?> <?php echo $points; ?><br/>
          <?php } ?>
          <?php if ($discounts) { ?>
          <?php foreach ($discounts as $discount) { ?>
          <?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?><br/>
          <?php } ?>
          <?php } ?>
        </div>
        <?php } ?>
        <?php } ?>
        <?php if ($phpner_popup_purchase_data['quantity']) { ?>
        <div class="payment-quantity">
          <div class="number">
            <div class="frame-change-count">
              <div class="btn-minus">
                <button type="button" id="superminus" onclick="$(this).parent().next().val(~~$(this).parent().next().val()-1); popup_update_prices('<?php echo $product_id; ?>');">
                <span class="icon-minus"><i class="fa fa-minus"></i></span>
                </button>
              </div>
              <input type="text" name="quantity" value="<?php echo $minimum; ?>" maxlength="3" size="8" class="plus-minus" onchange="popup_update_prices('<?php echo $product_id; ?>'); return validate(this);" keypress="popup_update_prices('<?php echo $product_id; ?>'); return validate(this);" id="input-quantity">
              <div class="btn-plus">
                <button type="button" id="superplus" onclick="$(this).parent().prev().val(~~$(this).parent().prev().val()+1); popup_update_prices('<?php echo $product_id; ?>');">
                <span class="icon-plus"><i class="fa fa-plus"></i></span>
                </button>
              </div>
            </div>
          </div>
        </div>
        <?php } else { ?>
        <input type="hidden" name="quantity" value="<?php echo $minimum; ?>" />
        <?php } ?>
      </div>
      <?php if ($options) { ?>
      <div class="info-heading-2"><?php echo $text_option; ?></div>
      <?php foreach ($options as $option) { ?>
      <?php if ($option['type'] == 'select') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" onchange="popup_update_prices('<?php echo $product_id; ?>');">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </option>
          <?php } ?>
        </select>
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'radio') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
        <label class="control-label"><?php echo $option['name']; ?></label>
        <div class="options-box" id="input-option<?php echo $option['product_option_id']; ?>">
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <?php if ($option_value['image']) { ?>
          <div class="radio radio-img">
            <label class="not-selected-img optid-<?php echo $option['option_id'];?>">
            <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
            <input onchange="popup_update_prices('<?php echo $product_id; ?>');" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" />
            <?php } else { ?>
            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" />
            <?php } ?>
            <img src="<?php echo $option_value['image']; ?>" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
            </label>
          </div>
          <?php } else { ?>
          <div class="radio phpner_-product-radio">
            <label class="optid-<?php echo $option['option_id'];?>">
            <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
            <input onchange="popup_update_prices('<?php echo $product_id; ?>');" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="product-input-radio none" />
            <?php } else { ?>
            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="product-input-radio none" />
            <?php } ?>
            <?php echo $option_value['name']; ?>
            </label>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </div>
          <?php } ?>
          <?php } ?>
        </div>
      </div>
      <?php if ($option_value['image']) { ?>
      <script>
        $(document).ready(function() {
           $('label.optid-<?php echo $option['option_id'];?>').click(function(){
             if ($(this).prev().is('input:disabled')) {
              $('label.selected-img').removeClass('selected-img').addClass('not-selected-img');
              $(this).css({
                'opacity': 0.5,
                'cursor': 'default'
              });
             } else {
              $('label.optid-<?php echo $option['option_id'];?>').removeClass('selected-img').addClass('not-selected-img');
              $(this).removeClass('not-selected-img').addClass('selected-img');
             }
           }); 
        });    
      </script>
      <?php } else { ?>
      <script>
        $(document).ready(function() {
           $('label.optid-<?php echo $option['option_id'];?>').click(function(){
             if ($(this).prev().is('input:disabled')) {
              $('label.selected').removeClass('selected').addClass('not-selected');
              $(this).css({
                'opacity': 0.5,
                'cursor': 'default'
              });
             } else {
              $('label.optid-<?php echo $option['option_id'];?>').removeClass('selected').addClass('not-selected');
              $(this).removeClass('not-selected').addClass('selected');
             }
           }); 
        });    
      </script>
      <?php } ?>
      <?php } ?>
      <?php if ($option['type'] == 'checkbox') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
        <label class="control-label"><?php echo $option['name']; ?></label>
        <div class="options-box" id="input-option<?php echo $option['product_option_id']; ?>">
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <div class="checkbox">
            <label  data-toggle="tooltip" data-trigger="hover" title="<?php echo $option['name']; ?> <?php echo $option_value['name']." "; if ($option_value['price']) { ?><?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?><?php } ?>">
            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" onchange="popup_update_prices('<?php echo $product_id; ?>');"/>
            <?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </label>
          </div>
          <?php } ?>
        </div>
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'text') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'textarea') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'file') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
        <label class="control-label"><?php echo $option['name']; ?></label>
        <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'date') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <div class="input-group date">
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
          </span>
        </div>
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'datetime') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <div class="input-group datetime">
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span>
        </div>
      </div>
      <?php } ?>
      <?php if ($option['type'] == 'time') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <div class="input-group time">
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span>
        </div>
      </div>
      <?php } ?>
      <?php } ?>
      <?php } ?>
    </div>
    <div class="payment-info col-md-6">
      <?php if ($phpner_popup_purchase_data['firstname']) { ?>
      <input type="text" name="firstname" value="<?php echo $firstname;?>" placeholder="<?php echo $enter_firstname; ?>" />
      <?php } ?>
      <?php if ($phpner_popup_purchase_data['telephone']) { ?>
      <input type="tel" name="telephone" value="<?php echo $telephone;?>" placeholder="<?php echo $enter_telephone; ?>" />
      <?php if ($mask) { ?>
      <script>
        var isMobile = {
        Android: function() {
          return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function() {
          return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function() {
          return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function() {
          return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function() {
          return navigator.userAgent.match(/IEMobile/i);
        },
        Chrome: function() {
          return navigator.userAgent.match(/Chrome/i);
        }
        };
        
        if ( !isMobile.Android() ) {
          $("#oneclick-popup [name='telephone']").inputmask('<?php echo $mask; ?>');
        }
      </script>
      <?php } ?>
      <?php } ?>
      <?php if ($phpner_popup_purchase_data['email']) { ?>
      <input type="email" name="email" value="<?php echo $email;?>" placeholder="<?php echo $enter_email; ?>" />
      <?php } ?>
      <?php if ($phpner_popup_purchase_data['comment']) { ?>
      <textarea name="comment" placeholder="<?php echo $enter_comment; ?>"><?php echo $comment;?></textarea>
      <?php } ?>
      <?php if ($text_terms) { ?>
      <div>
        <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;" />
      </div>
      <?php } ?>
    </div>
    <?php if ($recurrings) { ?>
    <div class="info-heading-2"><?php echo $text_payment_recurring ?></div>
    <div class="form-group required">
      <select name="recurring_id" class="form-control">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($recurrings as $recurring) { ?>
        <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
        <?php } ?>
      </select>
      <div class="help-block" id="recurring-description"></div>
    </div>
    <?php } ?>
  </form>
  <?php } ?>
  <div class="clearfix"></div>
  <div class="popup-buttons-box">
    <?php if (!$stock_warning) { ?>
    <a class="popup-button" id="popup-checkout-button"><?php echo $button_checkout; ?></a>
    <?php } ?>
  </div>
  <?php if (!$stock_warning) { ?>
  <?php if ($options) { ?>
  <script src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script>
  <script src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js"></script>
  <link href="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" />
  <script><!--
    $('#oneclick-popup .date').datetimepicker({
      pickTime: false,
    });
    $('#oneclick-popup .datetime').datetimepicker({
      pickDate: true,
      pickTime: true
    });
    $('#oneclick-popup .time').datetimepicker({
      pickDate: false,
    });
    $(document).on('click', 'button[id^=\'button-upload\']', function() {
      var node = this;
      $('#form-upload').remove();
      $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
      $('#form-upload input[name=\'file\']').trigger('click');
      if (typeof timer != 'undefined') {
        clearInterval(timer);
      }
      timer = setInterval(function() {
        if ($('#form-upload input[name=\'file\']').val() != '') {
          clearInterval(timer);
          $.ajax({
            url: 'index.php?route=tool/upload',
            type: 'post',
            dataType: 'json',
            data: new FormData($('#form-upload')[0]),
            cache: false,
            contentType: false,
            processData: false,
            beforeSend: function() {
              $(node).button('loading');
            },
            complete: function() {
              $(node).button('reset');
            },
            success: function(json) {
              $('#oneclick-popup .text-danger').remove();
              if (json['error']) {
                $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
              }
              if (json['success']) {
                alert(json['success']);
                $(node).parent().find('input').attr('value', json['code']);
              }
            },
            error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
          });
        }
      }, 500);
    });
    //-->
  </script>
  <?php } ?>
  <script><!--
    function masked(element, status) {
      if (status == true) {
        $('<div/>')
        .attr({ 'class':'masked' })
        .prependTo(element);
        $('<div class="masked_loading" />').insertAfter($('.masked'));
      } else {
        $('.masked').remove();
        $('.masked_loading').remove();
      }
    }
    <?php if ($phpner_popup_purchase_data['quantity']) { ?>
    function validate( input ) {
      input.value = input.value.replace( /[^\d,]/g, '' );
    }
    <?php } ?>
    $('#popup-checkout-button').on('click', function() {
      masked('#oneclick-popup', true);
      $.ajax({
          type: 'post',
          url:  'index.php?route=extension/module/phpner_popup_purchase/make_order',
          dataType: 'json',
          data: $('#purchase-form').serialize(),
          success: function(json) {
            $('#oneclick-popup .alert, #oneclick-popup .text-danger').remove();
            if (json['error']) {
              masked('#oneclick-popup', false);
              $('#oneclick-popup .text-danger').remove();

              if (json['error']['field']) {
                $.each(json['error']['field'], function(i, val) {
                  $('#oneclick-popup [name="' + i + '"]').addClass('error_style').after('<div class="text-danger">' + val + '</div>');
                });
              }
              if (json['error']['option']) {
                for (i in json['error']['option']) {
                  var element = $('#oneclick-popup #input-option' + i.replace('_', '-'));
                  element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                }
              }
              if (json['error']['recurring']) {
                $('#oneclick-popup select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
              }

              if (json['error']['quantity']) {
                $('#oneclick-popup .payment-quantity').after('<div class="text-danger">' + json['error']['quantity'] + '</div>');
              }
            } else {
              if (json['output']) {
                masked('#oneclick-popup', false);
                $('#popup-checkout-button').remove();
                $('#oneclick-popup #purchase-form').html(json['output']);
              }
            }
          }
      });
    });
    <?php if ($phpner_popup_purchase_data['quantity']) { ?>
    function popup_update_prices(product_id) {
      masked('#oneclick-popup', true);
      var input_val = $('#oneclick-popup').find('input[name=quantity]').val();
      var quantity = parseInt(input_val);
      <?php if ($minimum > 1) { ?>
        if (quantity < <?php echo $minimum; ?>) {
          quantity = $('#oneclick-popup').find('input[name=quantity]').val(<?php echo $minimum; ?>);
          masked('#oneclick-popup', false);
          return;
        }
      <?php } else { ?>
        if (quantity == 0) {
          quantity = $('#oneclick-popup').find('input[name=quantity]').val(1);
          masked('#oneclick-popup', false);
          return;
        }
      <?php } ?>
      $.ajax({
        url: 'index.php?route=extension/module/phpner_popup_purchase/update_prices&product_id=' + product_id + '&quantity=' + quantity,
        type: 'post',
        dataType: 'json',
        data: $('#purchase-form input[type=\'text\']:not(\'.phpner_-quantity-text-input\'), #purchase-form input[type=\'hidden\'], #purchase-form input[type=\'radio\']:checked, #purchase-form input[type=\'checkbox\']:checked, #purchase-form select, #purchase-form textarea'),
        success: function(json) {
          <?php if (!$special) { ?>
          $('#oneclick-popup #main-price').html(json['price']);
          <?php } ?>
          $('#oneclick-popup #special-price').html(json['special']);
          $('#oneclick-popup #main-tax').html(json['tax']);
          $('#oneclick-popup #you-save').html(json['you_save']);
          masked('#oneclick-popup', false);
        }
      });
    }
    <?php } else { ?>
      function popup_update_prices(product_id) {}
    <?php } ?>
    $('#oneclick-popup select[name=\'recurring_id\'], #oneclick-popup input[name="quantity"]').change(function(){
      $.ajax({
        url: 'index.php?route=product/product/getRecurringDescription',
        type: 'post',
        data: $('#purchase-form input[name=\'product_id\'], #purchase-form input[name=\'quantity\'], #purchase-form select[name=\'recurring_id\']'),
        dataType: 'json',
        beforeSend: function() {
          $('#oneclick-popup #recurring-description').html('');
        },
        success: function(json) {
          $('#oneclick-popup .alert, #oneclick-popup .text-danger').remove();
          if (json['success']) {
            $('#oneclick-popup #recurring-description').html(json['success']);
          }
        }
      });
    });
    //-->
  </script>
  <?php } ?>
</div>