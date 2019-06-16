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
      <p class="text-center"></p>
      