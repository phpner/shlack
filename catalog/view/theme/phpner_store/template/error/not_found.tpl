<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row">
  <div class="breadcrumb-box">
	  <ul class="breadcrumb">
	    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
    		<?php if($count == 0) { ?>
    			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    		<?php } elseif($count+1<count($breadcrumbs)) { ?>
    			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    		<?php } else { ?>
    			<li><span><?php echo $breadcrumb['text']; ?></span></li>
    		<?php } ?>
    	<?php } ?>
	  </ul>
  </div>
  <div class="row">
	  <div class="col-sm-12">
		  <h1 class="cat-header"><?php echo $heading_title; ?></h1>
	  </div>
  </div>
  <div class="row">
    <div id="content" class="col-sm-12 account-content">
      
      <p class="text-center"><?php echo $text_error; ?></p>
      <div class="buttons clearfix text-center">
        <div><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
      </div>
      </div>
  </div>
</div><?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
