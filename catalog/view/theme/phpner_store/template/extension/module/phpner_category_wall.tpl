<div class="row main-advantage-row cat-wall-row">
	<div class="phpner_-carousel-header"><?php echo $heading_title; ?></div>
  <?php foreach ($categories as $category) { ?>
  	<div class="col-sm-4">
  		<div class="main-advantage-item phpner-category-item-box">
  			<?php if ($category['thumb']) { ?>
  			<div class="main-advantage-item-icon phpner_-category-item-icon col-md-4 hidden-sm hidden-xs">
  				<a href="<?php echo $category['href']; ?>"><img class="img-responsive" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" /></a>
  			</div>
		    <?php } ?>
		    <div class="main-advantage-item-text phpner_-category-item-text col-md-8 col-sm-12 col-xs-12">
		    		<a href="<?php echo $category['href']; ?>" class="phpner_-category-item-header"><?php echo $category['name']; ?></a>
		    		<?php if ($category['children']) { ?>
		    		<ul>
			      <?php $countstop = 1; foreach ($category['children'] as $child) { $countstop++; ?>
			        <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
			        <?php if ($countstop > $limit) { ?>
			        <li class="phpner_-category-see-more"><a href="<?php echo $category['href']; ?>" ><?php echo $text_see_more; ?></a></li>
			        <?php break; } ?>
			      <?php } ?>
			    </ul>
			    <?php } ?>
		    </div>
		</div>
	</div>
  <?php } ?>
</div>
