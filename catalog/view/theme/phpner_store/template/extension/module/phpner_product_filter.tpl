<div id="filter-column"></div>
<div class="box" id="phpner_-ismobile">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content filtered">
    <input type="hidden" name="temp_limit" value="0" />
    <?php if ($phpner_product_filter_data['selected_values_position'] == 1) { ?>
    <div id="phpner_-selected-values"></div>
    <?php } ?>
    <form method="post" enctype="multipart/form-data" id="phpner_-product-filter-data">
      <?php if ($filter_prices) { ?>
      <div class="inner-box<?php if (!$phpner_product_filter_data['price_collapsed']) { ?> expanded<?php } ?>" data-sort="<?php echo $phpner_product_filter_data['price_sort_order']; ?>" data-type="price">
        <div class="item-title">
          <a class="list-group-item item-name"><span class="name"><?php echo $text_block_price; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['price_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
        </div>
        <div class="list-group-item item-content price-item">
          <div id="phpner_-price-slider"></div>
          <div class="row">
            <div class="col-xs-6"><input type="<?php if ($phpner_product_filter_data['price_input_status']) { ?>text<?php } else { ?>hidden<?php } ?>" name="low_price" value="<?php echo $filter_prices['low_price']; ?>" class="form-control phpner_-inp-pr-filter" /></div>
            <div class="col-xs-6"><input type="<?php if ($phpner_product_filter_data['price_input_status']) { ?>text<?php } else { ?>hidden<?php } ?>" name="high_price" value="<?php echo $filter_prices['high_price']; ?>" class="form-control phpner_-inp-pr-filter" /></div>
          </div>
          <?php if ($filter_special_only) { ?>
			<!-- 3359 -->
			<?php if ($special_only_total) { ?>
			  <div class="checkbox">
				<input id="special-only" type="checkbox" name="special_only" value="1" <?php if ($special_only) { ?>checked="checked"<?php } ?> <?php if (!$special_only_total) { ?>disabled<?php } ?>/>
				<label><?php echo $text_special_products_only; ?></label>
				<?php if ($special_only) { ?>
				  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
				<?php } else { ?>
				  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					<span class="label label-<?php if ($special_only_total) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo ($special_only_total) ? $special_only_total : 0; ?></span>
				  <?php } ?>
				<?php } ?>
			  </div>
			<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
				<div class="checkbox">
					<input id="special-only" type="checkbox" name="special_only" value="1" <?php if ($special_only) { ?>checked="checked"<?php } ?> <?php if (!$special_only_total) { ?>disabled<?php } ?>/>
					<label><?php echo $text_special_products_only; ?></label>
					<?php if ($special_only) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if ($special_only_total) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo ($special_only_total) ? $special_only_total : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				</div>
			<?php } ?>
			<!-- 3359 -->
          <?php } ?>
        </div>
      </div>
      <?php } ?>
      <?php if ($filter_tag) { ?>
      <div class="inner-box<?php if (!$phpner_product_filter_data['tag_collapsed']) { ?> expanded<?php } ?>" data-sort="<?php echo $phpner_product_filter_data['tag_sort_order']; ?>" data-type="tag">
        <div class="item-title">
          <a class="list-group-item item-name"><span class="name"><?php echo $text_block_tag; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['tag_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
        </div>
        <div class="list-group-item item-content">
          <?php if ($tag) { ?>
          <div class="input-group">
            <input type="text" name="tag" value="<?php echo $tag; ?>" class="form-control" placeholder="<?php echo $entry_tag; ?>" />
            <span class="input-group-addon" onclick="$(this).prev().val('');phpner_start_filter();" style="cursor: pointer;"><i class="fa fa-times"></i></span>
          </div>
          <?php } else { ?>
		  <div>
			<input type="text" name="tag" value="<?php echo $tag; ?>" class="form-control" placeholder="<?php echo $entry_tag; ?>" />
		  </div>
          <?php } ?>
          <small class="phpner_-filter-faq"><?php echo $text_tag_faq; ?></small>
        </div>
      </div>
      <?php } ?>
      <?php if ($filter_manufacturer) { ?>
        <div class="inner-box<?php if (!$phpner_product_filter_data['manufacturer_collapsed']) { ?> expanded<?php } ?>" data-sort="<?php echo $phpner_product_filter_data['manufacturer_sort_order']; ?>" data-type="manufacturer">
          <div class="item-title">
            <a class="list-group-item item-name"><span class="name"><?php echo $text_block_manufacturer; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['manufacturer_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
          </div>
          <div class="list-group-item item-content">
            <?php if ($phpner_product_filter_data['manufacturer_display_type'] == 1) { ?>
              <div class="select">
                <select name="m_id" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($filter_manufacturer as $manufacturer_key => $manufacturer) { ?>
					<!-- 3359 -->
					<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>
						<option id="manufacturer-key-<?php echo $manufacturer_key; ?>" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if (!isset($manufacturer['total'][$manufacturer['manufacturer_id']])) { ?>disabled<?php } ?> <?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>selected<?php } ?>><?php echo $manufacturer['name']; ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
							(<?php echo (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) ? $manufacturer['total'][$manufacturer['manufacturer_id']] : 0; ?>)
						<?php } ?>
						</option>
					  <?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						<option id="manufacturer-key-<?php echo $manufacturer_key; ?>" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if (!isset($manufacturer['total'][$manufacturer['manufacturer_id']])) { ?>disabled<?php } ?> <?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>selected<?php } ?>><?php echo $manufacturer['name']; ?>
						  <?php if ($phpner_product_filter_data['show_totals']) { ?>
						  (<?php echo (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) ? $manufacturer['total'][$manufacturer['manufacturer_id']] : 0; ?>)
						  <?php } ?>
						</option>
					<?php } ?>
					<!-- 3359 -->
                  <?php } ?>
                </select>
              </div>
            <?php } elseif ($phpner_product_filter_data['manufacturer_display_type'] == 2) { ?>
              <?php foreach ($filter_manufacturer as $manufacturer_key => $manufacturer) { ?>
				<!-- 3359 -->
				<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>
				  <div class="radio">
					<input type="radio" id="manufacturer-key-<?php echo $manufacturer_key; ?>" name="m_id" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if (!isset($manufacturer['total'][$manufacturer['manufacturer_id']])) { ?>disabled<?php } ?> <?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" style="display:none;" /> <?php echo $manufacturer['name']; ?></label>
					<?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) ? $manufacturer['total'][$manufacturer['manufacturer_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
				  <div class="radio">
					<input type="radio" id="manufacturer-key-<?php echo $manufacturer_key; ?>" name="m_id" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if (!isset($manufacturer['total'][$manufacturer['manufacturer_id']])) { ?>disabled<?php } ?> <?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" style="display:none;" /> <?php echo $manufacturer['name']; ?></label>
					<?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) ? $manufacturer['total'][$manufacturer['manufacturer_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } else { ?>
              <?php foreach ($filter_manufacturer as $manufacturer_key => $manufacturer) { ?>
				<!-- 3359 -->
				<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>
				  <div class="checkbox">
					<input type="checkbox" id="manufacturer-key-<?php echo $manufacturer_key; ?>" name="m_id[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if (!isset($manufacturer['total'][$manufacturer['manufacturer_id']])) { ?>disabled<?php } ?> <?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" style="display:none;" /> <?php echo $manufacturer['name']; ?></label>
					<?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) ? $manufacturer['total'][$manufacturer['manufacturer_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
				  <div class="checkbox">
					<input type="checkbox" id="manufacturer-key-<?php echo $manufacturer_key; ?>" name="m_id[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if (!isset($manufacturer['total'][$manufacturer['manufacturer_id']])) { ?>disabled<?php } ?> <?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" style="display:none;" /> <?php echo $manufacturer['name']; ?></label>
					<?php if (in_array($manufacturer['manufacturer_id'], $manufacturer['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($manufacturer['total'][$manufacturer['manufacturer_id']]) && $manufacturer['total'][$manufacturer['manufacturer_id']]) ? $manufacturer['total'][$manufacturer['manufacturer_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } ?>
              <?php } ?>
            <?php } ?>
          </div>
        </div>
      <?php } ?>
      <?php if ($filter_stock) { ?>
        <div class="inner-box<?php if (!$phpner_product_filter_data['stock_collapsed']) { ?> expanded<?php } ?>" data-sort="<?php echo $phpner_product_filter_data['stock_sort_order']; ?>" data-type="stock">
          <div class="item-title">
            <a class="list-group-item item-name"><span class="name"><?php echo $text_block_stock; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['stock_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
          </div>
          <div class="list-group-item item-content">
            <?php if ($phpner_product_filter_data['stock_display_type'] == 1) { ?>
              <div class="select">
                <select name="stock" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($filter_stock as $stock_key => $stock) { ?>
					<!-- 3359 -->
					<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>
						<option id="stock-key-<?php echo $stock_key; ?>" value="<?php echo $stock['stock_key']; ?>" <?php if (!isset($stock['total'][$stock['stock_key']]) || !$stock['total'][$stock['stock_key']]) { ?>disabled<?php } ?> <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>selected<?php } ?>><?php echo $stock['name']; ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						(<?php echo (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) ? $stock['total'][$stock['stock_key']] : 0; ?>)
						<?php } ?>
						</option>
					<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						<option id="stock-key-<?php echo $stock_key; ?>" value="<?php echo $stock['stock_key']; ?>" <?php if (!isset($stock['total'][$stock['stock_key']]) || !$stock['total'][$stock['stock_key']]) { ?>disabled<?php } ?> <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>selected<?php } ?>><?php echo $stock['name']; ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						(<?php echo (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) ? $stock['total'][$stock['stock_key']] : 0; ?>)
						<?php } ?>
						</option>
					<?php } ?>
					<!-- 3359 -->
                  <?php } ?>
                </select>
              </div>
            <?php } elseif ($phpner_product_filter_data['stock_display_type'] == 2) { ?>
              <?php foreach ($filter_stock as $stock_key => $stock) { ?>
				<!-- 3359 -->
				<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>
					<div class="radio">
					  <input type="radio" id="stock-key-<?php echo $stock_key; ?>" name="stock" value="<?php echo $stock['stock_key']; ?>" <?php if (!isset($stock['total'][$stock['stock_key']]) || !$stock['total'][$stock['stock_key']]) { ?>disabled<?php } ?> <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><?php echo $stock['name']; ?></label>
					  <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) ? $stock['total'][$stock['stock_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
					<div class="radio">
					  <input type="radio" id="stock-key-<?php echo $stock_key; ?>" name="stock" value="<?php echo $stock['stock_key']; ?>" <?php if (!isset($stock['total'][$stock['stock_key']]) || !$stock['total'][$stock['stock_key']]) { ?>disabled<?php } ?> <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><?php echo $stock['name']; ?></label>
					  <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) ? $stock['total'][$stock['stock_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } else { ?>
              <?php foreach ($filter_stock as $stock_key => $stock) { ?>
				<!-- 3359 -->
				<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>
					<div class="checkbox">
					  <input type="checkbox" id="stock-key-<?php echo $stock_key; ?>" name="stock[]" value="<?php echo $stock['stock_key']; ?>" <?php if (!isset($stock['total'][$stock['stock_key']]) || !$stock['total'][$stock['stock_key']]) { ?>disabled<?php } ?> <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><?php echo $stock['name']; ?></label>
					  <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) ? $stock['total'][$stock['stock_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
					<div class="checkbox">
					  <input type="checkbox" id="stock-key-<?php echo $stock_key; ?>" name="stock[]" value="<?php echo $stock['stock_key']; ?>" <?php if (!isset($stock['total'][$stock['stock_key']]) || !$stock['total'][$stock['stock_key']]) { ?>disabled<?php } ?> <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><?php echo $stock['name']; ?></label>
					  <?php if (in_array($stock['stock_key'], $stock['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($stock['total'][$stock['stock_key']]) && $stock['total'][$stock['stock_key']]) ? $stock['total'][$stock['stock_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } ?>
          </div>
        </div>
      <?php } ?>
      <?php if ($filter_review) { ?>
        <div class="inner-box<?php if (!$phpner_product_filter_data['review_collapsed']) { ?> expanded<?php } ?>" data-sort="<?php echo $phpner_product_filter_data['review_sort_order']; ?>" data-type="review">
          <div class="item-title">
            <a class="list-group-item item-name"><span class="name"><?php echo $text_block_reviews; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['review_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
          </div>
          <div class="list-group-item item-content">
            <?php if ($phpner_product_filter_data['review_display_type'] == 1) { ?>
              <div class="select">
                <select name="rating" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($filter_review as $review_key => $review) { ?>
					<!-- 3359 -->
					<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>
						<option id="review-key-<?php echo $review_key; ?>" value="<?php echo $review['review_value_id']; ?>" <?php if (!$review['total'][$review['review_key']]) { ?>disabled<?php } ?> <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>selected<?php } ?>><?php echo $review['name']; ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						(<?php echo (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) ? $review['total'][$review['review_key']] : 0; ?>)
						<?php } ?>
						</option>
					<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						<option id="review-key-<?php echo $review_key; ?>" value="<?php echo $review['review_value_id']; ?>" <?php if (!$review['total'][$review['review_key']]) { ?>disabled<?php } ?> <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>selected<?php } ?>><?php echo $review['name']; ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						(<?php echo (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) ? $review['total'][$review['review_key']] : 0; ?>)
						<?php } ?>
						</option>
					<?php } ?>
					<!-- 3359 -->
                  <?php } ?>
                </select>
              </div>
            <?php } elseif ($phpner_product_filter_data['review_display_type'] == 2) { ?>
              <?php foreach ($filter_review as $review_key => $review) { ?>
				<!-- 3359 -->
				<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>
					<div class="radio">
					  <input type="radio" id="review-key-<?php echo $review_key; ?>" name="rating" value="<?php echo $review['review_value_id']; ?>" <?php if (!$review['total'][$review['review_key']]) { ?>disabled<?php } ?> <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><img src="<?php echo $review['thumb']; ?>" class="phpner_-rating-stars" alt="<?php echo $review_key; ?>" /></label>
					  <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) ? $review['total'][$review['review_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
					<div class="radio">
					  <input type="radio" id="review-key-<?php echo $review_key; ?>" name="rating" value="<?php echo $review['review_value_id']; ?>" <?php if (!$review['total'][$review['review_key']]) { ?>disabled<?php } ?> <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><img src="<?php echo $review['thumb']; ?>" class="phpner_-rating-stars" alt="<?php echo $review_key; ?>" /></label>
					  <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) ? $review['total'][$review['review_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } else { ?>
              <?php foreach ($filter_review as $review_key => $review) { ?>
				<!-- 3359 -->
				<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>
					<div class="checkbox">
					  <input type="checkbox" id="review-key-<?php echo $review_key; ?>" name="rating[]" value="<?php echo $review['review_value_id']; ?>" <?php if (!$review['total'][$review['review_key']]) { ?>disabled<?php } ?> <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><img src="<?php echo $review['thumb']; ?>" class="phpner_-rating-stars"  alt="<?php echo $review_key; ?>" /></label>
					  <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) ? $review['total'][$review['review_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
					<div class="checkbox">
					  <input type="checkbox" id="review-key-<?php echo $review_key; ?>" name="rating[]" value="<?php echo $review['review_value_id']; ?>" <?php if (!$review['total'][$review['review_key']]) { ?>disabled<?php } ?> <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>checked="checked"<?php } ?>/>
					  <label><img src="<?php echo $review['thumb']; ?>" class="phpner_-rating-stars"  alt="<?php echo $review_key; ?>" /></label>
					  <?php if (in_array($review['review_value_id'], $review['checked'])) { ?>
						<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					  <?php } else { ?>
						<?php if ($phpner_product_filter_data['show_totals']) { ?>
						<span class="label label-<?php if (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($review['total'][$review['review_key']]) && $review['total'][$review['review_key']]) ? $review['total'][$review['review_key']] : 0; ?></span>
						<?php } ?>
					  <?php } ?>
					</div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } ?>
          </div>
        </div>
      <?php } ?>
      <?php if ($filter_attribute) { ?>
        <div class="inner-box" data-sort="<?php echo $phpner_product_filter_data['attribute_sort_order']; ?>" data-type="attribute">
          <?php foreach ($filter_attribute as $attribute_key => $attribute) { ?>
            <?php if (isset($phpner_product_filter_data['attribute_display_status'][$attribute['attribute_id']]) && $phpner_product_filter_data['attribute_display_status'][$attribute['attribute_id']] == 1) { ?>
              <?php if (isset($phpner_product_filter_data['attribute_display_type'][$attribute['attribute_id']]) && $phpner_product_filter_data['attribute_display_type'][$attribute['attribute_id']] == 1) { ?>
                <div class="<?php if (!$phpner_product_filter_data['attribute_collapsed']) { ?>expanded<?php } ?>" data-attribute-group-id="<?php echo $attribute['attribute_group_id']; ?>">
                  <div class="item-title">
                    <a class="list-group-item item-name"><span class="name"><?php echo $attribute['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['attribute_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                  </div>
                  <div class="list-group-item item-content">
                    <?php if ($attribute['values']) { ?>
                      <div class="select">
                        <select name="attribute[<?php echo $attribute['attribute_name_mod']; ?>]" class="form-control">
                          <option value=""><?php echo $text_select; ?></option>
                          <?php foreach ($attribute['values'] as $attribute_value_key => $attribute_value) { ?>
							<!--3359 -->
							<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>
							  <option id="attribute-value-key-<?php echo $attribute_key; ?>-<?php echo $attribute_value_key; ?>" value="<?php echo $attribute_value['attribute_value_mod']; ?>" <?php if (!isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ) { ?>disabled<?php } ?> <?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>selected<?php } ?>><?php echo $attribute_value['attribute_value']; ?>
								<?php if ($phpner_product_filter_data['show_totals']) { ?>
								(<?php echo (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ? $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']] : 0; ?>)
								<?php } ?>
							  </option>
							<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
								<option id="attribute-value-key-<?php echo $attribute_key; ?>-<?php echo $attribute_value_key; ?>" value="<?php echo $attribute_value['attribute_value_mod']; ?>" <?php if (!isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ) { ?>disabled<?php } ?> <?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>selected<?php } ?>><?php echo $attribute_value['attribute_value']; ?>
								<?php if ($phpner_product_filter_data['show_totals']) { ?>
								(<?php echo (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ? $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']] : 0; ?>)
								<?php } ?>
							  </option>
							<?php } ?>
							<!-- 3359 -->
                          <?php } ?>
                        </select>
                      </div>
                    <?php } ?>
                  </div>
                </div>
              <?php } elseif (isset($phpner_product_filter_data['attribute_display_type'][$attribute['attribute_id']]) && $phpner_product_filter_data['attribute_display_type'][$attribute['attribute_id']] == 2) { ?>
                <div class="<?php if (!$phpner_product_filter_data['attribute_collapsed']) { ?>expanded<?php } ?>" data-attribute-group-id="<?php echo $attribute['attribute_group_id']; ?>">
                  <div class="item-title">
                    <a class="list-group-item item-name"><span class="name"><?php echo $attribute['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['attribute_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                  </div>
                  <div class="list-group-item item-content">
                    <?php if ($attribute['values']) { ?>
                      <?php foreach ($attribute['values'] as $attribute_value_key => $attribute_value) { ?>
						<!--3359 -->
						<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>
						  <div class="radio">
							<input type="radio" id="attribute-value-key-<?php echo $attribute_key; ?>-<?php echo $attribute_value_key; ?>" name="attribute[<?php echo $attribute['attribute_name_mod']; ?>]" value="<?php echo $attribute_value['attribute_value_mod']; ?>" <?php if (!isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>checked="checked"<?php } ?> />
							<label><?php echo $attribute_value['attribute_value']; ?></label>
							<?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>
							  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
							<?php } else { ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  <span class="label label-<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ? $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']] : 0; ?></span>
							  <?php } ?>
							<?php } ?>
						  </div>
						<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						  <div class="radio">
							<input type="radio" id="attribute-value-key-<?php echo $attribute_key; ?>-<?php echo $attribute_value_key; ?>" name="attribute[<?php echo $attribute['attribute_name_mod']; ?>]" value="<?php echo $attribute_value['attribute_value_mod']; ?>" <?php if (!isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>checked="checked"<?php } ?> />
							<label><?php echo $attribute_value['attribute_value']; ?></label>
							<?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>
							  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
							<?php } else { ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  <span class="label label-<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ? $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']] : 0; ?></span>
							  <?php } ?>
							<?php } ?>
						  </div>
						<?php } ?>
						<!-- 3359 -->
                      <?php } ?>
                    <?php } ?>
                  </div>
                </div>
              <?php } else { ?>
                <div class="<?php if (!$phpner_product_filter_data['attribute_collapsed']) { ?>expanded<?php } ?>" data-attribute-group-id="<?php echo $attribute['attribute_group_id']; ?>">
                  <div class="item-title">
                    <a class="list-group-item item-name"><span class="name"><?php echo $attribute['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['attribute_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                  </div>
                  <div class="list-group-item item-content">
                    <?php if ($attribute['values']) { ?>
                      <?php foreach ($attribute['values'] as $attribute_value_key => $attribute_value) { ?>
						<!--3359 -->
						<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>
							<div class="checkbox">
								<input type="checkbox" id="attribute-value-key-<?php echo $attribute_key; ?>-<?php echo $attribute_value_key; ?>" name="attribute[<?php echo $attribute['attribute_name_mod']; ?>][]" value="<?php echo $attribute_value['attribute_value_mod']; ?>" <?php if (!isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>checked="checked"<?php } ?>/>
								<label><?php echo $attribute_value['attribute_value']; ?></label>
								<?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>
								  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
								<?php } else { ?>
								  <?php if ($phpner_product_filter_data['show_totals']) { ?>
								  <span class="label label-<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ? $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']] : 0; ?></span>
								  <?php } ?>
								<?php } ?>
							</div>
						<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
							<div class="checkbox">
								<input type="checkbox" id="attribute-value-key-<?php echo $attribute_key; ?>-<?php echo $attribute_value_key; ?>" name="attribute[<?php echo $attribute['attribute_name_mod']; ?>][]" value="<?php echo $attribute_value['attribute_value_mod']; ?>" <?php if (!isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>checked="checked"<?php } ?>/>
								<label><?php echo $attribute_value['attribute_value']; ?></label>
								<?php if (in_array($attribute_value['attribute_value_mod'], $attribute['checked'])) { ?>
								  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
								<?php } else { ?>
								  <?php if ($phpner_product_filter_data['show_totals']) { ?>
								  <span class="label label-<?php if (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) && $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']]) ? $attribute['total'][$attribute['attribute_group_id']][$attribute['attribute_name_mod']][$attribute_value['attribute_value_mod']] : 0; ?></span>
								  <?php } ?>
								<?php } ?>
							</div>
						<?php } ?>
						<!-- 3359 -->
                      <?php } ?>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
            <?php } ?>
          <?php } ?>
        </div>
      <?php } ?>
      <?php if ($filter_option) { ?>
        <div class="inner-box" data-sort="<?php echo $phpner_product_filter_data['option_sort_order']; ?>" data-type="option">
          <?php foreach ($filter_option as $option_key => $option) { ?>
            <?php if (isset($phpner_product_filter_data['option_display_status'][$option['option_id']]) && $phpner_product_filter_data['option_display_status'][$option['option_id']] == 1) { ?>
              <?php if (isset($phpner_product_filter_data['option_display_type'][$option['option_id']]) && $phpner_product_filter_data['option_display_type'][$option['option_id']] == 1) { ?>
                <div class="<?php if (!$phpner_product_filter_data['option_collapsed']) { ?>expanded<?php } ?>">
                  <div class="item-title">
                    <a class="list-group-item item-name"><span class="name"><?php echo $option['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['option_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                  </div>
                  <div class="list-group-item item-content">
                    <?php if ($option['values']) { ?>
                      <div class="select">
                        <select name="option[<?php echo $option['option_name_mod']; ?>]" class="form-control">
                          <option value=""><?php echo $text_select; ?></option>
                          <?php foreach ($option['values'] as $option_value_key => $option_value) { ?>
							<!-- 3359 -->
							<?php if (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) { ?>
								<option id="option-value-key-<?php echo $option_key; ?>-<?php echo $option_value_key; ?>" value="<?php echo $option_value['option_value_id']; ?>" <?php if (!isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']])) { ?>disabled<?php } ?>
								<?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>selected<?php } ?>><?php echo $option_value['option_value_name']; ?>
								<?php if ($phpner_product_filter_data['show_totals']) { ?>
								(<?php echo (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) ? $option['total'][$option['option_name_mod']][$option_value['option_value_id']] : 0; ?>)
								<?php } ?>
								</option>
							<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
								<option id="option-value-key-<?php echo $option_key; ?>-<?php echo $option_value_key; ?>" value="<?php echo $option_value['option_value_id']; ?>" <?php if (!isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']])) { ?>disabled<?php } ?>
								<?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>selected<?php } ?>><?php echo $option_value['option_value_name']; ?>
								<?php if ($phpner_product_filter_data['show_totals']) { ?>
								(<?php echo (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) ? $option['total'][$option['option_name_mod']][$option_value['option_value_id']] : 0; ?>)
								<?php } ?>
								</option>
							<?php } ?>
							<!-- 3359 -->
                          <?php } ?>
                        </select>
                      </div>
                    <?php } ?>
                  </div>
                </div>
              <?php } elseif (isset($phpner_product_filter_data['option_display_type'][$option['option_id']]) && $phpner_product_filter_data['option_display_type'][$option['option_id']] == 2) { ?>
                <div class="<?php if (!$phpner_product_filter_data['option_collapsed']) { ?>expanded<?php } ?>">
                  <div class="item-title">
                    <a class="list-group-item item-name"><span class="name"><?php echo $option['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['option_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                  </div>
                  <div class="list-group-item item-content">
                    <?php if ($option['values']) { ?>
                      <?php foreach ($option['values'] as $option_value_key => $option_value) { ?>
						<!-- 3359 -->
						<?php if (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) { ?>
						  <div class="radio">
							<input type="radio" id="option-value-key-<?php echo $option_key; ?>-<?php echo $option_value_key; ?>" name="option[<?php echo $option['option_name_mod']; ?>]" value="<?php echo $option_value['option_value_id']; ?>" <?php if (!isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']])) { ?>disabled<?php } ?> <?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>checked="checked"<?php } ?> />
							<label><?php if (isset($phpner_product_filter_data['option_display_image'][$option['option_id']]) && $phpner_product_filter_data['option_display_image'][$option['option_id']] == 1) { ?>
							  <img src="<?php echo $option_value['option_value_image']; ?>" alt="<?php echo $option_value['option_value_name']; ?>" /> <?php } ?>
							  <?php echo $option_value['option_value_name']; ?>
							</label>
							<?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>
							  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
							<?php } else { ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  <span class="label label-<?php if (isset($option['total'][$option_value['option_value_id']]) && $option['total'][$option_value['option_value_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) ? $option['total'][$option['option_name_mod']][$option_value['option_value_id']] : 0; ?></span>
							  <?php } ?>
							<?php } ?>
						  </div>
						<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						  <div class="radio">
							<input type="radio" id="option-value-key-<?php echo $option_key; ?>-<?php echo $option_value_key; ?>" name="option[<?php echo $option['option_name_mod']; ?>]" value="<?php echo $option_value['option_value_id']; ?>" <?php if (!isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']])) { ?>disabled<?php } ?> <?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>checked="checked"<?php } ?> />
							<label><?php if (isset($phpner_product_filter_data['option_display_image'][$option['option_id']]) && $phpner_product_filter_data['option_display_image'][$option['option_id']] == 1) { ?>
							  <img src="<?php echo $option_value['option_value_image']; ?>" alt="<?php echo $option_value['option_value_name']; ?>" /> <?php } ?>
							  <?php echo $option_value['option_value_name']; ?>
							</label>
							<?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>
							  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
							<?php } else { ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  <span class="label label-<?php if (isset($option['total'][$option_value['option_value_id']]) && $option['total'][$option_value['option_value_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) ? $option['total'][$option['option_name_mod']][$option_value['option_value_id']] : 0; ?></span>
							  <?php } ?>
							<?php } ?>
						  </div>
						<?php } ?>
						<!-- 3359 -->
                      <?php } ?>
                    <?php } ?>
                  </div>
                </div>
              <?php } else { ?>
                <div class="<?php if (!$phpner_product_filter_data['option_collapsed']) { ?>expanded<?php } ?>">
                  <div class="item-title">
                    <a class="list-group-item item-name"><span class="name"><?php echo $option['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['option_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                  </div>
                  <div class="list-group-item item-content">
                    <?php if ($option['values']) { ?>
                      <?php foreach ($option['values'] as $option_value_key => $option_value) { ?>
						<!-- 3359 -->
						<?php if (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) { ?>
						  <div class="checkbox">
							<input type="checkbox" id="option-value-key-<?php echo $option_key; ?>-<?php echo $option_value_key; ?>" name="option[<?php echo $option['option_name_mod']; ?>][]" value="<?php echo $option_value['option_value_id']; ?>" <?php if (!isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']])) { ?>disabled<?php } ?> <?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>checked="checked"<?php } ?> />
							<label><?php if (isset($phpner_product_filter_data['option_display_image'][$option['option_id']]) && $phpner_product_filter_data['option_display_image'][$option['option_id']] == 1) { ?>
							  <img src="<?php echo $option_value['option_value_image']; ?>" alt="<?php echo $option_value['option_value_name']; ?>" /> <?php } ?>
							  <?php echo $option_value['option_value_name']; ?>
							</label>
							<?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>
							  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
							<?php } else { ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  <span class="label label-<?php if (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) ? $option['total'][$option['option_name_mod']][$option_value['option_value_id']] : 0; ?></span>
							  <?php } ?>
							<?php } ?>
						  </div>
						<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						  <div class="checkbox">
							<input type="checkbox" id="option-value-key-<?php echo $option_key; ?>-<?php echo $option_value_key; ?>" name="option[<?php echo $option['option_name_mod']; ?>][]" value="<?php echo $option_value['option_value_id']; ?>" <?php if (!isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']])) { ?>disabled<?php } ?> <?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>checked="checked"<?php } ?> />
							<label><?php if (isset($phpner_product_filter_data['option_display_image'][$option['option_id']]) && $phpner_product_filter_data['option_display_image'][$option['option_id']] == 1) { ?>
							  <img src="<?php echo $option_value['option_value_image']; ?>" alt="<?php echo $option_value['option_value_name']; ?>" /> <?php } ?>
							  <?php echo $option_value['option_value_name']; ?>
							</label>
							<?php if (in_array($option_value['option_value_id'], $option['checked'])) { ?>
							  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
							<?php } else { ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  <span class="label label-<?php if (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($option['total'][$option['option_name_mod']][$option_value['option_value_id']]) && $option['total'][$option['option_name_mod']][$option_value['option_value_id']]) ? $option['total'][$option['option_name_mod']][$option_value['option_value_id']] : 0; ?></span>
							  <?php } ?>
							<?php } ?>
						  </div>
						<?php } ?>
						<!-- 3359 -->
                      <?php } ?>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
            <?php } ?>
          <?php } ?>
        </div>
      <?php } ?>
      <?php if ($filter_sticker) { ?>
        <div class="inner-box<?php if (!$phpner_product_filter_data['sticker_collapsed']) { ?> expanded<?php } ?>" data-sort="<?php echo $phpner_product_filter_data['sticker_sort_order']; ?>" data-type="sticker">
          <div class="item-title">
            <a class="list-group-item item-name"><span class="name"><?php echo $text_block_stickers; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['sticker_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
          </div>
          <div class="list-group-item item-content">
            <?php if ($phpner_product_filter_data['sticker_display_type'] == 1) { ?>
              <div class="select">
                <select name="sticker" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($filter_sticker as $sticker_key => $sticker) { ?>
					<!-- 3359 -->
					<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>
					  <option id="sticker-key-<?php echo $sticker_key; ?>" value="<?php echo $sticker['product_sticker_id']; ?>" <?php if (!isset($sticker['total'][$sticker['product_sticker_id']])) { ?>disabled<?php } ?> <?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>selected<?php } ?>><?php echo $sticker['name']; ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  (<?php echo (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) ? $sticker['total'][$sticker['product_sticker_id']] : 0; ?>)
					  <?php } ?>
					  </option>
					<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
					  <option id="sticker-key-<?php echo $sticker_key; ?>" value="<?php echo $sticker['product_sticker_id']; ?>" <?php if (!isset($sticker['total'][$sticker['product_sticker_id']])) { ?>disabled<?php } ?> <?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>selected<?php } ?>><?php echo $sticker['name']; ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  (<?php echo (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) ? $sticker['total'][$sticker['product_sticker_id']] : 0; ?>)
					  <?php } ?>
					  </option>
					<?php } ?>
					<!-- 3359 -->
                  <?php } ?>
                </select>
              </div>
            <?php } elseif ($phpner_product_filter_data['sticker_display_type'] == 2) { ?>
              <?php foreach ($filter_sticker as $sticker_key => $sticker) { ?>
				<!-- 3359 -->
				<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>
				  <div class="radio">
					<input type="radio" id="sticker-key-<?php echo $sticker_key; ?>" name="sticker" value="<?php echo $sticker['product_sticker_id']; ?>" <?php if (!isset($sticker['total'][$sticker['product_sticker_id']])) { ?>disabled<?php } ?> <?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><?php echo $sticker['name']; ?></label>
					<?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) ? $sticker['total'][$sticker['product_sticker_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
				  <div class="radio">
					<input type="radio" id="sticker-key-<?php echo $sticker_key; ?>" name="sticker" value="<?php echo $sticker['product_sticker_id']; ?>" <?php if (!isset($sticker['total'][$sticker['product_sticker_id']])) { ?>disabled<?php } ?> <?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><?php echo $sticker['name']; ?></label>
					<?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) ? $sticker['total'][$sticker['product_sticker_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } else { ?>
              <?php foreach ($filter_sticker as $sticker_key => $sticker) { ?>
				<!-- 3359 -->
				<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>
				  <div class="checkbox">
					<input type="checkbox" id="sticker-key-<?php echo $sticker_key; ?>" name="sticker[]" value="<?php echo $sticker['product_sticker_id']; ?>" <?php if (!isset($sticker['total'][$sticker['product_sticker_id']])) { ?>disabled<?php } ?> <?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><?php echo $sticker['name']; ?></label>
					<?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) ? $sticker['total'][$sticker['product_sticker_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
				  <div class="checkbox">
					<input type="checkbox" id="sticker-key-<?php echo $sticker_key; ?>" name="sticker[]" value="<?php echo $sticker['product_sticker_id']; ?>" <?php if (!isset($sticker['total'][$sticker['product_sticker_id']])) { ?>disabled<?php } ?> <?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>checked="checked"<?php } ?>/>
					<label><?php echo $sticker['name']; ?></label>
					<?php if (in_array($sticker['product_sticker_id'], $sticker['checked'])) { ?>
					  <span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
					<?php } else { ?>
					  <?php if ($phpner_product_filter_data['show_totals']) { ?>
					  <span class="label label-<?php if (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($sticker['total'][$sticker['product_sticker_id']]) && $sticker['total'][$sticker['product_sticker_id']]) ? $sticker['total'][$sticker['product_sticker_id']] : 0; ?></span>
					  <?php } ?>
					<?php } ?>
				  </div>
				<?php } ?>
				<!-- 3359 -->
              <?php } ?>
            <?php } ?>
          </div>
        </div>
      <?php } ?>
      <?php if ($filter_standard) { ?>
        <div class="inner-box" data-sort="<?php echo $phpner_product_filter_data['standard_sort_order']; ?>" data-type="standard">
          <?php foreach ($filter_standard as $standard_key => $standard) { ?>
            <?php if (isset($phpner_product_filter_data['standard_display_type'][$standard['filter_group_id']]) && $phpner_product_filter_data['standard_display_type'][$standard['filter_group_id']] == 1) { ?>
              <div class="<?php if (!$phpner_product_filter_data['standard_collapsed']) { ?>expanded<?php } ?>" data-standard-group-id="<?php echo $standard['filter_group_id']; ?>">
                <div class="item-title">
                  <a class="list-group-item item-name"><span class="name"><?php echo $standard['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['standard_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                </div>
                <div class="list-group-item item-content">
                  <?php if ($standard['values']) { ?>
                    <div class="select">
                      <select name="standard[<?php echo $standard['filter_name_mod']; ?>]" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($standard['values'] as $standard_value_key => $standard_value) { ?>
						  <!-- 3359 -->
						  <?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>
							<option id="standard-value-key-<?php echo $standard_key; ?>-<?php echo $standard_value_key; ?>" value="<?php echo $standard_value['filter_value_mod']; ?>" <?php if (!isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>selected<?php } ?>><?php echo $standard_value['filter_value']; ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  (<?php echo (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) ? $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']] : 0; ?>)
							  <?php } ?>
							</option>
						  <?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
							<option id="standard-value-key-<?php echo $standard_key; ?>-<?php echo $standard_value_key; ?>" value="<?php echo $standard_value['filter_value_mod']; ?>" <?php if (!isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>selected<?php } ?>><?php echo $standard_value['filter_value']; ?>
							  <?php if ($phpner_product_filter_data['show_totals']) { ?>
							  (<?php echo (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) ? $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']] : 0; ?>)
							  <?php } ?>
							</option>
						  <?php } ?>
						  <!-- 3359 -->
                        <?php } ?>
                      </select>
                    </div>
                  <?php } ?>
                </div>
              </div>
            <?php } elseif (isset($phpner_product_filter_data['standard_display_type'][$standard['filter_group_id']]) && $phpner_product_filter_data['standard_display_type'][$standard['filter_group_id']] == 2) { ?>
              <div class="<?php if (!$phpner_product_filter_data['standard_collapsed']) { ?>expanded<?php } ?>" data-standard-group-id="<?php echo $standard['filter_group_id']; ?>">
                <div class="item-title">
                  <a class="list-group-item item-name"><span class="name"><?php echo $standard['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['standard_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                </div>
                <div class="list-group-item item-content">
                  <?php if ($standard['values']) { ?>
                    <?php foreach ($standard['values'] as $standard_value_key => $standard_value) { ?>
					  <!-- 3359 -->
					  <?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>
						<div class="radio">
						  <input type="radio" id="standard-value-key-<?php echo $standard_key; ?>-<?php echo $standard_value_key; ?>" name="standard[<?php echo $standard['filter_name_mod']; ?>]" value="<?php echo $standard_value['filter_value_mod']; ?>" <?php if (!isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>checked="checked"<?php } ?> />
						  <label><?php echo $standard_value['filter_value']; ?></label>
						  <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>
							<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
						  <?php } else { ?>
							<?php if ($phpner_product_filter_data['show_totals']) { ?>
							<span class="label label-<?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) ? $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']] : 0; ?></span>
							<?php } ?>
						  <?php } ?>
						</div>
					  <?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						<div class="radio">
						  <input type="radio" id="standard-value-key-<?php echo $standard_key; ?>-<?php echo $standard_value_key; ?>" name="standard[<?php echo $standard['filter_name_mod']; ?>]" value="<?php echo $standard_value['filter_value_mod']; ?>" <?php if (!isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>checked="checked"<?php } ?> />
						  <label><?php echo $standard_value['filter_value']; ?></label>
						  <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>
							<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().removeAttr('checked');phpner_start_filter();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
						  <?php } else { ?>
							<?php if ($phpner_product_filter_data['show_totals']) { ?>
							<span class="label label-<?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) ? $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']] : 0; ?></span>
							<?php } ?>
						  <?php } ?>
						</div>
					  <?php } ?>
					  <!-- 3359 -->
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
            <?php } else { ?>
              <div class="<?php if (!$phpner_product_filter_data['standard_collapsed']) { ?>expanded<?php } ?>" data-standard-group-id="<?php echo $standard['filter_group_id']; ?>">
                <div class="item-title">
                  <a class="list-group-item item-name"><span class="name"><?php echo $standard['name']; ?></span><span class="link"><i class="fa fa-<?php if (!$phpner_product_filter_data['standard_collapsed']) { ?>minus<?php } else { ?>plus<?php } ?>"></i></span></a>
                </div>
                <div class="list-group-item item-content">
                  <?php if ($standard['values']) { ?>
                    <?php foreach ($standard['values'] as $standard_value_key => $standard_value) { ?>
					  <!-- 3359 -->
					  <?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>
						<div class="checkbox">
						  <input type="checkbox" id="standard-value-key-<?php echo $standard_key; ?>-<?php echo $standard_value_key; ?>" name="standard[<?php echo $standard['filter_name_mod']; ?>][]" value="<?php echo $standard_value['filter_value_mod']; ?>" <?php if (!isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>checked="checked"<?php } ?>/>
						  <label><?php echo $standard_value['filter_value']; ?></label>
						  <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>
							<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
						  <?php } else { ?>
							<?php if ($phpner_product_filter_data['show_totals']) { ?>
							<span class="label label-<?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) ? $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']] : 0; ?></span>
							<?php } ?>
						  <?php } ?>
						</div>
					  <?php } elseif(isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
						<div class="checkbox">
						  <input type="checkbox" id="standard-value-key-<?php echo $standard_key; ?>-<?php echo $standard_value_key; ?>" name="standard[<?php echo $standard['filter_name_mod']; ?>][]" value="<?php echo $standard_value['filter_value_mod']; ?>" <?php if (!isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']])) { ?>disabled<?php } ?> <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>checked="checked"<?php } ?>/>
						  <label><?php echo $standard_value['filter_value']; ?></label>
						  <?php if (in_array($standard_value['filter_value_mod'], $standard['checked'])) { ?>
							<span class="label label-danger phpner_-filter-total-label" onclick="$(this).prev().prev().click();"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>
						  <?php } else { ?>
							<?php if ($phpner_product_filter_data['show_totals']) { ?>
							<span class="label label-<?php if (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) { ?>primary<?php } else { ?>default<?php } ?> phpner_-filter-total-label"><?php echo (isset($standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) && $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']]) ? $standard['total'][$standard['filter_name_mod']][$standard_value['filter_value_mod']] : 0; ?></span>
							<?php } ?>
						  <?php } ?>
						</div>
					  <?php } ?>
					  <!-- 3359 -->
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
            <?php } ?>
          <?php } ?>
        </div>
      <?php } ?>
    </form>
    <?php if ($phpner_product_filter_data['selected_values_position'] == 2) { ?>
    <div id="phpner_-selected-values"></div>
    <?php } ?>
  </div>
</div>
<script><!--
/* 3359 ADD */
$(document).ready(function() {
	$(".inner-box .item-content").each(function(i,lines) {
		if ($(this).find("div").length == 0) {
			$(this).prev().hide();
			$(this).hide();
		}
	});
});
/* 3359 ADD */
$(function() {
	$('body').prepend('<div id="filter-mobile"></div>');
	$('.mobile-category-header').prepend('<div id="filter-button" class="phpner_-button"><i class="fa fa-search"></i> <?php echo $heading_title; ?></div>');
	$('.box-heading').prepend('<div id="filter-close"><i class="fa fa-times"></i></div>');

	var portraitWidth = $(window).width();
	if (portraitWidth <= '992'){
	$("#phpner_-ismobile") .appendTo("#filter-mobile");
	}

	$("#filter-button").click(function() {
	if ($('#filter-mobile').is(':empty')){
		$("#phpner_-ismobile") .appendTo("#filter-mobile");
	}
	  $("#filter-mobile").toggleClass("filter-show");
	  return false;
	});

	$("#filter-close").click(function() {
	  $("#filter-mobile").removeClass("filter-show");
	  return false;
	});


	var isMobile = {
        Android: function() {
          return navigator.userAgent.match(/Android/i);
        }
      };
	  var win = $(this);
	  if (!isMobile.Android()) {
			  $(window).on('resize', function(){
				      if (win.width() <= 992) {
					    		$("#phpner_-ismobile") .appendTo("#filter-mobile");
					  }  else {
					    		$("#phpner_-ismobile") .prependTo("#filter-column");
					  }
				});
	  } else {
			   if (win.width() <= 992) {
			   		$("#phpner_-ismobile") .appendTo("#filter-mobile");
			  	} else {
				    $("#phpner_-ismobile") .prependTo("#filter-column");
				}

			window.addEventListener("orientationchange", function() {
			  if(window.orientation == 90) {
				  $("#phpner_-ismobile") .prependTo("#filter-column");
			  }
			}, false);

	  }
});
<?php if ($filter_prices) { ?>
var phpner_price_slider = document.getElementById('phpner_-price-slider');
noUiSlider.create(phpner_price_slider, {
  start: [<?php echo $filter_prices['low_price']; ?>, <?php echo $filter_prices['high_price']; ?>],
  behaviour: 'hover',
  margin: 1,
  connect: true,
  range: {
    'min': [<?php echo $filter_range_prices['low_price']; ?>],
    'max': [<?php echo $filter_range_prices['high_price']; ?>]
  },
  format: wNumb({
    decimals: 0
  }),
  slide: function(event, ui) {
    if (ui.value == parseInt($('#phpner_-product-filter-data input[name=\'high_price\']').val())-1) {
      return false;
    }
  }
});
phpner_price_slider.noUiSlider.on('update', function(values, handle) {
  $('#phpner_-product-filter-data input[name=\'low_price\']').val(values[0]);
  $('#phpner_-product-filter-data input[name=\'high_price\']').val(values[1]);
});
phpner_price_slider.noUiSlider.on('end', function() {
  phpner_start_filter();
});
<?php } ?>
<?php if (isset($phpner_product_filter_data['collapse_expand_type'])) { ?>
  <?php if (in_array('3', $phpner_product_filter_data['collapse_expand_type'])) { ?>
  $(document).on('click', '#phpner_-product-filter-data a.list-group-item', function(e) {
    $(this).parent().parent().toggleClass("expanded");
    $(this).find("i").toggleClass("fa-minus").addClass("fa-plus");
  });
  <?php } else { ?>
    <?php if (in_array('1', $phpner_product_filter_data['collapse_expand_type'])) { ?>
    $(document).on('click', '#phpner_-product-filter-data a.list-group-item .name', function(e) {
      $(this).parent().parent().parent().toggleClass("expanded");
      $(this).next().find("i").toggleClass("fa-minus").addClass("fa-plus");
    });
    <?php } ?>
    <?php if (in_array('2', $phpner_product_filter_data['collapse_expand_type'])) { ?>
    $(document).on('click', '#phpner_-product-filter-data a.list-group-item .link', function(e) {
      $(this).parent().parent().parent().toggleClass("expanded");
      $(this).find("i").toggleClass("fa-minus").addClass("fa-plus");
    });
    <?php } ?>
  <?php } ?>
<?php } else { ?>
  $(document).on('click', '#phpner_-product-filter-data a.list-group-item', function(e) {
    $(this).parent().parent().toggleClass("expanded");
    $(this).find("i").toggleClass("fa-minus").addClass("fa-plus");
  });
<?php } ?>
$(document).on('click', '#phpner_-product-filter-data .list-group-item label', function(e) {
  $(this).prev().click();
});
<?php if ($filter_prices) { ?>
$(document).on('change', '#phpner_-product-filter-data input[name=\'low_price\']', function() {
  phpner_price_slider.noUiSlider.set([parseInt($(this).val()), null]);
});
$(document).on('change', '#phpner_-product-filter-data input[name=\'high_price\']', function() {
  phpner_price_slider.noUiSlider.set([null, parseInt($(this).val())]);
});
$(document).on('change', '#phpner_-product-filter-data input[name=\'special_only\']', function() {
  phpner_price_slider.noUiSlider.set([<?php echo $filter_range_prices['low_price']; ?>, <?php echo $filter_range_prices['high_price']; ?>]);
});
<?php } ?>
$(document).on('click', <?php if (isset($phpner_product_filter_data['enable_seo'])) { ?>'#content .pagination a'<?php } else { ?>'#phpner_-product-pagination a'<?php } ?>, function(e) {
  e.preventDefault();
  var page = phpner_get_value_from_url($(this).attr('href'), 'page');
  if (page) {
    phpner_start_filter({page: phpner_get_value_from_url($(this).attr('href'), 'page')});
  } else {
    phpner_start_filter({page: '1'});
  }
});
function hide_long_list() {
  var max = <?php echo $phpner_product_filter_data['visible_items_in_block_limit']; ?>-1;
  $('.list-group-item').each(function(i,lines) {
    if ($(this).find(".checkbox").length > parseInt(max+1)) {
      $(this).children('.checkbox:gt('+max+')').hide().end().append(
        $('<a class="phpner_-filter-view"><?php echo $text_full_list; ?> (+'+parseInt($(this).find(".checkbox").length - (max+1))+') <i class="fa fa-caret-down" aria-hidden="true"></i></a>').click(function() {
          $(this).siblings(':hidden').show().end().remove();
        })
      );
    }
    if ($(this).find(".radio").length > parseInt(max+1)) {
      $(this).children('.radio:gt('+max+')').hide().end().append(
        $('<a class="phpner_-filter-view"><?php echo $text_full_list; ?> (+'+parseInt($(this).find(".radio").length - (max+1))+') <i class="fa fa-caret-down" aria-hidden="true"></i></a>').click(function() {
          $(this).siblings(':hidden').show().end().remove();
        })
      );
    }
  });
}
function sort_filter_blocks() {
  var $wrapper = $('#phpner_-product-filter-data');
  $wrapper.find('.inner-box').sort(function(a, b) {
    return +a.dataset.sort - +b.dataset.sort;
  }).appendTo($wrapper);
}
function filter_mask(element, status) {
  if (status == true) {
    $('<div/>')
    .attr({'class':'masked'})
    .prependTo(element);
    $('<div class="masked_loading" />').insertAfter($('.masked'));
  } else {
    $('.masked').remove();
    $('.masked_loading').remove();
  }
}
$(function() {
  <?php if ($filter_prices) { ?>
  if (parseInt($('#phpner_-product-filter-data input[name=\'low_price\']').val()) == parseInt($('#phpner_-product-filter-data input[name=\'high_price\']').val())) {
    $('#phpner_-price-slider').remove();
  }
  <?php } ?>
  sort_filter_blocks();
  hide_long_list();
  $('select[id="input-limit"], select[id="input-sort"]').removeAttr('onchange');
  <?php if ($custom_sort) { ?>
    $('select[id="input-sort"]').empty();
    custom_sort_options = '';
    <?php foreach ($custom_sort as $sort_value) { ?>
    custom_sort_options += '<option value="&sort=<?php echo $sort_value["value"]; ?>" <?php if ($sort_value["checked"]) { ?>selected="selected"<?php } ?>><?php echo $sort_value["name"]; ?></option>';
    <?php } ?>
    $('select[id="input-sort"]').append(custom_sort_options);
  <?php } ?>
  <?php if ($custom_limit) { ?>
    $('select[id="input-limit"]').empty();
    custom_limit_options = '';
    <?php foreach ($custom_limit as $limit_value) { ?>
    custom_limit_options += '<option value="&limit=<?php echo $limit_value["value"]; ?>" <?php if ($limit_value["checked"]) { ?>selected="selected"<?php } ?>><?php echo $limit_value["value"]; ?></option>';
    <?php } ?>
    $('select[id="input-limit"]').append(custom_limit_options);
  <?php } ?>
  <?php if ($filter_start) { ?>
    phpner_start_filter();
  <?php } ?>
});
$('#button-reset').on('click', function() {
  phpner_reset_filter();
});

$(document).on('change', '#phpner_-product-filter-data input[type=\'text\'], #phpner_-product-filter-data input[type=\'hidden\'], #phpner_-product-filter-data input[type=\'radio\'], #phpner_-product-filter-data input[type=\'checkbox\'], #phpner_-product-filter-data select', function() {
  phpner_start_filter({page: 1});
});

$(document).on('change', 'select[id="input-sort"], select[id="input-limit"]', function() {
  phpner_start_filter();
});

function phpner_reset_filter() {
  <?php if ($filter_prices) { ?>
  $('#phpner_-product-filter-data input[name=\'low_price\']').val('<?php echo $filter_range_prices['low_price']; ?>');
  $('#phpner_-product-filter-data input[name=\'high_price\']').val('<?php echo $filter_range_prices['high_price']; ?>');
  <?php } ?>
  $('#phpner_-product-filter-data input[type=\'radio\']').removeAttr('checked');
  $('#phpner_-product-filter-data input[type=\'checkbox\']').removeAttr('checked');
  $('#phpner_-product-filter-data select').val('');
  phpner_start_filter({render_products: true});
}
function reset_selected_value(value, id, type) {
  if (type == 'checkbox') {
    $("#phpner_-product-filter-data #"+id).click();
  }

  if (type == 'radio') {
    $("#phpner_-product-filter-data #"+id).removeAttr('checked');
    phpner_start_filter();
  }

  if (type == 'select') {
    $("#phpner_-product-filter-data #"+id).parent().val('').change();
  }
}
function phpner_scroll_to_top() {
  $("html, body").animate({
    scrollTop: $('#phpner_-filter-tag').offset().top -60
  }, {
    duration: 800,
    easing: "swing"
  });
}
function phpner_get_value_from_url(url, type) {
  var value = 0;
  if (type == 'sort' || type == 'limit' || type == 'order' || type == 'page') {
    var arr = url.split("&");
  }
  for(var i = 0; i < arr.length; i++){
    var value = arr[i].split("=");
    if (value[0] === type) {
      return value[1];
    }
  }
}
function phpner_show_more_products() {
  $('#button-show-more-products').append('<i class="fa fa-refresh fa-spin fa-fw"></i>');
  phpner_start_filter({increase_limit: <?php echo $phpner_product_filter_data['show_more_limit']; ?>, page: 1});
}
function phpner_start_filter({count_totals = true, render_products = true, increase_limit = 0, page = <?php echo $page; ?>} = {}) {
  <?php if ($phpner_product_filter_data['mask_on_filtering']) { ?>
  filter_mask('#phpner_-product-filter-data', true);
  filter_mask('#res-products', true);
  <?php } ?>
  var phpner_pf = [];
  var phpner_field_data = $('#phpner_-product-filter-data input[type=\'text\'], #phpner_-product-filter-data input[type=\'hidden\'], #phpner_-product-filter-data input[type=\'radio\']:checked, #phpner_-product-filter-data input[type=\'checkbox\']:checked, #phpner_-product-filter-data select').serializeArray();
  $.each(phpner_field_data, function(i, field) {
    if (field.value) {
      phpner_pf.push({
        name: field.name,
        value: field.value
      });
    }
  });
  if (increase_limit) {
    $('input[name="temp_limit"]').val(parseInt($('input[name="temp_limit"]').val()) + parseInt(increase_limit));
    var limit = parseInt(phpner_get_value_from_url($('select[id="input-limit"]').val(), 'limit')) + parseInt($('input[name="temp_limit"]').val());
  } else {
    var limit = phpner_get_value_from_url($('select[id="input-limit"]').val(), 'limit');
  }
  phpner_pf.push({
    name: 'global_id',
    value: '<?php echo $global_id; ?>'
  }, {
    name: 'global_type',
    value: '<?php echo $global_type; ?>'
  }, {
    name: 'route',
    value: '<?php echo $route; ?>'
  }, {
    name: 'sort',
    value: phpner_get_value_from_url($('select[id="input-sort"]').val(), 'sort')
  }, {
    name: 'order',
    value: phpner_get_value_from_url($('select[id="input-sort"]').val(), 'order')
  }, {
    name: 'limit',
    value: limit
  }, {
    name: 'page',
    value: page
  }, {
    name: 'url',
    value: '<?php echo $url; ?>'
  });
  $.ajax({
    type: 'post',
    url: 'index.php?route=extension/module/phpner_product_filter/filterProducts',
    dataType: 'json',
    data: phpner_pf,
    success: function(json) {
      if (render_products) {
        if (json['products']) {
          product = '<div class="row filter-products">';
          if (json['error']) {
            product += '<div class="col-sm-12"><p>'+json['error']+'</p></div>';
          }
          $.each(json['products'], function(i,value) {
		  var class_quantity = (value['quantity'] <= 0 && value['product_preorder_status'] != 1) ? ' no_quantity' : '';
          product += '<div class="product-layout product-list col-sm-6 col-xs-6">';
            product += '<div class="product-thumb'+ class_quantity +'">';
              product += '<div class="image">';
                if (json['phpner_popup_view_status'] == '1' && value['quantity'] > 0) {
                  product += '<div class="quick-view"><a onclick="get_phpner_popup_product_view('+value['product_id']+');">'+json['language']['button_popup_view']+'</a></div>';
                }
                if (value['economy']) {
                  product += '<div class="phpner_-discount-box">';
                    product += '<div class="phpner_-discount-item">-'+value['economy']+'%</div>';
                  product += '</div>';
                }
                if (value['phpner_product_stickers']) {
                  product += '<div class="phpner_-sticker-box">';
                    $.each(value['phpner_product_stickers'], function(i,product_sticker) {
                      product += '<div class="phpner_-sticker-item" style="color: '+product_sticker['color']+'; background: '+product_sticker['background']+';">'+product_sticker['text']+'</div>';
                    });
                  product += '</div>';
                }
                product += '<a href="'+value['href']+'"><img src="'+value['thumb']+'" title="'+value['name']+'" alt="'+value['name']+'" class="img-responsive" /></a>';
              product += '</div>';
              product += '<div>';
                product += '<div class="caption">';
                  product += '<p class="cat-model">'+json['language']['text_model']+' <span>'+value['model']+'</span></p>';
                  product += '<h4><a href="'+value['href']+'">'+value['name']+'</a></h4>';
                  product += '<div class="rating">';
                  if (value['rating'] > 0) {
                    $.each(["1","2","3","4","5",], function(index,element) {
                      if (value['rating'] < element) {
                        product += '<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> ';
                      } else {
                        product += '<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> ';
                      }
                    });
                  } else {
                    $.each(["1","2","3","4","5",], function(index,element) {
                      product += '<span class="fa fa-stack"><i class="fa fa-star-o" aria-hidden="true"></i></span> ';
                    });
                  }
                  product += '</div>';
                  product += '<hr>';
                  product += '<div class="cat-box-effect">';
                    product += '<div class="cat-box-effect-inner">';
                      if (value['price']) {
                        product += '<p class="price">';
                        if (!value['special']) {
                          product += '<span class="common-price">'+value['price']+'</span>';
                        } else {
                          product += '<span class="price-new">'+value['special']+'</span> <span class="price-old">'+value['price']+'</span>';
                        }
                        product += '</p>';
                      }
                      product += '<div class="cart">';
                        if (value['quantity'] > 0) {
                          product += '<a class="button-cart phpner_-button" title="'+json['language']['button_cart']+'" onclick="get_phpner_popup_add_to_cart('+value['product_id']+', '+value['minimum']+');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs">'+json['language']['button_cart']+'</span></a>';
                        } else {
                          if (value['product_preorder_status'] == 1) {
                            product += '<a class="button-cart out-of-stock-button phpner_-button" href="javascript: void(0);" onclick="get_phpner_product_preorder('+value['product_id']+'); return false;"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs">'+value['product_preorder_text']+'</span></a>';
                          } else {
                            product += '<a class="button-cart out-of-stock-button phpner_-button" href="javascript: void(0);"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs">'+value['product_preorder_text']+'</span></a>';
                          }
                        }
                        product += ' <a onclick="get_phpner_popup_add_to_wishlist('+value['product_id']+');" title="'+json['language']['button_wishlist']+'" class="wishlist phpner_-button"><i class="fa fa-heart" aria-hidden="true"></i></a>';
                        product += ' <a onclick="get_phpner_popup_add_to_compare('+value['product_id']+');" title="'+json['language']['button_compare']+'" class="compare phpner_-button"><i class="fa fa-sliders" aria-hidden="true"></i></a>';
                      product += '</div>';
                    product += '</div>';
                  product += '</div>';
                  product += '<p class="phpner_-product-stock"><span class="hidden-xs">'+json['language']['text_stock']+' </span><span>'+value['stock']+'</span></p>';
                  product += '<div class="phpner_-additional-info">';
                  product += '  <p class="phpner_-product-desc">'+value['description']+'</p>';
                  if (value['phpner_options']) {
                    product += '<div class="cat-options">';
                      $.each(value['phpner_options'], function(io,option) {
                        if (option['type'] == 'radio') {
                          product += '<div class="form-group">';
                            product += '<label class="control-label">'+option['name']+'</label>';
                            product += '<br/>';
                            if (option['product_option_value']) {
                              $.each(option['product_option_value'], function(pov,povalue) {
                                if (povalue['image']) {
                                  product += '<div class="radio">';
                                    product += '<img src="'+povalue['image']+'" alt="'+povalue['name']+'" class="img-thumbnail" title="'+povalue['name']+'" />';
                                  product += '</div>';
                                } else {
                                  product += '<div class="radio"><label class="not-selected">'+povalue['name']+'</label></div>';
                                }
                              });
                            }
                          product += '</div>';
                        } else {
                          product += '<div class="form-group size-box">';
                            product += '<label class="control-label">'+option['name']+'</label>';
                            product += '<br/>';
                            if (option['product_option_value']) {
                              $.each(option['product_option_value'], function(pov,povalue) {
                                product += '<div class="radio">';
                                  product += '<label class="not-selected">'+povalue['name']+'</label>';
                                product += '</div>';
                              });
                            }
                          product += '</div>';
                        }
                      });
                    product += '</div>';
                  }
                  if (value['phpner_attributes']) {
                    product += '<div class="cat-options">';
                      $.each(value['phpner_attributes'], function(ia,attribute) {
                        product += '<div class="form-group size-box">';
                          product += '<label class="control-label">'+attribute['name']+'</label>';
                          product += '<br/>';
	                        product += '<span>'+attribute['text']+'</span>';
                        product += '</div>';
                      });
                    product += '</div>';
                  }
                  product += '</div>';
                product += '</div>';
              product += '</div>';
            product += '</div>';
          product += '</div>';
          });
          product += '</div>';
          if (json['show_more_limit_show']) {
            product += '<div class="row">';
            product += '  <div class="col-sm-12 text-center"><button onclick="phpner_show_more_products()" id="button-show-more-products" class="phpner_-button current-link">'+json['results_button_show_more_products']+'</button><br/><br/></div>';
            product += '</div>';
          }
          product += '<div class="row pagination-row">';
          product += '  <div class="col-sm-12 text-center" id="phpner_-product-pagination">'+json['pagination']+'</div>';
          product += '</div>';
          $('#res-products').html(product);
          $('#res-products').fadeIn();
        }
      }

      <?php if (isset($phpner_product_filter_data['enable_seo'])) { ?>
        $.ajax({
          type: 'post',
          url: 'index.php?route=extension/module/phpner_product_filter/filterProducts&update_seo_url=1',
          dataType: 'json',
          data: phpner_pf,
          success: function(json) {
            window.history.pushState({}, $('h1').html(), json['url'].replace(/&amp;/g, '&'));
          }
        });
      <?php } ?>

      if (count_totals) {
        $.ajax({
          url: 'index.php?route=extension/module/phpner_product_filter',
          type: 'POST',
          data: phpner_pf,
          dataType: 'html',
          success: function(data) {
            var selectBox = $('#phpner_-product-filter-data select').length ? $('#phpner_-product-filter-data select').val() : 0;
            var haveSelectedOptions = 0; 
            <?php if ($phpner_product_filter_data['selected_values_position'] == 1 || $phpner_product_filter_data['selected_values_position'] == 2) { ?>
            $('#phpner_-selected-values').html('');
            if ($('#phpner_-product-filter-data input[type=\'checkbox\']:checked').length || $('#phpner_-product-filter-data input[type=\'radio\']:checked').length || selectBox !== 0) {
              checkbox_item  = '<div class="item-title">';
              checkbox_item += '  <a class="list-group-item item-name"><span class="name"><?php echo $text_selected_values; ?></span></a>';
              checkbox_item += '</div>';
              checkbox_item += '<div class="list-group-item item-content">';

              $.each(['price','manufacturer','option','attribute','sticker','stock','review','standard'], function(i,value) {
                $('#phpner_-product-filter-data [data-type="'+value+'"] > div').each(function(index) {
                  var $this = $(this);
                  var $items = $this.find('input[type=\'checkbox\']:checked');
                  $.each($items, function(index) {
                    if (index == 0) {
                      checkbox_item += '<div class="phpner_-selected-group-label">'+$(this).parent().parent().parent().find('.name').html()+'</div>';
                    }
                    haveSelectedOptions = 1;
                    checkbox_item += '<div class="checkbox">';
                    checkbox_item += '  <label class="phpner_-selected-values-label">'+$(this).parent().find('label').html()+'</label>';
                    checkbox_item += '  <span class="label label-danger phpner_-filter-total-label" onclick="reset_selected_value(this,\''+$(this).attr('id')+'\', \'checkbox\');"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>';
                    checkbox_item += '</div>';
                  });
                });

                $('#phpner_-product-filter-data [data-type="'+value+'"] > div').each(function(index) {
                  var $this = $(this);
                  var $items = $this.find('input[type=\'radio\']:checked');
                  $.each($items, function(index) {
                    if (index == 0) {
                      checkbox_item += '<div class="phpner_-selected-group-label">'+$(this).parent().parent().parent().find('.name').html()+'</div>';
                    }
                    haveSelectedOptions = 1;
                    checkbox_item += '<div class="checkbox">';
                    checkbox_item += '  <label class="phpner_-selected-values-label">'+$(this).parent().find('label').html()+'</label>';
                    checkbox_item += '  <span class="label label-danger phpner_-filter-total-label" onclick="reset_selected_value(this,\''+$(this).attr('id')+'\', \'radio\');"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>';
                    checkbox_item += '</div>';
                  });
                });
				
				
				
                $('#phpner_-product-filter-data [data-type="'+value+'"] > div').each(function(index) {
                  var $this = $(this);
                  var $items = $this.find('select option:selected');
                  $.each($items, function(index) {
	                  
                    if ($(this).val()) {
                      if (index == 0) {
                        checkbox_item += '<div class="phpner_-selected-group-label">'+$(this).parent().parent().parent().parent().find('.name').html()+'</div>';
                      }
	                   haveSelectedOptions = 1;
                      checkbox_item += '<div class="checkbox">';
                      checkbox_item += '  <label class="phpner_-selected-values-label">'+$(this).text().replace(/\(.*/, "")+'</label>';
                      checkbox_item += '  <span class="label label-danger phpner_-filter-total-label" onclick="reset_selected_value(this,\''+$(this).attr('id')+'\', \'select\');"><i class="fa fa-times phpner_-filter-icon-unselect"></i></span>';
                      checkbox_item += '</div>';
                    }
                  });
                });
              });

              checkbox_item += '</div>';
              if(haveSelectedOptions > 0) {
              checkbox_item += '<button type="button" id="button-reset" class="phpner_-button" onclick="phpner_reset_filter();"><?php echo $button_reset; ?></button>';
              $('#phpner_-selected-values').append(checkbox_item);
              }
            }
            <?php } elseif ($phpner_product_filter_data['selected_values_position'] == 3) { ?>
            $('#phpner_-selected-values').remove();
            if ($('#phpner_-product-filter-data input[type=\'checkbox\']:checked').length || $('#phpner_-product-filter-data input[type=\'radio\']:checked').length || selectBox !== 0) {
              checkbox_item  = '<div id="phpner_-selected-values">';
                checkbox_item += '<div class="panel panel-default">';
                checkbox_item += '  <div class="panel-heading"><?php echo $text_selected_values; ?></div>';
                checkbox_item += '  <div class="panel-body">';

                $.each(['price','manufacturer','option','attribute','sticker','stock','review','standard'], function(i,value) {
                  $('#phpner_-product-filter-data [data-type="'+value+'"] > div').each(function(index) {
                    var $this = $(this);
                    var $items = $this.find('input[type=\'checkbox\']:checked');
                    $.each($items, function(index) {
                      if (index == 0) {
                        checkbox_item += '<div class="phpner_-selected-group-label">'+$(this).parent().parent().parent().find('.name').html()+'</div>';
                      }
                      checkbox_item += '<button type="button" onclick="reset_selected_value(this,\''+$(this).attr('id')+'\', \'checkbox\');" class="btn btn-default btn-xs">'+$(this).parent().find('label').html()+' <i class="fa fa-times phpner_-filter-icon-unselect"></i></button>';
                    });
                  });
                  $('#phpner_-product-filter-data [data-type="'+value+'"] > div').each(function(index) {
                    var $this = $(this);
                    var $items = $this.find('input[type=\'radio\']:checked');
                    $.each($items, function(index) {
                      if (index == 0) {
                        checkbox_item += '<div class="phpner_-selected-group-label">'+$(this).parent().parent().parent().find('.name').html()+'</div>';
                      }
                      checkbox_item += '<button type="button" onclick="reset_selected_value(this,\''+$(this).attr('id')+'\', \'radio\');" class="btn btn-default btn-xs">'+$(this).parent().find('label').html()+' <i class="fa fa-times phpner_-filter-icon-unselect"></i></button>';
                    });
                  });
                  $('#phpner_-product-filter-data [data-type="'+value+'"] > div').each(function(index) {
                    var $this = $(this);
                    var $items = $this.find('select option:selected');
                    $.each($items, function(index) {
                      if ($(this).val()) {
                        if (index == 0) {
                          checkbox_item += '<div class="phpner_-selected-group-label">'+$(this).parent().parent().parent().parent().find('.name').html()+'</div>';
                        }
                        checkbox_item += '<button type="button" onclick="reset_selected_value(this,\''+$(this).attr('id')+'\', \'select\');" class="btn btn-default btn-xs">'+$(this).text().replace(/\(.*/, "")+' <i class="fa fa-times phpner_-filter-icon-unselect"></i></button>';
                      }
                    });
                  });
                });
                checkbox_item += '  </div>';
                checkbox_item += '</div>';
              checkbox_item += '</div>';
              $('#res-products').before(checkbox_item);
            }
            <?php } ?>
            $('#phpner_-product-filter-data').html($(data).find('#phpner_-product-filter-data').children());
            hide_long_list();
            sort_filter_blocks();
            <?php if ($filter_prices) { ?>
            var phpner_price_slider = document.getElementById('phpner_-price-slider');
            noUiSlider.create(phpner_price_slider, {
              start: [parseInt($('#phpner_-product-filter-data input[name=\'low_price\']').val()), parseInt($('#phpner_-product-filter-data input[name=\'high_price\']').val())],
              behaviour: 'hover',
              connect: true,
              margin: 1,
              range: {
                'min': [<?php echo $filter_range_prices['low_price']; ?>],
                'max': [<?php echo $filter_range_prices['high_price']; ?>]
              },
              format: wNumb({
                decimals: 0
              }),
            });
            phpner_price_slider.noUiSlider.on('update', function(values, handle) {
              $('#phpner_-product-filter-data input[name=\'low_price\']').val(values[0]);
              $('#phpner_-product-filter-data input[name=\'high_price\']').val(values[1]);
            });
            if (parseInt($('#phpner_-product-filter-data input[name=\'low_price\']').val()) == parseInt($('#phpner_-product-filter-data input[name=\'high_price\']').val())) {
              $('#phpner_-price-slider').remove();
            }
            phpner_price_slider.noUiSlider.on('end', function() {
              phpner_start_filter();

            });
            <?php } ?>
			/* 3359 */
			$(".inner-box .item-content").each(function(i,lines) {
				if ($(this).find("div").length == 0) {
					$(this).prev().hide();
					$(this).hide();
				}
			});
			/* 3359 */
          }
        });
      }
      <?php if ($filter_prices) { ?>
      noUiSlider;
      phpner_price_slider.noUiSlider.set([parseInt($('#phpner_-product-filter-data input[name=\'low_price\']').val()), parseInt($('#phpner_-product-filter-data input[name=\'high_price\']').val())]);
      <?php } ?>
       $("#filter-mobile").removeClass("filter-show");
      <?php if ($phpner_product_filter_data['mask_on_filtering']) { ?>
      filter_mask('#phpner_-product-filter-data', false);
      filter_mask('#res-products', false);
      <?php } ?>
      if (localStorage.getItem('display') == 'list') {
        $('#list-view').trigger('click');
      } else {
        $('#grid-view').trigger('click');
      }
      if (!increase_limit) {
        phpner_scroll_to_top();
      }
      history.pushState({}, $('h1').html(), json['url'].replace(/&amp;/g, '&'));
    }
  });
}
//--></script>