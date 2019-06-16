<?php if ($modifications) { ?>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
</div>
<?php } ?>
<div class="table-responsive" style="margin-top: 5px;">
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <td style="width: 1px;" class="text-center"><input type="checkbox" data-toggle="system-selected-values" data-mod-type="system" onclick="$('#modification-system-list input[name*=\'selected\']').attr('checked', this.checked);" /></td>
        <td class="text-left"><?php echo $column_name; ?></td>
	      <td class="text-left"><?php echo $column_filename; ?></td>
        <td class="text-left"><?php echo $column_author; ?></td>
        <td class="text-left"><?php echo $column_version; ?></td>
	      <td class="text-left"><?php echo $column_status; ?></td>
	      <td class="text-left"><span data-toggle="tooltip" title="<?php echo $column_doubling_help; ?>"><?php echo $column_doubling; ?></span></td>
	      <td class="text-left"><?php echo $column_date_modified; ?></td>
        <td class="text-center" width="16%"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($modifications) { ?>
        <?php foreach ($modifications as $modification) { ?>
        <tr class="<?php if (!$modification['status']) { ?>disabled-extension<?php } ?> <?php if ($modification['doubling_status']) { ?>doubling-extension<?php } ?>">
          <td class="text-center"><input type="checkbox" name="selected[]" value="<?php echo $modification['filename']; ?>" data-toggle="system-selected-values" data-mod-type="system" /></td>
          <td class="text-left"><?php echo $modification['name']; ?></td>
	        <td class="text-left"><?php echo $modification['filename']; ?></td>
          <td class="text-left">
	          <?php if ($modification['link']) { ?>
	          <a href="<?php echo $modification['link']; ?>" target="_blank"><?php echo $modification['author']; ?></a>
						<?php } else { ?>
	          <?php echo $modification['author']; ?>
	          <?php } ?>
          </td>
          <td class="text-left"><?php echo $modification['version']; ?></td>
          <td class="text-left"><?php echo $modification['status_text']; ?></td>
          <td class="text-left"><?php echo $modification['doubling']; ?></td>
	        <td class="text-left"><?php echo $modification['date_modified']; ?></td>
	        <td class="text-center">
	          <?php if ($modification['status']) { ?>
	          <a onclick="confirm('<?php echo $text_confirm; ?>') ? change_status('<?php echo $modification['filename']; ?>', 'disable', 'system') : false;" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="<?php echo $button_disable; ?>"><i class="fa fa-minus-circle"></i></a>
	          <?php } else { ?>
	          <a onclick="confirm('<?php echo $text_confirm; ?>') ? change_status('<?php echo $modification['filename']; ?>', 'enable', 'system') : false;" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $button_enable; ?>"><i class="fa fa-plus-circle"></i></a>
	          <?php } ?>
	          <a onclick="confirm('<?php echo $text_confirm; ?>') ? delete_selected('<?php echo $modification['filename']; ?>', 'system') : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
		        <a onclick="confirm('<?php echo $text_confirm; ?>') ? archive_selected('<?php echo $modification['filename']; ?>', 'system') : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_archive; ?>"><i class="fa fa-file-archive-o"></i></a>
		        <a onclick="open_modificator('<?php echo $modification['filename']; ?>', 'system');" data-toggle="tooltip" title="" class="btn btn-info" data-original-title="<?php echo $button_edite; ?>"><i class="fa fa-pencil"></i></a>
          </td>
        </tr>
        <?php } ?>
      <?php } else { ?>
        <tr>
          <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
</div>
<?php if ($modifications) { ?>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php } ?>
<style type="text/css">
.disabled-extension {
	opacity: .5;
}
.disabled-extension:hover {
	opacity: 1;
}
.doubling-extension td {
	background: rgba(255, 0, 2, 0.11);
}
</style>