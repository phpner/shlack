<footer>
	<?php if (isset($phpner_popup_call_phone_data['status']) && $phpner_popup_call_phone_data['status'] == 1) { ?>
		<a class="field-tip" onclick="get_phpner_popup_call_phone();" id="uptocall-mini"><div class="uptocall-mini-phone"><i class="fa fa-phone" aria-hidden="true"></i></div><span class="tip-content"><?php echo $popup_call_phone_text['call_back']; ?></span></a>
	<?php } ?>
  <div class="container">
      <?php if ($garanted_text) { ?>
      <div class="row second-row">
          <div class="footer-advantages-box">
              <?php foreach ($garanted_text as $garanted) { ?>
              <div class="col-sm-3 col-xs-6 footer-advantages">
                  <a href="<?php echo $garanted['link']; ?>" <?php if ($garanted['popup'] == 'on' && $garanted['link'] && $garanted['link'] != '#') { ?>id="open-popup-foot-garanted-<?php echo $garanted['id']; ?>"<?php } ?>>
                  <?php if ($garanted['icon']) { ?>
                  <i class="<?php echo $garanted['icon']; ?>" aria-hidden="true"></i>
                  <?php } ?>

                  <div class="h5"><?php echo $garanted['name']; ?></div></a>
                  <?php if ($garanted['text']) { ?>
                  <span><?php echo $garanted['text']; ?></span>
                  <?php } ?>
                  <?php if ($garanted['popup'] == 'on' && $garanted['link'] && $garanted['link'] != '#') { ?>
                  <script>
                      $(document).delegate('#open-popup-foot-garanted-<?php echo $garanted['id']; ?>', 'click', function(e) {
                          e.preventDefault();

                          var element = this;

                          $.ajax({
                              url: $(element).attr('href'),
                              type: 'get',
                              dataType: 'html',
                              success: function(data) {
                                  $.magnificPopup.open({
                                      tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
                                      items: {
                                          src:  '<div id="service-popup" class="white-popup mfp-with-anim narrow-popup">'+
                                          '<h2 class="popup-header">' + $(element).children('.h5').text() + '</h2>'+
                                          '<div class="popup-text service-popup-text">'+
                                          '<p>' + data + '</p>'+
                                          '</div>'+
                                          '</div>',
                                          type: 'inline'
                                      },
                                      showCloseBtn: true,
                                      midClick: true,
                                      removalDelay: 200
                                  });
                              }
                          });
                      });
                  </script>
                  <?php } ?>
              </div>
              <?php } ?>
          </div>
      </div>
      <hr>
    <?php } ?>
		<?php if ($phpner_store_data['foot_show_contact_link'] == 'on') { ?>
			<?php if ($phpner_store_data['foot_show_soclinks'] == 'on') { ?>
			<div class="row first-row">
				<div class="col-sm-12 col-md-4">
				<?php echo $phpner_popup_subscribe; ?>
				<div class="col-md-12 hidden-sm hidden-xs text-left">
					<div class="h5"><?php echo $text_contact_us; ?></div>
				</div>
					<div class="col-md-12 col-sm-12 text-left socials-box">
						<?php if ($phpner_store_data['ps_vk_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_vk_id']; ?>" title="Vkonakte" target="_blank"><i class="fa fa-vk" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_facebook_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_facebook_id']; ?>" title="Facebook" target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_twitter_username']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_twitter_username']; ?>" title="Twitter" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_youtube_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_youtube_id']; ?>" title="Youtube" target="_blank"><i class="fa fa-play" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_instagram']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_instagram']; ?>" title="Instagram" target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_gplus_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_gplus_id']; ?>" title="Google Plus" target="_blank"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_odnoklass_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_odnoklass_id']; ?>" title="Odnoklassniki" target="_blank"><i class="fa fa-odnoklassniki" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_vimeo_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_vimeo_id']; ?>" title="Vimeo" target="_blank"><i class="fa fa-vimeo" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_pinterest_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_pinterest_id']; ?>" title="Pinterest" target="_blank"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
						<?php } ?>
						<?php if ($phpner_store_data['ps_flick_id']) { ?>
						<a rel="nofollow" href="<?php echo $phpner_store_data['ps_flick_id']; ?>" title="Flickr" target="_blank"><i class="fa fa-flickr" aria-hidden="true"></i></a>
						<?php } ?>
					</div>
                    <?php if(!empty($module_description_copyright)){ ?>
                    <div class="col-md-12 col-sm-12 copyright-footer  hidden-sm hidden-xs">
                        <?php echo $module_description_copyright?>
                    </div>
                    <?php } ?>
			</div>
                <div class="col-sm-12 col-md-4 footer-contacts">
					<div class="h5">
						<?php if ($phpner_store_cont_clock) { ?>
						<?php foreach ($phpner_store_cont_clock as $clock) { ?>
						<li><i class="fa fa-calendar" aria-hidden="true"></i> <?php echo $clock; ?></li>
						<?php } ?>
						<?php } ?>
						<a class="f-acc-toggle"></a>
					</div>
                    <div class="wrapp-ul">
					<ul class="footer-contacts-ul col-md-6">
						<?php if ($phpner_store_cont_phones) { ?>
						<?php foreach($phpner_store_cont_phones as $element) { ?>
						<li><a href="#" class="phoneclick" onclick="window.location.href='tel:+<?php echo preg_replace('/\D/', '', $element); ?>';return false;"><i class="fa fa-phone" aria-hidden="true"></i><?php echo $element; ?></a></li>
						<?php } ?>
						<?php } ?>
						<?php if ((isset($phpner_store_data['ps_whatsapp_id']) && strlen($phpner_store_data['ps_whatsapp_id']) > 1) or (isset($phpner_store_data['ps_telegram_id']) && strlen($phpner_store_data['ps_telegram_id']) > 1) or (isset($phpner_store_data['ps_viber_id']) && strlen($phpner_store_data['ps_viber_id']) > 1)) { ?>
						<li class="phpner_-messengers">
							<?php } ?>
							<?php if(isset($phpner_store_data['ps_whatsapp_id']) && strlen($phpner_store_data['ps_whatsapp_id']) > 1) { ?>
							<a class="phpner_-messengers-whatsapp" rel="nofollow" href="https://api.whatsapp.com/send?phone=<?php echo $phpner_store_data['ps_whatsapp_id']; ?>" title="Whatsapp" target="_blank"><i class="fa fa-whatsapp" aria-hidden="true"></i></a>
							<?php } ?>
							<?php if(isset($phpner_store_data['ps_telegram_id']) && strlen($phpner_store_data['ps_telegram_id']) > 1) { ?>
							<a class="phpner_-messengers-telegram" rel="nofollow" href="http://t.me/<?php echo $phpner_store_data['ps_telegram_id']; ?>" title="Telegram" target="_blank"><i class="fa fa-telegram" aria-hidden="true"></i></a>
							<?php } ?>
							<?php if(isset($phpner_store_data['ps_viber_id']) && strlen($phpner_store_data['ps_viber_id']) > 1) { ?>
							<a rel="nofollow" class="phpner_-messengers-viber viber-mobile" href="viber://add?number=<?php echo $phpner_store_data['ps_viber_id']; ?>" title="Viber" target="_blank"><i class="fa fa-viber" aria-hidden="true"></i></a>
							<a rel="nofollow" class="phpner_-messengers-viber viber-desktop" href="viber://chat?number=<?php echo $phpner_store_data['ps_viber_id']; ?>" title="Viber" target="_blank"><i class="fa fa-viber" aria-hidden="true"></i></a>
							<?php } ?>
							<?php if ((isset($phpner_store_data['ps_whatsapp_id']) && strlen($phpner_store_data['ps_whatsapp_id']) > 1) or (isset($phpner_store_data['ps_telegram_id']) && strlen($phpner_store_data['ps_telegram_id']) > 1) or (isset($phpner_store_data['ps_viber_id']) && strlen($phpner_store_data['ps_viber_id']) > 1)) { ?>
						</li>
						<?php } ?>
						<li><a  onclick="get_phpner_popup_call_phone();" >Перезвоните мне</a></li>
					</ul>
					<ul class="footer-contacts-ul-right col-md-6">
						<?php if ($phpner_store_cont_skype) { ?>
						<li><a href="skype:<?php echo $phpner_store_cont_skype; ?>"><i class="fa fa-skype" aria-hidden="true"></i> <?php echo $phpner_store_cont_skype; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_cont_email) { ?>
						<li><a href="mailto:<?php echo $phpner_store_cont_email; ?>"><i class="fa fa-envelope" aria-hidden="true"></i> <?php echo $phpner_store_cont_email; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_cont_adress) { ?>
						<li class="emails"><i class="fa fa-envelope" aria-hidden="true"></i> <?php echo $phpner_store_cont_adress; ?></li>
						<?php } ?>
					</ul>
                    </div>
				</div>
                <div class="conent-in-footer col-sm-12 col-md-4">
				<?php if ($phpner_store_footer_categories) { ?>
				<div class="col-sm-4 col-xs-4 col-md-5">
					<div class="h5"><?php echo $text_categories; ?> <a class="f-acc-toggle"></a></div>
					<ul class="list-unstyled">
						<?php foreach ($phpner_store_footer_categories as $category) { ?>
						<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
						<?php } ?>
					</ul>
				</div>
				<?php } ?>
			<?php } ?>
				<?php if ($phpner_store_footer_informations) { ?>
				<div class="col-sm-4 col-xs-4 col-md-5">
					<div class="h5"><?php echo $text_information; ?> <a class="f-acc-toggle"></a></div>
					<ul class="list-unstyled">

						<?php foreach ($phpner_store_footer_informations as $information) { ?>
						<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
						<?php } ?>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_contact_link'] == 'on') { ?>
						<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_return_link'] == 'on') { ?>
						<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_sitemap_link'] == 'on') { ?>
						<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_manufacturer_link'] == 'on') { ?>
						<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_voucher_link'] == 'on') { ?>
						<li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_affiliate_link'] == 'on') { ?>
						<li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
						<?php } ?>
						<?php if ($phpner_store_data['foot_show_block_special_link'] == 'on') { ?>
						<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
						<?php } ?>
					</ul>
				</div>
                <?php if(!empty($module_description)){ ?>
                <div class="col-sm-4 col-xs-4 col-md-2 our-ser">
                    <div class="h5"><?php echo $module_title ?></div>
                    <?php echo $module_description ?>
                </div>
                <?php } ?>
                </div>
			</div>
            <div class="row">
                <?php if(!empty($module_description_copyright)){ ?>
                <div class="col-md-12 col-sm-12 copyright-footer visible-xs visible-sm">
                    <?php echo $module_description_copyright?>
                </div>
                <?php } ?>
            </div>
	  <?php } ?>
	  <?php if ($phpner_store_data['foot_show_copy_and_payment'] == 'on') { ?>
    <div class="row last-row">
	    <div class="col-sm-4 col-xs-12">
  			<span class="phpner_-copy"><?php echo $phpner_powered; ?></span>
  		</div>
	    <div class="col-sm-8 col-xs-12 text-right payment-box">
		    <span class="text-payments"><?php echo $text_payments; ?></span>
				<?php if ($phpner_store_data['ps_sberbank'] == 'on') { ?>
				<span class="sberbank"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_privat'] == 'on') { ?>
				<span class="privat24"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_yamoney'] == 'on') { ?>
				<span class="yandex-money"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_webmoney'] == 'on') { ?>
				<span class="webmoney"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_visa'] == 'on') { ?>
				<span class="visa"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_qiwi'] == 'on') { ?>
				<span class="qiwi"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_skrill'] == 'on') { ?>
				<span class="skrill"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_interkassa'] == 'on') { ?>
				<span class="interkassa"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_liqpay'] == 'on') { ?>
				<span class="liqpay"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_paypal'] == 'on') { ?>
				<span class="paypal"></span>
				<?php } ?>
				<?php if ($phpner_store_data['ps_robokassa'] == 'on') { ?>
				<span class="robokassa"></span>
				<?php } ?>
				<?php echo (isset($phpner_store_data['ps_mastercard']) && $phpner_store_data['ps_mastercard'] == 'on') ? '<span class="mastercard"></span>' : ''; ?>
				<?php echo (isset($phpner_store_data['ps_maestro']) && $phpner_store_data['ps_maestro'] == 'on') ? '<span class="maestro"></span>' : ''; ?>
				<?php if ($ps_additional_icons) { ?>
				<?php foreach ($ps_additional_icons as $ps_additional_icon) { ?>
				<span class="custom-payment"><img src="<?php echo $ps_additional_icon['image']; ?>" alt=""></span>
				<?php } ?>
				<?php } ?>
    	</div>
		</div>
		<?php } ?>
  </div>
</footer>
</div>
<?php if ($phpner_page_bar) { ?>
<?php echo $phpner_page_bar; ?>
<?php } ?>
<?php if (!$phpner_page_bar) { ?>
<style>
footer {margin-bottom:0 !important;}
</style>
<?php } ?>
<?php if (isset($phpner_popup_subscribe_form_data['status']) && $phpner_popup_subscribe_form_data['status']) { ?>
<script>
$(function() {
  <?php $expire = $phpner_popup_subscribe_form_data['expire'] ? $phpner_popup_subscribe_form_data['expire'] : '1'; 
   $expire_ms = isset($phpner_popup_subscribe_form_data['seconds']) ? $phpner_popup_subscribe_form_data['seconds'] : '10000'; ?>
  <?php setcookie('phpner_popup_subscribe', 1, time() + (60*60*24*$expire), "/"); ?>
  var expire_timer = "<?php echo $expire_ms; ?>";
  var expire_timeout = setTimeout(function(){
  get_phpner_popup_subscribe();
  }, expire_timer);
  <?php if (isset($_COOKIE['phpner_popup_subscribe'])) { ?>
  clearTimeout(expire_timeout);
  <?php } ?>
});
</script>
<?php } ?>
<?php if (isset($phpner_popup_product_options_data['status']) && $phpner_popup_product_options_data['status']) { ?>
<script>
$(document).ajaxSuccess(function(event, xhr, settings) {
  if (settings.url == "index.php?route=checkout/cart/add") {
    if (xhr.responseText.indexOf("error") > 0) {
      get_phpner_popup_product_options(phpner_get_product_id(settings.data));
    }
  }
});
</script>
<?php } ?>
<p id="back-top">
  <a href="#top"><i class="fa fa-angle-up" aria-hidden="true"></i></a>
</p>
<div class="menu-bckgr"></div>
</body>
</html>