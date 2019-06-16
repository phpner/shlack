<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
    <h4 class="modal-title" id="myModalLabel"><?php echo $button_add; ?></h4>
  </div>
  <div class="modal-body">
	  <label><?php echo $text_install_mod_type; ?></label>
	  <select name="mod_type" class="form-control">
      <option value="system"><?php echo $text_install_mod_to_system; ?></option>
		  <option value="archive"><?php echo $text_install_mod_to_archive; ?></option>
		  <option value="installed"><?php echo $text_install_mod_by_default; ?></option>
    </select>
	  <br/>
	  <div id="modification-input">
	  <label><?php echo $text_modification_name; ?></label>
	  <input type="text" name="modification" value="" class="form-control" />
	  <br/>
	  </div>
		<textarea id="source-modification"></textarea>
		<br/>
	</div>
  <div class="modal-footer">
    <button type="button" class="btn btn-info" onclick="add_selected();"><?php echo $button_save; ?></button>
    <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close"><?php echo $button_cancel; ?></button>
  </div>
</div>
<script type="text/javascript">
var codemirror = CodeMirror.fromTextArea(document.querySelector('#source-modification'), {
  mode : 'xml',
  height: '100%',
  lineNumbers: true,
  autofocus: true,
  theme: 'base16-dark',
  lineWrapping: true
});

$('#modal-container select[name=\'mod_type\']').change(function() {
  var val = $(this).val();

  if (val == 'system') {
    $('#modification-input').show();
  } else {
    $('#modification-input').hide();
  }
});

$('#modal-container select[name=\'mod_type\']').trigger('change');

function add_selected() {
  var mod_type = $('#modal-container select[name=\'mod_type\']').val();

	$.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/add_modification_action&token=<?php echo $token; ?>',
	  data: 'code='+encodeURIComponent(codemirror.getValue())+'&modification='+encodeURIComponent($('#modal-container input[name=\'modification\']').val())+'&mod_type='+$('#modal-container select[name=\'mod_type\']').val(),
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger, #modal-container-list .modal-content .modal-body .alert, #modal-container-list .modal-content .modal-body .text-danger').remove();

      if (json['error']) {
	      $('#modal-container-list .modal-content .modal-body').prepend('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }

      if (json['success']) {
        $('a[href=#modification-'+mod_type+'-tab]').click();

        $('#modification-'+mod_type+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+mod_type+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+mod_type+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+mod_type+'-tab input[name=\'filter_name\']').val()));

        $('#modification-'+mod_type+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

	      $('#modal-container').modal('hide');
      }
      //$('[role=\'tooltip\']').tooltip('destroy');
    },
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
  });
}
</script>