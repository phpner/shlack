<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $blog_setting; ?>" data-toggle="tooltip" title="<?php echo $text_blog_setting; ?>" class="btn btn-info"><i class="fa fa-link"></i> <?php echo $text_blog_setting; ?></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-bestseller" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_heading; ?></label>
            <div class="col-sm-10">
              <ul class="nav nav-tabs" id="heading">
                <?php foreach ($languages as $language) { ?>
                  <li>
                    <a href="#tab-heading-language-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                  </li>
                <?php } ?>
              </ul>
              <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="tab-heading-language-<?php echo $language['language_id']; ?>">
                  <input
                    type="text"
                    name="heading[<?php echo $language['code']; ?>]"
                    value="<?php echo (!empty($heading[$language['code']])) ? $heading[$language['code']] : ''; ?>"
                    class="form-control"
                  />
                  <?php if (isset($error_heading[$language['code']])) { ?>
                    <div style="margin-bottom: 0px;margin-top: 10px;" class="alert alert-danger text-danger"><?php echo $error_heading[$language['code']]; ?></div>
                  <?php } ?>
                </div>
              <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_link; ?></label>
            <div class="col-sm-10">
              <ul class="nav nav-tabs" id="link">
                <?php foreach ($languages as $language) { ?>
                  <li>
                    <a href="#tab-link-language-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                  </li>
                <?php } ?>
              </ul>
              <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="tab-link-language-<?php echo $language['language_id']; ?>">
                  <input
                    type="text"
                    name="link[<?php echo $language['code']; ?>]"
                    value="<?php echo (!empty($link[$language['code']])) ? $link[$language['code']] : ''; ?>"
                    class="form-control"
                  />
                  <?php if (isset($error_link[$language['code']])) { ?>
                    <div style="margin-bottom: 0px;margin-top: 10px;" class="alert alert-danger text-danger"><?php echo $error_link[$language['code']]; ?></div>
                  <?php } ?>
                </div>
              <?php } ?>
              </div>
            </div>
          </div> 
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-phpner_blog"><span data-toggle="tooltip" title="<?php echo $help_category; ?>"><?php echo $entry_category; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="phpner_blog" value="" placeholder="<?php echo $entry_category; ?>" id="input-phpner_blog" class="form-control" />
              <div id="phpner_blog-category" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($phpner_blogs as $phpner_blog) { ?>
                <div id="phpner_blog-category<?php echo $phpner_blog['phpner_blog_category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $phpner_blog['name']; ?>
                  <input type="hidden" name="phpner_blog[]" value="<?php echo $phpner_blog['phpner_blog_category_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-desc-limit"><?php echo $entry_desc_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="desc_limit" value="<?php echo $desc_limit; ?>" placeholder="<?php echo $entry_desc_limit; ?>" id="input-desc-limit" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
            <div class="col-sm-10">
              <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
              <?php if ($error_width) { ?>
              <div class="text-danger"><?php echo $error_width; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
            <div class="col-sm-10">
              <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
              <?php if ($error_height) { ?>
              <div class="text-danger"><?php echo $error_height; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort_order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <select name="sort_order" id="input-sort_order" class="form-control">
                <?php if ($sort_order == "a.sort_order_asc") { ?>
                <option value="a.sort_order_asc" selected="selected"><?php echo $text_sort_order_1; ?></option>
                <option value="a.sort_order_desc"><?php echo $text_sort_order_2; ?></option>
                <option value="ad.name_asc"><?php echo $text_sort_order_3; ?></option>
                <option value="ad.name_desc"><?php echo $text_sort_order_4; ?></option>
                <option value="a.date_added_asc"><?php echo $text_sort_order_5; ?></option>
                <option value="a.date_added_desc"><?php echo $text_sort_order_6; ?></option>
                <?php } elseif ($sort_order == "a.sort_order_desc") { ?>
                <option value="a.sort_order_asc"><?php echo $text_sort_order_1; ?></option>
                <option value="a.sort_order_desc" selected="selected"><?php echo $text_sort_order_2; ?></option>
                <option value="ad.name_asc" ><?php echo $text_sort_order_3; ?></option>
                <option value="ad.name_desc"><?php echo $text_sort_order_4; ?></option>
                <option value="a.date_added_asc"><?php echo $text_sort_order_5; ?></option>
                <option value="a.date_added_desc"><?php echo $text_sort_order_6; ?></option>
                <?php } elseif ($sort_order == "a.date_added_desc") { ?>
                <option value="a.sort_order_asc"><?php echo $text_sort_order_1; ?></option>
                <option value="a.sort_order_desc"><?php echo $text_sort_order_2; ?></option>
                <option value="ad.name_asc" ><?php echo $text_sort_order_3; ?></option>
                <option value="ad.name_desc"><?php echo $text_sort_order_4; ?></option>
                <option value="a.date_added_asc"><?php echo $text_sort_order_5; ?></option>
                <option value="a.date_added_desc" selected="selected"><?php echo $text_sort_order_6; ?></option>
                <?php } elseif ($sort_order == "a.date_added_asc") { ?>
                <option value="a.sort_order_asc"><?php echo $text_sort_order_1; ?></option>
                <option value="a.sort_order_desc"><?php echo $text_sort_order_2; ?></option>
                <option value="ad.name_asc" ><?php echo $text_sort_order_3; ?></option>
                <option value="ad.name_desc"><?php echo $text_sort_order_4; ?></option>
                <option value="a.date_added_asc" selected="selected"><?php echo $text_sort_order_5; ?></option>
                <option value="a.date_added_desc"><?php echo $text_sort_order_6; ?></option>
                <?php } elseif ($sort_order == "ad.name_asc") { ?>
                <option value="a.sort_order_asc"><?php echo $text_sort_order_1; ?></option>
                <option value="a.sort_order_desc"><?php echo $text_sort_order_2; ?></option>
                <option value="ad.name_asc" selected="selected"><?php echo $text_sort_order_3; ?></option>
                <option value="ad.name_desc"><?php echo $text_sort_order_4; ?></option>
                <option value="a.date_added_asc"><?php echo $text_sort_order_5; ?></option>
                <option value="a.date_added_desc"><?php echo $text_sort_order_6; ?></option>
                <?php } else { ?>
                <option value="a.sort_order_asc"><?php echo $text_sort_order_1; ?></option>
                <option value="a.sort_order_desc"><?php echo $text_sort_order_2; ?></option>
                <option value="ad.name_asc"><?php echo $text_sort_order_3; ?></option>
                <option value="ad.name_desc" selected="selected"><?php echo $text_sort_order_4; ?></option>
                <option value="a.date_added_asc"><?php echo $text_sort_order_5; ?></option>
                <option value="a.date_added_desc"><?php echo $text_sort_order_6; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-show_image"><?php echo $entry_show_image; ?></label>
            <div class="col-sm-10">
              <select name="show_image" id="input-show_image" class="form-control">
                <?php if ($show_image) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'phpner_blog\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=phpner/blog_category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['phpner_blog_category_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'phpner_blog\']').val('');
    
    $('#phpner_blog-category' + item['value']).remove();
    
    $('#phpner_blog-category').append('<div id="phpner_blog-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="phpner_blog[]" value="' + item['value'] + '" /></div>');
  }
});
  
$('#phpner_blog-category').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});
//--></script>
<script type="text/javascript"><!--
$('#heading a:first').tab('show');
$('#link a:first').tab('show');
//--></script>
<?php echo $footer; ?>