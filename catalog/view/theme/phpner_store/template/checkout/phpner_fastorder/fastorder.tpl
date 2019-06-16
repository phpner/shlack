<?php echo $header; ?>
<div class="container">
	<div class="col-sm-12  content-row">
		<div class="breadcrumb-box">
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
				<?php if($count == 0) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } elseif($count+1<count($breadcrumbs)) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } else { ?>
				<li><span><?php echo $breadcrumb['text']; ?></span></li>
				<?php } ?>
				<?php } ?>
			</ul>
		</div>
		<?php echo $content_top; ?>
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
			<script type="text/javascript">$(function(){$('#button-go').attr('disabled', 'disabled');$('#button-go').addClass('disabled');});</script>
		<?php } ?>
		<div class="row">
			<div class="col-sm-12">
				<h1 class="cat-header"><?php echo $heading_title; ?></h1>
			</div>
		</div>
		<div class="row">
			<?php echo $column_left; ?>
			<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
			<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-9'; ?>
			<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
			<?php } ?>
			<div id="content" class="<?php echo $class; ?>">
				<div class="phpner_-checkout-content">
					<?php if (!isset($address)) {?>
					<div class="row">
						<div class="col-md-12">
							<div class="well login-checkout">
								<div id="show-login">
									<p class="registered-text"><?php echo $text_i_am_returning_customer; ?></p>
									<p class="registered-button"><a class="phpner_-button" onclick="get_phpner_popup_login();" ><?php echo $heading_login_block; ?></a></p>
								</div>
							</div>
						</div>
					</div>
					<?php } ?>
					<div class="row checkout_form">
						<?php $key_step = 0;?>
						<?php if (isset($phpner_fastorder_data['cart_view_is']) && $phpner_fastorder_data['cart_view_is'] == 1) { ?>
						<?php $key_step++; ?>
						<div class="col-sm-12 checkout_form-first-div">
							<div class="panel-group fastorder-panel-group" id="cart-table">
								<div class="panel panel-default fastorder-panel-default">
									<div class="panel-heading">
										<h4 class="panel-title phpner_-fastorder-header"><span><?php echo $key_step; ?></span><?php echo $heading_cart_block; ?> <?php echo $weight; ?></h4>
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
											<?php } ?>
											<div class="phpner_-bottom-cart-box">
												<div class="table-responsive">
													<table class="table">
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
												<div class="phpner_-bottom-cart-total-cart">
													<?php foreach ($totals as $total) { ?>
													<div class="total-text"><?php echo $total['title']; ?>: <span><?php echo $total['text']; ?></span></div>
													<?php } ?>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<?php } ?>
						<div class="clearfix"></div>
						<?php $key_step++; ?>
						<div class="col-md-12 register_block">
							<div class="panel panel-default fastorder-panel-default">
								<div class="phpner_-fastorder-header"><span><?php echo $key_step; ?></span><?php echo $heading_user_block; ?></div>
								<div class="panel-body">
									<?php if ($phpner_fastorder_data['customer_groups'] == 1 && $customer_groups) { ?>
										<div class="form-group">
											<label class="control-label"><?php echo $entry_customer_group; ?></label>
											<?php foreach ($customer_groups as $customer_group) { ?>
											<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
											<div class="radio">
												<label><input type="radio"  name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" /><?php echo $customer_group['name']; ?></label>
											</div>
											<?php } else { ?>
											<div class="radio">
												<label><input type="radio" checked="checked" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" /><?php echo $customer_group['name']; ?></label>
											</div>
											<?php } ?>
											<?php } ?>
										</div>
									<?php } else { ?>
										<input type="hidden" name="customer_group_id" value="<?php echo $customer_group_id; ?>" />
									<?php } ?>
									<div class="row">
										<div class="form-group required col-md-12">
											<label class="control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?></label>
											<input type="text" name="firstname" value="<?php if (isset($address['firstname'])) echo $address['firstname']; elseif (isset($firstname)) echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-payment-firstname" class="form-control" />
										</div>
										<?php if ($phpner_fastorder_data['lastname'] == 1) { ?>  
											<div class="form-group required col-md-12">
												<label class="control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
												<input type="text" name="lastname" value="<?php if (isset($address['lastname'])) echo $address['lastname']; elseif (isset($lastname)) echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-payment-lastname" class="form-control" />
											</div>
										<?php } else { ?>
											<input type="hidden" name="lastname" value="" />
										<?php } ?>
										<?php if ($phpner_fastorder_data['email'] == 2) { ?>
											<div class="form-group required col-md-12">
												<label class="control-label" for="input-payment-email"><?php echo $entry_email; ?></label>
												<input type="text" name="email" value="<?php echo (isset($email_user)) ? $email_user : $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-payment-email" class="form-control" />
											</div>
										<?php } elseif ($phpner_fastorder_data['email'] == 1) { ?>
											<div class="form-group col-md-12">
												<label class="control-label" for="input-payment-email"><?php echo $entry_email; ?></label>
												<input type="text" name="email" value="<?php echo (isset($email_user)) ? $email_user : $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-payment-email" class="form-control" />
											</div>
										<?php } else { ?>
											<input type="hidden" name="email" value="<?php echo $phpner_fastorder_data['notify_email']; ?>" />
										<?php } ?>
										<div class="form-group required col-md-12" <?php if (isset($customer_id)) {?>style="display:none;"<?php }?>>
											<label class="control-label" for="input-payment-telephone"><?php echo $entry_telephone; ?></label>
											<input type="text" name="telephone" value="<?php echo (isset($telephone_user)) ? $telephone_user : $telephone ;?>" placeholder="<?php echo $entry_telephone; ?>" id="input-payment-telephone" class="form-control"/>
										</div>
										<?php if ($phpner_fastorder_data['fax'] == 1) { ?>  
											<div class="form-group col-md-12" >
												<label class="control-label" for="input-payment-fax"><?php echo $entry_fax; ?></label>
												<input type="text" name="fax" value="<?php if (isset($fax)) echo $fax;?>" placeholder="<?php echo $entry_fax; ?>" id="input-payment-fax" class="form-control"  />
											</div>
										<?php } else { ?>
											<input type="hidden" name="fax" value="" />
										<?php } ?>
										<?php if (isset($custom_fields)) { ?>
											<?php foreach ($custom_fields as $custom_field) { ?>
												<?php if ($custom_field['location'] == 'account') { ?>
													<?php if ($custom_field['type'] == 'select') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
																	<option value=""><?php echo $text_select; ?></option>
																	<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																	<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
																	<?php } ?>
																</select>
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'radio') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
																	<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																	<div class="radio">
																		<label>
																		<input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
																		<?php echo $custom_field_value['name']; ?></label>
																	</div>
																	<?php } ?>
																</div>
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'checkbox') { ?>
													<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
														<label class="control-label"><?php echo $custom_field['name']; ?></label>
														<div class="">
															<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
																<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																<div class="checkbox">
																	<label>
																	<input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
																	<?php echo $custom_field_value['name']; ?></label>
																</div>
																<?php } ?>
															</div>
														</div>
													</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'text') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'textarea') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'file') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
																<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'date') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<input type="date" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'datetime') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<input type="datetime-local" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
															</div>
														</div>
													<?php } ?>
													<?php if ($custom_field['type'] == 'time') { ?>
														<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
															<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
															<div class="">
																<input type="time" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
															</div>
														</div>
													<?php } ?>
												<?php } ?>
											<?php } ?>
										<?php } ?>
										<?php if ($addresses) { ?>
											<?php if (isset($customer_id)) { ?>	  
												<div class="col-md-12" >
													<div class="radio"><label><input type="radio" name="payment_address" value="existing" checked="checked" onclick="$('#payment-address-new').hide()" /><?php echo $text_address_existing_payment; ?></label></div>
													<div id="payment-existing">
														<select name="payment_address_id" class="form-control">
															<?php foreach ($addresses as $address) { ?>
															<?php if (isset($payment_address_id) && $address['address_id'] == $payment_address_id) { ?>
															<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
															<?php } else { ?>
															<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
															<?php } ?>
															<?php } ?>
														</select>
													</div>
													<div class="radio" style="display:none;"><label><input type="radio" name="payment_address" value="new" onclick="$('#payment-address-new').show();"/><?php echo $text_address_new; ?></label></div>
												</div>
											<?php } ?>
										<?php } ?>
										<div id="payment-address-new" <?php if (isset($customer_id) && $addresses) { ?>style="display:none"<?php }?>>
											<?php if ($phpner_fastorder_data['company'] == 1) { ?>  
												<div class="form-group col-md-12">
													<label class="control-label" for="input-payment-company"><?php echo $entry_company; ?></label>
													<input type="text" name="company" value="<?php if (isset($company)) echo $company;?>" placeholder="<?php echo $entry_company; ?>" id="input-payment-company" class="form-control" />
												</div>
											<?php } else { ?>
												<input type="hidden" name="company" value="" />
											<?php } ?>
											<input type="hidden" name="company_id" value="" />
											<input type="hidden" name="tax_id" value="" />
											<?php if ($phpner_fastorder_data['address_1'] == 1 or $phpner_fastorder_data['address_1'] == 2) { ?>
												<div class="form-group <?php if ($phpner_fastorder_data['address_1'] == 2) { ?>required<?php } ?> col-md-12">
													<label class="control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
													<input type="text" name="address_1" value="<?php if (isset($address_1)) echo $address_1;?>" placeholder="<?php echo $entry_address_1; ?>" id="input-payment-address-1" class="form-control" />
												</div>
											<?php } else { ?>
												<input type="hidden" name="address_1" value="" />
											<?php } ?>
											<?php if ($phpner_fastorder_data['address_2'] == 1 or $phpner_fastorder_data['address_2'] == 2) { ?>
												<div class="form-group <?php if ($phpner_fastorder_data['address_2'] == 2) { ?>required<?php } ?> col-md-12">
													<label class="control-label" for="input-payment-address-2"><?php echo $entry_address_2; ?></label>
													<input type="text" name="address_2" value="<?php if (isset($address_2)) echo $address_2;?>" placeholder="<?php echo $entry_address_2; ?>" id="input-payment-address-2" class="form-control" />
												</div>
											<?php } else { ?>
												<input type="hidden" name="address_2" value="" />
											<?php } ?>
											<?php if ($phpner_fastorder_data['country_and_region'] == 1 or $phpner_fastorder_data['country_and_region'] == 2) { ?>
												<div class="form-group <?php if ($phpner_fastorder_data['country_and_region'] == 2) { ?>required<?php } ?> col-md-6">
													<label class="control-label" for="input-payment-country"><?php echo $entry_country; ?></label>
													<select name="country_id" id="input-payment-country" class="form-control">
														<option value=""><?php echo $text_select; ?></option>
														<?php foreach ($countries as $country) { ?>
															<?php if ($country['country_id'] == $country_id) { ?>
																<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
															<?php } else { ?>
																<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
															<?php } ?>
														<?php } ?>
													</select>
												</div>
												<div class="form-group required col-md-6">
													<label class="control-label" for="input-payment-zone"><?php echo $entry_zone;; ?></label>
													<select name="zone_id" id="input-payment-zone" class="form-control"></select>
												</div>
											<?php } else { ?>
												<select name="country_id" style="display: none;">
													<option value="<?php echo $phpner_fastorder_data['default_country']; ?>" selected="selected"></option>
												</select>
												<select name="zone_id" style="display: none;"></select>
											<?php } ?>
											<?php if ($phpner_fastorder_data['city'] == 1 or $phpner_fastorder_data['city'] == 2) { ?>
												<div class="form-group <?php if ($phpner_fastorder_data['city'] == 2) { ?>required<?php } ?> col-md-12">
													<label class="control-label" for="input-payment-city"><?php echo $entry_city; ?></label>
													<input type="text" name="city" value="<?php if (isset($city) and !empty($city)) { echo $city; } elseif(isset($phpner_fastorder_data['default_city']) and !empty($phpner_fastorder_data['default_city'])){ echo $phpner_fastorder_data['default_city']; } ?>" placeholder="<?php echo $entry_city; ?>" id="input-payment-city" class="form-control" />
												</div>
											<?php } else { ?>
												<input type="hidden" name="city" value="<?php echo $phpner_fastorder_data['default_city']; ?>" />
											<?php } ?>
											<?php if ($phpner_fastorder_data['postcode'] == 1) { ?>
												<div class="form-group col-md-12">
													<label class="control-label" for="input-payment-postcode"><?php echo $entry_postcode; ?></label>
													<input type="text" name="postcode" value="<?php if (isset($postcode)) echo $postcode;?>" placeholder="<?php echo $entry_postcode; ?>" id="input-payment-postcode" class="form-control" />
												</div>
											<?php } else { ?>
												<input type="hidden" name="postcode" value="" />
											<?php } ?>
											<?php if (isset($custom_fields)) { ?>
												<?php foreach ($custom_fields as $custom_field) { ?>
													<?php if ($custom_field['location'] == 'address') { ?>
														<?php if ($custom_field['type'] == 'select') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
																		<option value=""><?php echo $text_select; ?></option>
																		<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																		<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
																		<?php } ?>
																	</select>
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'radio') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
																		<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																		<div class="radio">
																			<label>
																			<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
																			<?php echo $custom_field_value['name']; ?></label>
																		</div>
																		<?php } ?>
																	</div>
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'checkbox') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
																		<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																		<div class="checkbox">
																			<label>
																			<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
																			<?php echo $custom_field_value['name']; ?></label>
																		</div>
																		<?php } ?>
																	</div>
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'text') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'textarea') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'file') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
																	<input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'date') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="date" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'datetime') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="datetime-local" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
														<?php } ?>
														<?php if ($custom_field['type'] == 'time') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="time" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
														<?php } ?>
													<?php } ?>
												<?php } ?>
											<?php } ?>
										</div>
										<?php if ($shipping_required) { ?>
										<div class="col-sm-12">
											<?php if (!isset($customer_id)) {?>
											<div class="form-group"  style="display:none;">
												<label><input type="checkbox" name="shipping_address" value="new" <?php if (isset($address_id)) echo 'checked="checked"';?> onclick="$('.shipping-address').toggle()"> <?php echo $text_address_new; ?></label>
											</div>
											<?php } ?>
											<div class="shipping-address" <?php if (isset($shipping_address_id) || isset($customer_id)) echo 'style="display:block"'; else echo 'style="display:none"'; ?>>
												<?php if ($addresses) { ?>
												<?php if (isset($customer_id)) { ?>	  
												<div class="radio"><label><input type="radio" name="shipping_address" value="existing" checked="checked" onclick="$('#shipping-new').hide()" /><?php echo $text_address_existing_shipping; ?></label></div>
												<div id="shipping-existing">
													<select name="shipping_address_id" class="form-control">
														<?php foreach ($addresses as $address) { ?>
														<?php if (isset($shipping_address_id) && $address['address_id'] == $shipping_address_id) { ?>
														<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
														<?php } ?>
														<?php } ?>
													</select>
												</div>
												<?php } ?>
												<?php if (isset($customer_id)) { ?>	  
												<div class="radio" style="display:none;"><label><input type="radio" name="shipping_address" value="new" onclick="$('#shipping-new').show();"/><?php echo $text_address_new; ?></label></div>
												<?php } ?>
												<?php } ?>
												<div id="shipping-new" style="display: <?php echo (($addresses && isset($customer_id)) ? 'none' : 'block'); ?>;">
													<div class="phpner_-fastorder-header"><?php echo $text_shipping_arderss; ?></div>
													<div class="form-group required">
														<label class="control-label" for="input-shipping-firstname"><?php echo $entry_firstname; ?></label>
														<div class="">
															<input type="text" name="shipping_firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-shipping-firstname" class="form-control" />
														</div>
													</div>
													<?php if ($phpner_fastorder_data['lastname'] == 1) { ?>
													<div class="form-group required">
														<label class="control-label" for="input-shipping-lastname"><?php echo $entry_lastname; ?></label>
														<div class="">
															<input type="text" name="shipping_lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-shipping-lastname" class="form-control" />
														</div>
													</div>
													<?php } else { ?>
														<input type="hidden" name="shipping_lastname" value="" />
													<?php } ?>
													<?php if ($phpner_fastorder_data['company'] == 1) { ?>
													<div class="form-group" >
														<label class="control-label" for="input-shipping-company"><?php echo $entry_company; ?></label>
														<div class="">
															<input type="text" name="shipping_company" value="" placeholder="<?php echo $entry_company; ?>" id="input-shipping-company" class="form-control" />
														</div>
													</div>
													<?php } else { ?>
													<input type="hidden" name="shipping_company" value="" />
													<?php } ?>
													<?php if ($phpner_fastorder_data['address_1'] == 1 or $phpner_fastorder_data['address_1'] == 2) { ?>
													<div class="form-group <?php if ($phpner_fastorder_data['address_1'] == 2) { ?>required<?php } ?>">
														<label class="control-label" for="input-shipping-address-1"><?php echo $entry_address_1; ?></label>
														<div class="">
															<input type="text" name="shipping_address_1" value="" placeholder="<?php echo $entry_address_1; ?>" id="input-shipping-address-1" class="form-control" />
														</div>
													</div>
													<?php } else { ?>
													<input type="hidden" name="shipping_address_1" value="" />
													<?php } ?>
													<?php if ($phpner_fastorder_data['address_2'] == 1 or $phpner_fastorder_data['address_2'] == 2) { ?>
													<div class="form-group <?php if ($phpner_fastorder_data['address_2'] == 2) { ?>required<?php } ?>">
														<label class="control-label" for="input-shipping-address-2"><?php echo $entry_address_2; ?></label>
														<div class="">
															<input type="text" name="shipping_address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="input-shipping-address-2" class="form-control" />
														</div>
													</div>
													<?php } else { ?>
													<input type="hidden" name="shipping_address_2" value="" />
													<?php } ?>
													<?php if ($phpner_fastorder_data['city'] == 1 or $phpner_fastorder_data['city'] == 2) { ?>
													<div class="form-group <?php if ($phpner_fastorder_data['city'] == 2) { ?>required<?php } ?>">
														<label class="control-label" for="input-shipping-city"><?php echo $entry_city; ?></label>
														<div class="">
															<input type="text" name="shipping_city" value="" placeholder="<?php echo $entry_city; ?>" id="input-shipping-city" class="form-control" />
														</div>
													</div>
													<?php } else { ?>
													<input type="hidden" name="shipping_city" value="<?php echo $phpner_fastorder_data['default_city']; ?>" />
													<?php } ?>
													<?php if ($phpner_fastorder_data['postcode'] == 1) { ?>
													<div class="form-group">
														<label class="control-label" for="input-shipping-postcode"><?php echo $entry_postcode; ?></label>
														<div class="">
															<input type="text" name="shipping_postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-shipping-postcode" class="form-control" />
														</div>
													</div>
													<?php } else { ?>
													<input type="hidden" name="shipping_postcode" value="" />
													<?php } ?>
													<?php if ($phpner_fastorder_data['country_and_region'] == 1 or $phpner_fastorder_data['country_and_region'] == 2) { ?>
													<div class="form-group <?php if ($phpner_fastorder_data['country_and_region'] == 2) { ?>required<?php } ?>">
														<label class="control-label" for="input-shipping-country"><?php echo $entry_country; ?></label>
														<div class="">
															<select name="shipping_country_id" id="input-shipping-country" class="form-control">
																<option value=""><?php echo $text_select; ?></option>
																<?php foreach ($countries as $country) { ?>
																<?php if ($country['country_id'] == $country_id) { ?>
																<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
																<?php } else { ?>
																<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
																<?php } ?>
																<?php } ?>
															</select>
														</div>
													</div>
													<div class="form-group required">
														<label class="control-label" for="input-shipping-zone"><?php echo $entry_zone; ?></label>
														<div class="">
															<select name="shipping_zone_id" id="input-shipping-zone" class="form-control"></select>
														</div>
													</div>
													<?php } else { ?>
														<select name="shipping_country_id" style="display: none;">
															<option value="<?php echo $phpner_fastorder_data['default_country']; ?>" selected="selected"></option>
														</select>
														<select name="shipping_zone_id" style="display: none;"></select>
													<?php } ?>
													<?php if (isset($custom_fields)) { ?>
														<?php foreach ($custom_fields as $custom_field) { ?>
															<?php if ($custom_field['location'] == 'address') { ?>
															<?php if ($custom_field['type'] == 'select') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
																		<option value=""><?php echo $text_select; ?></option>
																		<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																		<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
																		<?php } ?>
																	</select>
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'radio') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
																		<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																		<div class="radio">
																			<label>
																			<input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
																			<?php echo $custom_field_value['name']; ?></label>
																		</div>
																		<?php } ?>
																	</div>
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'checkbox') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
																		<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
																		<div class="checkbox">
																			<label>
																			<input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
																			<?php echo $custom_field_value['name']; ?></label>
																		</div>
																		<?php } ?>
																	</div>
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'text') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'textarea') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'file') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
																	<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'date') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="date" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'datetime') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="datetime-local" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
															<?php } ?>
															<?php if ($custom_field['type'] == 'time') { ?>
															<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field col-md-12">
																<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
																<div class="">
																	<input type="time" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
																</div>
															</div>
															<?php } ?>
															<?php } ?>
														<?php } ?>
													<?php } ?>
												</div>
											</div>
										</div>
										<?php } ?>
										<?php if ($phpner_fastorder_data['comment'] == 1) { ?>
										<div class="form-group col-sm-12">
											<label class="control-label"><?php echo $text_comments; ?></label>
											<textarea name="comment" rows="3" class="form-control"><?php echo $comment; ?></textarea>
										</div>
										<?php } else { ?>
										<textarea name="comment" style="display:none;"></textarea>
										<?php } ?>
										<?php if (!isset($customer_id)) { ?>	
										<div class="form-group col-md-12" <?php if ($phpner_fastorder_data['registration'] != 1) { ?>style="display: none;"<?php } ?>>
											<label>
											<input type="checkbox" name="register" onclick="$('.register-form').toggle()">&nbsp;<?php echo $text_register; ?></label>
										</div>
										<?php } ?>  
										<div class="register-form" style="display: none;">
											<div class="form-group required col-md-6">
												<label class="control-label" for="input-payment-password"><?php echo $entry_password; ?></label>
												<input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-payment-password" class="form-control" />
											</div>
											<div class="form-group required col-md-6">
												<label class="control-label" for="input-payment-confirm"><?php echo $entry_confirm; ?></label>
												<input type="password" name="confirm" value="" placeholder="<?php echo $entry_confirm; ?>" id="input-payment-confirm" class="form-control" />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<?php $key_step++; ?>
						<div class="col-md-12">
							<?php //if ($shipping_required) { ?>
							<div class="panel panel-default fastorder-panel-default">
								<div class="phpner_-fastorder-header"><span><?php echo $key_step;?></span><?php echo $heading_shipping_block; ?></div>
								<div class="panel-body shipping-method">
									<?php if ($error_warning) { ?>
									<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
									<?php } ?>
									<?php if ($shipping_methods) { ?>
									<p><?php echo $text_shipping_method; ?></p>
									<?php foreach ($shipping_methods as $shipping_method) { ?>
									<p><strong><?php echo $shipping_method['title']; ?></strong></p>
									<?php if (!$shipping_method['error']) { ?>
									<?php foreach ($shipping_method['quote'] as $quote) { ?>
									<div class="radio">
										<label>
										<?php if ($quote['code'] == $code || !$code) { ?>
										<?php $code = $quote['code']; ?>
										<input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>"  title="<?php echo $quote['title']; ?>" checked="checked" />
										<?php } else { ?>
										<input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>"  title="<?php echo $quote['title']; ?>" />
										<?php } ?>
										<?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
									</div>
									<?php } ?>
									<?php } else { ?>
									<div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
									<?php } ?>
									<?php } ?>
									<?php } ?>
								</div>
							</div>
							<?php //} ?>
							<?php $key_step++; ?>
							<div class="panel panel-default fastorder-panel-default">
								<div class="phpner_-fastorder-header"><span><?php echo $key_step; ?></span><?php echo $heading_payment_block; ?></div>
								<div class="panel-body payment-method">
									<?php if ($error_warning) { ?>
									<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
									<?php } ?>
									<?php if ($payment_methods) { ?>
									<p><?php echo $text_payment_method; ?></p>
									<?php foreach ($payment_methods as $payment_method) { ?>
									<div class="radio">
										<label>
										<?php if ($payment_method['code'] == $code || !$code) { ?>
										<?php $code = $payment_method['code']; ?>
										<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" title="<?php echo $payment_method['title']; ?>" checked="checked" />
										<?php } else { ?>
										<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" title="<?php echo $payment_method['title']; ?>" />
										<?php } ?>
										<?php echo $payment_method['title']; ?>
										</label>
									</div>
									<?php } ?>
									<?php } ?>
								</div>
							</div>
						</div>
						<?php if ($modules) { ?>
						<?php $key_step++; ?>
						<div class="col-sm-12 phpner_-fastorder-next-choice">
							<div class="phpner_-fastorder-header"><span><?php echo $key_step; ?></span><?php echo $text_next; ?></div>
							<p><?php echo $text_next_choice; ?></p>
							<div class="panel-group fastorder-panel-group" id="accordion">
								<?php foreach ($modules as $module) { ?>
								<?php echo $module; ?>
								<?php } ?>
							</div>
						</div>
						<?php } ?>
						<?php if ($text_agree) { ?>
						<div class="col-sm-12" id="agree-block" style="margin-bottom:10px;">
							<div class="text-left">
								<?php if ($agree) { ?>
								<input type="checkbox" name="agree" value="1" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="agree" value="1" />
								<?php } ?>
								&nbsp;<?php echo $text_agree; ?>
							</div>
							<div class="clearfix"></div>
						</div>
						<?php } ?>
						<?php if ($text_payment_agree) { ?>
						<div class="col-sm-12" id="payment_agree-block" style="margin-bottom:10px;">
							<div class="text-left">
								<?php if ($payment_agree) { ?>
								<input type="checkbox" name="payment_agree" value="1" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="payment_agree" value="1" />
								<?php } ?>
								&nbsp;<?php echo $text_payment_agree; ?>
							</div>
							<div class="clearfix"></div>
						</div>
						<?php } ?>
						<div style="display:none;">
							<div id="popup-terms-block" class="size-popup">
								<button type="button" class="mfp-close">×</button>
								<div></div>
							</div>
						</div>
						<div class="col-sm-12 phpner_-fastorder-payment text-left">
							<?php if (isset($payment) && $payment) {?>
							<p><?php $payment; ?></p>
							<?php } else { ?>
							<input type="button" class="phpner_-button" id="button-go" value="<?php echo $button_checkout;?>" />
							<?php } ?>
						</div>
					</div>
				</div>
				<?php echo $content_bottom; ?>
			</div>
			<?php echo $column_right; ?>
		</div>
	</div>
</div>
<?php if ($text_agree || $text_payment_agree) { ?>
<script>
$(document).delegate('#open-popup-terms', 'click', function(e) {
  e.preventDefault();

  $('#modal-agree').remove();

  var element = this;

  $.ajax({
   url: $(element).attr('href'),
   type: 'get',
   dataType: 'html',
   success: function(data) {
	$.magnificPopup.open({
	   items: {
		 src:  '<div id="service-popup" class="white-popup mfp-with-anim narrow-popup">'+
								'<h2 class="popup-header">' + $(element).text() + '</h2>'+
								'<div class="popup-text">'+
									'<p>' + data + '</p>'+
								'</div>'+
							'</div>',
			type: 'inline'
	   },
	   showCloseBtn: true
	 });
   }
 });
});
</script>
<?php } ?>
<?php if ($mask) { ?>
<script src="catalog/view/theme/phpner_store/js/input-mask.js"></script>
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
 
if( !isMobile.Android() ) {
  $(".checkout_form input[name=\'telephone\']").inputmask('<?php echo $mask; ?>');
}
</script>
<?php } ?>
<script><!--
var error = true;
// Login
$(document).delegate('#button-login', 'click', function() {
  $.ajax({
	url: 'index.php?route=checkout/phpner_fastorder/login_validate',
	type: 'post',
	data: $('.login-form :input'),
	dataType: 'json',
	beforeSend: function() {
		$('#button-login').button('loading');
		},  
	complete: function() {
	   $('#button-login').button('reset');
	},              
	success: function(json) {
	  $('.alert, .text-danger').remove();
		
	  if (json['redirect']) {
		location = json['redirect'];
	  } else if (json['error']) {
		$('.login-form .message').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	  }
	},
	error: function(xhr, ajaxOptions, thrownError) {
	  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
  }); 
});

// Register
$(document).delegate('#button-go', 'click', function() {
	var data = $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select').serialize();
	data += '&_shipping_method='+ $('.checkout_form input[name=\'shipping_method\']:checked').prop('title') + '&_payment_method=' + $('.checkout_form input[name=\'payment_method\']:checked').prop('title');
	
  $.ajax({
	url: 'index.php?route=checkout/phpner_fastorder/validate_form',
	type: 'post',
	data: data,
	dataType: 'json',
	beforeSend: function() {
			$('#button-go').button('loading');
		},  
	complete: function() {
	  $('#button-go').button('reset');
	},          
	success: function(json) {
	  $('.alert, .text-danger').remove();
	  $('.register_block input, .register_block select').css({'background':'#ffffff'});
	  $('.register_block input, .register_block select').parent().removeClass('has-error');      

	  if (json['redirect']) {
		location = json['redirect'];                
	  } else if (json['error']) {
			$('html, body').animate({
			  scrollTop: $('.register_block').offset().top,
			}, 1000);

			error = true;
		 
		if (json['error']['warning_agree']) {
			$('html, body').animate({
				  scrollTop: $('#agree-block').offset().top
				}, 1000);
			$('html, body').stop();
		  $('#agree-block').append('<div class="alert alert-danger">' + json['error']['warning_agree'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		}

		if (json['error']['warning_user_exist']) {
			$('html, body').animate({
				  scrollTop: $('.payment-method').offset().top
				}, 1000);
				$('html, body').stop();
		  $('.register_block').before('<div class="alert alert-danger">' + json['error']['warning_user_exist'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		}

		if (json['error']['warning_payment_agree']) {
			$('html, body').animate({
				  scrollTop: $('.payment-method').offset().top
				}, 1000);
			$('html, body').stop();
		  $('#payment_agree-block').append('<div class="alert alert-danger">' + json['error']['warning_payment_agree'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		}
		
		for (i in json['error']) {
			// $('[name="' + i + '"]').after('<div class="text-danger">' + json['error'][i] + '</div>');
			$('.checkout_form [name="' + i + '"]').css({'background':'#ffc0bf'});
			$('.checkout_form [name="' + i + '"]').parent().addClass('has-error');
		}
		
		if (json['error']['custom_field']) {
			for (i in json['error']['custom_field']) {
				// $('[name="' + i + '"]').after('<div class="text-danger">' + json['error'][i] + '</div>');
				$('.checkout_form [name="custom_field[' + i + ']"]').css({'background':'#ffc0bf'});
				$('.checkout_form [name="custom_field[' + i + ']"]').parent().addClass('has-error');
			}
		}
	  } else {
			error = false;
			$('[name=\'payment_method\']:checked').click();

	  }    
	},
	error: function(xhr, ajaxOptions, thrownError) {
	  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
  }); 
});

$('select[name=\'country_id\']').on('change', function() {
	$.ajax({
	url: 'index.php?route=checkout/phpner_fastorder/country&country_id=' + this.value,
	dataType: 'json',
	beforeSend: function() {
			$('select[name=\'country_id\']').after(' <i class="fa fa-spinner fa-spin"></i>');
	},
	complete: function() {
			$('.fa-spinner').remove();
	},          
	success: function(json) {
		<?php if ($phpner_fastorder_data['postcode'] == 1) { ?>
				if (json['postcode_required'] == '1') {
					$('input[name=\'postcode\']').parent().addClass('required');
				} else {
					$('input[name=\'postcode\']').parent().removeClass('required');
				}
			<?php } ?>       

	  html = '<option value=""><?php echo $text_select; ?></option>';
	  
	  if (json['zone'] && json['zone'] != '') {
		for (i = 0; i < json['zone'].length; i++) {
		  html += '<option value="' + json['zone'][i]['zone_id'] + '"';
		  
		  if (json['zone'][i]['zone_id'] == '<?php echo ($phpner_fastorder_data["country_and_region"] == 1) ? $zone_id : $phpner_fastorder_data["default_region"]; ?>') {
			html += ' selected="selected"';
		  }

		  html += '>' + json['zone'][i]['name'] + '</option>';
		}
	  } else {
		html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
	  }

	  <?php if ($phpner_fastorder_data["country_and_region"] == 1) { ?>
		$('select[name=\'zone_id\']').html(html).val('');
	  <?php } else { ?>
		$('select[name=\'zone_id\']').html(html);
		$('select[name=\'zone_id\']').trigger('change');
	  <?php } ?>
	  $('select[name=\'shipping_country_id\']').val('');
	},
	error: function(xhr, ajaxOptions, thrownError) {
	  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
  });
});

$('select[name=\'country_id\']').trigger('change');

$('select[name=\'shipping_country_id\']').on('change', function() {
	$.ajax({
	url: 'index.php?route=checkout/phpner_fastorder/country&country_id=' + this.value,
	dataType: 'json',
	beforeSend: function() {
			$('select[name=\'country_id\']').after(' <i class="fa fa-spinner fa-spin"></i>');
	},
	complete: function() {
			$('.fa-spinner').remove();
	},          
	success: function(json) {
		<?php if ($phpner_fastorder_data['postcode'] == 1) { ?>
				if (json['postcode_required'] == '1') {
					$('input[name=\'postcode\']').parent().addClass('required');
				} else {
					$('input[name=\'postcode\']').parent().removeClass('required');
				}
			<?php } ?> 
						
	  html = '<option value=""><?php echo $text_select; ?></option>';
	  
	  if (json['zone'] && json['zone'] != '') {
		for (i = 0; i < json['zone'].length; i++) {
		  html += '<option value="' + json['zone'][i]['zone_id'] + '"';
		  
		  if (json['zone'][i]['zone_id'] == '<?php echo ($phpner_fastorder_data["country_and_region"] == 1) ? $zone_id : $phpner_fastorder_data["default_region"]; ?>') {
			html += ' selected="selected"';
		  }

		  html += '>' + json['zone'][i]['name'] + '</option>';
		}
	  } else {
		html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
	  }
	  
	  <?php if ($phpner_fastorder_data["country_and_region"] == 1) { ?>
		$('select[name=\'shipping_zone_id\']').html(html).val('');
	  <?php } else { ?>
		$('select[name=\'shipping_zone_id\']').html(html);
	  <?php } ?>
	},
	error: function(xhr, ajaxOptions, thrownError) {
		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
  });
});

$('select[name=\'shipping_country_id\']').trigger('change');

$('select[name=\'country_id\'], select[name=\'zone_id\'], select[name=\'shipping_country_id\'], select[name=\'shipping_zone_id\'], input[type=\'radio\'][name=\'payment_address\'], input[type=\'radio\'][name=\'shipping_address\']').on('change', function() {
	
	if ($(this).attr("name") == 'country_id') {
		$("select[name=\'zone_id\']").val('');
	}
	
	if ($(this).attr("name") == 'shipping_country_id') {
		$("select[name=\'shipping_zone_id\']").val('');
	}
	
  $(".shipping-method").load('index.php?route=checkout/phpner_fastorder/shipping_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
		if ($("input[name=\'shipping_method\']:first").length) {
			$("input[name=\'shipping_method\']:first").attr('checked', 'checked').prop('checked', true).click();
		} else {
			$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
		}
  });

	$(".payment-method").load('index.php?route=checkout/phpner_fastorder/payment_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
		$('input[name=\'payment_method\']:first').attr('checked', 'checked').prop('checked', true).click();
	});
});    

<?php if (isset($customer_id)) { ?>
$(function(){
	$('select[name=\'shipping_address_id\']').trigger('change');
});

$('select[name=\'shipping_address_id\']').on('change', function() {
	$(".shipping-method").load('index.php?route=checkout/phpner_fastorder/shipping_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
		if ($("input[name=\'shipping_method\']:first").length) {
			$("input[name=\'shipping_method\']:first").attr('checked', 'checked').prop('checked', true).click();
		} else {
			$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
		}
  });
});
<?php } ?>

$('input[name=\'city\'], input[name=\'shipping_city\']').on('change', function() {
	$(".shipping-method").load('index.php?route=checkout/phpner_fastorder/shipping_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
		if ($("input[name=\'shipping_method\']:first").length) {
			$("input[name=\'shipping_method\']:first").attr('checked', 'checked').prop('checked', true).click();
		} else {
			$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
		}
  });
});

$(document).delegate('input[name=\'shipping_method\']', 'click', function() {
  $("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));
});  

$('body').delegate('input[name=\'payment_method\']','click', function() {
	var data = $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select').serialize();
	data += '&_shipping_method='+ $('.checkout_form input[name=\'shipping_method\']:checked').prop('title') + '&_payment_method=' + $('.checkout_form input[name=\'payment_method\']:checked').prop('title');

	if (!error) {
	$.ajax({
	  url: 'index.php?route=checkout/phpner_fastorder/confirm',
	  type: 'post',
	  data: data,
	  success: function(html) {
		$(".phpner_-fastorder-payment").html(html);
		if ($(".phpner_-fastorder-payment input[type=button]").length > 0) {
			$(".phpner_-fastorder-payment input[type=button]").click();
		}
		if ($(".phpner_-fastorder-payment input[type=submit]").length > 0) {
			$(".phpner_-fastorder-payment input[type=submit]").click();
		}
	  },
	  error: function(xhr, ajaxOptions, thrownError) {
		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	  }
	});
  }
});
$(document).ready(function() {
	$('input:radio[name=\'payment_method\']:first').attr('checked', true).prop('checked', true);
});
//-->
</script> 
<script><!--
function update(target, status) {
  var input_val    = $(target).parent().parent().children('input[name=quantity]').val(),
	  quantity     = parseInt(input_val),
	  product_id   = $(target).parent().parent().parent().children('input[name=product_id]').val(),
	  product_id_q = $(target).parent().parent().parent().children('input[name=product_id_q]').val(),
	  product_key  = $(target).parent().next().next().next().find('input[name=product_id]').val(),
	  urls         = null;

  if (quantity <= 0) {
	quantity = $(target).parent().parent().children('input[name=quantity]').val(1);
	return;
  }

  if (status == 'update') {
	urls = 'index.php?route=checkout/phpner_fastorder/cart&update=' + product_id + '&quantity=' + quantity;
  } else if (status == 'add') {
	urls = 'index.php?route=checkout/phpner_fastorder/cart&add=' + target + '&quantity=1';
  } else {
	urls = 'index.php?route=checkout/phpner_fastorder/cart&remove=' + product_key;
  }

  $.ajax({
	url: urls,
	type: 'get',
	dataType: 'html',
	beforeSend: function() {
	  $(target).html('<i class="fa fa-refresh fa-spin"></i>');
	},
	success: function(data) {
	  $.ajax({
		url: 'index.php?route=checkout/phpner_fastorder/status_cart',
		type: 'get',
		dataType: 'json',
		success: function(json) {
		  if (json['total']) {
			$('#cart-total').html(json['text_items']);
			$('#cart > ul').load('index.php?route=common/cart/info ul li');
			$('#phpner_-bottom-cart-content').load('index.php?route=extension/module/phpner_page_bar/block_cart');
			$("#phpner_-bottom-cart-quantity").html(json['total']);
		  }
		  if (!json['redirect']) {

			$(".shipping-method").load('index.php?route=checkout/phpner_fastorder/shipping_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
							if ($("input[name=\'shipping_method\']:first").length) {
								$("input[name=\'shipping_method\']:first").attr('checked', 'checked').prop('checked', true).click();
							} else {
								$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
							}
					  });
			
		  } else {
			location = json['redirect'];
		  }
		}
	  });
	}
  });
}
function update_manual(target, product_id) {
  var input_val = $(target).val(),
	  quantity  = parseInt(input_val);

  if (quantity <= 0) {
	quantity = $(target).val(1);
	return;
  }

  $.ajax({
	url: 'index.php?route=checkout/phpner_fastorder/cart&update=' + product_id + '&quantity=' + quantity,
	type: 'get',
	dataType: 'html',
	success: function(data) {
	  $.ajax({
		url: 'index.php?route=checkout/phpner_fastorder/status_cart',
		type: 'get',
		dataType: 'json',
		success: function(json) {
		  if (json['total']) {
			$('#cart-total').html(json['text_items']);
			$('#cart > ul').load('index.php?route=common/cart/info ul li');
			$('#phpner_-bottom-cart-content').load('index.php?route=extension/module/phpner_page_bar/block_cart');
			$("#phpner_-bottom-cart-quantity").html(json['total']);
		  }
		  if (!json['redirect']) {
   
			$(".shipping-method").load('index.php?route=checkout/phpner_fastorder/shipping_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
							if ($("input[name=\'shipping_method\']:first").length) {
								$("input[name=\'shipping_method\']:first").attr('checked', 'checked').prop('checked', true).click();
							} else {
								$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
							}
					  });
		   
		  } else {
			location = json['redirect'];
		  }
		}
	  });
	}
  });
}

function voucher_remove(voucher_key) {
  $.ajax({
	url: 'index.php?route=checkout/phpner_fastorder/cart&remove=' + voucher_key,
	type: 'get',
	dataType: 'html',
	success: function(data) {
	  $.ajax({
		url: 'index.php?route=checkout/phpner_fastorder/status_cart',
		type: 'get',
		dataType: 'json',
		success: function(json) {
		  if (json['total']) {
			$('#cart-total').html(json['text_items']);
			$('#cart > ul').load('index.php?route=common/cart/info ul li');
			$('#phpner_-bottom-cart-content').load('index.php?route=extension/module/phpner_page_bar/block_cart');
			$("#phpner_-bottom-cart-quantity").html(json['total']);
		  }
		  if (!json['redirect']) {
   
			$(".shipping-method").load('index.php?route=checkout/phpner_fastorder/shipping_method', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, input[name=\'shipping_method\']:first, .checkout_form textarea, .checkout_form select'), function() {
				if ($("input[name=\'shipping_method\']:first").length) {
					$("input[name=\'shipping_method\']:first").attr('checked', 'checked').prop('checked', true).click();
				} else {
					$("#cart-table").load('index.php?route=checkout/phpner_fastorder/cart', $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select'));	
				}
			});
		   
		  } else {
			location = json['redirect'];
		  }
		}
	  });
	}
  });
}
</script>
<style>
	.panel2 {margin-bottom: 20px;background-color: #fff;border: 1px solid transparent;border-radius: 4px;-webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);box-shadow: 0 1px 1px rgba(0,0,0,.05);}
	.well {
	min-height: 20px;
	padding: 19px;
	margin-bottom: 20px;
	background-color: #f5f5f5;
	border: 1px solid #e3e3e3;
	border-radius: 4px;
	box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
	}
</style>
<?php echo $footer; ?>