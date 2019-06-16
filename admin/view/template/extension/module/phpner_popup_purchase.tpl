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
                  <select name="phpner_popup_purchase_data[status]" id="input-status" class="form-control">
                    <?php if ($phpner_popup_purchase_data['status']) { ?>
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
                <label class="col-sm-2 control-label" for="input-allow_page"><?php echo $entry_allow_page; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[allow_page]" id="input-allow_page" class="form-control">
                    <?php if ($phpner_popup_purchase_data['allow_page']) { ?>
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
                <label class="col-sm-2 control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[firstname]" id="input-firstname" class="form-control">
                    <?php if ($phpner_popup_purchase_data['firstname'] == 1) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } elseif ($phpner_popup_purchase_data['firstname'] == 2) { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[email]" id="input-email" class="form-control">
                    <?php if ($phpner_popup_purchase_data['email'] == 1) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } elseif ($phpner_popup_purchase_data['email'] == 2) { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-notify_email"><?php echo $entry_notify_email; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_purchase_data[notify_email]" value="<?php echo (isset($phpner_popup_purchase_data['notify_email'])) ? $phpner_popup_purchase_data['notify_email'] : ''; ?>" id="input-notify_email" class="form-control" />
                  <?php if ($error_notify_email) { ?>
                    <div class="text-danger"><?php echo $error_notify_email; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[telephone]" id="input-telephone" class="form-control">
                    <?php if ($phpner_popup_purchase_data['telephone'] == 1) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } elseif ($phpner_popup_purchase_data['telephone'] == 2) { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-comment"><?php echo $entry_comment; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[comment]" id="input-comment" class="form-control">
                    <?php if ($phpner_popup_purchase_data['comment'] == 1) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } elseif ($phpner_popup_purchase_data['comment'] == 2) { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2" selected="selected"><?php echo $text_enabled_required; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="2"><?php echo $text_enabled_required; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[quantity]" id="input-quantity" class="form-control">
                    <?php if ($phpner_popup_purchase_data['quantity']) { ?>
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
                <label class="col-sm-2 control-label" for="input-stock-check"><span data-toggle="tooltip" title="<?php echo $help_stock_checkout; ?>"><?php echo $text_allow_stock_check; ?></span></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[stock_check]" id="input-stock-check" class="form-control">
                    <?php if ($phpner_popup_purchase_data['stock_check']) { ?>
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
                <label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[description]" id="input-description" class="form-control">
                    <?php if ($phpner_popup_purchase_data['description']) { ?>
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
                  <input type="text" name="phpner_popup_purchase_data[description_max]" value="<?php echo $phpner_popup_purchase_data['description_max']; ?>" id="input-description_max" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_popup_purchase_data[image]" id="input-image" class="form-control">
                    <?php if ($phpner_popup_purchase_data['image']) { ?>
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
                  <input type="text" name="phpner_popup_purchase_data[image_width]" value="<?php echo $phpner_popup_purchase_data['image_width']; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_purchase_data[image_height]" value="<?php echo $phpner_popup_purchase_data['image_height']; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_options; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($options as $option) { ?>
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="phpner_popup_purchase_data[allowed_options][<?php echo $row; ?>]" value="<?php echo $option['option_id']; ?>" <?php echo (!empty($phpner_popup_purchase_data['allowed_options'][$row])) ? 'checked' : ''; ?> /> <?php echo $option['name']; ?>
                      </label>
                    </div>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-mask"><?php echo $entry_mask; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_popup_purchase_data[mask]" value="<?php echo $phpner_popup_purchase_data['mask']; ?>" placeholder="<?php echo $entry_mask_info; ?>" id="input-mask" class="form-control" />
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