<div id="subscribe-popup" class="white-popup middle-popup mfp-with-anim">
  <h2 class="popup-header"><?php echo $heading_title; ?></h2>
  <div class="popup-center">
    <div class="popup-text">
      <p><?php echo $promo_text; ?></p>
      <?php if ($thumb) { ?>
      <img class="img-responsive" src="image/<?php echo $thumb; ?>" alt="" />
      <?php } ?>
    </div>
    <div class="popup-form-box">
      <form method="post" enctype="multipart/form-data" id="popup-subscribe-form">
        <input class="input-text" placeholder="<?php echo $enter_email; ?>" type="text" name="email" value="<?php echo $email; ?>" />
        <?php if ($text_terms) { ?>
          <div>
            <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;display:inline-block;margin: 0;" />
          </div>
          <br/>
        <?php } ?>
        <button class="phpner_-button" title="<?php echo $button_subscribe; ?>" type="button" id="popup-subscribe-button"><?php echo $button_subscribe; ?></button>
      </form>
    </div>
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

  $('input[name=\'stop\']').on('change', function(){
    if ($(this).is(':checked')) {
      $.ajax({
        type: 'get',
        url:  'index.php?route=extension/module/phpner_popup_subscribe/set_cookie&set=365'
      });
    } else {
      $.ajax({
        type: 'get',
        url:  'index.php?route=extension/module/phpner_popup_subscribe/set_cookie&set=<?php echo $expire; ?>'
      });
    }
  });

  $('#popup-subscribe-button').on('click', function() {
    masked('#subscribe-popup', true);
    $.ajax({
      type: 'post',
      url:  'index.php?route=extension/module/phpner_popup_subscribe/make_subscribe',
      dataType: 'json',
      data: $('#popup-subscribe-form').serialize(),
      success: function(json) {
        if (json['error']) {
          masked('#subscribe-popup', false);
          $('#subscribe-popup .alert-danger').remove();
          $('.popup-form-box').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }
        if (json['output']) {
          masked('#subscribe-popup', false);
          $('#subscribe-popup .popup-center').html(json['output']);
        }
      }
    });
  });
  //--></script>
</div>
