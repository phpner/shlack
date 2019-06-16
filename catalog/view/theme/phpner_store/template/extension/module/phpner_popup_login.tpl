<div id="auth-popup" class="white-popup mfp-with-anim narrow-popup">
  <h2 class="popup-header"><?php echo $heading_title; ?></h2>
  <div class="popup-text">
    <p class="blue"><?php echo $text_login; ?></p>
  </div>
  <div class="popup-login-error-text"></div>
  <div class="popup-form-box">
    <form method="post" enctype="multipart/form-data" id="popup-login-form">
      <input class="input-text" title="<?php echo $entry_email; ?>" placeholder="<?php echo $entry_email; ?>" type="text" name="email" />
      <input class="input-text" title="<?php echo $entry_password; ?>" placeholder="<?php echo $entry_password; ?>" type="password" name="password" />
      <?php if ($text_terms) { ?>
        <div>
          <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;display:inline-block;margin: 0;" />
        </div>
      <?php } ?>
    </form>
    <button class="phpner_-button" title="<?php echo $button_login; ?>" type="button" id="popup-login-button"><?php echo $button_login; ?></button>
  </div>
  <div class="auth-popup-links">
    <a class="reg-popup-link" href="<?php echo $register_url; ?>"><?php echo $button_register; ?></a><br/>
    <a class="forget-popup-link" href="<?php echo $forgotten_url; ?>"><?php echo $button_forgotten; ?></a>
  </div>
  <script><!--
    function masked(element, status) {
      if (status == true) {
        $('<div/>')
        .attr({ 'class':'masked' })
        .prependTo(element);
        $('<div class="masked_loading" />').insertAfter($('.masked'));
      } else {
        $('.masked').remove();
        $('.masked_loading').remove();
      }
    }
    $('#popup-login-button').on('click', function() {
      masked('#auth-popup', true);
      $.ajax({
        type: 'post',
        url:  'index.php?route=extension/module/phpner_popup_login/login',
        dataType: 'json',
        data: $('#popup-login-form').serialize(),
        success: function(json) {
          $('.popup-login-error-text .text-danger').remove();
          
          if (json['warning']) {
          	masked('#auth-popup', false);
            $('.popup-login-error-text').html('<div class="text-danger">'+json['warning']+'</div>');
          } else {
            masked('#auth-popup', false);
            $('.popup-login-error-text').hide();
            location = '<?php echo $account_url; ?>';
          }
        }
      });
    });
  //--></script>
</div>