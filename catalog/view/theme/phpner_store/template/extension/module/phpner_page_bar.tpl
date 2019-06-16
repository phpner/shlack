<div id="phpner_-slide-panel">
	<div class="phpner_-slide-panel-heading">
		<div id="hide-slide-panel"><i class="fa fa-times" aria-hidden="true"></i></div>
		<div class="container">
			<?php if ($phpner_page_bar_data['show_viewed_bar']) { ?>
			<div id="phpner_-last-seen-link" class="col-sm-3 col-xs-3">
				<a href="javascript:void(0);" class="phpner_-panel-link">
					<i class="fa fa-eye" aria-hidden="true"></i>
					<span class="hidden-xs hidden-sm"><?php echo $text_viewed; ?></span>
					<span id="phpner_-last-seen-quantity" class="phpner_-slide-panel-quantity"><?php echo $total_viewed; ?></span>
				</a>
			</div>
			<?php } ?>
			<?php if ($phpner_page_bar_data['show_wishlist_bar']) { ?>
			<div id="phpner_-favorite-link" class="col-sm-3 col-xs-3">
				<a href="javascript:void(0);" class="phpner_-panel-link">
					<i class="fa fa-heart-o" aria-hidden="true"></i>
					<span class="hidden-xs hidden-sm"><?php echo $text_wishlist; ?></span>
					<span id="phpner_-favorite-quantity" class="phpner_-slide-panel-quantity"><?php echo $total_wishlist; ?></span>
				</a>
			</div>
			<?php } ?>
			<?php if ($phpner_page_bar_data['show_compare_bar']) { ?>
			<div id="phpner_-compare-link" class="col-sm-3 col-xs-3">
				<a href="javascript:void(0);" class="phpner_-panel-link">
					<i class="fa fa-sliders" aria-hidden="true"></i>
					<span class="hidden-xs hidden-sm"><?php echo $text_compare; ?></span>
					<span id="phpner_-compare-quantity" class="phpner_-slide-panel-quantity"><?php echo $total_compare; ?></span>
				</a>
			</div>
			<?php } ?>
			<?php if ($phpner_page_bar_data['show_cart_bar']) { ?>
			<div id="phpner_-bottom-cart-link" class="col-sm-3 col-xs-3">
				<a href="javascript:void(0);" class="phpner_-panel-link">
					<i class="fa fa-shopping-basket" aria-hidden="true"></i>
					<span class="hidden-xs hidden-sm"><?php echo $text_cart; ?></span>
					<span id="phpner_-bottom-cart-quantity" class="phpner_-slide-panel-quantity"><?php echo $total_cart; ?></span>
				</a>
			</div>
			<?php } ?>
		</div>	
	</div>
	<div class="phpner_-slide-panel-content">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<?php if ($phpner_page_bar_data['show_viewed_bar']) { ?>
					<div id="phpner_-last-seen-content" class="phpner_-slide-panel-item-content"></div>
					<?php } ?>
					<?php if ($phpner_page_bar_data['show_wishlist_bar']) { ?>
					<div id="phpner_-favorite-content" class="phpner_-slide-panel-item-content"></div>
					<?php } ?>
					<?php if ($phpner_page_bar_data['show_compare_bar']) { ?>
					<div id="phpner_-compare-content" class="phpner_-slide-panel-item-content"></div>
					<?php } ?>
					<?php if ($phpner_page_bar_data['show_cart_bar']) { ?>
					<div id="phpner_-bottom-cart-content" class="phpner_-slide-panel-item-content"></div>
					<?php } ?>
				</div>
			</div>
		</div>			
	</div>
</div>