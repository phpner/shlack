<link href="catalog/view/javascript/phpner_store/p_special_timer/flipclock.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/phpner_store/p_special_timer/flipclock.js"></script>
<?php if ($position == "column_left" OR $position == "column_right") { ?>
<?php } else { ?>
<div class="row phpner_-day-goods-row">
  <div class="col-sm-12">
    <div class="phpner_-day-goods-box">
      <div class="phpner_-carousel-header"><?php echo $heading_title; ?></div>
      <div id="phpner_-day-goods-<?php echo $module; ?>" class="owl-carousel owl-theme">
        <?php foreach ($products as $product) { ?>     
          <div class="item">
            <div class="phpner_-day-goods-item">
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
              <div class="things-to-buy">
                <div class="cart">
                  <?php if ($product['quantity'] > 0) { ?>
                    <a class="button-cart" title="<?php echo $button_cart_time; ?>" onclick="get_phpner_popup_add_to_cart('<?php echo $product['product_id']; ?>');"><i class="fa fa-hourglass-half" aria-hidden="true"></i> <?php echo $button_cart_time; ?></a>
                  <?php } else { ?>
                    <a class="out-of-stock-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_phpner_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $product['product_preorder_text']; ?></span></a>
                  <?php } ?>
                </div>
                <div class="counter">
                  <div id="clock-<?php echo $product['product_id']; ?>"></div>
                  <script>
                  $(document).ready(function() {
                    var futureDate  = new Date("<?php echo $product['date_end']; ?>");
                    var currentDate = new Date();
                    var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;
                    function dayDiff(first, second) {
                      return (second-first)/(1000*60*60*24);
                    }
                    if (dayDiff(currentDate, futureDate) < 100) {
                      $('.clock').addClass('twoDayDigits');
                    } else {
                      $('.clock').addClass('threeDayDigits');
                    }
                    if(diff < 0) {
                      diff = 0;
                    }
                    clock = $('#clock-<?php echo $product['product_id']; ?>').FlipClock(diff, {
                      clockFace: 'DailyCounter',
                      countdown: true,
                      language: '<?php echo $language_code; ?>'
                    });
                  });
                  </script>
                </div>
              </div>
            </div>
          </div>
        <?php } ?>   
      </div>
    </div>
  </div>
</div>
<script>
  $('#phpner_-day-goods-<?php echo $module; ?>').owlCarousel({
    items: <?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>,
    itemsDesktop : [1599,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>],
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
<?php } ?>