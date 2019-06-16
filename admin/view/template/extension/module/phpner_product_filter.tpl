<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onclick="$('#form').submit();" type="submit" form="form-carousel" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a class="btn btn-success" onclick="$('#actionstay').val('1');$('#form').submit();" data-toggle="tooltip" title="<?php echo $button_stay_in_module; ?>"><i class="fa fa-save"></i> + <i class="fa fa-refresh" aria-hidden="true"></i></a>
        <button class="btn btn-danger" type="button" data-toggle="collapse" data-target="#collapse-refresh-block" aria-expanded="false" aria-controls="collapse-refresh-block" title="<?php echo $button_refresh; ?>"><i class="fa fa-download"></i></button>
        <a href="<?php echo $cache; ?>" data-toggle="tooltip" title="<?php echo $button_cache; ?>" class="btn btn-warning"><i class="fa fa-trash-o"></i></a>
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
    <div class="row">
      <div class="collapse" id="collapse-refresh-block">
        <div class="form-group" style="margin-bottom: 0px;">
          <div class="col-sm-12">
            <div class="well">
              <b id="block-refresh-attribute" style="display: none;"><i class="fa fa-spinner fa-spin"></i></b> <?php echo $button_refresh_attribute; ?><br/>
              <b id="block-refresh-filter" style="display: none;"><i class="fa fa-spinner fa-spin"></i></b> <?php echo $button_refresh_filter; ?><br/>
              <b id="block-refresh-option" style="display: none;"><i class="fa fa-spinner fa-spin"></i></b> <?php echo $button_refresh_option; ?><br/>
              <b id="block-refresh-stickers" style="display: none;"><i class="fa fa-spinner fa-spin"></i></b> <?php echo $button_refresh_stickers; ?><br/>
              <b id="block-refresh-manufacturers" style="display: none;"><i class="fa fa-spinner fa-spin"></i></b> <?php echo $button_refresh_manufacturers; ?><br/><br/>
              <button class="btn btn-success btn-sm" type="button" onclick="refreshIndexes();" id="button-refresh-start"><?php echo $button_refresh_start; ?></button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="container-fluid" id="settings-body">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <input type="hidden" id="actionstay" name="actionstay" value="0" />
          <div class="row">
            <div class="col-sm-2">
              <ul class="nav nav-pills nav-stacked">
                <li class="active"><a href="#tab_general" data-toggle="tab"><i class="fa fa-cog"></i> <?php echo $tab_general; ?></a></li>
                <li><a href="#tab_price" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_price; ?></a></li>
                <li><a href="#tab_option" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_option; ?></a></li>
                <li><a href="#tab_attribute" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_attribute; ?></a></li>
                <li><a href="#tab_manufacturer" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_manufacturer; ?></a></li>
                <li><a href="#tab_stock" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_stock; ?></a></li>
                <li><a href="#tab_review" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_review; ?></a></li>
                <li><a href="#tab_tag" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_tag; ?></a></li>
                <li><a href="#tab_sticker" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_sticker; ?></a></li>
                <li><a href="#tab_standard" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_standard; ?></a></li>
                <li><a href="#tab-seo" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_seo; ?></a></li>
              </ul>
            </div>
            <div class="col-sm-10">
              <div class="tab-content">
                <div id="tab_general" class="tab-pane active in">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_status" class="form-control">
                        <?php if ($phpner_product_filter_status) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
				  <!-- 3359 -->
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_show_no_quantity_products; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[show_no_quantity_products]" class="form-control">
                        <?php if (isset($phpner_product_filter_data['show_no_quantity_products']) && $phpner_product_filter_data['show_no_quantity_products']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_no_quantity_last; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[no_quantity_last]" class="form-control">
                        <?php if (isset($phpner_product_filter_data['no_quantity_last']) && $phpner_product_filter_data['no_quantity_last']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
				  <!-- 3359 -->
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_show_more_limit_show; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[show_more_limit_show]" class="form-control">
                        <?php if ($phpner_product_filter_data['show_more_limit_show']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_show_more_limit; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['show_more_limit']; ?>" type="text" name="phpner_product_filter_data[show_more_limit]" class="form-control" />
                      <?php if ($error_show_more_limit) { ?>
                        <div class="text-danger"><?php echo $error_show_more_limit; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_visible_items_in_block_limit; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['visible_items_in_block_limit']; ?>" type="text" name="phpner_product_filter_data[visible_items_in_block_limit]" class="form-control" />
                      <?php if ($error_visible_items_in_block_limit) { ?>
                        <div class="text-danger"><?php echo $error_visible_items_in_block_limit; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_collapse_expand_type; ?></label>
                    <div class="col-sm-10">
                      <div class="well well-sm" style="height: 110px; overflow: auto;">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="phpner_product_filter_data[collapse_expand_type][]" value="1" <?php echo (isset($phpner_product_filter_data['collapse_expand_type']) && in_array('1', $phpner_product_filter_data['collapse_expand_type'])) ? 'checked' : ''; ?> /> <?php echo $text_collapse_expand_type_1; ?>
                          </label>
                        </div>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="phpner_product_filter_data[collapse_expand_type][]" value="2" <?php echo (isset($phpner_product_filter_data['collapse_expand_type']) && in_array('2', $phpner_product_filter_data['collapse_expand_type'])) ? 'checked' : ''; ?> /> <?php echo $text_collapse_expand_type_2; ?>
                          </label>
                        </div>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="phpner_product_filter_data[collapse_expand_type][]" value="3" <?php echo (isset($phpner_product_filter_data['collapse_expand_type']) && in_array('3', $phpner_product_filter_data['collapse_expand_type'])) ? 'checked' : ''; ?> /> <?php echo $text_collapse_expand_type_3; ?>
                          </label>
                        </div>
                      </div>
                      <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_mask_on_filtering; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[mask_on_filtering]" class="form-control">
                        <?php if ($phpner_product_filter_data['mask_on_filtering']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_selected_values_position; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[selected_values_position]" class="form-control">
                        <?php if ($phpner_product_filter_data['selected_values_position'] == 1) { ?>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <option value="1" selected="selected"><?php echo $text_selected_values_position_1; ?></option>
                        <option value="2"><?php echo $text_selected_values_position_2; ?></option>
                        <option value="3"><?php echo $text_selected_values_position_3; ?></option>
                        <?php } elseif ($phpner_product_filter_data['selected_values_position'] == 2) { ?>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <option value="1"><?php echo $text_selected_values_position_1; ?></option>
                        <option value="2" selected="selected"><?php echo $text_selected_values_position_2; ?></option>
                        <option value="3"><?php echo $text_selected_values_position_3; ?></option>
                        <?php } elseif ($phpner_product_filter_data['selected_values_position'] == 3) { ?>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <option value="1"><?php echo $text_selected_values_position_1; ?></option>
                        <option value="2"><?php echo $text_selected_values_position_2; ?></option>
                        <option value="3" selected="selected"><?php echo $text_selected_values_position_3; ?></option>
                        <?php } else { ?>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <option value="1"><?php echo $text_selected_values_position_1; ?></option>
                        <option value="2"><?php echo $text_selected_values_position_2; ?></option>
                        <option value="3"><?php echo $text_selected_values_position_3; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_custom_sort; ?></label>
                    <div class="col-xs-10 col-sm-10 col-md-10">
                      <div class="table-responsive">
                        <table class="table table-bordered">
                          <thead>
                            <tr>
                              <td class="text-center" width="10%"><?php echo $text_col_custom_sort_status; ?></td>
                              <td class="text-left"><?php echo $text_col_custom_sort_name; ?></td>
                            </tr>
                          </thead>
                          <tbody>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="pd.name|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('pd.name|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_name_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="pd.name|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('pd.name|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_name_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.model|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.model|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_model_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.model|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.model|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_model_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.sort_order|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.sort_order|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_sort_order_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.sort_order|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.sort_order|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_sort_order_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.price|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.price|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_price_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.price|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.price|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_price_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="rating|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('rating|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_rating_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="rating|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('rating|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_rating_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.quantity|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.quantity|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_quantity_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.quantity|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.quantity|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_quantity_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.viewed|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.viewed|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_viewed_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.viewed|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.viewed|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_viewed_desc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.date_added|order=ASC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.date_added|order=ASC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_date_added_asc; ?></td>
                          </tr>
                          <tr>
                            <td class="text-center">
                              <input type="checkbox" name="phpner_product_filter_data[custom_sort][]" value="p.date_added|order=DESC" <?php echo (isset($phpner_product_filter_data['custom_sort']) && in_array('p.date_added|order=DESC', $phpner_product_filter_data['custom_sort'])) ? 'checked' : ''; ?> />
                            </td>
                            <td class="text-left"><?php echo $text_custom_sort_date_added_desc; ?></td>
                          </tr>
                          </tbody>
                        </table>
                        <?php if ($error_custom_sort) { ?>
                          <div class="text-danger"><?php echo $error_custom_sort; ?></div>
                        <?php } ?>
                        <a onclick="$(this).prev().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).prev().prev().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_default_sort; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[default_sort]" class="form-control">
                        <option value="pd.name|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'pd.name|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_name_asc; ?></option>
                        <option value="pd.name|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'pd.name|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_name_desc; ?></option>
                        <option value="p.model|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.model|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_model_asc; ?></option>
                        <option value="p.model|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.model|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_model_desc; ?></option>
                        <option value="p.sort|order|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.sort|order|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_sort_order_asc; ?></option>
                        <option value="p.sort|order|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.sort|order|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_sort_order_desc; ?></option>
                        <option value="p.price|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.price|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_price_asc; ?></option>
                        <option value="p.price|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.price|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_price_desc; ?></option>
                        <option value="rating|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'rating|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_rating_asc; ?></option>
                        <option value="rating|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'rating|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_rating_desc; ?></option>
                        <option value="p.quantity|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.quantity|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_quantity_asc; ?></option>
                        <option value="p.quantity|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.quantity|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_quantity_desc; ?></option>
                        <option value="p.viewed|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.viewed|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_viewed_asc; ?></option>
                        <option value="p.viewed|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.viewed|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_viewed_desc; ?></option>
                        <option value="p.date_added|order=ASC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.date_added|order=ASC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_date_added_asc; ?></option>
                        <option value="p.date_added|order=DESC" <?php echo ($phpner_product_filter_data['default_sort'] == 'p.date_added|order=DESC') ? 'selected="selected"' : ''; ?>><?php echo $text_custom_sort_date_added_desc; ?></option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_custom_limit; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['custom_limit']; ?>" type="text" name="phpner_product_filter_data[custom_limit]" class="form-control" />
                      <div class="alert alert-warning" role="alert" style="margin-bottom: 0;margin-top: 10px;"><i class="fa fa-info-circle" aria-hidden="true"></i> <?php echo $entry_custom_limit_explain; ?></div>
                      <?php if ($error_custom_limit) { ?>
                        <div class="text-danger"><?php echo $error_custom_limit; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_show_totals; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[show_totals]" class="form-control">
                        <?php if ($phpner_product_filter_data['show_totals']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
				  <!-- 3359 -->
				  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_display_empty_totals; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[display_empty_totals]" class="form-control">
                        <?php if (isset($phpner_product_filter_data['display_empty_totals']) && $phpner_product_filter_data['display_empty_totals']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
				  <!-- 3359 -->
                </div>
                <div id="tab_price" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_price_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[price_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['price_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_price_input_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[price_input_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['price_input_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_show_special_only_bytton; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[show_special_only_bytton]" class="form-control">
                        <?php if ($phpner_product_filter_data['show_special_only_bytton']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['price_sort_order']; ?>" type="text" name="phpner_product_filter_data[price_sort_order]" class="form-control" />
                      <?php if ($error_price_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_price_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[price_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['price_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <div id="tab_option" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_option_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[option_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['option_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[option_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['option_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_between_option; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[option_logic_between_option]" class="form-control">
                        <?php if ($phpner_product_filter_data['option_logic_between_option'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_option_image; ?></label>
                    <div class="col-sm-10">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_width; ?>&nbsp;</span>
                        <input value="<?php echo $phpner_product_filter_data['option_image_width']; ?>" type="text" name="phpner_product_filter_data[option_image_width]" class="form-control" />
                      </div>
                      <?php if ($error_option_image_width) { ?>
                        <div class="text-danger"><?php echo $error_option_image_width; ?></div>
                      <?php } ?>
                      <div class="input-group" style="margin-top: 10px;">
                        <span class="input-group-addon"><?php echo $text_height; ?></span>
                        <input value="<?php echo $phpner_product_filter_data['option_image_height']; ?>" type="text" name="phpner_product_filter_data[option_image_height]" class="form-control" />
                      </div>
                      <?php if ($error_option_image_height) { ?>
                        <div class="text-danger"><?php echo $error_option_image_height; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['option_sort_order']; ?>" type="text" name="phpner_product_filter_data[option_sort_order]" class="form-control" />
                      <?php if ($error_option_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_option_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[option_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['option_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <?php if ($option_filters) { ?>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-xs-10 col-sm-10 col-md-10">
                      <div class="table-responsive">
                        <table class="table table-bordered">
                          <thead>
                            <tr>
                              <td class="text-left"><?php echo $text_col_option_name; ?></td>
                              <td class="text-left"><?php echo $entry_display_type; ?></td>
                              <td class="text-left"><?php echo $text_col_option_status; ?></td>
                              <td class="text-left"><?php echo $text_col_option_image; ?></td>
                            </tr>
                          </thead>
                          <tbody>
                          <tr>
                            <td></td>
                            <td>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-type select').val('1');"><?php echo $text_like_select; ?></a>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-type select').val('2');"><?php echo $text_like_radio; ?></a>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-type select').val('3');"><?php echo $text_like_checkbox; ?></a>
                            </td>
                            <td>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-status select').val('1');"><?php echo $text_enabled; ?></a>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-status select').val('0');"><?php echo $text_disabled; ?></a>
                            </td>
                            <td>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-image select').val('1');"><?php echo $text_enabled; ?></a>
                              <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.option-filter-image select').val('0');"><?php echo $text_disabled; ?></a>
                            </td>
                          </tr>
                          <?php foreach ($option_filters as $option_filter) { ?>
                          <tr>
                            <td class="text-left"><?php echo $option_filter['name']; ?></td>
                            <td class="text-left option-filter-type">
                              <select name="phpner_product_filter_data[option_display_type][<?php echo $option_filter['option_id']; ?>]" class="form-control">
                                <option value="1" <?php if (isset($phpner_product_filter_data['option_display_type'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_type'][$option_filter['option_id']] == 1) { ?>selected="selected"<?php } ?>><?php echo $text_like_select; ?></option>
                                <option value="2" <?php if (isset($phpner_product_filter_data['option_display_type'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_type'][$option_filter['option_id']] == 2) { ?>selected="selected"<?php } ?>><?php echo $text_like_radio; ?></option>
                                <option value="3" <?php if (isset($phpner_product_filter_data['option_display_type'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_type'][$option_filter['option_id']] == 3) { ?>selected="selected"<?php } ?>><?php echo $text_like_checkbox; ?></option>
                              </select>
                            </td>
                            <td class="text-left option-filter-status">
                              <select name="phpner_product_filter_data[option_display_status][<?php echo $option_filter['option_id']; ?>]" class="form-control">
                                <option value="1" <?php if (isset($phpner_product_filter_data['option_display_status'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_status'][$option_filter['option_id']] == 1) { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                                <option value="0" <?php if (isset($phpner_product_filter_data['option_display_status'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_status'][$option_filter['option_id']] == 0) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                              </select>
                            </td>
                            <td class="text-left option-filter-image">
                              <select name="phpner_product_filter_data[option_display_image][<?php echo $option_filter['option_id']; ?>]" class="form-control">
                                <option value="1" <?php if (isset($phpner_product_filter_data['option_display_image'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_image'][$option_filter['option_id']] == 1) { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                                <option value="0" <?php if (isset($phpner_product_filter_data['option_display_image'][$option_filter['option_id']]) && $phpner_product_filter_data['option_display_image'][$option_filter['option_id']] == 0) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                              </select>
                            </td>
                          </tr>
                          <?php } ?>
                          </tbody>
                          <tfoot>
                            <tr>
                              <td></td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-type select').val('1');"><?php echo $text_like_select; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-type select').val('2');"><?php echo $text_like_radio; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-type select').val('3');"><?php echo $text_like_checkbox; ?></a>
                              </td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-status select').val('1');"><?php echo $text_enabled; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-status select').val('0');"><?php echo $text_disabled; ?></a>
                              </td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-image select').val('1');"><?php echo $text_enabled; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.option-filter-image select').val('0');"><?php echo $text_disabled; ?></a>
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>
                    </div>
                  </div>
                  <?php } ?>
                </div>
                <div id="tab_attribute" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_attribute_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[attribute_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['attribute_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[attribute_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['attribute_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_between_attribute; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[attribute_logic_between_attribute]" class="form-control">
                        <?php if ($phpner_product_filter_data['attribute_logic_between_attribute'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['attribute_sort_order']; ?>" type="text" name="phpner_product_filter_data[attribute_sort_order]" class="form-control" />
                      <?php if ($error_attribute_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_attribute_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[attribute_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['attribute_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <?php if ($attribute_filters) { ?>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-xs-10 col-sm-10 col-md-10">
                      <div class="table-responsive">
                        <table class="table table-bordered">
                          <thead>
                            <tr>
                              <td class="text-left"><?php echo $text_col_attribute_name; ?></td>
                              <td class="text-left"><?php echo $entry_display_type; ?></td>
                              <td class="text-left"><?php echo $text_col_attribute_status; ?></td>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td></td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-type select').val('1');"><?php echo $text_like_select; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-type select').val('2');"><?php echo $text_like_radio; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-type select').val('3');"><?php echo $text_like_checkbox; ?></a>
                              </td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-status select').val('1');"><?php echo $text_enabled; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-status select').val('0');"><?php echo $text_disabled; ?></a>
                              </td>
                            </tr>
                            <?php foreach ($attribute_filters as $attribute_filter) { ?>
                            <tr>
                              <td class="text-left"><?php echo $attribute_filter['name']; ?></td>
                              <td class="text-left attr-filter-type">
                                <select name="phpner_product_filter_data[attribute_display_type][<?php echo $attribute_filter['attribute_id']; ?>]" class="form-control">
                                  <option value="1" <?php if (isset($phpner_product_filter_data['attribute_display_type'][$attribute_filter['attribute_id']]) && $phpner_product_filter_data['attribute_display_type'][$attribute_filter['attribute_id']] == 1) { ?>selected="selected"<?php } ?>><?php echo $text_like_select; ?></option>
                                  <option value="2" <?php if (isset($phpner_product_filter_data['attribute_display_type'][$attribute_filter['attribute_id']]) && $phpner_product_filter_data['attribute_display_type'][$attribute_filter['attribute_id']] == 2) { ?>selected="selected"<?php } ?>><?php echo $text_like_radio; ?></option>
                                  <option value="3" <?php if (isset($phpner_product_filter_data['attribute_display_type'][$attribute_filter['attribute_id']]) && $phpner_product_filter_data['attribute_display_type'][$attribute_filter['attribute_id']] == 3) { ?>selected="selected"<?php } ?>><?php echo $text_like_checkbox; ?></option>
                                </select>
                              </td>
                              <td class="text-left attr-filter-status">
                                <select name="phpner_product_filter_data[attribute_display_status][<?php echo $attribute_filter['attribute_id']; ?>]" class="form-control">
                                  <option value="1" <?php if (isset($phpner_product_filter_data['attribute_display_status'][$attribute_filter['attribute_id']]) && $phpner_product_filter_data['attribute_display_status'][$attribute_filter['attribute_id']] == 1) { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                                  <option value="0" <?php if (isset($phpner_product_filter_data['attribute_display_status'][$attribute_filter['attribute_id']]) && $phpner_product_filter_data['attribute_display_status'][$attribute_filter['attribute_id']] == 0) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                                </select>
                              </td>
                            </tr>
                            <?php } ?>
                          </tbody>
                          <tfoot>
                            <tr>
                              <td></td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-type select').val('1');"><?php echo $text_like_select; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-type select').val('2');"><?php echo $text_like_radio; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-type select').val('3');"><?php echo $text_like_checkbox; ?></a>
                              </td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-status select').val('1');"><?php echo $text_enabled; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-status select').val('0');"><?php echo $text_disabled; ?></a>
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>
                    </div>
                  </div>
                  <?php } ?>
                </div>
                <div id="tab_manufacturer" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_manufacturer_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[manufacturer_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['manufacturer_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[manufacturer_display_type]" class="form-control">
                        <?php if ($phpner_product_filter_data['manufacturer_display_type'] == 1) { ?>
                        <option value="1" selected="selected"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } elseif ($phpner_product_filter_data['manufacturer_display_type'] == 2) { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2" selected="selected"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3" selected="selected"><?php echo $text_like_checkbox; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[manufacturer_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['manufacturer_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_manufacturer_image; ?></label>
                    <div class="col-sm-10">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_width; ?>&nbsp;</span>
                        <input value="<?php echo $phpner_product_filter_data['manufacturer_image_width']; ?>" type="text" name="phpner_product_filter_data[manufacturer_image_width]" class="form-control" />
                      </div>
                      <?php if ($error_manufacturer_image_width) { ?>
                        <div class="text-danger"><?php echo $error_manufacturer_image_width; ?></div>
                      <?php } ?>
                      <div class="input-group" style="margin-top: 10px;">
                        <span class="input-group-addon"><?php echo $text_height; ?></span>
                        <input value="<?php echo $phpner_product_filter_data['manufacturer_image_height']; ?>" type="text" name="phpner_product_filter_data[manufacturer_image_height]" class="form-control" />
                      </div>
                      <?php if ($error_manufacturer_image_height) { ?>
                        <div class="text-danger"><?php echo $error_manufacturer_image_height; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['manufacturer_sort_order']; ?>" type="text" name="phpner_product_filter_data[manufacturer_sort_order]" class="form-control" />
                      <?php if ($error_manufacturer_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_manufacturer_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[manufacturer_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['manufacturer_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <div id="tab_stock" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_stock_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[stock_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['stock_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[stock_display_type]" class="form-control">
                        <?php if ($phpner_product_filter_data['stock_display_type'] == 1) { ?>
                        <option value="1" selected="selected"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } elseif ($phpner_product_filter_data['stock_display_type'] == 2) { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2" selected="selected"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3" selected="selected"><?php echo $text_like_checkbox; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_stock_ending_value_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[stock_ending_value_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['stock_ending_value_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[stock_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['stock_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_between_stock; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[stock_logic_between_stock]" class="form-control">
                        <?php if ($phpner_product_filter_data['stock_logic_between_stock'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                      <div class="alert alert-warning" role="alert" style="margin-bottom: 0;margin-top: 10px;"><i class="fa fa-info-circle" aria-hidden="true"></i> <?php echo $entry_logic_between_explain; ?></div>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_stock_ending_value; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['stock_ending_value']; ?>" type="text" name="phpner_product_filter_data[stock_ending_value]" class="form-control" />
                      <?php if ($error_stock_ending_value) { ?>
                        <div class="text-danger"><?php echo $error_stock_ending_value; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['stock_sort_order']; ?>" type="text" name="phpner_product_filter_data[stock_sort_order]" class="form-control" />
                      <?php if ($error_stock_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_stock_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[stock_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['stock_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <div id="tab_review" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_review_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[review_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['review_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[review_display_type]" class="form-control">
                        <?php if ($phpner_product_filter_data['review_display_type'] == 1) { ?>
                        <option value="1" selected="selected"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } elseif ($phpner_product_filter_data['review_display_type'] == 2) { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2" selected="selected"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3" selected="selected"><?php echo $text_like_checkbox; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[review_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['review_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_between_review; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[review_logic_between_review]" class="form-control">
                        <?php if ($phpner_product_filter_data['review_logic_between_review'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                      <div class="alert alert-warning" role="alert" style="margin-bottom: 0;margin-top: 10px;"><i class="fa fa-info-circle" aria-hidden="true"></i> <?php echo $entry_logic_between_explain; ?></div>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['review_sort_order']; ?>" type="text" name="phpner_product_filter_data[review_sort_order]" class="form-control" />
                      <?php if ($error_review_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_review_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[review_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['review_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <div id="tab_tag" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_tag_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[tag_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['tag_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[tag_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['tag_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['tag_sort_order']; ?>" type="text" name="phpner_product_filter_data[tag_sort_order]" class="form-control" />
                      <?php if ($error_tag_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_tag_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[tag_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['tag_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <div id="tab_sticker" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_sticker_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[sticker_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['sticker_status']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                      <div class="alert alert-warning" role="alert" style="margin-bottom: 0;margin-top: 10px;"><i class="fa fa-info-circle" aria-hidden="true"></i> <?php echo $entry_sticker_status_explain; ?></div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[sticker_display_type]" class="form-control">
                        <?php if ($phpner_product_filter_data['sticker_display_type'] == 1) { ?>
                        <option value="1" selected="selected"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } elseif ($phpner_product_filter_data['sticker_display_type'] == 2) { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2" selected="selected"><?php echo $text_like_radio; ?></option>
                        <option value="3"><?php echo $text_like_checkbox; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_like_select; ?></option>
                        <option value="2"><?php echo $text_like_radio; ?></option>
                        <option value="3" selected="selected"><?php echo $text_like_checkbox; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[sticker_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['sticker_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_between_sticker; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[sticker_logic_between_sticker]" class="form-control">
                        <?php if ($phpner_product_filter_data['sticker_logic_between_sticker'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                      <div class="alert alert-warning" role="alert" style="margin-bottom: 0;margin-top: 10px;"><i class="fa fa-info-circle" aria-hidden="true"></i> <?php echo $entry_logic_between_explain; ?></div>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['sticker_sort_order']; ?>" type="text" name="phpner_product_filter_data[sticker_sort_order]" class="form-control" />
                      <?php if ($error_sticker_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_sticker_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[sticker_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['sticker_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <div id="tab_standard" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_standard_status; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[standard_status]" class="form-control">
                        <?php if ($phpner_product_filter_data['standard_status']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_type_with_other; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[standard_logic_with_other]" class="form-control">
                        <?php if ($phpner_product_filter_data['standard_logic_with_other'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic_between_standard; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[standard_logic_between_standard]" class="form-control">
                        <?php if ($phpner_product_filter_data['standard_logic_between_standard'] == 'AND') { ?>
                        <option value="AND" selected="selected"><?php echo $text_logic_and; ?></option>
                        <option value="OR"><?php echo $text_logic_or; ?></option>
                        <?php } else { ?>
                        <option value="AND"><?php echo $text_logic_and; ?></option>
                        <option value="OR" selected="selected"><?php echo $text_logic_or; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $phpner_product_filter_data['standard_sort_order']; ?>" type="text" name="phpner_product_filter_data[standard_sort_order]" class="form-control" />
                      <?php if ($error_standard_sort_order) { ?>
                        <div class="text-danger"><?php echo $error_standard_sort_order; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $enter_collapsed; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[standard_collapsed]" class="form-control">
                        <?php if ($phpner_product_filter_data['standard_collapsed']) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <?php if ($standard_filters) { ?>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_display_type; ?></label>
                    <div class="col-xs-10 col-sm-10 col-md-10">
                      <div class="table-responsive">
                        <table class="table table-bordered">
                          <thead>
                            <tr>
                              <td class="text-left"><?php echo $text_col_standard_name; ?></td>
                              <td class="text-left"><?php echo $entry_display_type; ?></td>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td></td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-type select').val('1');"><?php echo $text_like_select; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-type select').val('2');"><?php echo $text_like_radio; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().find('.attr-filter-type select').val('3');"><?php echo $text_like_checkbox; ?></a>
                              </td>
                            </tr>
                            <?php foreach ($standard_filters as $standard_filter) { ?>
                            <tr>
                              <td class="text-left"><?php echo $standard_filter['name']; ?></td>
                              <td class="text-left attr-filter-type">
                                <select name="phpner_product_filter_data[standard_display_type][<?php echo $standard_filter['filter_group_id']; ?>]" class="form-control">
                                  <option value="1" <?php if (isset($phpner_product_filter_data['standard_display_type'][$standard_filter['filter_group_id']]) && $phpner_product_filter_data['standard_display_type'][$standard_filter['filter_group_id']] == 1) { ?>selected="selected"<?php } ?>><?php echo $text_like_select; ?></option>
                                  <option value="2" <?php if (isset($phpner_product_filter_data['standard_display_type'][$standard_filter['filter_group_id']]) && $phpner_product_filter_data['standard_display_type'][$standard_filter['filter_group_id']] == 2) { ?>selected="selected"<?php } ?>><?php echo $text_like_radio; ?></option>
                                  <option value="3" <?php if (isset($phpner_product_filter_data['standard_display_type'][$standard_filter['filter_group_id']]) && $phpner_product_filter_data['standard_display_type'][$standard_filter['filter_group_id']] == 3) { ?>selected="selected"<?php } ?>><?php echo $text_like_checkbox; ?></option>
                                </select>
                              </td>
                            </tr>
                            <?php } ?>
                          </tbody>
                          <tfoot>
                            <tr>
                              <td></td>
                              <td>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-type select').val('1');"><?php echo $text_like_select; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-type select').val('2');"><?php echo $text_like_radio; ?></a>
                                <a class="btn btn-primary btn-xs" onclick="$(this).parent().parent().parent().prev().find('.attr-filter-type select').val('3');"><?php echo $text_like_checkbox; ?></a>
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>
                    </div>
                  </div>
                  <?php } ?>
                </div>
                <div id="tab-seo" class="tab-pane">
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_enable_seo; ?></label>
                    <div class="col-sm-10">
                      <select name="phpner_product_filter_data[enable_seo]" class="form-control">
                        <?php if (isset($phpner_product_filter_data['enable_seo']) && $phpner_product_filter_data['enable_seo']) { ?>
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
                    <label class="col-sm-2 control-label"><?php echo $entry_data_feed; ?></label>
                    <div class="col-sm-10">
                      <input value="<?php echo $data_feed; ?>" type="text" class="form-control" readonly="readonly" />
                    </div>
                  </div>
                  <div class="well">
                    <div class="input-group">
                      <input type="text" name="filter_seo_url" value="" placeholder="<?php echo $text_enter_seo_url; ?>" class="form-control" />
                      <span class="input-group-btn">
                        <button class="btn btn-danger" type="button" id="clear-filter-form"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
                        <button class="btn btn-primary" type="button" id="submit-filter-form"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                      </span>
                    </div>
                  </div>
                  <div id="history-seo"></div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
var types = ['stickers','filter','manufacturers','option','attribute'];
var i = 0;

function refreshIndexes(type) {
  $('#collapse-refresh-block b').show();
  $('#button-refresh-start').attr('disabled', 'disabled');
  if (typeof(type) == 'undefined') {
    type = 'stickers';
  }

  $.ajax({
    type: 'get',
    url:  'index.php?route=extension/module/phpner_product_filter/refresh&<?php echo $token; ?>&type='+type,
    dataType: 'json',
    success: function(json) {
      i++;
      if (i <= types.length) {
        $('#block-refresh-'+type).html('<i class="fa fa-check-circle"></i>');

        refreshIndexes(types[i]);
      } else {
        $('#button-refresh-start').removeAttr('disabled');
        $('#collapse-refresh-block').append('<div class="container-fluid"><div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> '+json['success']+'<button type="button" class="close" data-dismiss="alert">&times;</button></div></div>');
      }
    }
  });
}
</script>
<script type="text/javascript">
$('body').on('hidden.bs.modal', function () {
  if($('.modal.in').length > 0) {
    $('body').addClass('modal-open');
  }
});

function texteditor_action({id = '', destroy = false, start = true} = {}) {
  if (start) {
    $(id).summernote({focus: true});

    $(id).parent().next().find('button:eq(1)').show();

    if ($(id).summernote('isEmpty')) {
      $(id).val('');
    }
  }

  if (destroy) {
    $(id).summernote('destroy');
    $(id).parent().next().find('button:eq(1)').hide();
  }
}
</script>
<script type="text/javascript">
$(function() {
  $('a[href=#tab-seo]').on('click', function() {
    $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>');
    $('#tab-seo .alert, #tab-seo .text-danger').remove();
  });
});

function submit_seo(element, action) {
  $.ajax({
    url:  'index.php?route=extension/module/phpner_product_filter/history_seo_action&<?php echo $token; ?>',
    type: 'post',
    data: $('#modal-form-constructor input[type=\'text\'], #modal-form-constructor input[type=\'hidden\'], #modal-form-constructor textarea, #modal-form-constructor select'),
    dataType: 'json',
    success: function(json) {
      $('#modal-form-constructor-content .alert-danger, #modal-form-constructor-content .alert-success').remove();
      $('#modal-form-constructor-content .form-group').removeClass('has-error');

      if (json['error']) {
        for (i in json['error']) {
          if (i.replace(/_/g, '-') == 'warning') {
            $('#modal-form-constructor-content .panel-body').append('<div class="alert alert-danger" style="margin-bottom: 0px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'][i] + '</div>');
          } else if (i.replace(/_/g, '-') == 'form-description-language') {
            for (b in json['error'][i]) {
              for (c in json['error'][i][b]) {
                $('#modal-error-'+i.replace(/_/g, '-')+'-'+b.replace(/_/g, '-')+'-'+c).append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'][i][b][c] + '</div>');
              }
            }
          } else {
            $('#modal-error-' + i.replace(/_/g, '-')).html('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'][i] + '</div>');
            $('#modal-error-' + i.replace(/_/g, '-')).parent().parent().addClass('has-error');
          }
        }
      }

      if (json['success']) {
        if (action == 'add') {
          $(element).attr('disabled', true);
          $(element).next().show();
        }
        $('a[href=#tab-seo]').click();
        $('#modal-form-constructor-content > div > div >.panel-body').append('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
    }
  });
}

$('#history-seo').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
  $('#history-seo').load(this.href);
});

$('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>');

$('#submit-filter-form').on('click', function() {
  $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>&filter_seo_url='+encodeURIComponent($('input[name=\'filter_seo_url\']').val()));
});

$('#clear-filter-form').on('click', function() {
  $('input[name=\'filter_seo_url\']').val('');
  $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>&filter_seo_url='+encodeURIComponent($('input[name=\'filter_seo_url\']').val()));
});

$('input[name=\'filter_seo_url\']').autocomplete({
  'source': function(request, response) {
    $.ajax({
      url: 'index.php?route=extension/module/phpner_product_filter/autocomplete_seo_url&<?php echo $token; ?>&filter_seo_url='+encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['seo_url'],
            value: item['seo_id']
          }
        }));
      }
    });
  },
  'select': function(item) {
    $('input[name=\'filter_seo_url\']').val(item['label']);
  }
});

function open_seo({id = 0} = {}) {
  html = '';

  html += '<div id="modal-form-constructor" class="modal fade">';
  html += '  <div class="modal-dialog modal-lg">';
  html += '    <div id="modal-form-constructor-list"></div>';
  html += '  </div>';
  html += '</div>';

  $('body').append(html);

  if (id > 0) {
    $('#modal-form-constructor-list').load('index.php?route=extension/module/phpner_product_filter/history_seo&<?php echo $token; ?>&seo_id='+id);
  } else {
    $('#modal-form-constructor-list').load('index.php?route=extension/module/phpner_product_filter/history_seo&<?php echo $token; ?>');
  }

  $('#modal-form-constructor').modal('show'); 
}

function delete_selected(filter_status, type, id) {
  $.ajax({
    type: 'post',
    url:  'index.php?route=extension/module/phpner_product_filter/delete_selected&<?php echo $token; ?>&type='+type+'&delete='+id,
    dataType: 'json',
    success: function(json) {
      $('#tab-seo .alert, #tab-seo .text-danger').remove();
      
      if (json['error']) {
        $('#history-seo').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>');
        $('#history-seo').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    }
  });
}

function delete_all(filter_status, type) {
  $.ajax({
    type: 'get',
    url:  'index.php?route=extension/module/phpner_product_filter/delete_all&<?php echo $token; ?>&type='+type,
    dataType: 'json',
    success: function(json) {
      $('#tab-seo .alert, #tab-seo .text-danger').remove();
      
      if (json['error']) {
        $('#history-seo').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>');
        $('#history-seo').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    }
  });
}

function delete_all_selected(filter_status, type) {
  var checkbox_data = $('#history-seo input[type=\'checkbox\']:checked');

  $.ajax({
    type: 'post',
    url:  'index.php?route=extension/module/phpner_product_filter/delete_all_selected&<?php echo $token; ?>&type='+type,
    data: checkbox_data,
    dataType: 'json',
    success: function(json) {
      $('#tab-seo .alert, #tab-seo .text-danger').remove();
      
      if (json['error']) {
        $('#history-seo').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>');
        $('#history-seo').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    }
  });
}

function copy_selected(id) {
  $.ajax({
    type: 'post',
    url:  'index.php?route=extension/module/phpner_product_filter/copy_selected&<?php echo $token; ?>&copy='+id,
    dataType: 'json',
    success: function(json) {
      $('#tab-seo .alert, #tab-seo .text-danger').remove();
      
      if (json['error']) {
        $('#history-seo').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        $('#history-seo').load('index.php?route=extension/module/phpner_product_filter/history_seo_list&<?php echo $token; ?>');
        $('#history-seo').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    }
  });
}
</script>
<?php echo $footer; ?>
