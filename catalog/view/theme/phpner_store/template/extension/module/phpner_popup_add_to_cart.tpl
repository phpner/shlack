
<div id="addcart-popup" class="white-popup mfp-with-anim narrow-popup">
	<h2 class="popup-header"><?php echo $heading_title; ?></h2>
	<div class="left">
		<div class="popup-text">
			<h3 class="popup-h3 blue"><?php echo $product_name; ?></h3>
			<p><?php echo $text_go_to_checkout; ?></p>
		</div>
	</div>
	<div class="right">
		<div class="img-box">
			<img src="<?php echo $product_thumb; ?>" alt="<?php echo $product_name; ?>" class="img-responsive" />
		</div>
	</div>
	<div class="clearfix"></div>
	<div class="popup-buttons-box">
		<a class="popup-button" href="<?php echo $checkout_url; ?>"><?php echo $button_checkout; ?></a>
		<a class="popup-button" onclick="$.magnificPopup.close();"><?php echo $button_close; ?></a>
	</div>
</div>