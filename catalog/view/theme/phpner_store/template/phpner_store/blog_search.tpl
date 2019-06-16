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
        <label class="control-label" for="input-search"><?php echo $entry_search; ?></label>
        <div class="row">
          <div class="col-sm-5">
            <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
          </div>
          <div class="col-sm-3">
            <select name="category_id" class="form-control">
              <option value="0"><?php echo $text_category; ?></option>
              <?php foreach ($categories as $category_1) { ?>
              <?php if ($category_1['category_id'] == $category_id) { ?>
              <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
              <?php } ?>
              <?php foreach ($category_1['children'] as $category_2) { ?>
              <?php if ($category_2['category_id'] == $category_id) { ?>
              <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
              <?php } ?>
              <?php foreach ($category_2['children'] as $category_3) { ?>
              <?php if ($category_3['category_id'] == $category_id) { ?>
              <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
              <?php } ?>
              <?php } ?>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="checkbox-holder">
          <label class="checkbox-inline">
          <?php if ($description) { ?>
          <input type="checkbox" name="description" value="1" id="description" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="description" value="1" id="description" />
          <?php } ?>
          <?php echo $entry_description; ?></label>
          <label class="checkbox-inline">
          <?php if ($sub_category) { ?>
          <input type="checkbox" name="sub_category" value="1" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="sub_category" value="1" />
          <?php } ?>
          <?php echo $text_sub_category; ?></label>
        </div>
        <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="phpner_-button" />
        <h2 class="search-header"><?php echo $text_search; ?></h2>
        <?php if ($articles) { ?>
          <div class="row news-row">
            <?php foreach ($articles as $article) { ?>
            <div class="product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12">
              <div class="product-thumb">
                <div class="image"><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive" /></a></div>
                <div>
                  <div class="caption">
                    <h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>
                    <p><?php echo $article['description']; ?></p>
                    <div class="pull-left">
                      <div class="badge-box">
                        <i class="fa fa-clock-o" aria-hidden="true"></i>
                        <span class="badge"><?php echo $article['date_added']; ?></span>
                      </div>
                    </div>
                    <div class="pull-right">
                      <div class="badge-box">
                        <i class="fa fa-comment-o" aria-hidden="true"></i>
                        <span class="badge"><?php echo $article['comments']; ?></span>
                      </div>
                      <div class="badge-box">
                        <i class="fa fa-eye" aria-hidden="true"></i>
                        <span class="badge"><?php echo $article['viewed']; ?></span>
                      </div>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
            </div>
            <?php } ?>
          </div>
          <div class="row">
            <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
          </div>
        <?php } else { ?>
        <p class="text-left empty-text"><?php echo $text_empty; ?></p>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<script><!--
  $('#button-search').bind('click', function() {
    url = 'index.php?route=phpner/blog_search';
  
    var search = $('#content input[name=\'search\']').prop('value');
  
    if (search) {
      url += '&search=' + encodeURIComponent(search);
    }
  
    var category_id = $('#content select[name=\'category_id\']').prop('value');
  
    if (category_id > 0) {
      url += '&category_id=' + encodeURIComponent(category_id);
    }
  
    var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');
  
    if (sub_category) {
      url += '&sub_category=true';
    }
  
    var filter_description = $('#content input[name=\'description\']:checked').prop('value');
  
    if (filter_description) {
      url += '&description=true';
    }
  
    location = url;
  });
  
  $('#content input[name=\'search\']').bind('keydown', function(e) {
    if (e.keyCode == 13) {
      $('#button-search').trigger('click');
    }
  });
  
  $('select[name=\'category_id\']').on('change', function() {
    if (this.value == '0') {
      $('input[name=\'sub_category\']').prop('disabled', true);
    } else {
      $('input[name=\'sub_category\']').prop('disabled', false);
    }
  });
  
  $('select[name=\'category_id\']').trigger('change');
  --></script>
<?php echo $footer; ?>