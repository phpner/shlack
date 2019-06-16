<?php if ($modifications) { ?>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
</div>
<?php } ?>
<div class="table-responsive" style="margin-top: 5px;">
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <td style="width: 1px;" class="text-center"><input type="checkbox" data-toggle="archive-selected-values" data-mod-type="archive" onclick="$('#modification-archive-list input[name*=\'selected\']').attr('checked', this.checked);" /></td>
        <td class="text-left"><?php echo $column_name; ?></td>
	      <td class="text-left"><?php echo $column_filename; ?></td>
        <td class="text-left"><?php echo $column_author; ?></td>
        <td class="text-left"><?php echo $column_version; ?></td>
	      <td class="text-left"><?php echo $column_date_modified; ?></td>
        <td class="text-center" width="13%"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($modifications) { ?>
        <?php foreach ($modifications as $modification) { ?>
        <tr>
          <td class="text-center"><input type="checkbox" name="selected[]" value="<?php echo $modification['filename']; ?>" data-toggle="archive-selected-values" data-mod-type="archive" /></td>
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
	        <td class="text-left"><?php echo $modification['date_modified']; ?></td>
	        <td class="text-center">
		        <a onclick="confirm('<?php echo $text_confirm; ?>') ? delete_selected('<?php echo $modification['filename']; ?>', 'archive') : false;" data-toggle="tooltip" title="" class="btn btn-warning" data-original-title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
	          <div class="btn-group">
		          <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-upload"></i>&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
		          <ul class="dropdown-menu dropdown-menu-right">
		            <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? unarchive_selected('<?php echo $modification['filename']; ?>', 'system') : false;"><i class="fa fa-upload"></i> <?php echo $button_unarchive_selected; ?></a></li>
		            <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? unarchive_selected('<?php echo $modification['filename']; ?>', 'installed') : false;"><i class="fa fa-upload"></i> <?php echo $button_unarchive_installed; ?></a></li>
		          </ul>
		        </div>
		        <a onclick="open_modificator('<?php echo $modification['filename']; ?>', 'archive');" data-toggle="tooltip" title="" class="btn btn-info" data-original-title="<?php echo $button_edite; ?>"><i class="fa fa-pencil"></i></a>
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