<?php echo $header; ?>
<div class="container">
  <div class="col-sm-12  content-row">
    <div class="breadcrumb-box">
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
        <?php if($count == 0) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } elseif($count+1<count($breadcrumbs)) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } else { ?>
        <li><span><?php echo $breadcrumb['text']; ?></span></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
    <?php echo $content_top; ?>
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
        <?php if ($products) { ?>
        <div class="table-responsive">
	        <table class="table compare-table table-bordered">
	          <thead class="compare-table-thead">
	            <tr class="text-center">
	              <td colspan="<?php echo count($products) + 1; ?>"><?php echo $text_product; ?></td>
	            </tr>
	          </thead>
	          <tbody>
	            <tr>
	              <td><?php echo $text_name; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><a href="<?php echo $product['href']; ?>"><strong><?php echo $product['name']; ?></strong></a></td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_image; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td class="text-center compare-img-td"><?php if ($product['thumb']) { ?>
	                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
	                <?php } ?>
	              </td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_price; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><?php if ($product['price']) { ?>
	                <?php if (!$product['special']) { ?>
	                <?php echo $product['price']; ?>
	                <?php } else { ?>
	                <strike><?php echo $product['price']; ?></strike> <?php echo $product['special']; ?>
	                <?php } ?>
	                <?php } ?>
	              </td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_model; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><?php echo $product['model']; ?></td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_manufacturer; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><?php echo $product['manufacturer']; ?></td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_availability; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><?php echo $product['availability']; ?></td>
	              <?php } ?>
	            </tr>
	            <?php if ($review_status) { ?>
	            <tr>
	              <td><?php echo $text_rating; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td class="rating"><?php for ($i = 1; $i <= 5; $i++) { ?>
	                <?php if ($product['rating'] < $i) { ?>
	                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
	                <?php } else { ?>
	                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
	                <?php } ?>
	                <?php } ?>
	                <br />
	                <?php echo $product['reviews']; ?>
	              </td>
	              <?php } ?>
	            </tr>
	            <?php } ?>
	            <tr>
	              <td><?php echo $text_summary; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td class="description"><?php echo $product['description']; ?></td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_weight; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><?php echo $product['weight']; ?></td>
	              <?php } ?>
	            </tr>
	            <tr>
	              <td><?php echo $text_dimension; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <td><?php echo $product['length']; ?> x <?php echo $product['width']; ?> x <?php echo $product['height']; ?></td>
	              <?php } ?>
	            </tr>
	          </tbody>
	          <?php foreach ($attribute_groups as $attribute_group) { ?>
	          <thead>
	            <tr>
	              <td colspan="<?php echo count($products) + 1; ?>"><strong><?php echo $attribute_group['name']; ?></strong></td>
	            </tr>
	          </thead>
	          <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
	          <tbody>
	            <tr>
	              <td><?php echo $attribute['name']; ?></td>
	              <?php foreach ($products as $product) { ?>
	              <?php if (isset($product['attribute'][$key])) { ?>
	              <td><?php echo $product['attribute'][$key]; ?></td>
	              <?php } else { ?>
	              <td></td>
	              <?php } ?>
	              <?php } ?>
	            </tr>
	          </tbody>
	          <?php } ?>
	          <?php } ?>
	          <tr>
	            <td></td>
	            <?php foreach ($products as $product) { ?>
	            <td class="text-center">
	              <?php if ($product['quantity'] > 0) { ?>
	              <a class="button-cart phpner_-button" title="<?php echo $button_cart; ?>" onclick="get_phpner_popup_add_to_cart('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $button_cart; ?></span></a>
	              <?php } else { ?>
	              <a class="button-cart out-of-stock-button phpner_-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_phpner_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $product['product_preorder_text']; ?></span></a>
	              <?php } ?>
	              <a href="<?php echo $product['remove']; ?>" class="phpner_-button phpner_-button-inv"><i class="fa fa-times" aria-hidden="true"></i> <span class="hidden-xs"><?php echo $button_remove; ?></span></a>
	            </td>
	            <?php } ?>
	          </tr>
	        </table>
        </div>
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
  <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>