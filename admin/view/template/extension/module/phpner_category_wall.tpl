<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <?php foreach ($languages as $language) { ?>
             <?php if (isset($error_heading[$language['code']])) { ?>
                <div style="margin-bottom: 0px;margin-top: 10px;" class="alert alert-danger text-danger"><?php echo $error_heading[$language['code']]; ?></div>
              <?php } ?>
           <?php } ?>
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
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
            <div class="col-sm-10">
              <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">
                <table class="table table-striped">
                <?php foreach ($categories as $category) { ?>
                <tr>
                  <td class="checkbox">
                    <label>
                      <?php if (in_array($category['category_id'], $module_categories)) { ?>
                      <input type="checkbox" name="module_categories[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                      <?php echo $category['name']; ?>
                      <?php } else { ?>
                      <input type="checkbox" name="module_categories[]" value="<?php echo $category['category_id']; ?>" />
                      <?php echo $category['name']; ?>
                      <?php } ?>
                    </label>
                  </td>
                </tr>
                <?php } ?>
                </table>
              </div>
              <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
              <?php if ($error_limit) { ?>
              <div class="text-danger"><?php echo $error_limit; ?></div>
              <?php } ?>
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
            <label class="col-sm-2 control-label" for="input-show_image"><?php echo $entry_image; ?></label>
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
            <label class="col-sm-2 control-label" for="input-show_sub_categories"><?php echo $entry_sub_categories; ?></label>
            <div class="col-sm-10">
              <select name="show_sub_categories" id="input-show_sub_categories" class="form-control">
                <?php if ($show_sub_categories) { ?>
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
$('#heading a:first').tab('show');
//--></script>
<?php echo $footer; ?>