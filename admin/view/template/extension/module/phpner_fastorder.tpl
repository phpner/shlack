<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#setting-tab" data-toggle="tab"><i class="fa fa-cog"></i> <?php echo $tab_setting; ?></a></li>
            <li><a href="#fields-tab" data-toggle="tab"><i class="fa fa-user"></i> <?php echo $tab_filds; ?></a></li>
            <li><a href="#cart-tab" data-toggle="tab"><i class="fa fa-shopping-cart"></i> <?php echo $tab_cart; ?></a></li>
            <li style="display:none;"><a href="#display-tab" data-toggle="tab"><?php echo $tab_display; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="setting-tab">
			  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_fastorder_data[status]" id="input-status" class="form-control">
                    <?php if ($phpner_fastorder_data['status']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-is_shipping_dop"><?php echo $entry_is_shipping_dop; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_fastorder_data[is_shipping_dop]" id="input-is_shipping_dop" class="form-control">
                    <?php if ($phpner_fastorder_data['is_shipping_dop']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
			  <div class="form-group" style="display:none;">
                <label class="col-sm-2 control-label" for="input-order_in_popup"><?php echo $entry_order_in_popup; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_fastorder_data[order_in_popup]" id="input-order_in_popup" class="form-control">
                    <?php if ($phpner_fastorder_data['order_in_popup']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
			<div class="tab-pane" id="cart-tab">
			  <fieldset>
				<legend><?php echo $text_cart_settings; ?></legend>
				<div class="col-md-6">
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-cart_view_is"><?php echo $entry_cart_view_is; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[cart_view_is]" id="input-cart_view_is" class="form-control">
							<?php if ($phpner_fastorder_data['cart_view_is'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-image_view_is"><?php echo $entry_image_view_is; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[image_view_is]" id="input-image_view_is" class="form-control">
							<?php if ($phpner_fastorder_data['image_view_is'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-name_view"><?php echo $entry_name_view; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[name_view]" id="input-name_view" class="form-control">
							<?php if ($phpner_fastorder_data['name_view'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-model_view"><?php echo $entry_model_view; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[model_view]" id="input-model_view" class="form-control">
							<?php if ($phpner_fastorder_data['model_view'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-quantity_view"><?php echo $entry_quantity_view; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[quantity_view]" id="input-quantity_view" class="form-control">
							<?php if ($phpner_fastorder_data['quantity_view'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-price_view"><?php echo $entry_price_view; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[price_view]" id="input-price_view" class="form-control">
							<?php if ($phpner_fastorder_data['price_view'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-total_view"><?php echo $entry_total_view; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[total_view]" id="input-total_view" class="form-control">
							<?php if ($phpner_fastorder_data['total_view'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-cart_weight"><?php echo $entry_cart_weight; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[cart_weight]" id="input-cart_weight" class="form-control">
							<?php if ($phpner_fastorder_data['cart_weight'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<!--<div class="form-group">
						<label class="col-sm-5 control-label" for="input-cart_rewards"><?php //echo $entry_cart_rewards; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[cart_rewards]" id="input-cart_rewards" class="form-control">
							<?php //if ($phpner_fastorder_data['cart_rewards'] == 1) { ?>
							<option value="1" selected="selected"><?php //echo $text_enabled; ?></option>
							<option value="0"><?php //echo $text_disabled; ?></option>
							<?php //} else { ?>
							<option value="1"><?php //echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php //echo $text_disabled; ?></option>
							<?php //} ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-cart_coupon"><?php //echo $entry_cart_coupon; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[cart_coupon]" id="input-cart_coupon" class="form-control">
							<?php //if ($phpner_fastorder_data['cart_coupon'] == 1) { ?>
							<option value="1" selected="selected"><?php //echo $text_enabled; ?></option>
							<option value="0"><?php //echo $text_disabled; ?></option>
							<?php //} else { ?>
							<option value="1"><?php //echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php //echo $text_disabled; ?></option>
							<?php //} ?>
						  </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-cart_voucher"><?php //echo $entry_cart_voucher; ?></label>
						<div class="col-sm-7">
						  <select name="phpner_fastorder_data[cart_voucher]" id="input-cart_voucher" class="form-control">
							<?php //if ($phpner_fastorder_data['cart_voucher'] == 1) { ?>
							<option value="1" selected="selected"><?php //echo $text_enabled; ?></option>
							<option value="0"><?php //echo $text_disabled; ?></option>
							<?php //} else { ?>
							<option value="1"><?php //echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php //echo $text_disabled; ?></option>
							<?php //} ?>
						  </select>
						</div>
					</div>-->
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-minimum_order"><?php echo $entry_minimum_order; ?></label>
						<div class="col-sm-7">
						  <input type="text" name="phpner_fastorder_data[minimum_order]" value="<?php echo $phpner_fastorder_data['minimum_order'] ? $phpner_fastorder_data['minimum_order'] : ''; ?>" placeholder="<?php echo $entry_minimum_order; ?>" id="input-minimum_order" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-5 control-label" for="input-max_order"><?php echo $entry_max_order; ?></label>
						<div class="col-sm-7">
						  <input type="text" name="phpner_fastorder_data[max_order]" value="<?php echo $phpner_fastorder_data['max_order'] ? $phpner_fastorder_data['max_order'] : ''; ?>" placeholder="<?php echo $entry_max_order; ?>" id="input-max_order" class="form-control" />
						</div>
					</div>
				</div>
			  </fieldset>
			</div>
			<div class="tab-pane" id="fields-tab">
				<fieldset>
				  <legend><?php echo $text_fields_settings; ?></legend>
				  <div class="col-sm-6">
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-registration"><?php echo $entry_registration; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[registration]" id="input-registration" class="form-control">
							<?php if ($phpner_fastorder_data['registration'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[lastname]" id="input-lastname" class="form-control">
							<?php if ($phpner_fastorder_data['lastname'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<!--<option value="2"><?php //echo $text_enabled_required; ?></option>-->
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif($phpner_fastorder_data['lastname'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<!--<option value="2" selected="selected"><?php //echo $text_enabled_required; ?></option>-->
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<!--<option value="2"><?php //echo $text_enabled_required; ?></option>-->
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <!-- 3359 -->
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-email"><?php echo $entry_email; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[email]" id="input-email" class="form-control">
							<?php if ($phpner_fastorder_data['email'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif ($phpner_fastorder_data['email'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-notify_email"><?php echo $entry_notify_email; ?></label>
						<div class="col-sm-8">
						  <input type="text" name="phpner_fastorder_data[notify_email]" value="<?php echo (isset($phpner_fastorder_data['notify_email'])) ? $phpner_fastorder_data['notify_email'] : ''; ?>" id="input-notify_email" class="form-control" />
						  <?php if ($error_notify_email) { ?>
							<div class="text-danger"><?php echo $error_notify_email; ?></div>
						  <?php } ?>
						</div>
					  </div>
					  <!-- 3359 -->
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-customer_groups"><?php echo $entry_customer_groups; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[customer_groups]" id="input-customer_groups" class="form-control">
							<?php if ($phpner_fastorder_data['customer_groups'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[fax]" id="input-fax" class="form-control">
							<?php if ($phpner_fastorder_data['fax'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-company"><?php echo $entry_company; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[company]" id="input-company" class="form-control">
							<?php if ($phpner_fastorder_data['company'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-mask"><?php echo $entry_mask; ?></label>
						<div class="col-sm-8">
						  <input type="text" name="phpner_fastorder_data[mask]" value="<?php echo $phpner_fastorder_data['mask']; ?>" placeholder="<?php echo $entry_mask_info; ?>" id="input-mask" class="form-control" />
						</div>
					  </div>
					</div>
					<div class="col-sm-6">
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-address_1"><?php echo $entry_address_1; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[address_1]" id="input-address_1" class="form-control">
							<?php if ($phpner_fastorder_data['address_1'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif($phpner_fastorder_data['address_1'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-address_2"><?php echo $entry_address_2; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[address_2]" id="input-address_2" class="form-control">
							<?php if ($phpner_fastorder_data['address_2'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif($phpner_fastorder_data['address_2'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[postcode]" id="input-postcode" class="form-control">
							<?php if ($phpner_fastorder_data['postcode'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif($phpner_fastorder_data['postcode'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-city"><?php echo $entry_city; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[city]" id="input-city" class="form-control">
							<?php if ($phpner_fastorder_data['city'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif($phpner_fastorder_data['city'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-country_and_region"><?php echo $entry_country_and_region; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[country_and_region]" id="input-country_and_region" class="form-control">
							<?php if ($phpner_fastorder_data['country_and_region'] == 1) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } elseif($phpner_fastorder_data['country_and_region'] == 2) { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="2"><?php echo $text_enabled_required; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group required">
						<label class="col-sm-4 control-label" for="input-country"><?php echo $entry_default_country; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[default_country]" id="input-country" class="form-control">
							<?php foreach ($countries as $country) { ?>
							<?php if ($country['country_id'] == $phpner_fastorder_data['default_country']) { ?>
							<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
							<?php } else { ?>
							<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
							<?php } ?>
							<?php } ?>
						  </select>
						  <?php if ($error_default_country) { ?>
						  <div class="text-danger"><?php echo $error_default_country; ?></div>
						  <?php } ?>
						</div>
					  </div>
					  <div class="form-group required">
						<label class="col-sm-4 control-label" for="input-region"><?php echo $entry_default_region; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[default_region]" id="input-region" class="form-control">
						  </select>
						  <?php if ($error_default_region) { ?>
						  <div class="text-danger"><?php echo $error_default_region; ?></div>
						  <?php } ?>
						</div>
					  </div>
					  <div class="form-group required">
						<label class="col-sm-4 control-label" for="input-city"><?php echo $entry_default_city; ?></label>
						<div class="col-sm-8">
						  <input type="text" name="phpner_fastorder_data[default_city]" value="<?php echo $phpner_fastorder_data['default_city']; ?>" placeholder="<?php echo $entry_default_city; ?>" id="input-city" class="form-control" />
						  <?php if ($error_default_city) { ?>
						  <div class="text-danger"><?php echo $error_default_city; ?></div>
						  <?php } ?>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-4 control-label" for="input-comment"><?php echo $entry_comment; ?></label>
						<div class="col-sm-8">
						  <select name="phpner_fastorder_data[comment]" id="input-comment" class="form-control">
							<?php if ($phpner_fastorder_data['comment'] == 1) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
				  </div>
				</fieldset>
				<fieldset>
					<legend><?php echo $text_dop_filds; ?></legend>
					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="dop_fields_table">
						  <thead>
							<tr>
							  <td class="text-left"><?php echo $column_name; ?></td>
							  <td class="text-left"><?php echo $column_location; ?></td>
							  <td class="text-left"><?php echo $column_type; ?></td>
							  <td class="text-right"><?php echo $column_sort_order; ?></td>
							  <!--<td class="text-right"><?php //echo $column_action; ?></td>-->
							</tr>
						  </thead>
						  <tbody>
							<?php if ($custom_fields) { ?>
							<?php foreach ($custom_fields as $custom_field) { ?>
							<tr>
							  <td class="text-left"><?php echo $custom_field['name']; ?></td>
							  <td class="text-left"><?php echo $custom_field['location']; ?></td>
							  <td class="text-left"><?php echo $custom_field['type']; ?></td>
							  <td class="text-right"><?php echo $custom_field['sort_order']; ?></td>
							  <!--<td class="text-right"><a id="edit_fields" href="javascript:;" data-toggle="tooltip" title="<?php //echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>a id="delete_fields" href="javascript:;" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a></td>-->
							</tr>
							<?php } ?>
							<?php } else { ?>
							<tr>
							  <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
							</tr>
							<?php } ?>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="3"></td>
								<td class="text-right">
									<span data-toggle="modal" data-target="#add-fields-modal">
										<a id="add_fields" href="javascript:;" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
									</span>
								</td>
							</tr>
						</tfoot>
						</table>
					</div>
				</fieldset>
            </div>
            <div class="tab-pane" id="display-tab">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-backgorund_color_block_border"><?php echo $entry_backgorund_color_block_border; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[backgorund_color_block_border]" value="<?php echo $phpner_fastorder_data['backgorund_color_block_border']; ?>" placeholder="<?php echo $entry_backgorund_color_block_border; ?>" id="input-backgorund_color_block_border" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-backgorund_color_block_heading"><?php echo $entry_backgorund_color_block_heading; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[backgorund_color_block_heading]" value="<?php echo $phpner_fastorder_data['backgorund_color_block_heading']; ?>" placeholder="<?php echo $entry_backgorund_color_block_heading; ?>" id="input-backgorund_color_block_heading" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-text_color_block_heading"><?php echo $entry_text_color_block_heading; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[text_color_block_heading]" value="<?php echo $phpner_fastorder_data['text_color_block_heading']; ?>" placeholder="<?php echo $entry_text_color_block_heading; ?>" id="input-text_color_block_heading" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-backgorund_color_block_body"><?php echo $entry_backgorund_color_block_body; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[backgorund_color_block_body]" value="<?php echo $phpner_fastorder_data['backgorund_color_block_body']; ?>" placeholder="<?php echo $entry_backgorund_color_block_body; ?>" id="input-backgorund_color_block_body" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-text_color_block_body"><?php echo $entry_text_color_block_body; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[text_color_block_body]" value="<?php echo $phpner_fastorder_data['text_color_block_body']; ?>" placeholder="<?php echo $entry_text_color_block_body; ?>" id="input-text_color_block_body" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-backgorund_color_remove_button"><?php echo $entry_backgorund_color_remove_button; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[backgorund_color_remove_button]" value="<?php echo $phpner_fastorder_data['backgorund_color_remove_button']; ?>" placeholder="<?php echo $entry_backgorund_color_remove_button; ?>" id="input-backgorund_color_remove_button" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-text_color_remove_button"><?php echo $entry_text_color_remove_button; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[text_color_remove_button]" value="<?php echo $phpner_fastorder_data['text_color_remove_button']; ?>" placeholder="<?php echo $entry_text_color_remove_button; ?>" id="input-text_color_remove_button" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-backgorund_color_quantity_button"><?php echo $entry_backgorund_color_quantity_button; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[backgorund_color_quantity_button]" value="<?php echo $phpner_fastorder_data['backgorund_color_quantity_button']; ?>" placeholder="<?php echo $entry_backgorund_color_quantity_button; ?>" id="input-backgorund_color_quantity_button" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-text_color_quantity_button"><?php echo $entry_text_color_quantity_button; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[text_color_quantity_button]" value="<?php echo $phpner_fastorder_data['text_color_quantity_button']; ?>" placeholder="<?php echo $entry_text_color_quantity_button; ?>" id="input-text_color_quantity_button" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-backgorund_color_checkout_button"><?php echo $entry_backgorund_color_checkout_button; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[backgorund_color_checkout_button]" value="<?php echo $phpner_fastorder_data['backgorund_color_checkout_button']; ?>" placeholder="<?php echo $entry_backgorund_color_checkout_button; ?>" id="input-backgorund_color_checkout_button" class="form-control color" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-text_color_checkout_button"><?php echo $entry_text_color_checkout_button; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_fastorder_data[text_color_checkout_button]" value="<?php echo $phpner_fastorder_data['text_color_checkout_button']; ?>" placeholder="<?php echo $entry_text_color_checkout_button; ?>" id="input-text_color_checkout_button" class="form-control color" />
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" tabindex="-1" role="dialog" id="add-fields-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<form class="form-horizontal" method="POST" action="javascript:;" id="add-fields-form">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title"><?php echo $text_dop_filds; ?></h4>
				</div>
				<div class="modal-body">
					<div class="form-group required">
						<label class="col-sm-3 control-label"><?php echo $entry_name; ?></label>
						<div class="col-sm-9">
							<?php foreach ($languages as $language) { ?>
								<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
									<input type="text" name="custom_field_description[<?php echo $language['language_id']; ?>][name]" value="" placeholder="<?php echo $entry_name; ?>" class="form-control" />
								</div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-location"><?php echo $entry_location; ?></label>
						<div class="col-sm-9">
							<select name="location" id="input-location" class="form-control">
								<option value="account"><?php echo $text_account; ?></option>
								<option value="address"><?php echo $text_address; ?></option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-type"><?php echo $entry_type; ?></label>
						<div class="col-sm-9">
							<select name="type" id="input-type" class="form-control">
								<optgroup label="<?php echo $text_input; ?>">
									<option value="text"><?php echo $text_text; ?></option>
									<option value="textarea"><?php echo $text_textarea; ?></option>
								</optgroup>
								<optgroup label="<?php echo $text_choose; ?>">
									<option value="select"><?php echo $text_select; ?></option>
									<option value="radio"><?php echo $text_radio; ?></option>
									<option value="checkbox"><?php echo $text_checkbox; ?></option>
								</optgroup>
								<optgroup label="<?php echo $text_file; ?>">
									<option value="file"><?php echo $text_file; ?></option>
								</optgroup>
								<optgroup label="<?php echo $text_date; ?>">
									<option value="date"><?php echo $text_date; ?></option>
									<option value="time"><?php echo $text_time; ?></option>
									<option value="datetime"><?php echo $text_datetime; ?></option>
								</optgroup>
							</select>
						</div>
					</div>
					<div class="form-group" id="display-value">
						<label class="col-sm-3 control-label" for="input-value"><?php echo $entry_value; ?></label>
						<div class="col-sm-9">
							<input type="text" name="value" value="" placeholder="<?php echo $entry_value; ?>" id="input-value" class="form-control" />
						</div>
					</div>
					<div class="form-group" id="display-validation">
						<label class="col-sm-3 control-label" for="input-validation"><span data-toggle="tooltip" title="<?php echo $help_regex; ?>"><?php echo $entry_validation; ?></span></label>
						<div class="col-sm-9">
							<input type="text" name="validation" id="input-validation" value="" placeholder="<?php echo $text_regex; ?>"  class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><?php echo $entry_customer_group; ?></label>
						<div class="col-sm-9">
							<?php $customer_group_row = 0; ?>
							<?php foreach ($customer_groups as $customer_group) { ?>
								<div class="checkbox">
									<label>
										<input type="checkbox" name="custom_field_customer_group[<?php echo $customer_group_row; ?>][customer_group_id]" value="<?php echo $customer_group['customer_group_id']; ?>" />
										<?php echo $customer_group['name']; ?>
									</label>
								</div>
								<?php $customer_group_row++; ?>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><?php echo $entry_required; ?></label>
						<div class="col-sm-9">
							<?php $customer_group_row = 0; ?>
							<?php foreach ($customer_groups as $customer_group) { ?>
								<div class="checkbox">
									<label>
										<input type="checkbox" name="custom_field_customer_group[<?php echo $customer_group_row; ?>][required]" value="<?php echo $customer_group['customer_group_id']; ?>" />
										<?php echo $customer_group['name']; ?>
									</label>
								</div>
								<?php $customer_group_row++; ?>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-9">
							<select name="status" id="input-status" class="form-control">
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-sort-order"><span data-toggle="tooltip" title="<?php echo $help_sort_order; ?>"><?php echo $entry_sort_order; ?></span></label>
						<div class="col-sm-9">
							<input type="text" name="sort_order" value="" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
						</div>
					</div>
					<table id="custom-field-value" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<td class="text-left required"><?php echo $entry_custom_value; ?></td>
								<td class="text-right"><?php echo $entry_sort_order; ?></td>
								<td></td>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<td colspan="2"></td>
								<td class="text-left"><button id="addCustomFieldValue" type="button" data-toggle="tooltip" title="<?php echo $button_custom_field_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<div class="modal-footer">
					<i class="fa fa-circle-o-notch fa-spin add-redirect-loading hidden"></i>
					<button type="button" class="btn btn-warning" data-dismiss="modal"><?php echo $button_cancel; ?></button>
					<button type="button" id="addCustomerField" class="btn btn-primary"><?php echo $button_create; ?></button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript"><!--
$(function(){
	$('select[name=\'type\']').on('change', function() {
		if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox') {
			$('#custom-field-value').show();
			$('#display-value, #display-validation').hide();
		} else {
			$('#custom-field-value').hide();
			$('#display-value, #display-validation').show();
		}
		
		if (this.value == 'date') {
			$('#display-value > div').html('<div class="input-group date"><input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" data-date-format="YYYY-MM-DD" id="input-value" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div>');
		} else if (this.value == 'time') {
			$('#display-value > div').html('<div class="input-group time"><input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" data-date-format="HH:mm" id="input-value" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div>');
		} else if (this.value == 'datetime') {
			$('#display-value > div').html('<div class="input-group datetime"><input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-value" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div>');
		} else if (this.value == 'textarea') {
			$('#display-value > div').html('<textarea name="value" placeholder="<?php echo $entry_value; ?>" id="input-value" class="form-control">' + $('#input-value').val() + '</textarea>');
		} else {
			$('#display-value > div').html('<input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" id="input-value" class="form-control" />');
		}
		
		$('.date').datetimepicker({
			pickTime: false
		});
		
		$('.time').datetimepicker({
			pickDate: false
		});	
			
		$('.datetime').datetimepicker({
			pickDate: true,
			pickTime: true
		});
	});

	$('select[name=\'type\']').trigger('change');
});
$(document).ready(function() {
	var custom_field_value_row = 0;
	
	$("#addCustomFieldValue").click(function(){
		html  = '<tr id="custom-field-value-row' + custom_field_value_row + '">';	
		html += '  <td class="text-left" style="width: 70%;"><input type="hidden" name="custom_field_value[' + custom_field_value_row + '][custom_field_value_id]" value="" />';
		<?php foreach ($languages as $language) { ?>
		html += '    <div class="input-group">';
		html += '      <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><input type="text" name="custom_field_value[' + custom_field_value_row + '][custom_field_value_description][<?php echo $language['language_id']; ?>][name]" value="" placeholder="<?php echo $entry_custom_value; ?>" class="form-control" />';
		html += '    </div>';
		<?php } ?>
		html += '  </td>';
		html += '  <td class="text-right"><input type="text" name="custom_field_value[' + custom_field_value_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
		html += '  <td class="text-left"><button type="button" onclick="$(\'#custom-field-value-row' + custom_field_value_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
		html += '</tr>';	
		
		$('#custom-field-value tbody').append(html);
		
		custom_field_value_row++;
	});
	
	$('#addCustomerField').click(function(){
		$.ajax({
			url: 'index.php?route=extension/module/phpner_fastorder/addCustomerField&token=<?php echo $token; ?>',
			type: 'post',
			data: $("#add-fields-form").serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('#addCustomerField').attr('disabled', 'disabled');
				$('#addCustomerField').button('loading');
			},
			complete: function() {
				$('#addCustomerField').button('reset');
				$('#addCustomerField').removeAttr('disabled');
			},
			success: function(json) {
				if(json['success']) {
					html = '<tr>';
					html += '<td class="text-left">'+ json['success']['name'] +'</td>';
					html += '<td class="text-left">'+ json['success']['location'] +'</td>';
					html += '<td class="text-left">'+ json['success']['type'] +'</td>';
					html += '<td class="text-right">'+ json['success']['sort_order'] +'</td>';
					html += '</tr>';
					
					$('#dop_fields_table tbody').append(html);
					
					$("#add-fields-form").trigger("reset");
					$("#add-fields-modal").modal("hide");
				}
				
				if(json['error']) {					
					if (json['error']['name']) {
						$.each(json['error']['name'], function(i, val) {
							$("#add-fields-modal").find('[name="custom_field_description[' + i + '][name]"]').parent().parent().parent().addClass('has-error');
							$("#add-fields-modal").find('[name="custom_field_description[' + i + '][name]"]').parent().parent().append('<div class="text-danger">'+ val +'</div>');
						});
					}
					
					if (json['error']['custom_field_value']) {
						$.each(json['error']['custom_field_value'], function(i, val) {
							$("#add-fields-modal").find('[name="custom_field_value[' + i + '][custom_field_value_description]['+ val +'][name]"]').parent().addClass('has-error');
						});
					}
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
});
//--></script>

<script type="text/javascript">
  $(function(){
    $('input.color').minicolors();
  });
</script>
<script type="text/javascript"><!--
$('select[name*=\'default_country\']').on('change', function() {
  $.ajax({
    url: 'index.php?route=extension/module/phpner_fastorder/country&token=<?php echo $token; ?>&country_id=' + this.value,
    dataType: 'json',
    beforeSend: function() {
      $('select[name*=\'default_country\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
    },
    complete: function() {
      $('.fa-spin').remove();
    },
    success: function(json) {
      html = '<option value=""><?php echo $text_select; ?></option>';

      if (json['zone'] && json['zone'] != '') {
        for (i = 0; i < json['zone'].length; i++) {
                html += '<option value="' + json['zone'][i]['zone_id'] + '"';

          if (json['zone'][i]['zone_id'] == "<?php echo $phpner_fastorder_data['default_region']; ?>") {
                  html += ' selected="selected"';
          }

          html += '>' + json['zone'][i]['name'] + '</option>';
        }
      } else {
        html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
      }

      $('select[name*=\'default_region\']').html(html);
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

$('select[name*=\'default_country\']').trigger('change');
//--></script>
<style>
	@media (min-width: 768px) {
		.modal-dialog{width:70%;}
	}
</style>
<?php echo $footer; ?>