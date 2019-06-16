<div id="cart-popup" class="white-popup middle-popup mfp-with-anim">
  <div id="popup-cart-inner">
    <div class="phpner_-carousel-header"><?php echo $heading_title; ?></div>
    <?php if ($products || $vouchers) { ?>
      <?php if ($attention) { ?>
      <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <?php if ($success) { ?>
      <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } else { ?>
      <div id="success-message"></div>
      <?php } ?>
      <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <div class="popup-text">
        <p><?php echo $text_cart_items; ?></p>
      </div>
      <div class="popup-cart-box">
        <form action="index.php?route=checkout/cart/edit" method="post" enctype="multipart/form-data">
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <td class="delete-td"></td>
                  <td class="text-center image-td"><?php echo $column_image; ?></td>
                  <td class="text-left"><?php echo $column_name; ?></td>
                  <td class="text-left quantity-td"><?php echo $column_quantity; ?></td>
                  <td class="text-right price-td"><?php echo $column_price; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($products as $product) { ?>
                <tr>
                  <td class="delete-td">
                    <button type="button" class="delete" onclick="update(this, 'remove');">×</button>
                    <input name="product_key" value="<?php echo $product['key']; ?>" style="display: none;" hidden />
                    <input name="product_id_q" value="<?php echo $product['product_id']; ?>" style="display: none;" hidden />         
                  </td>
                  <td class="text-center image-td">
                    <?php if ($product['thumb']) { ?>
                      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail popup-img-thumbnail" /></a>
                    <?php } ?>
                  </td>
                  <td class="text-left">
                    <a href="<?php echo $product['href']; ?>" class="phpner_-popup-cart-link"><?php echo $product['name']; ?></a>
                    <?php if (!$product['stock']) { ?>
                    <span class="text-danger">***</span>
                    <?php } ?>
                    <?php if ($product['option']) { ?>
                    <?php foreach ($product['option'] as $option) { ?>
                    <br />
                    <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                    <?php } ?>
                    <?php } ?>
                    <?php if ($product['reward']) { ?>
                    <br />
                    <small><?php echo $product['reward']; ?></small>
                    <?php } ?>
                    <?php if ($product['recurring']) { ?>
                    <br />
                    <small><?php echo $text_recurring_item; ?> <?php echo $product['recurring']; ?></small>
                    <?php } ?>
                  </td>
                  <td class="text-center">
                    <div class="input-group btn-block" style="max-width: 100px;">
                      <input name="product_id_q" value="<?php echo $product['product_id']; ?>" style="display: none;" type="hidden" />
                      <input name="product_id" value="<?php echo $product['key']; ?>" style="display: none;" type="hidden" />
                      <input type="text" name="quantity" value="<?php echo $product['quantity']; ?>" class="form-control" onchange="update_manual(this, '<?php echo $product['key']; ?>'); return validate(this);" keypress="update_manual(this, '<?php echo $product['key']; ?>'); return validate(this);" />
                    </div>
                  </td>
                  <td class="text-right popup-table-text"><?php echo $product['total']; ?></td>
                </tr>
                <?php } ?>
                <?php foreach ($vouchers as $voucher) { ?>
                <tr>
                  <td class="delete-td"><button type="button" onclick="phpner_popup_voucher_remove('<?php echo $voucher['key']; ?>');">×</button></td>
                  <td class="text-center image-td"></td>
                  <td class="text-left"><span class="popup-table-text"><?php echo $voucher['description']; ?></span></td>
                  <td class="text-center">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                  </td>
                  <td class="text-right popup-table-text"><?php echo $voucher['amount']; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="popup-total-cart">
          <?php foreach ($totals as $total) { ?>
            <div class="total-text"><?php echo $total['title']; ?>: <span class="gold"><?php echo $total['text']; ?></span></div>
          <?php } ?>
          <div class="popup-buttons-box">
          <a class="popup-button" href="<?php echo $checkout_link; ?>"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_checkout; ?></a>
	        <a class="popup-button phpner_-button-inv" onclick="$.magnificPopup.close();"><?php echo $button_shopping; ?></a>
	        </div>
        </div>
      </div>
    <?php } else { ?>
      <div class="popup-text">
        <p><?php echo $empty; ?></p>
      </div>
      <div class="popup-buttons-box text-center">
        <a class="popup-button" onclick="$.magnificPopup.close();"><?php echo $button_shopping; ?></a>
      </div>
    <?php } ?>
  </div>
<script>
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
  function validate(input) {
    input.value = input.value.replace(/[^\d,]/g, '');
  }
  function update(target, status) {
    masked('#popup-cart-inner', true);
    var input_val    = $(target).parent().parent().parent().children('input[name=quantity]').val(),
    quantity     = parseInt(input_val),
    product_id   = $(target).parent().parent().parent().children('input[name=product_id]').val(),
    product_id_q = $(target).parent().parent().parent().children('input[name=product_id_q]').val(),
    product_key  = $(target).next().val(),
    urls         = null;
    if (quantity <= 0) {
      masked('#popup-cart-inner', false);
      quantity = $(target).parent().parent().parent().children('input[name=quantity]').val(1);
      return;
    }
    if (status == 'update') {
      urls = 'index.php?route=extension/module/phpner_popup_cart&update=' + product_id + '&quantity=' + quantity;
    } else if (status == 'add') {
      urls = 'index.php?route=extension/module/phpner_popup_cart&add=' + target + '&quantity=1';
    } else {
      urls = 'index.php?route=extension/module/phpner_popup_cart&remove=' + product_key;
    }
    $.ajax({
      url: urls,
      type: 'get',
      dataType: 'html',
      success: function(data) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_popup_cart/status_cart',
          type: 'get',
          dataType: 'json',
          success: function(json) {
            masked('#popup-cart-inner', false);
            
            $("#cart-total").html(json['total']);
		        $('#cart > ul').load('index.php?route=common/cart/info ul li');

		        $.ajax({
		          url:  'index.php?route=extension/module/phpner_page_bar/update_html',
		          type: 'get',
		          dataType: 'json',
		          success: function(json) {
		            $("#phpner_-bottom-cart-quantity").html(json['total_cart']);
		          }
		        });

            $('#popup-cart-inner').html($(data).find('#popup-cart-inner > *'));
          } 
        });
      } 
    });
  }
  function update_manual(target, product_id) {
    masked('#popup-cart-inner', true);
    var input_val = $(target).val(),
    quantity  = parseInt(input_val);
    if (quantity <= 0) {
      masked('#popup-cart-inner', false);
      quantity = $(target).val(1);
      return;
    }
    $.ajax({
      url: 'index.php?route=extension/module/phpner_popup_cart&update=' + product_id + '&quantity=' + quantity,
      type: 'get',
      dataType: 'html',
      success: function(data) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_popup_cart/status_cart',
          type: 'get',
          dataType: 'json',
          success: function(json) {
            masked('#popup-cart-inner', false);

            $("#cart-total").html(json['total']);
		        $('#cart > ul').load('index.php?route=common/cart/info ul li');

		        $.ajax({
		          url:  'index.php?route=extension/module/phpner_page_bar/update_html',
		          type: 'get',
		          dataType: 'json',
		          success: function(json) {
		            $("#phpner_-bottom-cart-quantity").html(json['total_cart']);
		          }
		        });

            $('#popup-cart-inner').html($(data).find('#popup-cart-inner > *'));
          } 
        });
      } 
    });
  }
  function phpner_popup_voucher_remove(voucher_key) {
    masked('#popup-cart-inner', true);
    $.ajax({
      url: 'index.php?route=extension/module/phpner_popup_cart&remove=' + voucher_key,
      type: 'get',
      dataType: 'html',
      success: function(data) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_popup_cart/status_cart',
          type: 'get',
          dataType: 'json',
          success: function(json) {
            masked('#popup-cart-inner', false);
   
            $("#cart-total").html(json['total']);
		        $('#cart > ul').load('index.php?route=common/cart/info ul li');

		        $.ajax({
		          url:  'index.php?route=extension/module/phpner_page_bar/update_html',
		          type: 'get',
		          dataType: 'json',
		          success: function(json) {
		            $("#phpner_-bottom-cart-quantity").html(json['total_cart']);
		          }
		        });

            $('#popup-cart-inner').html($(data).find('#popup-cart-inner > *'));
          } 
        });
      } 
    });
  }
</script>
</div>