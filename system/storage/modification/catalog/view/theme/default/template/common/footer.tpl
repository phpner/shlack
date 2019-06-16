
			<?php if (isset ($ya_metrika_active) && $ya_metrika_active){ ?>
				<?php echo $yandex_metrika; ?>
				<script type="text/javascript">
					window.dataLayer = window.dataLayer || [];
                    if(typeof cart.add != 'undefined'){
                        var old_addCart = cart.add;
                        cart.add = function (product_id, quantity)
                        {
                            dataLayer.push({
                                "ecommerce": {
                                    "add": {
                                        "products": [
                                            {
                                                "id": product_id,
                                                "name": 'product id = '+product_id,
                                                "quantity": quantity
                                            }
                                        ]
                                    }
                                }
                            });
                            old_addCart(product_id, quantity);
                        }
                    }

                    if(typeof $('#button-cart') != 'undefined'){
                        $('#button-cart').on('click', function() {
                            var product =

                            dataLayer.push({
                                "ecommerce": {
                                    "add": {
                                        "products": [
                                            {
                                                "id": $('#product input[name="product_id"]').val(),
                                                "name": 'product id = '+ $('#product input[name="product_id"]').val(),
                                                "quantity": $('#product input[name="quantity"]').val()
                                            }
                                        ]
                                    }
                                }
                            });
                        });
                    }
				</script>
			<?php } ?>
<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
    </div>
    <hr>
    <p><?php echo $powered; ?></p>

			<?php if ($ya_kassa_show_in_footer) : ?>
			<p><a href="https://kassa.yandex.ru/?_openstat=promo;merchants;opencart2">Работает Яндекс.Касса</a></p>
			<?php endif; ?>
			
  </div>
</footer>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->

</body></html>