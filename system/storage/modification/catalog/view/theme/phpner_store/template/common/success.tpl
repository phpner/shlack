<?php echo $header; ?>
<div class="container">
  <div class="col-sm-12 content-row">
  	<div class="breadcrumb-box">
		  <ul class="breadcrumb">
		    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
		    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		    <?php } ?>
		  </ul>
	  </div>
    <div id="content" class="account-content"><?php echo $content_top; ?>
      <h2><i class="fa fa-check-square"></i><?php echo $heading_title; ?></h2>
      <div class="text-center"><?php echo $text_message; ?></div>
      <div class="buttons">
        <div><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
      </div>
      <div class="clearfix"></div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>

			<?php if (isset($script_order)) { echo $script_order; } ?>
			<?php echo $footer; ?>
			