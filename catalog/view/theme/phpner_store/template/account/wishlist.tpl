<?php echo $header; ?>
<div class="container">
  <div class="col-sm-12 content-row">
  	<div class="breadcrumb-box">
		  <ul class="breadcrumb">
		    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
		    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		    <?php } ?>
		  </ul>
	  </div>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div id="content" class="account-content"><?php echo $content_top; ?>
      <h2><i class="fa fa-heart"></i><?php echo $heading_title; ?></h2>
      <?php if ($products) { ?>
      <div class="table-div table-responsive wishlist-table">
        <table class="table table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-center"><?php echo $column_image; ?></td>
              <td class="text-left"><?php echo $column_name; ?></td>
              <td class="text-left"><?php echo $column_model; ?></td>
              <td class="text-right phpner_-column-stock"><?php echo $column_stock; ?></td>
              <td class="text-right phpner_-column-price"><?php echo $column_price; ?></td>
              <td class="text-right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product) { ?>
            <tr class="wishlist-content-tr">
              <td class="text-center"><?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?></td>
              <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
              <td class="text-left"><?php echo $product['model']; ?></td>
              <td class="text-right"><?php echo $product['stock']; ?></td>
              <td class="text-right"><?php if ($product['price']) { ?>
                <div class="price">
                  <?php if (!$product['special']) { ?>
                  <?php echo $product['price']; ?>
                  <?php } else { ?>
                  <b><?php echo $product['special']; ?></b><br/><s><?php echo $product['price']; ?></s>
                  <?php } ?>
                </div>
                <?php } ?></td>
              <td class="text-right">
                <a href="<?php echo $product['remove']; ?>" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="phpner_-button phpner_-button-inv"><i class="fa fa-times"></i></a>
              </td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <div><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>