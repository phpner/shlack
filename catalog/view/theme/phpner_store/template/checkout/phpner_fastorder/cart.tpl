<div class="panel panel-default fastorder-panel-default">
  <div class="panel-heading">
    <h4 class="panel-title phpner_-fastorder-header"><span>1</span><?php echo $heading_cart_block; ?> <?php echo $weight; ?></h4>
  </div>
  <div class="panel-collapse">
    <div class="panel-body">
      <?php if ($attention) { ?>
      <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <?php if ($error_warning) { ?>
		  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		  </div>
		  <script type="text/javascript">$(function(){$('#button-go').attr('disabled', 'disabled');$('#button-go').addClass('disabled');});</script>
      <?php } ?>
      <div class="phpner_-bottom-cart-box" id="checkout-fastorder-page">
	      <div class="table-responsive">
	        <table id="cart_table" class="table">
	            <thead>
	              <tr>
					<td class="delete-td"></td>
					<?php if (isset($phpner_fastorder_data['image_view_is']) && $phpner_fastorder_data['image_view_is'] == 1) { ?>
						<td class="text-center image-td"><?php echo $column_image; ?></td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['name_view']) && $phpner_fastorder_data['name_view'] == 1) { ?>
						<td class="text-left"><?php echo $column_name; ?></td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['model_view']) && $phpner_fastorder_data['model_view'] == 1) { ?>
						<td class="text-left"><?php echo $column_model; ?></td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['quantity_view']) && $phpner_fastorder_data['quantity_view'] == 1) { ?>
						<td class="text-left"><?php echo $column_quantity; ?></td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['price_view']) && $phpner_fastorder_data['price_view'] == 1) { ?>
						<td class="text-right"><?php echo $column_price; ?></td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['total_view']) && $phpner_fastorder_data['total_view'] == 1) { ?>
						<td class="text-right"><?php echo $column_total; ?></td>
					<?php } ?>
				  </tr>
	            </thead>
	            <tbody>
	              <?php foreach ($products as $product) { ?>
	              <tr>
	                <td class="delete-td">
	                  <button type="button" class="delete" onclick="update(this, 'remove');">×</button>         
	                </td>
					<?php if (isset($phpner_fastorder_data['image_view_is']) && $phpner_fastorder_data['image_view_is'] == 1) { ?>
	                <td class="text-center image-td">
	                  <?php if ($product['thumb']) { ?>
	                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail phpner_-bottom-cart-img-thumbnail" /></a>
	                  <?php } ?>
	                </td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['name_view']) && $phpner_fastorder_data['name_view'] == 1) { ?>
	                <td class="text-left">
	                  <a href="<?php echo $product['href']; ?>" class="phpner_-bottom-cart-table-text"><?php echo $product['name']; ?></a>
	                  <?php if (!$product['stock']) { ?>
	                  <span class="text-danger">***</span>
	                  <?php } ?>
	                  <?php if ($product['option']) { ?>
	                  <?php foreach ($product['option'] as $option) { ?>
	                  <br />
	                  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?>
	                  <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['quantity_status'] && isset($option['phpner_quantity_value']) && $option['phpner_quantity_value']) { ?>
	                  	x<?php echo $option['phpner_quantity_value']; ?>
	                  <?php } ?>
	                  <?php if ((isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['allow_sku'] && $option['sku']) || (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['allow_model'] && $option['model'])) { ?>(<?php if ($phpner_advanced_options_settings_data['allow_sku'] && $option['sku']) { ?><?php echo $text_option_sku; ?>: <?php echo $option['sku']; ?>, <?php } ?><?php if ($phpner_advanced_options_settings_data['allow_model'] && $option['model']) { ?><?php echo $text_option_model; ?>: <?php echo $option['model']; ?><?php } ?>)
	                  <?php } ?>
	                  </small>
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
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['model_view']) && $phpner_fastorder_data['model_view'] == 1) { ?>
					<td class="text-center">
						<?php echo $product['model']; ?>
					</td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['quantity_view']) && $phpner_fastorder_data['quantity_view'] == 1) { ?>
	                <td class="text-center">
	                  <div class="input-group btn-block" style="max-width: 200px;">
	                    <input name="product_id_q" value="<?php echo $product['product_id']; ?>" style="display: none;" type="hidden" />
	                    <input name="product_id" value="<?php echo $product['key']; ?>" style="display: none;" type="hidden" />
	                    <input type="text" name="quantity" value="<?php echo $product['quantity']; ?>" class="form-control" onchange="update_manual(this, '<?php echo $product['key']; ?>'); return validate(this);" keypress="update_manual(this, '<?php echo $product['key']; ?>'); return validate(this);" />
	                  </div>
	                </td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['price_view']) && $phpner_fastorder_data['price_view'] == 1) { ?>
	                <td class="text-right popup-table-text popup-table-price"><?php echo $product['price']; ?></td>
					<?php } ?>
					<?php if (isset($phpner_fastorder_data['total_view']) && $phpner_fastorder_data['total_view'] == 1) { ?>
	                <td class="text-right popup-table-text popup-table-price"><?php echo $product['total']; ?></td>
					<?php } ?>
	              </tr>
	              <?php } ?>
	              <?php foreach ($vouchers as $voucher) { ?>
	                <tr>
		                <td class="delete-td">
		                  <button type="button" class="delete" onclick="voucher_remove('<?php echo $voucher['key']; ?>');">×</button>    
		                </td>
		                <td class="text-center image-td"></td>
		                <td class="text-left"><?php echo $voucher['description']; ?></td>
						<td class="text-right"></td>
		                <td class="text-left">
			                <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
		                </td>
		                <td class="text-right"></td>
		                <td class="text-right popup-table-text popup-table-price"><?php echo $voucher['amount']; ?></td>
	                </tr>
	                <?php } ?>
	            </tbody>
	          </table>
	      </div>
      </div>
      <div class="phpner_-bottom-cart-total-cart">
        <?php foreach ($totals as $total) { ?>
          <div class="total-text"><?php echo $total['title']; ?>: <span><?php echo $total['text']; ?></span></div>
        <?php } ?>
      </div>
    </div>
  </div>
</div>