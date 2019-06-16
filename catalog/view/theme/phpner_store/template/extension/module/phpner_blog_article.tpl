<?php if ($position == "column_left" OR $position == "column_right") { ?>
<div class="row phpner_-carousel-row phpner_-col-module">
<?php } else { ?>
<div class="row phpner_-carousel-row news-row">
<?php } ?>
  <div class="col-sm-12">
    <div class="phpner_-carousel-box">
      <div class="phpner_-carousel-header">
        <?php if ($link == '#') { ?>
          <?php echo $heading_title; ?>
        <?php } else { ?>
          <a href="<?php echo $link; ?>"><?php echo $heading_title; ?></a>
        <?php } ?>
      </div>
      <div id="phpner_-news-carousel-<?php echo $module; ?>" class="owl-carousel owl-theme">
        <?php foreach ($articles as $article) { ?>
          <div class="item">
            <div class="news-item">
              <?php if ($article['thumb']) { ?>
                <div class="image">
                  <a href="<?php echo $article['href']; ?>"><img class="img-responsive" src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" /></a>
                </div> 
              <?php } ?>
              <div class="news-date">
                <span><?php echo $article['date_added']; ?></span>
              </div>
              <div class="name">
                <a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a>
              </div>
              <div class="news-desc">
              	<p><?php echo $article['description']; ?></p>
              </div>
            </div>
          </div> 
        <?php } ?>        
      </div>
    </div>
  </div>
</div>
<script>
  $('#phpner_-news-carousel-<?php echo $module; ?>').owlCarousel({
    items: <?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>,
    itemsDesktop : [1921,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>],
    itemsDesktop : [1199,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>],
    itemsDesktopSmall : [979,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 2; } ?>],
    itemsTablet : [768,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 2; } ?>],
    itemsMobile : [479,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 1; } ?>],
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