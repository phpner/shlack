<div id="popup-cart-inner" class="row">
  <div class="col-sm-12">
    <div class="phpner_-carousel-header"><?php echo $text_cart; ?></div>
    <?php if ($products || $vouchers) { ?>
    <div class="phpner_-bottom-cart-in-cart"><?php echo $text_cart_items; ?></div>
    <div class="phpner_-bottom-cart-box">
      <form action="index.php?route=checkout/cart/edit" method="post" enctype="multipart/form-data">
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
                <td class="delete-td"></td>
                <td class="text-center image-td"><?php echo $column_image; ?></td>
                <td class="text-left"><?php echo $column_name; ?></td>
                <td class="text-left"><?php echo $column_quantity; ?></td>
                <td class="text-right"><?php echo $column_price; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="delete-td">
                  <button type="button" data-toggle="tooltip" title="" class="delete" onclick="page_bar_update(this, 'remove');">×</button>
                  <input name="product_key" value="<?php echo $product['key']; ?>" style="display: none;" hidden />
                  <input name="product_id_q" value="<?php echo $product['product_id']; ?>" style="display: none;" hidden />           
                </td>
                <td class="text-center image-td">
                  <?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail phpner_-bottom-cart-img-thumbnail" /></a>
                  <?php } ?>
                </td>
                <td class="text-left">
                  <a href="<?php echo $product['href']; ?>" class="phpner_-bottom-cart-table-text"><?php echo $product['name']; ?></a>
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
                  <div class="input-group btn-block" style="max-width: 200px;">
                    <input name="product_id_q" value="<?php echo $product['product_id']; ?>" style="display: none;" type="hidden" />
                    <input name="product_id" value="<?php echo $product['key']; ?>" style="display: none;" type="hidden" />
                    <input type="text" name="quantity" value="<?php echo $product['quantity']; ?>" class="form-control" onchange="page_bar_update_manual(this, '<?php echo $product['key']; ?>'); return validate(this);" keypress="page_bar_update_manual(this, '<?php echo $product['key']; ?>'); return validate(this);" />
                  </div>
                </td>
                <td class="text-right popup-table-text popup-table-price"><?php echo $product['total']; ?></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $voucher) { ?>
                <tr>
                  <td class="delete-td">
                    <button type="button" class="delete" onclick="page_bar_voucher_remove('<?php echo $voucher['key']; ?>');">×</button>      
                  </td>
                  <td class="text-left"></td>
                  <td class="text-left"><span class="phpner_-bottom-cart-table-text"><?php echo $voucher['description']; ?></span></td>
                  <td class="text-left">
                    <div class="input-group btn-block" style="max-width: 200px;">
                      <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                    </div>
                  </td>
                  <td class="text-right popup-table-text popup-table-price"><?php echo $voucher['amount']; ?></td>
                </tr>
                <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
      <div class="phpner_-bottom-cart-total-cart">
        <a class="phpner_-button" href="<?php echo $checkout_link; ?>"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_checkout; ?></a>
      </div>
    </div>
    <?php } else { ?>
      <div class="text-center empty-bottom-cart">
        <p><?php echo $empty; ?></p>
      </div>
    <?php } ?>
  </div>
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

  function page_bar_update(target, status) {
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
      urls = 'index.php?route=extension/module/phpner_page_bar/block_cart&update=' + product_id + '&quantity=' + quantity;
    } else if (status == 'add') {
      urls = 'index.php?route=extension/module/phpner_page_bar/block_cart&add=' + target + '&quantity=1';
    } else {
      urls = 'index.php?route=extension/module/phpner_page_bar/block_cart&remove=' + product_key;
    }
    $.ajax({
      url: urls,
      type: 'get',
      dataType: 'html',
      success: function(data) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_page_bar/status_cart',
          type: 'get',
          dataType: 'json',
          success: function(json) {
            masked('#popup-cart-inner', false);
            
            $('#cart-total').html(json['text_cart_items']);
            $('#cart > ul').load('index.php?route=common/cart/info ul li');
            $('#phpner_-bottom-cart-content').load('index.php?route=extension/module/phpner_page_bar/block_cart');
            $("#phpner_-bottom-cart-quantity").html(json['total']);
            $("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart');

	          if ($('#checkout-cart-page').length || $('#checkout-fastorder-page').length) {
	          	$.ajax({
	              url: 'index.php?route=checkout/phpner_fastorder/status_cart',
	              type: 'get',
	              dataType: 'json',
	              success: function(json) {
	                if (json['redirect']) {
	                  location = json['redirect'];
	                }
	              }
	            });
	          }
          } 
        });
      } 
    });
  }

  function page_bar_update_manual(target, product_id) {
    masked('#popup-cart-inner', true);
    var input_val = $(target).val(),
    quantity  = parseInt(input_val);
    if (quantity <= 0) {
      masked('#popup-cart-inner', false);
      quantity = $(target).val(1);
      return;
    }
    $.ajax({
      url: 'index.php?route=extension/module/phpner_page_bar/block_cart&update=' + product_id + '&quantity=' + quantity,
      type: 'get',
      dataType: 'html',
      success: function(data) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_page_bar/status_cart',
          type: 'get',
          dataType: 'json',
          success: function(json) {
            masked('#popup-cart-inner', false);
   
            $('#cart-total').html(json['text_cart_items']);
            $('#cart > ul').load('index.php?route=common/cart/info ul li');
            $('#phpner_-bottom-cart-content').load('index.php?route=extension/module/phpner_page_bar/block_cart');
            $("#phpner_-bottom-cart-quantity").html(json['total']);
						$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart');

	          if ($('#checkout-cart-page').length || $('#checkout-fastorder-page').length) {
	          	$.ajax({
	              url: 'index.php?route=checkout/phpner_fastorder/status_cart',
	              type: 'get',
	              dataType: 'json',
	              success: function(json) {
	                if (json['redirect']) {
	                  location = json['redirect'];
	                }
	              }
	            });
	          }
          } 
        });
      } 
    });
  }

  function page_bar_voucher_remove(voucher_key) {
    masked('#popup-cart-inner', true);
    $.ajax({
      url: 'index.php?route=extension/module/phpner_page_bar/block_cart&remove=' + voucher_key,
      type: 'get',
      dataType: 'html',
      success: function(data) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_page_bar/status_cart',
          type: 'get',
          dataType: 'json',
          success: function(json) {
            masked('#popup-cart-inner', false);
   
            $('#cart-total').html(json['text_cart_items']);
            $('#cart > ul').load('index.php?route=common/cart/info ul li');
            $('#phpner_-bottom-cart-content').load('index.php?route=extension/module/phpner_page_bar/block_cart');
            $("#phpner_-bottom-cart-quantity").html(json['total']);
						$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart');

	          if ($('#checkout-cart-page').length || $('#checkout-fastorder-page').length) {
	          	$.ajax({
	              url: 'index.php?route=checkout/phpner_fastorder/status_cart',
	              type: 'get',
	              dataType: 'json',
	              success: function(json) {
	                if (json['redirect']) {
	                  location = json['redirect'];
	                }
	              }
	            });
	          }
          } 
        });
      } 
    });
  }
</script>
