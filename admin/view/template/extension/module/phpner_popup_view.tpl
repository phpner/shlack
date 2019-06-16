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
          <ul class="nav nav-tabs">
            <li class="active"><a href="#setting-tab" data-toggle="tab"><?php echo $tab_setting; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="setting-tab">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[status]" id="input-status" class="form-control">
                    <?php if ($phpner_popup_view_data['status']) { ?>
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
                <label class="col-sm-2 control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[quantity]" id="input-quantity" class="form-control">
                    <?php if ($phpner_popup_view_data['quantity']) { ?>
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
                <label class="col-sm-2 control-label" for="input-specification"><?php echo $entry_specification_tab; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[specification]" id="input-specification" class="form-control">
                    <?php if ($phpner_popup_view_data['specification']) { ?>
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
                <label class="col-sm-2 control-label" for="input-review"><?php echo $entry_review_tab; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[review]" id="input-review" class="form-control">
                    <?php if ($phpner_popup_view_data['review']) { ?>
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
                <label class="col-sm-2 control-label" for="input-wishlist"><?php echo $entry_wishlist; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[wishlist]" id="input-wishlist" class="form-control">
                    <?php if ($phpner_popup_view_data['wishlist']) { ?>
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
                <label class="col-sm-2 control-label" for="input-compare"><?php echo $entry_compare; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[compare]" id="input-compare" class="form-control">
                    <?php if ($phpner_popup_view_data['compare']) { ?>
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
                <label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description_tab; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[description]" id="input-description" class="form-control">
                    <?php if ($phpner_popup_view_data['description']) { ?>
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
                <label class="col-sm-2 control-label" for="input-description_max"><?php echo $entry_description_max; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_view_data[description_max]" value="<?php echo $phpner_popup_view_data['description_max']; ?>" id="input-description_max" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[image]" id="input-image" class="form-control">
                    <?php if ($phpner_popup_view_data['image']) { ?>
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
                <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_view_data[image_width]" value="<?php echo $phpner_popup_view_data['image_width']; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_view_data[image_height]" value="<?php echo $phpner_popup_view_data['image_height']; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-additional_image"><?php echo $entry_additional_image; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_view_data[additional_image]" id="input-additional_image" class="form-control">
                    <?php if ($phpner_popup_view_data['additional_image']) { ?>
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
                <label class="col-sm-2 control-label" for="input-additional_width"><?php echo $entry_additional_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_view_data[image_additional_width]" value="<?php echo $phpner_popup_view_data['image_additional_width']; ?>" placeholder="<?php echo $entry_additional_width; ?>" id="input-additional_width" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-additional_height"><?php echo $entry_additional_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_view_data[image_additional_height]" value="<?php echo $phpner_popup_view_data['image_additional_height']; ?>" placeholder="<?php echo $entry_additional_height; ?>" id="input-additional_height" class="form-control" />
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>