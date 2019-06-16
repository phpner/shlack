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
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
    <div id="content" class="account-content"><?php echo $content_top; ?>
      <h2><i class="fa fa-lock"></i><?php echo $heading_title; ?></h2>
      <p class="text-center"><?php echo $text_email; ?></p>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <div class="form-group required">
            <label class="col-sm-3 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-9">
              <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
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