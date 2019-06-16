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
        <?php if ($articles) { ?>
        <div class="row news-row">
          <?php foreach ($articles as $article) { ?>
          <div class="product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12">
            <div class="product-thumb">
              <div class="image"><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive" /></a></div>
              <div>
                <div class="caption">
                  <h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>
                  <p><?php echo $article['description']; ?></p>
                  <div class="pull-left">
                    <div class="badge-box">
                      <i class="fa fa-clock-o" aria-hidden="true"></i>
                      <span class="badge"><?php echo $article['date_added']; ?></span>
                    </div>
                  </div>
                  <div class="pull-right">
                    <div class="badge-box">
                      <i class="fa fa-comment-o" aria-hidden="true"></i>
                      <span class="badge"><?php echo $article['comments']; ?></span>
                    </div>
                    <div class="badge-box">
                      <i class="fa fa-eye" aria-hidden="true"></i>
                      <span class="badge"><?php echo $article['viewed']; ?></span>
                    </div>
                  </div>
                  <div class="clearfix"></div>
                </div>
              </div>
            </div>
          </div>
          <?php } ?>
        </div>
        <div class="row">
          <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
        </div>
        <?php } ?>
        <?php if ($description) { ?>
        <div class="row">
          <div class="col-sm-12 cat-desc-box">
            <?php if ($description) { ?>
            <?php echo str_replace("<img", "<img class=\"img-responsive\"", $description); ?>
            <?php } ?>
          </div>
        </div>
        <?php } ?>
        <?php if (!$articles) { ?>
        <p class="text-left empty-text"><?php echo $text_empty; ?></p>
        <div class="buttons">
          <div class="text-left"><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>