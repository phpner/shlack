<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row product-content-row">
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
      <div id="content" class="<?php echo $class; ?> phpner_-news-content">
        <div class="phpner_-news-content-box">
          <?php if ($thumb) { ?>
          <ul class="thumbnails">
            <?php if ($thumb) { ?>
            <li><a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
            <?php } ?>
          </ul>
          <?php } ?>
          <div id="description_block"><?php echo $description; ?></div>
          <?php if ($images) { ?>
          <div class="row thumbnails">
            <?php foreach ($images as $image) { ?>
            <div class="col-md-3 col-sm-6 col-xs-12"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
            <?php } ?>
          </div>
         <?php } ?>
          <div class="clearfix"></div>
          <div class="panel">
            <div class="panel-body phpner_-panel">
              <div class="badge-box">
                <i class="fa fa-clock-o" aria-hidden="true"></i>
                <span class="badge"><?php echo $date_added; ?></span>
              </div>
              <div class="badge-box">
                <i class="fa fa-comment-o" aria-hidden="true"></i>
                <span class="badge"><?php echo $comments; ?></span>
              </div>
              <div class="badge-box">
                <i class="fa fa-eye" aria-hidden="true"></i>
                <span class="badge"><?php echo $viewed; ?></span>
              </div>
            </div>
          </div>
          <?php if ($tags) { ?>
          <div class="panel panel-default">
            <div class="panel-body">
              <div style="float:left;">
                <?php echo $text_tags; ?>
                <?php for ($i = 0; $i < count($tags); $i++) { ?>
                <?php if ($i < (count($tags) - 1)) { ?>
                <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
                <?php } else { ?>
                <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
                <?php } ?>
                <?php } ?>
              </div>
            </div>
          </div>
          <?php } ?>
          <?php if ($comment_show && $comment_write) { ?>
          <h3><?php echo $text_comments; ?></h3>
          <?php if ($comment_show) { ?>
          <div id="comments"></div>
          <?php } ?>
          <?php if ($comment_write) { ?>
          <form class="form-horizontal" id="form-comments">
            <div class="form-group required">
              <div class="col-sm-12">
                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                <input type="text" name="name" value="" id="input-name" class="form-control" />
              </div>
            </div>
            <div class="form-group required">
              <div class="col-sm-12">
                <label class="control-label" for="input-comments"><?php echo $entry_comment; ?></label>
                <textarea name="text" rows="5" id="input-comments" class="form-control"></textarea>
                <div class="help-block"><?php echo $text_note; ?></div>
              </div>
            </div>
            <div class="form-group required">
              <div class="col-sm-12">
                <label class="control-label"><?php echo $entry_rating; ?></label>
                <select id="ratingme" name="rating">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                </select>
                <script>
                  $(function() {
                   $('#ratingme').barrating({
                     theme: 'fontawesome-stars'
                   });
                  });
                </script>
              </div>
            </div>
            <?php echo $captcha; ?>
            <?php if ($text_terms) { ?>
            <div>
              <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;display:inline-block;margin: 0;" />
            </div>
            <?php } ?>
            <div class="buttons clearfix">
              <div class="text-left">
                <button type="button" id="button-comments" data-loading-text="<?php echo $text_loading; ?>" class="phpner_-button"><?php echo $button_continue; ?></button>
              </div>
            </div>
          </form>
          <?php } ?>
          <?php } ?>
        </div>
        <?php if ($articles) { ?>
        <h3><?php echo $text_related_articles; ?></h3>
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
        <?php } ?>  
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php if ($products) { ?>
  <div class="row phpner_-carousel-row">
    <div class="col-sm-12">
      <div class="phpner_-carousel-box">
        <h2 class="phpner_-carousel-header"><?php echo $text_related_products; ?></h2>
        <div id="owl-carousel-module-products" class="owl-carousel owl-theme">
          <?php foreach ($products as $product) { ?>     
          <div class="item">
            <div class="image">
              <?php if ($product['special']) { ?>
              <div class="phpner_-discount-box">
                <div class="phpner_-discount-item">-<?php echo $product['saving']; ?>%</div>
              </div>
              <?php } ?>
              <?php if ($product['phpner_product_stickers']) { ?>
              <div class="phpner_-sticker-box">
                <?php foreach ($product['phpner_product_stickers'] as $product_sticker) { ?>
                <div class="phpner_-sticker-item" style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;"><?php echo $product_sticker['text']; ?></div>
                <?php } ?>
              </div>
              <?php } ?>
              <?php if (isset($phpner_popup_view_data['status']) && $phpner_popup_view_data['status'] && $product['quantity'] > 0) { ?>
              <div class="quick-view"><a onclick="get_phpner_popup_product_view('<?php echo $product['product_id']; ?>');"><?php echo $button_popup_view; ?></a></div>
              <?php } ?>   
              <?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name'] ?>" /></a>
              <?php } ?>
            </div>
            <div class="name">
              <a href="<?php echo $product['href']; ?>"><?php echo $product['name'] ?></a>
            </div>
            <?php if ($product['rating']) { ?>
            <div class="rating">
              <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($product['rating'] < $i) { ?>
              <i class="fa fa-star-o" aria-hidden="true"></i>
              <?php } else { ?>
              <i class="fa fa-star" aria-hidden="true"></i>
              <?php } ?>
              <?php } ?>
            </div>
            <?php } ?>
            <?php if ($product['price']) { ?>
            <div class="price">
                <?php if (!$product['special']) { ?>
                  <span class="price-new phpner_-price-normal"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                  <span class="price-old phpner_-price-old"><?php echo $product['price']; ?></span><span class="price-new phpner_-price-new"><?php echo $product['special']; ?></span>
                <?php } ?>
              </div>
            <?php } ?>
            <div class="cart">
              <?php if ($product['quantity'] > 0) { ?>
              <a class="button-cart phpner_-button" title="<?php echo $button_cart; ?>" onclick="get_phpner_popup_add_to_cart('<?php echo $product['product_id']; ?>', '1');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_cart; ?></a>
              <?php } else { ?>
              <a class="out-of-stock-button phpner_-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_phpner_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><?php echo $product['product_preorder_text']; ?></a>
              <?php } ?>
              <a onclick="get_phpner_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist phpner_-button"><i class="fa fa-heart" aria-hidden="true"></i></a>
              <a onclick="get_phpner_popup_add_to_compare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="compare phpner_-button"><i class="fa fa-sliders" aria-hidden="true"></i></a>
            </div>
          </div>
          <?php } ?>   
        </div>
      </div>
    </div>
  </div>
  <script>
    $('#owl-carousel-module-products').owlCarousel({
      items: 4,
      itemsDesktop : [1921, 4],
      itemsDesktop : [1199, 4],
      itemsDesktopSmall : [979, 3],
      itemsTablet : [768, 2],
      itemsMobile : [479, 1],
      autoPlay: false,
      navigation: true,
      slideMargin: 10,
      navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
      stopOnHover:true,
      smartSpeed: 800,
      loop: true,
      pagination: false
    });
  </script>
  <?php } ?>  
  <?php echo $content_bottom; ?>
</div>
<script><!--
  $('.img-class').each(function(){
    var $this = $(this); 
    $this.wrap('<a class="hrefimage" href="' + $this.attr('src') + '"></a>');
  });
  
  $(document).ready(function() {
    $('.hrefimage').magnificPopup({
      type: 'image',
      closeOnContentClick: true,
      closeBtnInside: false,
      fixedContentPos: true,
      mainClass: 'mfp-no-margins mfp-with-zoom', 
      image: {
        verticalFit: true
      },
      zoom: {
        enabled: true,
        duration: 300 
      }
    });
  });
  $('#comments').delegate('.pagination a', 'click', function(e) {
      e.preventDefault();
  
      $('#comments').fadeOut('slow');
  
      $('#comments').load(this.href);
  
      $('#comments').fadeIn('slow');
  });
  
  $('#comments').load('index.php?route=phpner/blog_article/comments&phpner_blog_article_id=<?php echo $phpner_blog_article_id; ?>');
  
  $('#button-comments').on('click', function() {
    $.ajax({
      url: 'index.php?route=phpner/blog_article/write&phpner_blog_article_id=<?php echo $phpner_blog_article_id; ?>',
      type: 'post',
      dataType: 'json',
      data: $("#form-comments").serialize(),
      beforeSend: function() {
        $('#button-comments').button('loading');
      },
      complete: function() {
        $('#button-comments').button('reset');
      },
      success: function(json) {
        $('.alert-success, .alert-danger').remove();
  
        if (json['error']) {
          $('#comments').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        }
  
        if (json['success']) {
          $('#comments').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
  
          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          $('input[name=\'rating\']:checked').prop('checked', false);
          $('input[name=\'terms\']:checked').prop('checked', false);
        }
      }
    });
  });
  
  function comment_plus(phpner_blog_comment_id) {
    $.ajax({
      url: 'index.php?route=phpner/blog_article/comment_plus&phpner_blog_comment_id='+phpner_blog_comment_id+'&phpner_blog_article_id=<?php echo $phpner_blog_article_id; ?>',
      dataType: 'json',
      success: function(json) {
        $('.alert-danger').remove();
  
        if (json['error']) {
          $('#comments').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        } else {
          $('#comment_plus_count-'+phpner_blog_comment_id).html(json['value']);
        }
      }
    });
  }
  
  function comment_minus(phpner_blog_comment_id) {
    $.ajax({
      url: 'index.php?route=phpner/blog_article/comment_minus&phpner_blog_comment_id='+phpner_blog_comment_id+'&phpner_blog_article_id=<?php echo $phpner_blog_article_id; ?>',
      dataType: 'json',
      success: function(json) {
        $('.alert-danger').remove();
  
        if (json['error']) {
          $('#comments').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        } else {
          $('#comment_minus_count-'+phpner_blog_comment_id).html(json['value']);
        }
      }
    });
  }
  
  $(document).ready(function() {
    $('#description_block').find('img').addClass('img-responsive');
  
    $('.thumbnails').magnificPopup({
      type:'image',
      delegate: 'a',
      gallery: {
        enabled:true
      }
    });
  });
  //-->
</script>
<?php echo $footer; ?>