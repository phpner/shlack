<div class="brands-carousel-box">
  <div id="carousel-<?php echo $module; ?>" class="owl-carousel brands-carousel">
    <?php foreach ($banners as $banner) { ?>
    <div class="item text-center">
      <?php if ($banner['link']) { ?>
      <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
      <?php } else { ?>
      <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
      <?php } ?>
    </div>
    <?php } ?>
  </div>
</div>
<script><!--
$('#carousel-<?php echo $module; ?>').owlCarousel({
  items: 6,
    itemsDesktop : [1921, 6],
    itemsDesktop : [1199, 6],
    itemsDesktopSmall : [979, 4],
    itemsTablet : [768, 4],
    itemsMobile : [479, 2],
  autoPlay: 3000,
  navigation: true,
  navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
  pagination: false
});
--></script>
