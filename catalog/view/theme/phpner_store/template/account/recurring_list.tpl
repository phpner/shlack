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
      <?php if ($recurrings) { ?>
      <div class="table-div table-responsive wishlist-table">
        <table class="table table-hover">
          <thead>
            <tr class="wishlist-tr">
              <td class="text-right"><?php echo $column_order_recurring_id; ?></td>
              <td class="text-left"><?php echo $column_product; ?></td>
              <td class="text-left"><?php echo $column_status; ?></td>
              <td class="text-left"><?php echo $column_date_added; ?></td>
              <td class="text-right"></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($recurrings as $recurring) { ?>
            <tr class="wishlist-content-tr">
              <td class="text-right">#<?php echo $recurring['order_recurring_id']; ?></td>
              <td class="text-left"><?php echo $recurring['product']; ?></td>
              <td class="text-left"><?php echo $recurring['status']; ?></td>
              <td class="text-left"><?php echo $recurring['date_added']; ?></td>
              <td class="text-right"><a href="<?php echo $recurring['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <div class="text-right"><?php echo $pagination; ?></div>
      <?php } else { ?>
      <p class="text-center"><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <div><a href="<?php echo $continue; ?>" class="phpner_-button"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>