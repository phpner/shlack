<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row">
    <div class="breadcrumb-box">
      	 <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
		    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
			    <?php if($count == 0) { ?>
				  <li>
					<a href="<?php echo $breadcrumb['href']; ?>">
					  <?php echo $breadcrumb['text']; ?>
					</a>
				  </li>
		        <?php } elseif($count+1<count($breadcrumbs)) { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
					<a itemscope itemtype="https://schema.org/Thing" itemprop="item" href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>">
					  <span itemprop="name" class="breadcrumbsitem"><?php echo $breadcrumb['text']; ?></span>
					  <?php echo $breadcrumb['text']; ?>
					</a>
					<meta itemprop="position" content="<?php echo $count; ?>" />
					</li>
		        <?php } else { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
		        	<span itemscope itemtype="https://schema.org/Thing" itemprop="item">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</span>
					<meta itemprop="position" content="<?php echo $count; ?>" />
		        	</li>
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
      <?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>">
        <?php if ($categories) { ?>
        <p><strong><?php echo $text_index; ?></strong>
          <?php foreach ($categories as $category) { ?>
          &nbsp;&nbsp;&nbsp;<a onclick="$('a[href=\'#<?php echo $category['name']; ?>\']').trigger('click'); $('html, body').animate({scrollTop: $('#<?php echo $category['name']; ?>').offset().top-80}, 1800);return false;" href="#"><?php echo $category['name']; ?></a>
          <?php } ?>
        </p>
        <?php foreach ($categories as $category) { ?>
        <h2 id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h2>
        <?php if ($category['manufacturer']) { ?>
        <?php foreach (array_chunk($category['manufacturer'], 6) as $manufacturers) { ?>
        <div class="row">
          <?php foreach ($manufacturers as $manufacturer) { ?>
          <div class="col-sm-2 col-xs-6 phpner_-manufacturer-item">
            <?php if ($show_logo) { ?>
            <a href="<?php echo $manufacturer['href']; ?>"><img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" class="img-responsive"></a>
            <?php } else { ?>
            <span><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></span>
            <?php } ?>
          </div>
          <?php } ?>
        </div>
        <?php } ?>
        <?php } ?>
        <?php } ?>
        <?php } else { ?>
        <p><?php echo $text_empty; ?></p>
        <div class="buttons clearfix">
          <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</div>
<div class="container">
	<div class="row">
 <?php echo $content_bottom; ?>
	</div>
</div>
<?php echo $footer; ?>