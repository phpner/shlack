<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row">
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
      <div class="col-sm-12">
        <h1 class="cat-header"><?php echo $heading_title; ?></h1>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="mobile-category-header"></div>
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
	      <div id="phpner_-filter-tag"></div>
        <?php if ($products) { ?>
        <div class="row sort-row">
          <div class="text-left left-sort-row">
            <div class="form-group input-group input-group-sm input-sort-div">
              <label class="input-group-addon" for="input-sort"><?php echo $text_sort; ?></label>
              <select id="input-sort" onchange="location = this.value;">
                <?php foreach ($sorts as $sorts) { ?>
                <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
              <div class="clearfix"></div>
            </div>
            <div class="form-group input-group input-group-sm input-limit-div">
              <select id="input-limit" onchange="location = this.value;">
                <?php foreach ($limits as $limits) { ?>
                <?php if ($limits['value'] == $limit) { ?>
                <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="text-right right-sort-row">
            <div class="hidden-xs text-right appearance">
              <div class="btn-group btn-group-sm">
                <span class="phpner_-product-view-text"></span>
                <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
                <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
              </div>
            </div>
          </div>
        </div>
        <div id="res-products">
          <div class="row">
            <?php foreach ($products as $product) { ?>
            <div class="product-layout product-list col-xs-12">
              <div class="product-thumb<?php echo (isset($product['product_preorder_status']) && $product['product_preorder_status'] != 1 && $product['quantity'] <= 0) ? ' no_quantity' : ''?>">
                <div class="image">
                  <?php if (isset($phpner_popup_view_data['status']) && $phpner_popup_view_data['status'] && $product['quantity'] > 0) { ?>
                  <div class="quick-view"><a onclick="get_phpner_popup_product_view('<?php echo $product['product_id']; ?>');"><?php echo $button_popup_view; ?></a></div>
                  <?php } ?>   
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
                  <a href="<?php echo $product['href']; ?>">
                  <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                  </a>
                </div>
                <div>
                  <div class="caption">
                    <p class="cat-model"><?php echo $text_model; ?> <span><?php echo $product['model']; ?></span></p>
                    <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                    <?php if ($product['rating']) { ?>
                    <div class="rating">
                      <?php for ($i = 1; $i <= 5; $i++) { ?>
                      <?php if ($product['rating'] < $i) { ?>
                      <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                      <?php } else { ?>
                      <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                      <?php } ?>
                      <?php } ?>
                    </div>
                    <?php } else { ?>
                    <div class="rating">
                      <?php for ($i = 1; $i <= 5; $i++) { ?>
                      <span class="fa fa-stack"><i class="fa fa-star-o" aria-hidden="true"></i></span>
                      <?php } ?>
                    </div>
                    <?php } ?>
                    <hr>
                    <div class="cat-box-effect">
                      <div class="cat-box-effect-inner">
                        <?php if ($product['price']) { ?>
                        <p class="price">
                          <?php if (!$product['special']) { ?>
                          <span class="common-price"><?php echo $product['price']; ?></span>
                          <?php } else { ?>
                          <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                          <?php } ?>
                          <?php if ($product['tax']) { ?>
                          <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                          <?php } ?>
                        </p>
                        <?php } ?>
                        <div class="cart">
                          <?php if ($product['quantity'] > 0) { ?>
                          <a class="button-cart phpner_-button" title="<?php echo $button_cart; ?>" onclick="get_phpner_popup_add_to_cart('<?php echo $product['product_id']; ?>', '1');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $button_cart; ?></span></a>
                          <?php } else { ?>
                          <a class="button-cart out-of-stock-button phpner_-button" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_phpner_product_preorder('<?php echo $product['product_id']; ?>');"<?php } ?>><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $product['product_preorder_text']; ?></span></a>
                          <?php } ?>
                          <a onclick="get_phpner_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist phpner_-button"><i class="fa fa-heart" aria-hidden="true"></i></a>
                          <a onclick="get_phpner_popup_add_to_compare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="compare phpner_-button"><i class="fa fa-sliders" aria-hidden="true"></i></a>
                        </div>
                      </div>
                    </div>
                    <p class="phpner_-product-stock"><?php echo $text_stock; ?> <span><?php echo $product['stock']; ?></span></p>
                    <div class="phpner_-additional-info">
                      <p class="phpner_-product-desc"><?php echo $product['description']; ?></p>
                      <?php if (isset($product['phpner_options']) && $product['phpner_options']) { ?>
                      <div class="cat-options">
                        <?php foreach ($product['phpner_options'] as $option) { ?>
                        <?php if ($option['type'] == 'radio') { ?>
                        <div class="form-group">
                          <label class="control-label"><?php echo $option['name']; ?></label>
                          <br/>
                          <?php if ($option['product_option_value']) { ?>
                          <?php foreach ($option['product_option_value'] as $product_option_value) { ?>
                          <?php if ($product_option_value['image']) { ?>
                          <div class="radio">
                            <img src="<?php echo $product_option_value['image']; ?>" alt="<?php echo $product_option_value['name']; ?>" class="img-thumbnail" title="<?php echo $product_option_value['name']; ?>" />
                          </div>
                          <?php } else { ?>
                          <div class="radio">
                            <label class="not-selected"><?php echo $product_option_value['name']; ?></label>
                          </div>
                          <?php } ?>
                          <?php } ?>
                          <?php } ?>
                        </div>
                        <?php } else { ?>
                        <div class="form-group size-box">
                          <label class="control-label"><?php echo $option['name']; ?></label>
                          <br/>
                          <?php if ($option['product_option_value']) { ?>
                          <?php foreach ($option['product_option_value'] as $product_option_value) { ?>
                          <div class="radio">
                            <label class="not-selected"><?php echo $product_option_value['name']; ?></label>
                          </div>
                          <?php } ?>
                          <?php } ?>
                        </div>
                        <?php } ?>
                        <?php } ?>
                      </div>
                      <?php } ?>
	                    <?php if (isset($product['phpner_attributes']) && $product['phpner_attributes']) { ?>
	                      <div class="cat-options">
	                        <?php foreach ($product['phpner_attributes'] as $attribute) { ?>
		                        <div class="form-group size-box">
		                          <label class="control-label"><?php echo $attribute['name']; ?></label>
		                          <br/>
			                        <span><?php echo $attribute['text']; ?></span>
		                        </div>
	                        <?php } ?>
	                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <?php } ?>
          </div>
          <div class="row">
            <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
          </div>
        </div>
        <?php if ($thumb || $description) { ?>
        <div class="row">
          <div class="col-sm-12 cat-desc-box">
            <?php if ($thumb) { ?>
            <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" />
            <?php } ?>
            <?php if ($description) { ?>
            <?php echo $description; ?>
            <?php } ?>
          </div>
        </div>
        <?php } ?>
        <?php } else { ?>
        <p class="text-left empty-text"><?php echo $text_empty; ?></p>
        <div class="buttons">
          <div class="text-left"><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>
      </div>
    <?php echo $column_right; ?>
    </div>
  </div>
</div>
<div class="container">
 <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>