<?php echo $header; ?>
<div class="container"><?php echo $content_top; ?>
  <div class="col-sm-12 content-row">
	<div class="breadcrumb-box">
	  <ul class="breadcrumb">
	    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
	    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
	    <?php } ?>
	  </ul>
	</div>
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> cart-content">
      <h2 class="phpner_-carousel-header"><?php echo $heading_title; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="table-responsive phpner_-bottom-cart-box" id="checkout-cart-page">
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
	                  <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="delete" onclick="cart.remove('<?php echo $product['cart_id']; ?>');">×</button>           
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
	                  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?> 
	                  <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['quantity_status'] && isset($option['phpner_quantity_value']) && $option['phpner_quantity_value']) { ?>
	                  	x<?php echo $option['phpner_quantity_value']; ?>
	                  <?php } ?>
	                  <?php if ((isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['allow_sku'] && $option['sku']) || (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['allow_model'] && $option['model'])) { ?>(<?php if ($phpner_advanced_options_settings_data['allow_sku'] && $option['sku']) { ?><?php echo $phpner_text_option_sku; ?>: <?php echo $option['sku']; ?>, <?php } ?><?php if ($phpner_advanced_options_settings_data['allow_model'] && $option['model']) { ?><?php echo $phpner_text_option_model; ?>: <?php echo $option['model']; ?><?php } ?>)
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
	                <td class="text-center">
	                  <div class="input-group btn-block" style="max-width: 200px;">
	                  	<input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
	                    <span class="input-group-btn">
	                    <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="phpner_-button phpner_-refresh-button"><i class="fa fa-refresh"></i></button>
	                    </span>
	                  </div>
	                </td>
	                <td class="text-right popup-table-text popup-table-price"><?php echo $product['total']; ?></td>
	              </tr>
	              <?php } ?>
	              <?php foreach ($vouchers as $voucher) { ?>
	                <tr>
		                <td class="delete-td">
		                  <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="delete" onclick="voucher.remove('<?php echo $voucher['key']; ?>');">×</button>    
		                </td>
		                <td class="text-center image-td"></td>
		                <td class="text-left"><?php echo $voucher['description']; ?></td>
		                <td class="text-left">
			                <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
		                </td>
		                <td class="text-right popup-table-text popup-table-price"><?php echo $voucher['amount']; ?></td>
	                </tr>
	                <?php } ?>
	            </tbody>
	          </table>
        </div>
      </form>
      <?php if ($modules) { ?>
      <h2><?php echo $text_next; ?></h2>
      <p><?php echo $text_next_choice; ?></p>
      <div class="panel-group" id="accordion">
        <?php foreach ($modules as $module) { ?>
        <?php echo $module; ?>
        <?php } ?>
      </div>
      <?php } ?>
      <br />
      <div class="row">
        <div class="col-sm-6">
          <table class="table table-bordered">
            <?php foreach ($totals as $total) { ?>
            <tr>
              <td class="text-left"><strong><?php echo $total['title']; ?>:</strong></td>
              <td class="text-left"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
          </table>
        </div>
      </div>
      <div class="buttons clearfix">
        <div class="pull-left"><a href="<?php echo $checkout; ?>" class="phpner_-button"><?php echo $button_checkout; ?></a></div>
      </div>
      </div>
    <?php echo $column_right; ?></div>
<?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
