<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" formaction="<?php echo $action; ?>" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#setting-tab" data-toggle="tab"><?php echo $tab_setting; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="setting-tab">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="phpner_advanced_attributes_settings_data[status]" id="input-status" class="form-control">
                    <?php if ($phpner_advanced_attributes_settings_data['status']) { ?>
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
		            <label class="col-sm-2 control-label" for="input-attribute"><span data-toggle="tooltip" title="<?php echo $help_attribute; ?>"><?php echo $text_attributes; ?></span></label>
		            <div class="col-sm-10">
		              <input type="text" name="attribute_name" value="" placeholder="<?php echo $entry_attribute; ?>" id="input-attribute" class="form-control" />
		              <div id="featured-attribute" class="well well-sm" style="height: 150px; overflow: auto;">
			              <?php if ($attributes) { ?>
		                <?php foreach ($attributes as $attribute) { ?>
		                <div id="featured-attribute<?php echo $attribute['attribute_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $attribute['name']; ?>
		                  <input type="hidden" name="phpner_advanced_attributes_settings_data[allowed_attributes][]" value="<?php echo $attribute['attribute_id']; ?>" />
		                </div>
		                <?php } ?>
			              <?php } ?>
		              </div>
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
$('input[name=\'attribute_name\']').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=extension/module/phpner_advanced_attributes_settings/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.attribute_id
					}
				}));
			}
		});
	},
	select: function(item) {
		$('input[name=\'attribute_name\']').val('');

		$('#featured-attribute' + item['value']).remove();

		$('#featured-attribute').append('<div id="featured-attribute' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="phpner_advanced_attributes_settings_data[allowed_attributes][]" value="' + item['value'] + '" /></div>');
	}
});

$('#featured-attribute').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
</script>
<?php echo $footer; ?>
