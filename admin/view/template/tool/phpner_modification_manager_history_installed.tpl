<?php if ($modifications) { ?>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
</div>
<?php } ?>
<div class="table-responsive" style="margin-top: 5px;">
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <td style="width: 1px;" class="text-center"><input type="checkbox" data-toggle="installed-selected-values" data-mod-type="installed" onclick="$('#modification-installed-list input[name*=\'selected\']').attr('checked', this.checked);" /></td>
        <td class="text-left"><?php echo $column_name; ?></td>
	      <td class="text-left"><?php echo $column_author; ?></td>
        <td class="text-left"><?php echo $column_version; ?></td>
        <td class="text-left"><?php echo $column_status; ?></td>
	      <td class="text-left"><?php echo $column_date_added; ?></td>
	      <td class="text-center" width="16%"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($modifications) { ?>
        <?php foreach ($modifications as $modification) { ?>
        <tr>
          <td class="text-center"><input type="checkbox" name="selected[]" value="<?php echo $modification['modification_id']; ?>" data-toggle="installed-selected-values" data-mod-type="installed" /></td>
          <td class="text-left"><?php echo $modification['name']; ?></td>
          <td class="text-left">
	          <?php if ($modification['link']) { ?>
	          <a href="<?php echo $modification['link']; ?>" target="_blank"><?php echo $modification['author']; ?></a>
						<?php } else { ?>
	          <?php echo $modification['author']; ?>
	          <?php } ?>
          </td>
          <td class="text-left"><?php echo $modification['version']; ?></td>
          <td class="text-left"><?php echo $modification['status_text']; ?></td>
	        <td class="text-left"><?php echo $modification['date_added']; ?></td>
	        <td class="text-center">
	          <?php if ($modification['status']) { ?>
	          <a onclick="confirm('<?php echo $text_confirm; ?>') ? change_status('<?php echo $modification['modification_id']; ?>', 'disable', 'installed') : false;" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="<?php echo $button_disable; ?>"><i class="fa fa-minus-circle"></i></a>
	          <?php } else { ?>
	          <a onclick="confirm('<?php echo $text_confirm; ?>') ? change_status('<?php echo $modification['modification_id']; ?>', 'enable', 'installed') : false;" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $button_enable; ?>"><i class="fa fa-plus-circle"></i></a>
	          <?php } ?>
	          <a onclick="confirm('<?php echo $text_confirm; ?>') ? delete_selected('<?php echo $modification['modification_id']; ?>', 'installed') : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
		        <a onclick="confirm('<?php echo $text_confirm; ?>') ? archive_selected('<?php echo $modification['modification_id']; ?>', 'installed') : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_archive; ?>"><i class="fa fa-file-archive-o"></i></a>
		        <a onclick="open_modificator('<?php echo $modification['modification_id']; ?>', 'installed');" data-toggle="tooltip" title="" class="btn btn-info" data-original-title="<?php echo $button_edite; ?>"><i class="fa fa-pencil"></i></a>
          </td>
        </tr>
        <?php } ?>
      <?php } else { ?>
        <tr>
          <td class="text-center" colspan="7"><?php echo $text_no_results; ?></td>
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
