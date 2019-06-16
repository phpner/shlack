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
      <h2><i class="fa fa-map-marker"></i><?php echo $heading_title; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <div class="form-group">
            <label class="col-sm-6 control-label newsletter-label"><?php echo $entry_newsletter; ?></label>
            <div class="col-sm-6 newsletter-div">
              <?php if ($newsletter) { ?>
              <label class="radio-inline">
                <input type="radio" name="newsletter" value="1" checked="checked" />
                <?php echo $text_yes; ?> </label>
              <label class="radio-inline">
                <input type="radio" name="newsletter" value="0" />
                <?php echo $text_no; ?></label>
              <?php } else { ?>
              <label class="radio-inline">
                <input type="radio" name="newsletter" value="1" />
                <?php echo $text_yes; ?> </label>
              <label class="radio-inline">
                <input type="radio" name="newsletter" value="0" checked="checked" />
                <?php echo $text_no; ?></label>
              <?php } ?>
            </div>
          </div>
        </fieldset>
        <div class="buttons clearfix">
          <div><a href="<?php echo $back; ?>" class="button-back"><?php echo $button_back; ?></a></div>
          <div>
            <input type="submit" value="<?php echo $button_continue; ?>" class="phpner_-button" />
          </div>
        </div>
      </form>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>