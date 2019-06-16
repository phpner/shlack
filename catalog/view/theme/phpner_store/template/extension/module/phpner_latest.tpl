<?php if ($position == "column_left" OR $position == "column_right") { ?>
<div class="row phpner_-carousel-row phpner_-col-module">
<?php } else { ?>
<div class="row phpner_-carousel-row">
<?php } ?>
<div class="col-sm-12">
    <div class="phpner_-carousel-box">
      <div class="phpner_-carousel-header"><?php echo $heading_title; ?></div>
      <div id="phpner_-owl-carousel-<?php echo $module; ?>" class="owl-carousel owl-theme">
        <?php foreach ($products as $product) { ?>     
          <div class="item">
            <div class="image">
              <?php if ($product['special']) { ?>
                <div class="phpner_-discount-box">
                  <div class="phpner_-discount-item">-<?php echo $product['saving']; ?>%</div>
                </div>
              <?php } ?>
              <?php if ($product['phpner_product_stickers']) { ?>
              <div class="phpner_-sticker-box">
                <?php foreach ($product['phpner_product_stickers'] as $product_sticker) { ?>
                  <div class="phpner_-sticker-item" style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;"><?php echo $product_sticker['text']; ?></div>
                <?php } ?>
              </div>
              <?php } ?>
              <?php if (isset($phpner_popup_view_data['status']) && $phpner_popup_view_data['status'] && $product['quantity'] > 0) { ?>
                <div class="quick-view"><a onclick="get_phpner_popup_product_view('<?php echo $product['product_id']; ?>');"><?php echo $button_popup_view; ?></a></div>
              <?php } ?>   
              <?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name'] ?>" /></a>
              <?php } ?>
            </div> 
            <div class="name">
              <a href="<?php echo $product['href']; ?>"><?php echo $product['name'] ?></a>
            </div>
            <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <i class="fa fa-star-o" aria-hidden="true"></i>
                <?php } else { ?>
                <i class="fa fa-star" aria-hidden="true"></i>
                <?php } ?>
                <?php } ?>
              </div>
            <?php } ?>
            <?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                  <span class="price-new phpner_-price-normal"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                  <span class="price-old phpner_-price-old"><?php echo $product['price']; ?></span><span class="price-new phpner_-price-new"><?php echo $product['special']; ?></span>
                <?php } ?>
              </div>
            <?php } ?>
            <div class="cart">
              <?php if ($product['quantity'] > 0) { ?>
                <a class="button-cart phpner_-button" title="<?php echo $button_cart; ?>" onclick="get_phpner_popup_add_to_cart('<?php echo $product['product_id']; ?>', '1');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_cart; ?></a>
              <?php } else { ?>
                <a class="out-of-stock-button phpner_-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_phpner_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $product['product_preorder_text']; ?></span></a>
              <?php } ?>
              <a onclick="get_phpner_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist phpner_-button"><i class="fa fa-heart" aria-hidden="true"></i></a>
              <a onclick="get_phpner_popup_add_to_compare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="compare phpner_-button"><i class="fa fa-sliders" aria-hidden="true"></i></a>
            </div>
          </div>
        <?php } ?>   
      </div>
    </div>
  </div>
</div>
<script>
  $('#phpner_-owl-carousel-<?php echo $module; ?>').owlCarousel({
    items: <?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>,
    itemsDesktop : [1921,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>],
    itemsDesktop : [1199,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>],
    itemsDesktopSmall : [979,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 3; } ?>],
    itemsTablet : [768,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 2; } ?>],
    itemsMobile : [479,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 1; } ?>],
    autoPlay: false,
    navigation: true,
    slideMargin: 10,
    navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
    stopOnHover:true,
    smartSpeed: 800,
    loop: true,
    pagination: false
  });
</script>