<div id="phpner_-slideshow<?php echo $module; ?>" class="phpner_-slideshow-box owl-carousel" style="opacity: 1;">
  <?php foreach ($phpner_banners_plus as $banner) { ?>
  <div class="item container">
    <div class="row">
      <div class="col-sm-4 col-sm-offset-1 phpner_-slideshow-left">
      <div class="phpner_-slideshowplus-header"><?php echo $banner['title']; ?></div>
        <?php echo $banner['description']; ?>
        <div class="phpner_-slideshow-item-button">
          <a href="<?php echo $banner['link']; ?>" class=" phpner_-button"><?php echo $banner['button']; ?> <i class="fa fa-angle-right" aria-hidden="true"></i></a>
        </div>
      </div>
      <div class="col-sm-6 phpner_-slideshow-right">
        <a href="<?php echo $banner['link']; ?>"><img class="img-responsive" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a>
      </div>
    </div>
  </div>
  <?php } ?>
</div>
<script><!--
$('#phpner_-slideshow<?php echo $module; ?>').owlCarousel({
  items: 6,
  
          autoPlay: true,
      
  singleItem: true,
  stopOnHover: true,
  navigation: <?php echo ($arrows[$banner_id]) ? 'true' : 'false'; ?>,
  navigationText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
  pagination: <?php echo ($pagination[$banner_id]) ? 'true' : 'false'; ?>
});
--></script>
