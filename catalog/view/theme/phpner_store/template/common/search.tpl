<div id="search" class="input-group">
	<div class="input-group-btn dropdown">
		<button type="button" class="cats-button hidden-xs btn btn-default btn-lg dropdown-toggle" data-toggle="dropdown" aria-expanded="false" data-hover="dropdown">
			<span class="category-name"><?php echo $phpner_search_cat; ?></span><i class="fa fa-caret-down" aria-hidden="true"></i>
		</button>
		<ul class="dropdown-menu">
			<li><a href="#" onclick="return false;" id="0"><?php echo $phpner_search_cat; ?></a></li>
			<?php foreach ($search_phpner_cat as $search_phpner_category) { ?>
			<li><a href="#" onclick="return false;" id="<?php echo $search_phpner_category['category_id']; ?>"><?php echo $search_phpner_category['name']; ?></a></li>
			<?php } ?>
			</ul>
		<input class="selected_phpner_cat" type="hidden" name="category_id" value="0">
	</div>
  <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_search; ?>" class="input-lg" />
  <span class="input-group-btn">
    <button type="button"  id="phpner_-search-button" class="btn btn-default btn-lg btn-search"><i class="fa fa-search"></i></button>
  </span>
</div>
