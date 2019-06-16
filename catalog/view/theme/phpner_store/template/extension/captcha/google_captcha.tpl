<script src="//www.google.com/recaptcha/api.js?hl=<?php echo $lang; ?>"></script>
<fieldset>
  <div class="form-group required">
    <?php if (substr($route, 0, 9) == 'checkout/') { ?>
    <div id="input-payment-captcha" class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
    <?php if ($error_captcha) { ?>
    <div class="text-danger"><?php echo $error_captcha; ?></div>
    <?php } ?>
    <?php } else { ?>
    <div class="col-sm-10">
      <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
      <?php if ($error_captcha) { ?>
      <div class="text-danger"><?php echo $error_captcha; ?></div>
      <?php } ?>
    </div>
    <?php } ?>
  </div>
</fieldset>
