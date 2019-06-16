<!Dphpner_YPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><?php echo $title; ?></title>
	</head>
	<body style="font-size: 12px; line-height:18px; font-family: Arial, sans-serif; background: rgba(201, 209, 231, 0.62);">
		<div style="max-width: 1000px; margin: 0 auto;">
			<div style="height: 30px;">&nbsp;</div>
			<div style="font-size: 14px; line-height: 24px; margin: 20px; color: #222;">
				<p style="text-align: center;">
					<a href="<?php echo $store_url; ?>" title="<?php echo $store_name; ?>"><img src="<?php echo $logo; ?>" alt="<?php echo $store_name; ?>" style="margin-bottom: 20px; border: none;" /></a>
				</p>
				<?php echo $text_greeting; ?>
				<?php if ($customer_id) { ?>
					<p style="margin-top: 0px; margin-bottom: 10px;"><?php echo $text_link; ?></p>
					<p style="margin-top: 0px; margin-bottom: 10px;"><a href="<?php echo $link; ?>"><?php echo $link; ?></a></p>
				<?php } ?>
				<?php if ($download) { ?>
					<p style="margin-top: 0px; margin-bottom: 10px;"><?php echo $text_download; ?></p>
					<p style="margin-top: 0px; margin-bottom: 10px;"><a href="<?php echo $download; ?>"><?php echo $download; ?></a></p>
				<?php } ?>
				<?php if ($comment) { ?>
					<p style="margin-top: 0px; margin-bottom: 10px;"><?php echo $text_instruction; ?></p>
					<p style="margin-top: 0px; margin-bottom: 10px;"><?php echo $comment; ?></p>
				<?php } ?>
			</div>
			<main style="background: #fff; position: relative; box-shadow: 0 0 13px 0 rgba(0, 0, 0, .4);">
				<div class="order-details">
					<div style="border-bottom: 1px dashed #e5e5e5; padding: 20px; background: #426f9c; color: #fff; font-size: 16px;">
						<div class="order-wrap">
							<time style="font-size: 11px;  color: rgba(208, 208, 208, 0.96);"><?php echo $date_added; ?></time>
							<div style="float: right; font-size: 24px;"><span class="xhr">#<?php echo $order_id; ?></span></div> 
						</div>
					</div>
					<div style="border-bottom: 1px dashed #e5e5e5; padding: 20px; color: #222;">
						<table style="font-size: 14px; line-height: 22px;">
							<tbody>
								<tr style="border-bottom: 1px solid #ecedf3;">
									<td style="padding: 5px 8px 5px 2px;"><?php echo $text_payment_method; ?></td>
									<td style="padding: 5px 8px 5px 2px;"><?php echo $payment_method; ?></td>
								</tr>
								<?php if ($shipping_method) { ?>
									<tr style="border-bottom: 1px solid #ecedf3;">
										<td style="padding: 5px 8px 5px 2px;"><?php echo $text_shipping_method; ?></td>
										<td style="padding: 5px 8px 5px 2px;"><?php echo $shipping_method; ?></td>
									</tr>
								<?php } ?>
								<tr style="border-bottom: 1px solid #ecedf3;">
									<td style="padding: 5px 8px 5px 2px;"><?php echo $text_email; ?></td>
									<td style="padding: 5px 8px 5px 2px;"><?php echo $email; ?></td>
								</tr>
								<tr style="border-bottom: 1px solid #ecedf3;">
									<td style="padding: 5px 8px 5px 2px;"><?php echo $text_telephone; ?></td>
									<td style="padding: 5px 8px 5px 2px;"><?php echo $telephone; ?></td>
								</tr>
								<tr style="border-bottom: 1px solid #ecedf3;">
									<td style="padding: 5px 8px 5px 2px;"><?php echo $text_order_status; ?></td>
									<td style="padding: 5px 8px 5px 2px;"><?php echo $order_status; ?></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div>
						<div class="order-goods">
							<table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;">
								<thead>
									<tr>
										<td style="font-size: 12px; border-right: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; background-color: #3f97c7; font-weight: bold; text-align: left; padding: 7px; color: #fff;">&nbsp;</td>
										<td style="font-size: 12px; border-right: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; background-color: #3f97c7; font-weight: bold; text-align: left; padding: 7px; color: #fff;"><?php echo $text_product; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; background-color: #3f97c7; font-weight: bold; text-align: left; padding: 7px; color: #fff;"><?php echo $text_model; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; background-color: #3f97c7; font-weight: bold; text-align: right; padding: 7px; color: #fff;"><?php echo $text_quantity; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; background-color: #3f97c7; font-weight: bold; text-align: right; padding: 7px; color: #fff;"><?php echo $text_price; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; background-color: #3f97c7; font-weight: bold; text-align: right; padding: 7px; color: #fff;"><?php echo $text_total; ?></td>
									</tr>
								</thead>
								<tbody>
									<?php foreach ($products as $product) { ?>
									<tr>
										<td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
											<?php if ($product['image']) { ?>
												<div style="float: left; text-align: center; margin-right: 20px;">
													<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['image']; ?>" style="width:65px;"></a>
												</div>
											<?php } ?>
										</td>
										<td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">
											<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
											<?php foreach ($product['option'] as $option) { ?>
											<br />
											&nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?>
											<?php if ($option['type'] == 'phpner_quantity' && isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['quantity_status'] && isset($option['phpner_quantity_value'])) { ?>
		                  	x<?php echo $option['phpner_quantity_value']; ?>
		                  <?php } ?>
											<?php if ((isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['allow_sku'] && $option['sku']) || (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['allow_model'] && $option['model'])) { ?>(<?php if ($phpner_advanced_options_settings_data['allow_sku'] && $option['sku']) { ?><?php echo $phpner_text_option_sku; ?>: <?php echo $option['sku']; ?>, <?php } ?><?php if ($phpner_advanced_options_settings_data['allow_model'] && $option['model']) { ?><?php echo $phpner_text_option_model; ?>: <?php echo $option['model']; ?><?php } ?>)
	                  	<?php } ?>
											</small>
											<?php } ?>
										</td>
										<td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $product['model']; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $product['quantity']; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $product['price']; ?></td>
										<td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $product['total']; ?></td>
									</tr>
									<?php } ?>
								</tbody>
							</table>
							<?php foreach ($totals as $total) { ?>    
								<div style="border-bottom: 1px dashed #e5e5e5; padding: 20px; text-align: right; font-size: 16px; font-weight: bold;">
									<div name="bonus_price"></div>
									<div style="float: left;"><?php echo $total['title']; ?></div>
									<div class="order-total-sum"><?php echo $total['text']; ?></div>
								</div>
							<?php } ?>
							<div style="float: left; width: 50%; padding: 10px 0; border-bottom: 0; color: #222; font-size: 12px; padding: 20px;">
								<b><?php echo $text_shipping_address; ?></b>
								<br />
								<?php echo $payment_address; ?>
							</div>
							<div style="clear: both; height: 1px;"></div>
						</div>
					</div>
				</div>
			</main>
			<?php foreach ($vouchers as $voucher) { ?>
				<table style="border-collapse: collapse; width: 100%; margin: 20px;">
					<tbody>
					<tr style="border-bottom: 1px solid #ecedf3;">
					<td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $voucher['description']; ?></td>
					<td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"></td>
					<td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;">1</td>
					<td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $voucher['amount']; ?></td>
					<td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: right; padding: 7px;"><?php echo $voucher['amount']; ?></td>
					</tr>
					</tbody>
					<tfoot></tfoot>
				</table>
			<?php } ?>
			<div style="color: #757575; font-size: 12px; text-align: center; margin: 30px 0;">
				<?php if ($phpner_store_cont_adress) { ?>
				<?php echo $phpner_store_cont_adress; ?>
				<?php } ?>
				<br/>
				<?php if ($phpner_store_cont_phones) { ?>
					<?php foreach ($phpner_store_cont_phones as $phone) { ?>
						<?php echo $phone; ?> 
					<?php } ?>
				<?php } ?>
				<br />
				<?php if ($phpner_store_cont_clock) { ?>
					<?php foreach ($phpner_store_cont_clock as $clock) { ?>
						<?php echo $clock; ?> 
					<?php } ?>
				<?php } ?>
				<br />
				<?php if ($phpner_store_data['ps_facebook_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_facebook_id']; ?>" alt="facebook"><i class="fa fa-facebook-square" aria-hidden="true"></i></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_vk_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_vk_id']; ?>" alt="vk"><i class="fa fa-vk" aria-hidden="true"></i></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_gplus_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_gplus_id']; ?>" alt="gplus"></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_odnoklass_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_odnoklass_id']; ?>" alt="odnoklass"></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_twitter_username']) { ?>
				<a href="<?php echo $phpner_store_data['ps_twitter_username']; ?>" alt="twitter"></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_vimeo_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_vimeo_id']; ?>" alt="vimeo"></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_pinterest_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_pinterest_id']; ?>" alt="pinterest"></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_flick_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_flick_id']; ?>" alt="flick"></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_instagram']) { ?>
				<a href="<?php echo $phpner_store_data['ps_instagram']; ?>" alt="instagram"><i class="fa fa-instagram" aria-hidden="true"></i></a>
				<?php } ?>
				<?php if ($phpner_store_data['ps_youtube_id']) { ?>
				<a href="<?php echo $phpner_store_data['ps_youtube_id']; ?>" alt="youtube"></a>
				<?php } ?>
				<br /><br /><br />
			</div>
		</div>
	</body>
</html>