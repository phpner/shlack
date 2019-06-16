<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row product-content-row">
    <div class="breadcrumb-box">
      	 <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
		    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
			    <?php if($count == 0) { ?>
				  <li>
					<a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $phpner_home_text; ?>">
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
      <?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>"<?php if ($tech_pr_micro == "on") { ?> itemscope itemtype="https://schema.org/Product"<?php } ?>>
        <?php if ($tech_pr_micro == "on") { ?><span class="micro-name" itemprop="name"><?php echo $heading_title; ?></span><?php } ?>
        <div class="row">
          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } ?>
          <div class="<?php echo $class; ?> left-info">
            <?php if ($thumb || $images) { ?>
            <ul>
              <?php if ($special) { ?>
              <li id="main-product-you-save">-<?php echo $economy; ?>%</li>
              <?php } ?>
              
              <?php if ($phpner_product_stickers) { ?>
              <li class="product-sticker-box">
                <?php foreach ($phpner_product_stickers as $product_sticker) { ?>
                <div style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;">
                  <?php echo $product_sticker['text']; ?>
                </div>
                <?php } ?>
              </li>
              <?php } ?>
              <?php if ($images) { ?>
              <?php if ($thumb) { ?>
              <li class="image thumbnails-one thumbnail">
                <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" <?php if ($check_zoom) { ?>data-fancybox="images"<?php } else { ?>onclick="$('.cloud-zoom-gallery').eq(0).click(); return false; "<?php } ?> class='cloud-zoom' id='zoom1' data-index="0">
                <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" class="img-responsive" alt="<?php echo $heading_title; ?>" />
                </a>
              </li>
              <?php } ?>
              <?php if (count($images) > 0) { ?>
              <li class="image-additional" id="image-additional">
                <div class="thumbnails all-carousel">
                  <?php $data_index = 0; foreach ($images as $image) { ?>
                  <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" data-fancybox="images" data-index="<?php echo $data_index; ?>" data-main-img="<?php echo $image['main_img']; ?>" data-main-popup="<?php echo $image['main_popup']; ?>" class="cloud-zoom-gallery <?php if ($data_index == 0) { ?>selected-thumb<?php } ?>" data-rel="useZoom: 'zoom1', smallImage: '<?php echo $image['popup']; ?>'">
                  <img src="<?php echo $image['thumb']; ?>" <?php if ($tech_pr_micro == "on") { ?>itemprop="image" <?php } ?>title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
                  </a>
                  <?php $data_index++; } ?>
                </div>
              </li>
              <?php } ?>
              <?php } ?>
            </ul>
            <?php } ?>
          </div>
          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } ?>
          <div id="product-info-right" class="<?php echo $class; ?>">
            <h1 class="product-header"><?php echo $heading_title; ?></h1>
            <div class="row after-header-row">
              <div class="col-sm-4 col-xs-12">
                <div class="after-header-item">
                  <span class="blue"><i class="fa fa-check-circle" aria-hidden="true"></i></span> <span><?php echo $stock; ?></span>
                </div>
              </div>
              <div class="col-sm-4 col-xs-12 product-rating-box">
                <div class="after-header-item">
                  <span><?php echo $text_raiting; ?></span>
                  <?php $rating_data = preg_replace("/[^0-9]/", '', $reviews); ?>
                  <span class="rating" <?php if ($tech_pr_micro == "on" && $rating_data>0) { ?> itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating"<?php } ?>>
                    <?php if ($tech_pr_micro == "on" && $rating_data>0) { ?>
                    <meta itemprop="reviewCount" content="<?php echo $rating_data; ?>">
                    <meta itemprop="ratingValue" content="<?php echo $rating; ?>">
                    <meta itemprop="bestRating" content="5" />
                    <?php } ?>
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                    <?php if ($rating < $i) { ?>
                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                    <?php } else { ?>
                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                    <?php } ?>
                    <?php } ?>
                  </span>
                </div>
              </div>
              <div class="col-sm-4 col-xs-12">
                <div class="after-header-item">
                  <span class="blue"><i class="fa fa-pencil-square" aria-hidden="true"></i></span> <span><a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); $('html, body').animate({scrollTop: $('h2.scrolled').offset().top-80}, 800);return false;"><?php echo $phpner_text_review; ?></a></span> 
                </div>
              </div>
            </div>
            <div id="product">
              <?php if ($options) { ?>
              <hr>
              <h3 class="options-header"><?php echo $text_option; ?></h3>
              <?php foreach ($options as $option) { ?>
              <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status'] && $phpner_advanced_options_settings_data['quantity_status'] && $option['type'] == 'phpner_quantity') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li phpner_-quantity-div">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div class="table-responsive" id="input-option<?php echo $option['product_option_id']; ?>">
                  <table class="table">
                    <thead>
                      <tr>
                        <?php if ($phpner_advanced_options_settings_data['allow_column_q_image']) { ?>
                        <td class="phpner_-col-option-image"><?php echo $text_col_option_image; ?></td>
                        <?php } ?>
                        <td><?php echo $text_col_option_name; ?></td>
                        <?php if ($phpner_advanced_options_settings_data['allow_column_q_sku']) { ?>
                        <td class="phpner_-col-sku"><?php echo $text_col_option_sku; ?></td>
                        <?php } ?>
                        <?php if ($phpner_advanced_options_settings_data['allow_column_q_model']) { ?>
                        <td class="phpner_-col-model"><?php echo $text_col_option_model; ?></td>
                        <?php } ?>
                        <td><?php echo $text_col_option_price; ?></td>
                        <td><?php echo $text_col_option_quantity; ?></td>
                      </tr>
                    </thead>
                    <tbody>
                      <?php foreach ($option['product_option_value'] as $option_value) { ?>
                      <tr>
                        <?php if ($phpner_advanced_options_settings_data['allow_column_q_image']) { ?>
                        <td class="text-left phpner_-col-option-image" style="vertical-align: middle;"><img src="<?php echo $option_value['o_v_image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /></td>
                        <?php } ?>
                        <td class="text-left" style="vertical-align: middle;"><?php echo $option_value['name']; ?></td>
                        <?php if ($phpner_advanced_options_settings_data['allow_column_q_sku']) { ?>
                        <td class="text-left phpner_-col-sku" style="vertical-align: middle;"><?php echo $option_value['sku']; ?></td>
                        <?php } ?>
                        <?php if ($phpner_advanced_options_settings_data['allow_column_q_model']) { ?>
                        <td class="text-left phpner_-col-model" style="vertical-align: middle;"><?php echo $option_value['model']; ?></td>
                        <?php } ?>
                        <td class="text-left" style="vertical-align: middle;"><?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?></td>
                        <td class="text-left phpner_-input-td" style="vertical-align: middle;">
                          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" style="display: none !important; visibility: hidden !important;" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" />
                          <button class="phpner_-button opt-phpner_-button left-opt-button" type="button" onclick="phpner_option_quantity_minus(this,'<?php echo $option_value['product_option_value_id']; ?>');"><i class="fa fa-minus" aria-hidden="true"></i></button>
                          <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
                          <input type="text" value="0" size="2" onchange="phpner_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" onkeyup="phpner_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" class="phpner_-quantity-text-input form-control"   />
                          <?php } else { ?>
                          <input type="text" value="0" size="2" onchange="phpner_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" onkeyup="phpner_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" class="phpner_-quantity-text-input"  />
                          <?php } ?>
                          <button class="phpner_-button opt-phpner_-button right-opt-button" type="button" onclick="phpner_option_quantity_plus(this,'<?php echo $option_value['product_option_value_id']; ?>');"><i class="fa fa-plus" aria-hidden="true"></i></button>
                        </td>
                      </tr>
                      <?php } ?>
                    </tbody>
                  </table>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'select') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
                <select onchange="phpner_update_prices_opt();" name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <?php } else { ?>
                <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                  <?php } ?>
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <option value="<?php echo $option_value['product_option_value_id']; ?>" <?php if (!$option_value['quantity_status']) { ?>disabled="disabled"<?php } ?> data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </option>
                  <?php } ?>
                </select>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'radio') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div class="options-box" id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <?php if ($option_value['image']) { ?>
                  <div class="radio radio-img">
                    <?php if ($option_value['quantity_status']) { ?>
                    <label class="not-selected-img optid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>">
                    <?php } else { ?>
                    <label class="not-selected-img optid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $text_phpner_option_disable; ?>" style="opacity:0.2;cursor:not-allowed;">
                    <?php } ?>  
                    <?php if ($option_value['quantity_status']) { ?>
                    <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
                    <input onchange="phpner_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="none" />
                    <?php } else { ?>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="none" />
                    <?php } ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } else { ?>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" disabled="disabled" />
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>
                    </label>
                  </div>
                  <?php } else { ?>
                  <div class="radio phpner_-product-radio">
                    <?php if ($option_value['quantity_status']) { ?>
                    <label class="optid-<?php echo $option['option_id'];?>" data-toggle="tooltip">
                    <?php } else { ?>
                    <label class="optid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $text_phpner_option_disable; ?>" style="opacity:0.5;cursor:not-allowed;">
                    <?php } ?>  
                    <?php if ($option_value['quantity_status']) { ?>
                    <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
                    <input onchange="phpner_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="product-input-radio none" />
                    <?php } else { ?>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="product-input-radio none" />
                    <?php } ?>
                    <?php } else { ?>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="product-input-radio none" disabled="disabled" />
                    <?php } ?>  
                    <?php echo $option_value['name']; ?>
                    </label>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </div>
                  <?php } ?>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'checkbox') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div class="options-box" id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="checkbox">
                    <label <?php if (!$option_value['quantity_status']) { ?>style="opacity:0.5;cursor:not-allowed;" title="<?php echo $text_phpner_option_disable; ?>"<?php } ?>>
                    <?php if ($option_value['quantity_status']) { ?>  
                    <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
                    <input onchange="phpner_update_prices_opt();" type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" />
                    <?php } else { ?>
                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" />
                    <?php } ?>
                    <?php } else { ?>
                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" disabled="disabled" />
                    <?php } ?>
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'text') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'textarea') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'file') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'date') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group date">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                  </span>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'datetime') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group datetime">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'time') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group time">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span>
                </div>
              </div>
              <?php } ?>
              <?php } ?>
              <?php } ?>
              <div class="row">
                <div class="col-sm-12">
                  <hr class="product-hr">
                </div>
              </div>
              <?php if($special_date_start && $special_date_end > 0) { ?>
              <div class="row" id="product-info-counter">
              	<div class="product-info-counter-header col-lg-4 col-md-12 col-sm-12 col-xs-12"><?php echo $text_counter; ?></div>
	            <link href="catalog/view/javascript/phpner_store/p_special_timer/flipclock.css" rel="stylesheet" media="screen" />
				<script src="catalog/view/javascript/phpner_store/p_special_timer/flipclock.js"></script>
	            <div class="counter col-lg-8 col-md-12 col-sm-12 col-xs-12">
                  <div id="clock-<?php echo $product_id; ?>"></div>
                  <script>
                  $(document).ready(function() {
                    var futureDate  = new Date("<?php echo $special_date_end; ?>");
                    var currentDate = new Date();
                    var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;
                    function dayDiff(first, second) {
                      return (second-first)/(1000*60*60*24);
                    }
                    if (dayDiff(currentDate, futureDate) < 100) {
                      $('.clock').addClass('twoDayDigits');
                    } else {
                      $('.clock').addClass('threeDayDigits');
                    }
                    if(diff < 0) {
                      diff = 0;
                    }
                    clock = $('#clock-<?php echo $product_id; ?>').FlipClock(diff, {
                      clockFace: 'DailyCounter',
                      countdown: true,
                      language: 'Russian'
                    });
                  });
                  </script>
                </div>
                </div>
	            <?php } ?>
              <?php if ($price) { ?>
              <div class="row">
	              
                <div class="col-md-4 col-sm-12 price-col"<?php if ($tech_pr_micro == "on") { ?> itemprop="offers" itemscope itemtype="http://schema.org/Offer"<?php } ?>>
                  <?php if ($tech_pr_micro == "on") {  ?>
                  <span itemprop="availability" class="micro-availability" content="http://schema.org/InStock"><?php echo $stock."\r\n"; ?></span>
                  <meta itemprop="priceCurrency" content="<?php echo $phpner_tech_currency_code_data; ?>" />
                  <span class="micro-price" itemprop="price" content="<?php if (!$special) { echo preg_replace('/[^0-9,.]+/','',rtrim($price, "."));}else{echo preg_replace('/[^0-9,.]+/','',rtrim($special, "."));} ?>"><?php if (!$special) { echo preg_replace('/[^0-9,.]+/','',rtrim($price, "."));}else{echo preg_replace('/[^0-9,.]+/','',rtrim($special, "."));} ?></span>
                  <?php } ?>
                  <div class="product-price">
                  <?php if ($reward) { ?>
		            <span class="phpner_-reward"><?php echo $text_reward; ?> <?php echo $reward; ?></span>
		           <?php } ?>
                  <?php if (!$special) { ?>
                    <h2 id="main-product-price" class="phpner_-price-normal"><?php echo $price; ?></h2>
                  <?php } else { ?>
                    <h3 id="main-product-price" class="phpner_-price-old"><?php echo $price; ?></h3>
                    <h2 id="main-product-special" class="phpner_-price-new"><?php echo $special; ?></h2>
                  <?php } ?>
                  </div>
                  <?php if ($tax) { ?>
                  <p><?php echo $text_tax; ?> <span id="main-product-tax"><?php echo $tax; ?></span></p>
                  <?php } ?>
                  <?php if ($points) { ?>
                  <p><?php echo $text_points; ?> <?php echo $points; ?></p>
                  <?php } ?>
                  <?php if ($discounts) { ?>
                  <?php foreach ($discounts as $discount) { ?>
                  <p><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></p>
                  <?php } ?>
                  <?php } ?>
                </div>
                <?php if (isset($phpner_popup_found_cheaper_data['status']) && $phpner_popup_found_cheaper_data['status']) { ?>
                <div class="col-lg-5 col-md-4 col-sm-6">
                  <div class="found-cheaper">
                    <a href="javascript:void(0);" onclick="get_phpner_popup_found_cheaper('<?php echo $product_id; ?>');"><?php echo $text_phpner_popup_found_cheaper; ?></a>
                  </div>
                </div>
                <?php } ?>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
                  <div class="number">
                    <input name="product_id" value="<?php echo $product_id; ?>" style="display: none;" type="hidden">
                    <div class="frame-change-count">
                      <div class="btn-minus">
                        <button type="button" id="superminus" onclick="$(this).parent().next().val(~~$(this).parent().next().val()-1); phpner_update_product_quantity('<?php echo $product_id; ?>');">
                        <span class="icon-minus"><i class="fa fa-minus"></i></span>
                        </button>
                      </div>
                      <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="8" class="plus-minus" id="input-quantity" onchange="phpner_update_prices_opt(); return validate(this);" onkeyup="phpner_update_prices_opt(); return validate(this);">
                      <div class="btn-plus">
                        <button type="button" id="superplus" onclick="$(this).parent().prev().val(~~$(this).parent().prev().val()+1); phpner_update_product_quantity('<?php echo $product_id; ?>');">
                        <span class="icon-plus"><i class="fa fa-plus"></i></span>
                        </button>
                      </div>
                    </div>
                  </div>
                  <?php } else { ?>
                  <div class="number">
                    <input name="product_id" value="<?php echo $product_id; ?>" style="display: none;" type="hidden">
                    <div class="frame-change-count">
                      <div class="btn-minus">
                        <button type="button" id="superminus" onclick="$(this).parent().next().val(~~$(this).parent().next().val()-1);">
                        <span class="icon-minus"><i class="fa fa-minus"></i></span>
                        </button>
                      </div>
                      <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="8" class="plus-minus" id="input-quantity" onchange="return validate(this);" onkeyup="return validate(this);">
                      <div class="btn-plus">
                        <button type="button" id="superplus" onclick="$(this).parent().prev().val(~~$(this).parent().prev().val()+1);">
                        <span class="icon-plus"><i class="fa fa-plus"></i></span>
                        </button>
                      </div>
                    </div>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($minimum > 1) { ?>
              <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <input type="hidden" id="minimumval" value="<?php echo $minimum; ?>">
              <?php } ?>
              <div class="row product-buttons-row">
                <div class="col-sm-12">
                  <div class="product-buttons-box<?php if ($disable_buy != 0) { ?> preorder-buttons-box<?php } ?>">
                    <?php if ($disable_buy == 0) { ?>
                    <a href="javascript:void(0);" data-toggle="tooltip" id="button-cart" title="<?php echo $button_cart; ?>" data-loading-text="<?php echo $text_loading; ?>" class="phpner_-button"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-sm hidden-xs"><?php echo $button_cart; ?></span></a>
                    <?php } elseif ($disable_buy == 2) { ?>
                    <a style="display:none;" href="javascript:void(0);" title="<?php echo $stockbutton; ?>" class="phpner_-button"><span class="hidden-sm hidden-xs"><?php echo $stockbutton; ?><span></a>
                    <?php } else { ?>
                    <a href="javascript:void(0);" title="<?php echo $stockbutton; ?>" class="phpner_-button phpner_-preorder-button" onclick="get_phpner_product_preorder('<?php echo $product_id; ?>'); return false"><span><?php echo $stockbutton; ?></span></a>
                    <?php } ?>
                    <?php if (isset($phpner_popup_purchase_data['status']) && $phpner_popup_purchase_data['status'] && $disable_buy == 0) { ?>
                    <a href="javascript:void(0);" data-toggle="tooltip" class="phpner_-button button-one-click" title="<?php echo $text_phpner_popup_purchase; ?>" onclick="get_phpner_popup_purchase('<?php echo $product_id; ?>');"><i class="fa fa-hand-pointer-o" aria-hidden="true"></i> <span class="hidden-sm hidden-xs"><?php echo $text_phpner_popup_purchase; ?></span></a>
                    <?php } ?>
                    <a href="javascript:void(0);" data-toggle="tooltip" class="phpner_-button button-wishlist" title="<?php echo $button_wishlist; ?>" onclick="get_phpner_popup_add_to_wishlist('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></a>
                    <a href="javascript:void(0);" data-toggle="tooltip" class="phpner_-button button-compare" title="<?php echo $button_compare; ?>" onclick="get_phpner_popup_add_to_compare('<?php echo $product_id; ?>');"><i class="fa fa-sliders" aria-hidden="true"></i></a>
                  </div>
                </div>
              </div>
              
              <?php if ($phpner_store_pr_social_button_script) { ?>
              <?php echo $phpner_store_pr_social_button_script; ?>
              <?php } ?>
              <div class="row">
                <div class="col-sm-12">
                  <hr class="product-hr">
                </div>
              </div>
              <ul class="list-unstyled product-info-ul">
                <?php if ($manufacturer) { ?>
                <li class="product-info-li"><span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php if ($tech_pr_micro == "on") { ?><span itemprop="brand"><?php } ?><?php echo $manufacturer; ?><?php if ($tech_pr_micro == "on") { ?></span><?php } ?></a></li>
                <?php } ?>
                <li class="product-info-li main-product-model"><span><?php echo $text_model; ?></span> <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?><strong id="main-product-model" style="font-weight: normal;"<?php if ($tech_pr_micro == "on") { ?> itemprop="model"<?php } ?>><?php echo $model; ?></strong><?php } else { ?><?php if ($tech_pr_micro == "on") { ?><span itemprop="model"><?php } ?><?php echo $model; ?><?php if ($tech_pr_micro == "on") { ?></span><?php } } ?></li>
                <?php if ($sku) { ?>
                <li class="product-info-li main-product-sku"><span><?php echo $text_sku; ?></span> <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?><strong id="main-product-sku" style="font-weight: normal;"><?php echo $sku; ?></strong><?php } else { ?><?php echo $sku; ?><?php } ?></li>
                <?php } ?>
              </ul>
              <?php if ($recurrings) { ?>
              <hr>
              <h3><?php echo $text_payment_recurring; ?></h3>
              <div class="form-group required">
                <select name="recurring_id" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($recurrings as $recurring) { ?>
                  <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
                  <?php } ?>
                </select>
                <div class="help-block" id="recurring-description"></div>
              </div>
              <?php } ?>
              <?php if ($garanted_text) { ?>
              <hr>
              <div class="product-advantages-box">
                <div class="row">
                  <?php foreach ($garanted_text as $garanted) { ?>
                  <div class="col-xs-6 col-sm-6 col-md-3 product-advantages-item">
                    <a href="<?php echo $garanted['link']; ?>" <?php if ($garanted['popup'] == 'on' && $garanted['link'] && $garanted['link'] != '#') { ?>id="open-popup-garanted-<?php echo $garanted['id']; ?>"<?php } ?>>
                    <?php if ($garanted['icon']) { ?>
                    <i class="<?php echo $garanted['icon']; ?>" aria-hidden="true"></i>
                    <?php } ?>
                    <span><?php echo $garanted['name']; ?></span>
                    </a>
                    <?php if ($garanted['popup'] == 'on' && $garanted['link'] && $garanted['link'] != '#') { ?>
                    <script>
                      $(document).delegate('#open-popup-garanted-<?php echo $garanted['id']; ?>', 'click', function(e) {
                        e.preventDefault();
                      
                        var element = this;
                      
                        $.ajax({
                          url: $(element).attr('href'),
                          type: 'get',
                          dataType: 'html',
                          success: function(data) {
                            $.magnificPopup.open({
                              tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
                              items: {
                                src:  '<div id="service-popup" class="white-popup mfp-with-anim narrow-popup">'+
                                        '<h2 class="popup-header">' + $(element).text() + '</h2>'+
                                        '<div class="popup-text service-popup-text">'+
                                          '<p>' + data + '</p>'+
                                        '</div>'+
                                      '</div>',
                                type: 'inline'
                              },
                              showCloseBtn: true,
                              midClick: true, 
                              removalDelay: 200
                            });
                          }
                        });
                      });
                    </script>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>
        <div class="row product-tabs-row">
          <div class="col-sm-12">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
              <?php if ($attribute_groups) { ?>
              <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
              <?php } ?>
              <?php if ($review_status) { ?>
              <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
              <?php } ?>
              <?php if ($phpner_product_extra_tabs) { ?>
              <?php $tab_i=0; foreach ($phpner_product_extra_tabs as $product_extra_tab) { ?>
              <li><a href="#tab-extra-<?php echo $tab_i; ?>" data-toggle="tab"><?php echo $product_extra_tab['title']; ?></a></li>
              <?php $tab_i++; } ?>
              <?php } ?>
              <?php if ($phpner_pr_additional_tab) { ?>
              <li><a href="#tab-phpner_pr_additional_tab" class="scrolled" data-toggle="tab"><?php echo $phpner_pr_additional_tab['heading']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab-description">
                <?php if ($tech_pr_micro == "on") { ?>
                <div itemprop="description"><?php } ?>
                  <?php echo $description; ?>
                  <?php if ($tech_pr_micro == "on") { ?>
                </div>
                <?php } ?>
              </div>
              <?php if ($attribute_groups) { ?>
              <div class="tab-pane" id="tab-specification">
                <div class="phpner_-specification">
                  <div class="table">
                    <?php foreach ($attribute_groups as $attribute_group) { ?>
                    <div class="row">
                      <div class="col-sm-12">
                        <div class="head-td"><strong><?php echo $attribute_group['name']; ?></strong></div>
                      </div>
                    </div>
                    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                    <div  class="row">
                      <div class="col-xs-5">
                        <div class="attr-td"><?php echo $attribute['name']; ?></div>
                      </div>
                      <div class="col-xs-7">
                        <div class="attr-td"><?php echo $attribute['text']; ?></div>
                      </div>
                    </div>
                    <?php } ?>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <?php } ?>
              <?php if ($review_status) { ?>
              <div class="tab-pane" id="tab-review">
                <form class="form-horizontal" id="form-review">
                  <div id="review"></div>
                  <h2 class="scrolled"><?php echo $text_write; ?></h2>
                  <?php if ($review_guest) { ?>
                  <div class="form-group required">
                    <div class="col-sm-12">
                      <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                      <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
                    </div>
                  </div>
                  <?php if (isset($phpner_product_reviews_data['status']) && $phpner_product_reviews_data['status']) { ?>
                  <div class="col-sm-6">
                    <div class="form-group positive-text-box">
                      <label class="control-label" for="input-positive_text"><?php echo $entry_positive_text; ?></label>
                      <textarea name="positive_text" rows="4" id="input-positive_text" class="form-control"></textarea>
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group  negative-text-box">
                      <label class="control-label" for="input-negative_text"><?php echo $entry_negative_text; ?></label>
                      <textarea name="negative_text" rows="4" id="input-negative_text" class="form-control"></textarea>
                    </div>
                  </div>
                  <input type="hidden" name="where_bought" value="1" />
                  <?php } ?>
                  <div class="form-group required">
                    <div class="col-sm-12">
                      <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                      <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                      <div class="help-block"><?php echo $text_note; ?></div>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-1"><?php echo $entry_rating; ?></label>
                    <div class="col-sm-11">
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
                    <div class="clearfix"></div>
                  </div>
                  <?php echo $captcha; ?>
                  <?php if ($text_terms) { ?>
                  <div>
                    <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;display:inline-block;margin: 0;" />
                  </div>
                  <?php } ?>
                  <div class="buttons clearfix">
                    <div class="pull-left">
                      <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="phpner_-button"><?php echo $button_continue; ?></button>
                    </div>
                  </div>
                  <?php } else { ?>
                  <?php echo $text_login; ?>
                  <?php } ?>
                </form>
              </div>
              <?php } ?>
              <?php if ($phpner_product_extra_tabs) { ?>
              <?php $tab_i=0; foreach ($phpner_product_extra_tabs as $product_extra_tab) { ?>
              <div class="tab-pane" id="tab-extra-<?php echo $tab_i; ?>"><?php echo $product_extra_tab['text']; ?></div>
              <?php $tab_i++; } ?>
              <?php } ?>
              <?php if ($phpner_pr_additional_tab) { ?>
              <div class="tab-pane" id="tab-phpner_pr_additional_tab">
                <?php echo $phpner_pr_additional_tab['text']; ?>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>
        <?php if ($products) { ?>
        <div class="phpner_-carousel-row phpner_-related-row">
          <div class="phpner_-carousel-box">
            <div class="phpner_-carousel-header"><?php echo $text_related; ?></div>
            <div id="phpner_-related" class="owl-carousel owl-theme">
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
                  <a class="out-of-stock-button phpner_-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_phpner_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $product['product_preorder_text']; ?></span></a>
                  <?php } ?>
                  <a onclick="get_phpner_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist phpner_-button"><i class="fa fa-heart" aria-hidden="true"></i></a>
                  <a onclick="get_phpner_popup_add_to_compare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="compare phpner_-button"><i class="fa fa-sliders" aria-hidden="true"></i></a>
                </div>
              </div>
              <?php } ?>   
            </div>
          </div>
        </div>
        <script>
          $('#phpner_-related').owlCarousel({
              items: 4,
          itemsDesktop : [1921,4],
          itemsDesktop : [1199,4],
          itemsDesktopSmall : [979,3],
          itemsTablet : [768,2],
          itemsMobile : [479,1],
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
        <?php if ($tags) { ?>
        <p><?php echo $text_tags; ?>
          <?php for ($i = 0; $i < count($tags); $i++) { ?>
          <?php if ($i < (count($tags) - 1)) { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
          <?php } else { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
          <?php } ?>
          <?php } ?>
        </p>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<?php if ($options) { ?>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'radio') { ?>
<?php foreach ($option['product_option_value'] as $option_value) { ?>
<?php if ($option_value['image']) { ?>
<script>
  $(function() {
     $('label.optid-<?php echo $option['option_id'];?>').click(function(){
       if ($(this).find('input[type=radio]').is('input:disabled')) {
        //$('label.selected-img').removeClass('selected-img').addClass('not-selected-img');
       } else {
        $('label.optid-<?php echo $option['option_id'];?>').removeClass('selected-img').addClass('not-selected-img');
        $(this).removeClass('not-selected-img').addClass('selected-img');
       }
     }); 
  });    
</script>
<?php } else { ?>
<script>
  $(function() {
     $('label.optid-<?php echo $option['option_id'];?>').click(function(){
       if ($(this).find('input[type=radio]').is('input:disabled')) {
        $('label.selected').removeClass('selected').addClass('not-selected');
        $(this).css({
          'opacity': 0.5,
          'cursor': 'not-allowed'
        });
       } else {
        $('label.optid-<?php echo $option['option_id'];?>').removeClass('selected').addClass('not-selected');
        $(this).removeClass('not-selected').addClass('selected');
       }
     }); 
  });    
</script>
<?php } ?>
<?php } ?>
<?php } ?>
<?php } ?>
<?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
<script>
  <?php if ($phpner_advanced_options_settings_data['allow_autoselect_option']) { ?>
  $(function() {
    $.each($('div.product-info-li').not('.phpner_-quantity-div'), function(i, val) {
      setTimeout(function() {
        $(val).find('input[type=\'radio\']').eq(0).click();
        $(val).find('input[type=\'checkbox\']').eq(0).click();
        $(val).find('select option:nth-child(2)').attr("selected", "selected").trigger('change');
      }, i * 1000);
    });
  });
  <?php } ?>
  <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?>
  $(document).on('change', '#product input[type=\'radio\']', function() {
    $('#main-product-sku').html($(this).attr('data-option-sku'));
  });
  $(document).on('change', '#product input[type=\'text\']', function() {
    $('#main-product-sku').html($(this).attr('data-option-sku'));
  });
  <?php } ?>
  <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?>
  $(document).on('change', '#product input[type=\'radio\']', function() {
    $('#main-product-model').html($(this).attr('data-option-model'));
  });
  $(document).on('change', '#product input[type=\'text\']', function() {
    $('#main-product-model').html($(this).attr('data-option-model'));
  });
  <?php } ?>
  <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?>
  $(document).on('change', '#product input[type=\'checkbox\']', function() {
    if ($(this).is(':checked')) {
      $('#main-product-sku').html($(this).attr('data-option-sku'));
    } else {
      $('#main-product-sku').html('<?php echo $sku; ?>');
    }
  });
  <?php } ?>
  <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?>
  $(document).on('change', '#product input[type=\'checkbox\']', function() {
    if ($(this).is(':checked')) {
      $('#main-product-model').html($(this).attr('data-option-model'));
    } else {
      $('#main-product-model').html('<?php echo $model; ?>');
    }
  });
  <?php } ?>
  <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?>
  $(document).on('change', '#product select', function() {
    $('#main-product-sku').html($(this).find(':selected').attr('data-option-sku'));
  });
  <?php } ?>
  <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?>
  $(document).on('change', '#product select', function() {
    $('#main-product-model').html($(this).find(':selected').attr('data-option-model'));
  });
  <?php } ?>
</script>
<script>
  function phpner_option_quantity_minus(e,i) {
    if (~~$(e).next().val() > 0) { 
      $(e).next().val(~~$(e).next().val()-1); 
      $(e).prev().val(i+'|'+$(e).next().val()); 
      $(e).prev().prop('checked', true); 
    } 
    if (~~$(e).next().val() <= 0) { 
      $(e).prev().removeAttr('checked'); 
    } 
    <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?>
      if ($(e).prev().is(':checked')) {
        $('#main-product-model').html($(e).prev().attr('data-option-model'));
      } else {
        $('#main-product-model').html('<?php echo $model; ?>');
      }
    <?php } ?>
    <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?>
      if ($(e).prev().is(':checked')) {
        $('#main-product-sku').html($(e).prev().attr('data-option-sku'));
      } else {
        $('#main-product-sku').html('<?php echo $sku; ?>');
      }
    <?php } ?>
    <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
      phpner_update_prices_opt();
    <?php } ?>
  }
  
  function phpner_option_quantity_manual(e,i) {
    $(e).prev().prev().val(i+'|'+$(e).val());
    $(e).prev().prev().prop('checked', true); 
    if ($(e).val() <= 0) { 
      $(e).prev().prev().removeAttr('checked'); 
    }
    <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?>
      if ($(e).prev().prev().is(':checked')) {
        $('#main-product-model').html($(e).prev().prev().attr('data-option-model'));
      } else {
        $('#main-product-model').html('<?php echo $model; ?>');
      }
    <?php } ?>
    <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?>
      if ($(e).prev().prev().is(':checked')) {
        $('#main-product-sku').html($(e).prev().prev().attr('data-option-sku'));
      } else {
        $('#main-product-sku').html('<?php echo $sku; ?>');
      }
    <?php } ?>
    <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
      phpner_update_prices_opt();
    <?php } ?>
  }
  
  function phpner_option_quantity_plus(e,i) {
    $(e).prev().val(~~$(e).prev().val()+1); 
    $(e).prev().prev().prev().val(i+'|'+$(e).prev().val()); 
    $(e).prev().prev().prev().prop('checked', true); 
    
    <?php if ($phpner_advanced_options_settings_data['allow_model']) { ?>
      if ($(e).prev().prev().prev().is(':checked')) {
        $('#main-product-model').html($(e).prev().prev().prev().attr('data-option-model'));
      } else {
        $('#main-product-model').html('<?php echo $model; ?>');
      }
    <?php } ?>
    <?php if ($phpner_advanced_options_settings_data['allow_sku']) { ?>
      if ($(e).prev().prev().prev().is(':checked')) {
        $('#main-product-sku').html($(e).prev().prev().prev().attr('data-option-sku'));
      } else {
        $('#main-product-sku').html('<?php echo $sku; ?>');
      }
    <?php } ?>
    <?php if (isset($phpner_advanced_options_settings_data['status']) && $phpner_advanced_options_settings_data['status']) { ?>
      phpner_update_prices_opt();
    <?php } ?>
  }
</script>
<script><!--
  $('#product .date').datetimepicker({
    pickTime: false
  });
  
  $('#product .datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });
  
  $('#product .time').datetimepicker({
    pickDate: false
  });
  
  $('#product button[id^=\'button-upload\']').on('click', function() {
    var node = this;
  
    $('#form-upload').remove();
  
    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
  
    $('#form-upload input[name=\'file\']').trigger('click');
  
    if (typeof timer != 'undefined') {
        clearInterval(timer);
    }
  
    timer = setInterval(function() {
      if ($('#form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);
  
        $.ajax({
          url: 'index.php?route=tool/upload',
          type: 'post',
          dataType: 'json',
          data: new FormData($('#form-upload')[0]),
          cache: false,
          contentType: false,
          processData: false,
          beforeSend: function() {
            $(node).button('loading');
          },
          complete: function() {
            $(node).button('reset');
          },
          success: function(json) {
            $('.text-danger').remove();
  
            if (json['error']) {
              $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            }
  
            if (json['success']) {
              alert(json['success']);
  
              $(node).parent().find('input').val(json['code']);
            }
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
      }
    }, 500);
  });
  //-->
</script>
<?php } ?>
<script>
  $(document).on('change', '#product input[type=\'radio\'], #product input[type=\'checkbox\'], #product select', function() {
    $.ajax({
      url: 'index.php?route=product/product/getPImages&product_id=<?php echo $product_id; ?>',
      type: 'post',
      data: $('#product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select'),
      dataType: 'json',
      success: function(json) {
        var items2 = [];
  
        if (json['images']) {
          var patterns  = '<div class="thumbnails all-carousel">';
          $.each(json['images'], function(i,val) {
            patterns += '   <a href="'+val['popup']+'" data-fancybox="images" data-index="'+i+'" data-main-img="'+val['main_img']+'" data-main-popup="'+val['main_popup']+'" class="cloud-zoom-gallery" data-rel="useZoom: \'zoom1\', smallImage: \''+val['popup']+'\'">';
            patterns += '     <img class="img-responsive" src="'+val['thumb']+'" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />';
            patterns += '   </a>';  
          });
  
          patterns += '</div>';
        }
  
        $('.left-info #image-additional').html(patterns);
  
        <?php if ($check_zoom) { ?>  
          $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom({position: 'inside'});
  
          if ($('.cloud-zoom-gallery').eq(0).length) {
            $('.cloud-zoom-gallery').eq(0).click();
            $('.cloud-zoom-gallery').eq(0).addClass('selected-thumb');
          }
        <?php } else { ?>
          if ($('.cloud-zoom-gallery').eq(0).length) {
            $('.left-info .thumbnails-one').find('a').attr('href', $('.cloud-zoom-gallery').eq(0).attr('data-main-popup'));
            $('.left-info .thumbnails-one a').find('img').attr('src', $('.cloud-zoom-gallery').eq(0).attr('data-main-img'));
          }
        <?php } ?>
        $('.thumbnails a').on('click', function(e) {
          $(".thumbnails a").removeClass("selected-thumb");
          $(this).addClass("selected-thumb"); 
        });
      }
    });
  });
</script> 
<?php } ?>
<script>
  $(function() {
    <?php if ($minimum > 1) { ?>
      phpner_update_prices_opt();
    <?php } ?>
  });
  
  function phpner_update_prices_opt() { 
    var input_val = $('#product').find('input[name=quantity]').val();
    var quantity = parseInt(input_val);
    var minimumval = $('#minimumval').val();
  
    if (quantity < minimumval) {
      $('.plus-minus').val(minimumval);  
    }
    
    $.ajax({
      type: 'post',
      url:  'index.php?route=product/product/update_prices',
      data: $('#product input[type=\'text\']:not(\'.phpner_-quantity-text-input\'), #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select'),
      dataType: 'json',
      success: function(json) {
        <?php if (!$special) { ?>
          $('#main-product-price').html(json['price']);
        <?php } ?>
        $('#main-product-special').html(json['special']);
        $('#main-product-tax').html(json['tax']);
        $('#main-product-you-save').html(json['you_save']);
      } 
    });
  }
  function phpner_update_product_quantity(product_id) {
    var input_val = $('#product').find('input[name=quantity]').val();
    var quantity = parseInt(input_val);
  
    <?php if ($minimum > 1) { ?>
      if (quantity < <?php echo $minimum; ?>) {
        quantity = $('#product').find('input[name=quantity]').val(<?php echo $minimum; ?>);
        return;
      }
    <?php } else { ?>
      if (quantity == 0) {
        quantity = $('#product').find('input[name=quantity]').val(1);
        return;
      }
    <?php } ?>
  
    $.ajax({
      url: 'index.php?route=product/product/update_prices&product_id=' + product_id + '&quantity=' + quantity,
      type: 'post',
      dataType: 'json',
      data: $('#product input[type=\'text\']:not(\'.phpner_-quantity-text-input\'), #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
      success: function(json) {
        <?php if (!$special) { ?>
          $('#main-product-price').html(json['price']);
        <?php } ?>
        $('#main-product-special').html(json['special']);
        $('#main-product-tax').html(json['tax']);
        $('#main-product-you-save').html(json['you_save']);
      } 
    });
  }
</script>
<?php if ($check_zoom) { ?> 
<script>
  $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom({position: 'inside'}); 
  $(function() {
    $('body').delegate('.mousetrap', 'click', function() {
      var iar = [];
      var ind = '';
      $('.thumbnails a.cloud-zoom-gallery').each(function(index) {
        iar.push({src: $(this).attr('href')});
        
        if ($(this).attr('href') == $("#zoom1").attr('href')) {
          ind = index;
        } 
      });
      $.fancybox.open(iar, {padding : 0, index: ind});
    });
  });
</script>
<?php } else { ?>
<script>
  $(function() {
    if($('[data-fancybox]').length){
      $.fancybox.defaults.hash = false;
    }
  });
</script>
<?php } ?>
<script><!--
  $('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
    $.ajax({
      url: 'index.php?route=product/product/getRecurringDescription',
      type: 'post',
      data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
      dataType: 'json',
      beforeSend: function() {
        $('#recurring-description').html('');
      },
      success: function(json) {
        $('.alert, .text-danger').remove();
  
        if (json['success']) {
          $('#recurring-description').html(json['success']);
        }
      }
    });
  });
  //-->
</script>
<script><!--
  $('#button-cart').on('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/cart/add&phpner_dirrect_add=1',
      type: 'post',
      data: $('#product input[type=\'text\']:not(\'.phpner_-quantity-text-input\'), #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
      dataType: 'json',
      success: function(json) {
        $('.alert, .text-danger').remove();
        $('.form-group').removeClass('has-error');
  
        if (json['error']) {
          if (json['error']['option']) {
            for (i in json['error']['option']) {
              var element = $('#input-option' + i.replace('_', '-'));
  
              if (element.parent().hasClass('input-group')) {
                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
              } else {
                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
              }
            }
          }
  
          if (json['error']['recurring']) {
            $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
          }
  
          // Highlight any found errors
          $('.text-danger').parent().addClass('has-error');
        }
  
        if (json['success']) {
          // $.magnificPopup.open({
          //   tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
          //   items: {
          //     src: "index.php?route=extension/module/phpner_popup_add_to_cart&product_id=" + <?php echo $product_id; ?>,
          //     type: "ajax"
          //   },
          //   midClick: true,
          //   removalDelay: 200
          // });
	        get_phpner_popup_cart();
  
          $("#cart-total").html(json['total']);
          $('#cart > ul').load('index.php?route=common/cart/info ul li');
  
          $.ajax({
            url:  'index.php?route=extension/module/phpner_page_bar/update_html',
            type: 'get',
            dataType: 'json',
            success: function(json) {
              $("#phpner_-bottom-cart-quantity").html(json['total_cart']);
            }
          });
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });
  //-->
</script>
<script><!--
  $('#review').delegate('.pagination a', 'click', function(e) {
      e.preventDefault();
  
      $('#review').fadeOut('slow');
  
      $('#review').load(this.href);
  
      $('#review').fadeIn('slow');
  });
  
  $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
  
  $('#button-review').on('click', function() {
    $.ajax({
      url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
      type: 'post',
      dataType: 'json',
      data: $("#form-review").serialize(),
      beforeSend: function() {
        $('#button-review').button('loading');
      },
      complete: function() {
        $('#button-review').button('reset');
      },
      success: function(json) {
        $('.alert-success, .alert-danger').remove();
  
        if (json['error']) {
          $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        }
  
        if (json['success']) {
          $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
  
          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          <?php if (isset($phpner_product_reviews_data['status']) && $phpner_product_reviews_data['status']) { ?>
          $('textarea[name=\'positive_text\']').val('');
          $('textarea[name=\'negative_text\']').val('');
          <?php } ?>
          $('input[name=\'rating\']:checked').prop('checked', false);
          <?php if ($text_terms) { ?>
          $('input[name=\'terms\']:checked').prop('checked', false);
          <?php } ?>
        }
      }
    });
    <?php if ($captcha) { ?>
    grecaptcha.reset();
    <?php } ?>
  });
  
  $(function() {  
    var hash = window.location.hash;
    if (hash) {
      var hashpart = hash.split('#');
      var  vals = hashpart[1].split('-');
      for (i=0; i<vals.length; i++) {
        $('div.options').find('select option[value="'+vals[i]+'"]').attr('selected', true).trigger('select');
        $('div.options').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
      }
    }
  })
  //-->
</script>
<?php if (isset($phpner_product_reviews_data['status']) && $phpner_product_reviews_data['status']) { ?>
<script>
  function review_reputation(review_id, reputation_type) {
    $.ajax({
      url: 'index.php?route=product/product/phpner_review_reputation&review_id=' + review_id + '&reputation_type=' + reputation_type,
      dataType: 'json',
      success: function(json) {
        $('#form-review .alert-success, #form-review .alert-danger').remove();
  
        if (json['error']) {
          alert(json['error']);
        }
        if (json['success']) {
          alert(json['success']);
          $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
        }
      }
    });
  }
</script>
<?php } ?>
<?php echo $footer; ?>