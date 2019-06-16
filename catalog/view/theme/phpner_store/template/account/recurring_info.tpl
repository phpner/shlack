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
      <h2><i class="fa fa-money"></i><?php echo $heading_title; ?></h2>
      <div class="table-div table-responsive wishlist-table">
        <table class="table table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-left" colspan="2"><?php echo $text_recurring_detail; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="wishlist-content-tr">
              <td class="text-left" style="width: 50%;"><b><?php echo $text_order_recurring_id; ?></b> #<?php echo $order_recurring_id; ?><br />
                <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?><br />
                <b><?php echo $text_status; ?></b> <?php echo $status; ?><br />
                <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?></td>
              <td class="text-left" style="width: 50%;"><b><?php echo $text_order_id; ?></b> <a href="<?php echo $order; ?>">#<?php echo $order_id; ?></a><br />
                <b><?php echo $text_product; ?></b> <a href="<?php echo $product; ?>"><?php echo $product_name; ?></a><br />
                <b><?php echo $text_quantity; ?></b> <?php echo $product_quantity; ?></td>
            </tr>
          </tbody>
        </table>
        <div class="table-div table-responsive wishlist-table">
	        <table class="table table-hover">
	          <thead>
	            <tr class="wishlist-tr">
	              <td class="text-left"><?php echo $text_description; ?></td>
	              <td class="text-left"><?php echo $text_reference; ?></td>
	            </tr>
	          </thead>
	          <tbody>
	            <tr class="wishlist-content-tr">
	              <td class="text-left" style="width: 50%;"><?php echo $recurring_description; ?></td>
	              <td class="text-left" style="width: 50%;"><?php echo $reference; ?></td>
	            </tr>
	          </tbody>
	        </table>
      	</div>
      </div>
      <h2><i class="fa fa-money"></i><?php echo $text_transactions; ?></h2>
      <div class="table-div table-responsive wishlist-table">
        <table class="table table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-left"><?php echo $column_date_added; ?></td>
              <td class="text-left"><?php echo $column_type; ?></td>
              <td class="text-right"><?php echo $column_amount; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($transactions) { ?>
            <?php foreach ($transactions as $transaction) { ?>
            <tr class="wishlist-content-tr">
              <td class="text-left"><?php echo $transaction['date_added']; ?></td>
              <td class="text-left"><?php echo $transaction['type']; ?></td>
              <td class="text-right"><?php echo $transaction['amount']; ?></td>
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
      <?php echo $recurring; ?>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>
