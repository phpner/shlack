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
    <div id="content" class="account-content"><?php echo $content_top; ?>
      <h2><i class="fa fa-reply"></i><?php echo $heading_title; ?></h2>
      <div class="table-div wishlist-table">
	      <table class="table table-hover">
	        <thead>
	          <tr class="wishlist-tr">
	            <td class="text-left" colspan="2"><?php echo $text_return_detail; ?></td>
	          </tr>
	        </thead>
	        <tbody>
	          <tr class="wishlist-content-tr">
	            <td class="text-left" style="width: 50%;"><b><?php echo $text_return_id; ?></b> #<?php echo $return_id; ?><br />
	              <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
	            <td class="text-left" style="width: 50%;"><b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
	              <b><?php echo $text_date_ordered; ?></b> <?php echo $date_ordered; ?></td>
	          </tr>
	        </tbody>
	      </table>
    		</div>
      <h2><i class="fa fa-reply"></i><?php echo $text_product; ?></h2>
      <div class="table-div wishlist-table">
        <table class="table table-bordered table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-left" style="width: 33.3%;"><?php echo $column_product; ?></td>
              <td class="text-left" style="width: 33.3%;"><?php echo $column_model; ?></td>
              <td class="text-right" style="width: 33.3%;"><?php echo $column_quantity; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="wishlist-content-tr">
              <td class="text-left"><?php echo $product; ?></td>
              <td class="text-left"><?php echo $model; ?></td>
              <td class="text-right"><?php echo $quantity; ?></td>
            </tr>
          </tbody>
        </table>
      </div>
      <h2><i class="fa fa-reply"></i><?php echo $text_reason; ?></h2>
      <div class="table-div wishlist-table">
        <table class="table table-bordered table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-left" style="width: 33.3%;"><?php echo $column_reason; ?></td>
              <td class="text-left" style="width: 33.3%;"><?php echo $column_opened; ?></td>
              <td class="text-left" style="width: 33.3%;"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="wishlist-content-tr">
              <td class="text-left"><?php echo $reason; ?></td>
              <td class="text-left"><?php echo $opened; ?></td>
              <td class="text-left"><?php echo $action; ?></td>
            </tr>
          </tbody>
        </table>
      </div>
      <?php if ($comment) { ?>
      <div class="table-div wishlist-table">
        <table class="table table-bordered table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-left"><?php echo $text_comment; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="wishlist-content-tr">
              <td class="text-left"><?php echo $comment; ?></td>
            </tr>
          </tbody>
        </table>
      </div>
      <?php } ?>
      <h2><i class="fa fa-reply"></i><?php echo $text_history; ?></h2>
      <div class="table-div wishlist-table">
        <table class="table table-bordered table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-left" style="width: 33.3%;"><?php echo $column_date_added; ?></td>
              <td class="text-left" style="width: 33.3%;"><?php echo $column_status; ?></td>
              <td class="text-left" style="width: 33.3%;"><?php echo $column_comment; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($histories) { ?>
            <?php foreach ($histories as $history) { ?>
            <tr class="wishlist-content-tr">
              <td class="text-left"><?php echo $history['date_added']; ?></td>
              <td class="text-left"><?php echo $history['status']; ?></td>
              <td class="text-left"><?php echo $history['comment']; ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td colspan="3" class="text-center"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <div class="buttons clearfix">
        <div><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>
