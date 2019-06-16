<?php if ($comments) { ?>
<?php foreach ($comments as $comment) { ?>
<table class="table table-striped comments-table">
  <tr>
    <td>
      <span class="comments-info"><strong><?php echo $comment['author']; ?></strong></span> <span class="comments-info"><?php echo $comment['date_added']; ?></span> 
      <?php for ($i = 1; $i <= 5; $i++) { ?>
      <?php if ($comment['rating'] < $i) { ?>
      <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
      <?php } else { ?>
      <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
      <?php } ?>
      <?php } ?>
      <div class="pull-right">
        <a style="cursor:pointer;" onclick="comment_plus('<?php echo $comment['phpner_blog_comment_id']; ?>');"><i class="fa fa-thumbs-o-up" style="color:green;" aria-hidden="true"></i> <span id="comment_plus_count-<?php echo $comment['phpner_blog_comment_id']; ?>"><?php echo $comment['plus']; ?></span></a>
        |
        <a style="cursor:pointer;" onclick="comment_minus('<?php echo $comment['phpner_blog_comment_id']; ?>');"><i class="fa fa-thumbs-o-down " style="color:red;" aria-hidden="true"></i> <span id="comment_minus_count-<?php echo $comment['phpner_blog_comment_id']; ?>"><?php echo $comment['minus']; ?></span></a>
      </div>
    </td>
  </tr>
  <tr>
    <td class="comment-text"><?php echo $comment['text']; ?></td>
  </tr>
</table>
<?php } ?>
<div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
<p><?php echo $text_no_comments; ?></p>
<?php } ?>
