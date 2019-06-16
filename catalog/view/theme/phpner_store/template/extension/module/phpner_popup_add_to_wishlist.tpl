<div id="wishlist-popup" class="white-popup mfp-with-anim narrow-popup">
	<h2 class="popup-header"><?php echo $heading_title; ?></h2>
	<div class="popup-text">
		<?php if ($success_add) { ?>
			<p><?php echo $text_success_add; ?></p>
			<p><a href="<?php echo $product_link; ?>" class="item-link"><?php echo $product_name; ?></a></p>
			<p><a href="<?php echo $wishlist_url; ?>"><?php echo $text_wishlist; ?></a></p>
		<?php } else { ?>
			<p><?php echo $text_warning_add; ?></p>
		<?php } ?>
	</div>
	<a class="popup-button" onclick="$.magnificPopup.close();"><?php echo $button_ok; ?></a>
</div>