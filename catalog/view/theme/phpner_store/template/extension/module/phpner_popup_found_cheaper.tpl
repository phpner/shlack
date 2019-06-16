<div id="cheaper-popup" class="white-popup mfp-with-anim middle-popup">
  <h2 class="popup-header"><?php echo $heading_title; ?></h2>
  <div class="row">
    <div class="popup-text col-md-6">
      <?php if (isset($thumb)) { ?>
      <img src="<?php echo $thumb; ?>" alt="" class="img-responsive" />
      <?php } ?>
      <?php if (isset($heading_title_product)) { ?>
      <h3 class="popup-h3 blue"><?php echo $heading_title_product; ?></h3>
      <?php } ?>
      <?php if ($price) { ?>
        <div class="product-price">
          <?php if (!$special) { ?>
            <span id="main-price"><?php echo $price; ?></span>
          <?php } else { ?>
            <span id="special-price" class="phpner_-price-old"><?php echo $price; ?></span>
            <span id="main-price" class="phpner_-price-new"><?php echo $special; ?></span>
          <?php } ?>
        </div>
      <?php } ?>
    </div>
    <form method="post" enctype="multipart/form-data" id="found-cheaper-form" class="col-md-6">
      <div class="popup-form-box">
        <?php if ($phpner_popup_found_cheaper_data['name']) { ?>
          <input type="text" class="input-text" name="name" value="<?php echo $name;?>" placeholder="<?php echo $enter_name; ?>" />
        <?php } ?>
        <?php if ($phpner_popup_found_cheaper_data['telephone']) { ?>
          <input type="text" class="input-text" name="telephone" value="<?php echo $telephone;?>" placeholder="<?php echo $enter_telephone; ?>" />
          <?php if ($mask) { ?>
          <script>
            var isMobile = {
      		    Android: function() {
      		      return navigator.userAgent.match(/Android/i);
      		    },
      		    BlackBerry: function() {
      		      return navigator.userAgent.match(/BlackBerry/i);
      		    },
      		    iOS: function() {
      		      return navigator.userAgent.match(/iPhone|iPad|iPod/i);
      		    },
      		    Opera: function() {
      		      return navigator.userAgent.match(/Opera Mini/i);
      		    },
      		    Windows: function() {
      		      return navigator.userAgent.match(/IEMobile/i);
      		    },
      		    Chrome: function() {
      		      return navigator.userAgent.match(/Chrome/i);
      		    }
      		  };
		 
		        if( !isMobile.Android() ) {
              $("#cheaper-popup [name='telephone']").inputmask('<?php echo $mask; ?>');
            }
          </script>
          <?php } ?>
        <?php } ?>
        <?php if ($phpner_popup_found_cheaper_data['link']) { ?>
          <input type="text" class="input-text" name="link" value="<?php echo $link;?>" placeholder="<?php echo $enter_link; ?>" class="datetime" />
        <?php } ?>
        <?php if ($phpner_popup_found_cheaper_data['comment']) { ?>
          <textarea name="comment" placeholder="<?php echo $enter_comment; ?>"><?php echo $comment;?></textarea>
        <?php } ?>
        <?php if ($text_terms) { ?>
          <div>
            <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;clear: right;" />
          </div>
        <?php } ?>
      </div>
      <input type="hidden" name="pid" value="<?php echo $href; ?>">
      <input type="hidden" name="mid" value="<?php echo $model; ?>">
    </form>
  </div>
	<div class="popup-buttons-box">
    <a class="popup-button" id="popup-send-button"><?php echo $button_send; ?></a>
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
  $('#popup-send-button').on('click', function() {
    masked('#cheaper-popup', true);
    $.ajax({
      type: 'post',
      url:  'index.php?route=extension/module/phpner_popup_found_cheaper/send',
      dataType: 'json',
      data: $('#found-cheaper-form').serialize(),
      success: function(json) {
        if (json['error']) {
          if (json['error']['field']) {
            masked('#cheaper-popup', false);
            $('#cheaper-popup .text-danger').remove();
            $.each(json['error']['field'], function(i, val) {
              $('#cheaper-popup [name="' + i + '"]').addClass('error_style').after('<div class="text-danger">' + val + '</div>');
            });
          }
        } else {
          if (json['output']) {
            masked('#cheaper-popup', false);
            $('#cheaper-popup > .popup-buttons-box').remove();
            $('#cheaper-popup > .row').html(json['output']);
          }
        }
      }
    });
  });
  //--></script>
</div>
