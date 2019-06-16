<?php if ($reviews) { ?>
  <?php foreach ($reviews as $review) { ?>
  <table class="table table-striped table-bordered review-table">
    <tr>
      <td style="width: 50%;"><span class="author"><?php echo $review['author']; ?></span> <span class="phpner_-review-date"><?php echo $review['date_added']; ?></span></td>
      <td class="text-right reputation-buttons">
        <?php if (isset($review['plus_reputation'])) { ?>
          <button class="plus-reputation" type="button" onclick="review_reputation('<?php echo $review['review_id']; ?>', '1');"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></button>
          <span id="plus-reputation-<?php echo $review['review_id']; ?>"><?php echo $review['plus_reputation']; ?></span>
        <?php } ?>
        <?php if (isset($review['minus_reputation'])) { ?>
          <button class="minus-reputation" type="button" onclick="review_reputation('<?php echo $review['review_id']; ?>', '2');"><i class="fa fa-thumbs-o-down" aria-hidden="true"></i></button>
          <span id="minus-reputation-<?php echo $review['review_id']; ?>"><?php echo $review['minus_reputation']; ?></span>
        <?php } ?>
      </td>
    </tr>
    <tr class="white-tr">
      <td colspan="2">
        <?php if (isset($phpner_product_reviews_data['status']) && $phpner_product_reviews_data['status']) { ?>
          <?php if (isset($review['where_bought'])) { ?>
            <p style="display:none;"><b><?php echo $text_where_bought; ?></b> <?php echo $review['where_bought']; ?></p>
          <?php } ?>
          <?php if (isset($review['positive_text']) && $review['positive_text']) { ?>
            <p class="positive_text"><i class="fa fa-plus" aria-hidden="true"></i> <span><?php echo $entry_positive_text; ?></span></p>
            <p><?php echo $review['positive_text']; ?></p>
          <?php } ?>
          <?php if (isset($review['negative_text']) && $review['negative_text']) { ?>
            <p class="negative_text"><i class="fa fa-minus" aria-hidden="true"></i> <span><?php echo $entry_negative_text; ?></span></p>
            <p><?php echo $review['negative_text']; ?></p>
          <?php } ?>
          <p class="review-text"><?php echo $review['text']; ?></p>
          <?php if (isset($review['admin_answer']) && $review['admin_answer']) { ?>
          <div class="admin_answer">
            <p class="admin_answer_text"><i class="fa fa-reply fa-rotate-180" aria-hidden="true"></i> <span><?php echo $text_admin_answer; ?></span></p>
            <p><?php echo $review['admin_answer']; ?></p>
          </div>
          <?php } ?>
        <?php } ?>
        <div class="rating">
          <span class="my-rating"><?php echo $text_my_assessment; ?></span>
          <?php for ($i = 1; $i <= 5; $i++) { ?>
            <?php if ($review['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
            <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
            <?php } ?>
          <?php } ?>
        </div>
      </td>
    </tr>
  </table>
  <?php } ?>
  <div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
  <p><?php echo $text_no_reviews; ?></p>
<?php } ?>
