<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
    <h4 class="modal-title" id="myModalLabel"><?php echo $button_edite; ?></h4>
  </div>
  <div class="modal-body">
		<textarea id="source-modification"><?php echo $xml; ?></textarea>
		<br/>
		<div id="result-modification"></div>
	</div>
  <div class="modal-footer">
    <button type="button" class="btn btn-info" onclick="edite_selected('<?php echo $modification; ?>', 'close', '<?php echo $mod_type; ?>');"><?php echo $button_save; ?></button>
	  <button type="button" class="btn btn-info" onclick="edite_selected('<?php echo $modification; ?>', 'stay', '<?php echo $mod_type; ?>');"><?php echo $button_save_and_stay; ?></button>
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
$(window).keypress(function(event) {
  if (!(event.which == 115 && event.ctrlKey) && !(event.which == 19)) return true;
  edite_selected('<?php echo $modification; ?>', 'ctrl_s', '<?php echo $mod_type; ?>');
  event.preventDefault();
  return false;
});
</script>