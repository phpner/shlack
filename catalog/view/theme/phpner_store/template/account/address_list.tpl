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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
    <?php } ?>
    <div id="content" class="account-content"><?php echo $content_top; ?>
      <h2><i class="fa fa-map-marker"></i><?php echo $text_address_book; ?></h2>
      <?php if ($addresses) { ?>
        <div class="table-div">
          <table class="table table-bordered table-hover">
            <?php foreach ($addresses as $result) { ?>
            <tr>
              <td class="text-left"><?php echo $result['address']; ?></td>
              <td class="text-right"><a href="<?php echo $result['update']; ?>" class="button-back no-mt"><?php echo $button_edit; ?></a> <a href="<?php echo $result['delete']; ?>" class="button-back no-mt"><?php echo $button_delete; ?><i class="fa fa-times"></i></a></td>
            </tr>
            <?php } ?>
          </table>
        </div>
      <?php } else { ?>
        <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <div><a href="<?php echo $back; ?>" class="button-back"><?php echo $button_back; ?></a></div>
        <div><a href="<?php echo $add; ?>" class="phpner_-button"><i class="fa fa-plus-circle"></i><?php echo $button_new_address; ?></a></div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>