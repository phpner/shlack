<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $uninstall; ?>" data-toggle="tooltip" title="<?php echo $button_uninstall; ?>" class="btn btn-danger"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
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
    <?php if ($warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
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
                  <select name="phpner_blog_setting_data[status]" id="input-status" class="form-control">
                    <?php if ($phpner_blog_setting_data['status']) { ?>
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
                <label class="col-sm-2 control-label" for="input-comment_moderation"><?php echo $entry_comment_moderation; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_blog_setting_data[comment_moderation]" id="input-comment_moderation" class="form-control">
                    <?php if ($phpner_blog_setting_data['comment_moderation']) { ?>
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
                <label class="col-sm-2 control-label" for="input-comment_show"><?php echo $entry_comment_show; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_blog_setting_data[comment_show]" id="input-comment_show" class="form-control">
                    <?php if ($phpner_blog_setting_data['comment_show']) { ?>
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
                <label class="col-sm-2 control-label" for="input-comment_write"><?php echo $entry_comment_write; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_blog_setting_data[comment_write]" id="input-comment_write" class="form-control">
                    <?php if ($phpner_blog_setting_data['comment_write']) { ?>
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
                <label class="col-sm-2 control-label" for="input-desc_limit"><?php echo $entry_desc_limit; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[desc_limit]" value="<?php echo $phpner_blog_setting_data['desc_limit']; ?>" placeholder="<?php echo $entry_desc_limit; ?>" id="input-desc_limit" class="form-control" />
                  <?php if ($error_desc_limit) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_desc_limit; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-main_image_width"><?php echo $entry_main_image_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[main_image_width]" value="<?php echo $phpner_blog_setting_data['main_image_width']; ?>" placeholder="<?php echo $entry_main_image_width; ?>" id="input-main_image_width" class="form-control" />
                  <?php if ($error_main_image_width) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_main_image_width; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-main_image_height"><?php echo $entry_main_image_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[main_image_height]" value="<?php echo $phpner_blog_setting_data['main_image_height']; ?>" placeholder="<?php echo $entry_main_image_height; ?>" id="input-main_image_height" class="form-control" />
                  <?php if ($error_main_image_height) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_main_image_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-main_image_popup_width"><?php echo $entry_main_image_popup_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[main_image_popup_width]" value="<?php echo $phpner_blog_setting_data['main_image_popup_width']; ?>" placeholder="<?php echo $entry_main_image_popup_width; ?>" id="input-main_image_popup_width" class="form-control" />
                  <?php if ($error_main_image_popup_width) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_main_image_popup_width; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-main_image_popup_height"><?php echo $entry_main_image_popup_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[main_image_popup_height]" value="<?php echo $phpner_blog_setting_data['main_image_popup_height']; ?>" placeholder="<?php echo $entry_main_image_popup_height; ?>" id="input-main_image_popup_height" class="form-control" />
                  <?php if ($error_main_image_popup_height) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_main_image_popup_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-sub_image_width"><?php echo $entry_sub_image_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[sub_image_width]" value="<?php echo $phpner_blog_setting_data['sub_image_width']; ?>" placeholder="<?php echo $entry_sub_image_width; ?>" id="input-sub_image_width" class="form-control" />
                  <?php if ($error_sub_image_width) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_sub_image_width; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-sub_image_height"><?php echo $entry_sub_image_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[sub_image_height]" value="<?php echo $phpner_blog_setting_data['sub_image_height']; ?>" placeholder="<?php echo $entry_sub_image_height; ?>" id="input-sub_image_height" class="form-control" />
                  <?php if ($error_sub_image_height) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_sub_image_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-r_p_image_width"><?php echo $entry_r_p_image_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[r_p_image_width]" value="<?php echo $phpner_blog_setting_data['r_p_image_width']; ?>" placeholder="<?php echo $entry_r_p_image_width; ?>" id="input-r_p_image_width" class="form-control" />
                  <?php if ($error_r_p_image_width) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_r_p_image_width; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-r_p_image_height"><?php echo $entry_r_p_image_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[r_p_image_height]" value="<?php echo $phpner_blog_setting_data['r_p_image_height']; ?>" placeholder="<?php echo $entry_r_p_image_height; ?>" id="input-r_p_image_height" class="form-control" />
                  <?php if ($error_r_p_image_height) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_r_p_image_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-r_a_image_width"><?php echo $entry_r_a_image_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[r_a_image_width]" value="<?php echo $phpner_blog_setting_data['r_a_image_width']; ?>" placeholder="<?php echo $entry_r_a_image_width; ?>" id="input-r_a_image_width" class="form-control" />
                  <?php if ($error_r_a_image_width) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_r_a_image_width; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-r_a_image_height"><?php echo $entry_r_a_image_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[r_a_image_height]" value="<?php echo $phpner_blog_setting_data['r_a_image_height']; ?>" placeholder="<?php echo $entry_r_a_image_height; ?>" id="input-r_a_image_height" class="form-control" />
                  <?php if ($error_r_a_image_height) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_r_a_image_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-a_image_width_in_category"><?php echo $entry_a_image_width_in_category; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[a_image_width_in_category]" value="<?php echo $phpner_blog_setting_data['a_image_width_in_category']; ?>" placeholder="<?php echo $entry_a_image_width_in_category; ?>" id="input-a_image_width_in_category" class="form-control" />
                  <?php if ($error_a_image_width_in_category) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_a_image_width_in_category; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-a_image_height_in_category"><?php echo $entry_a_image_height_in_category; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[a_image_height_in_category]" value="<?php echo $phpner_blog_setting_data['a_image_height_in_category']; ?>" placeholder="<?php echo $entry_a_image_height_in_category; ?>" id="input-a_image_height_in_category" class="form-control" />
                  <?php if ($error_a_image_height_in_category) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_a_image_height_in_category; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-c_image_width"><?php echo $entry_c_image_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[c_image_width]" value="<?php echo $phpner_blog_setting_data['c_image_width']; ?>" placeholder="<?php echo $entry_c_image_width; ?>" id="input-c_image_width" class="form-control" />
                  <?php if ($error_c_image_width) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_c_image_width; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-c_image_height"><?php echo $entry_c_image_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="phpner_blog_setting_data[c_image_height]" value="<?php echo $phpner_blog_setting_data['c_image_height']; ?>" placeholder="<?php echo $entry_c_image_height; ?>" id="input-c_image_height" class="form-control" />
                  <?php if ($error_c_image_height) { ?>
                    <div class="alert alert-danger text-danger"><?php echo $error_c_image_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_seo_title; ?></label>
                <div class="col-sm-10">
                  <?php foreach ($languages as $language) { ?>
                    <div class="input-group" style="margin-bottom: 5px;">
                      <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                      <input type="text" name="phpner_blog_setting_data[language][<?php echo $language['language_id']; ?>][seo_title]" value="<?php echo isset($phpner_blog_setting_data['language'][$language['language_id']]) ? $phpner_blog_setting_data['language'][$language['language_id']]['seo_title'] : ''; ?>" class="form-control" />
                    </div>
                    <?php if (isset($error_seo_title[$language['language_id']])) { ?>
                      <div class="alert alert-danger text-danger"><?php echo $error_seo_title[$language['language_id']]; ?></div>
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_seo_h1; ?></label>
                <div class="col-sm-10">
                  <?php foreach ($languages as $language) { ?>
                    <div class="input-group" style="margin-bottom: 5px;">
                      <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                      <input type="text" name="phpner_blog_setting_data[language][<?php echo $language['language_id']; ?>][seo_h1]" value="<?php echo isset($phpner_blog_setting_data['language'][$language['language_id']]) ? $phpner_blog_setting_data['language'][$language['language_id']]['seo_h1'] : ''; ?>" class="form-control" />
                    </div>
                    <?php if (isset($error_seo_h1[$language['language_id']])) { ?>
                      <div class="alert alert-danger text-danger"><?php echo $error_seo_h1[$language['language_id']]; ?></div>
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_seo_meta_description; ?></label>
                <div class="col-sm-10">
                  <?php foreach ($languages as $language) { ?>
                    <div class="input-group" style="margin-bottom: 5px;">
                      <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                      <textarea name="phpner_blog_setting_data[language][<?php echo $language['language_id']; ?>][seo_meta_description]" class="form-control"><?php echo isset($phpner_blog_setting_data['language'][$language['language_id']]) ? $phpner_blog_setting_data['language'][$language['language_id']]['seo_meta_description'] : ''; ?></textarea>
                    </div>
                    <?php if (isset($error_seo_meta_description[$language['language_id']])) { ?>
                      <div class="alert alert-danger text-danger"><?php echo $error_seo_meta_description[$language['language_id']]; ?></div>
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_seo_meta_keywords; ?></label>
                <div class="col-sm-10">
                  <?php foreach ($languages as $language) { ?>
                    <div class="input-group" style="margin-bottom: 5px;">
                      <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                      <textarea name="phpner_blog_setting_data[language][<?php echo $language['language_id']; ?>][seo_meta_keywords]" class="form-control"><?php echo isset($phpner_blog_setting_data['language'][$language['language_id']]) ? $phpner_blog_setting_data['language'][$language['language_id']]['seo_meta_keywords'] : ''; ?></textarea>
                    </div>
                    <?php if (isset($error_seo_meta_keywords[$language['language_id']])) { ?>
                      <div class="alert alert-danger text-danger"><?php echo $error_seo_meta_keywords[$language['language_id']]; ?></div>
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_seo_description; ?></label>
                <div class="col-sm-10">
                  <?php foreach ($languages as $language) { ?>
                    <div class="input-group" style="margin-bottom: 5px;">
                      <span class="input-group-addon"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                      <textarea name="phpner_blog_setting_data[language][<?php echo $language['language_id']; ?>][seo_description]" id="seo_description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($phpner_blog_setting_data['language'][$language['language_id']]) ? $phpner_blog_setting_data['language'][$language['language_id']]['seo_description'] : ''; ?></textarea>
                    </div>
                    <div class="btn-group" style="margin-bottom: 5px;">
                      <button type="button" class="btn btn-default btn-xs" onclick="texteditor_action({id: '#seo_description<?php echo $language['language_id']; ?>'});"><?php echo $text_open_texteditor; ?></button>
                      <button type="button" class="btn btn-default btn-xs" onclick="texteditor_action({id: '#seo_description<?php echo $language['language_id']; ?>', start: false, destroy: true});" style="display: none;"><?php echo $text_save_texteditor; ?></button>
                    </div>
                    <?php if (isset($error_seo_description[$language['language_id']])) { ?>
                      <div class="alert alert-danger text-danger"><?php echo $error_seo_description[$language['language_id']]; ?></div>
                    <?php } ?>
                  <?php } ?>
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
<?php echo $footer; ?>