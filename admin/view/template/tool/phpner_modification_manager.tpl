<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	      <div class="btn-group">
          <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-trash"></i>&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
          <ul class="dropdown-menu dropdown-menu-right">
            <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? service_modification('refresh_mod') : false;"><i class="fa fa-refresh"></i> <?php echo $button_refresh; ?></a></li>
            <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? service_modification('clear_mod') : false;"><i class="fa fa-trash"></i> <?php echo $button_clear; ?></a></li>
	          <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? service_modification('refresh_system_cache') : false;"><i class="fa fa-trash"></i> <?php echo $button_refresh_system_cache; ?></a></li>
	          <li><a onclick="confirm('<?php echo $text_confirm; ?>') ? service_modification('refresh_image_cache') : false;"><i class="fa fa-trash"></i> <?php echo $button_refresh_image_cache; ?></a></li>
          </ul>
        </div>
        <button type="button" onclick="add_modification();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body" id="modification-container">
	      <ul class="nav nav-tabs">
          <li class="active"><a href="#modification-system-tab" data-toggle="tab"><?php echo $tab_system; ?></a></li>
          <li><a href="#modification-installed-tab" data-toggle="tab"><?php echo $tab_modification; ?></a></li>
		      <li><a href="#modification-archive-tab" data-toggle="tab"><?php echo $tab_archive; ?></a></li>
		      <li><a href="#system-information" data-toggle="tab"><?php echo $tab_system_information; ?></a></li>
        </ul>
	      <div class="tab-content">
		      <div class="tab-pane active" id="modification-system-tab">
			      <div class="well" style="margin-bottom: 5px;">
				      <div class="row">
					      <div class="col-sm-6">
						      <label><?php echo $text_mod_type; ?></label>
						      <div class="input-group">
				            <select name="filter_author" class="form-control">
					            <option value="-all-"><?php echo $text_all_modificators; ?></option>
					            <?php if ($authors_system) { ?>
					            <?php foreach ($authors_system as $author) { ?>
					            <option value="<?php echo $author; ?>"><?php echo $author; ?></option>
					            <?php } ?>
					            <?php } ?>
				            </select>
				            <span class="input-group-btn">
				              <button class="btn btn-default" type="button" id="clear-system-filter-form-author"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
				            </span>
				          </div>
					      </div>
					      <div class="col-sm-6">
						      <label><?php echo $text_filter_name; ?></label>
						      <div class="input-group">
						        <input value="" name="filter_name" class="form-control" />
							      <span class="input-group-btn">
				              <button class="btn btn-default" type="button" id="clear-system-filter-form-name"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
				            </span>
						      </div>
					      </div>
							</div>
		        </div>
						<div id="modification-system-list"></div>
			    </div>
		      <div class="tab-pane" id="modification-installed-tab">
			      <div class="well" style="margin-bottom: 5px;">
				      <div class="row">
					      <div class="col-sm-6">
						      <label><?php echo $text_mod_type; ?></label>
						      <div class="input-group">
				            <select name="filter_author" class="form-control">
					            <option value=""><?php echo $text_all_modificators; ?></option>
					            <?php if ($modification_authors) { ?>
					            <?php foreach ($modification_authors as $author) { ?>
					            <option value="<?php echo $author; ?>"><?php echo $author; ?></option>
					            <?php } ?>
					            <?php } ?>
				            </select>
				            <span class="input-group-btn">
				              <button class="btn btn-default" type="button" id="clear-installed-filter-form-author"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
				            </span>
				          </div>
					      </div>
					      <div class="col-sm-6">
						      <label><?php echo $text_filter_name; ?></label>
						      <div class="input-group">
						        <input value="" name="filter_name" class="form-control" />
							      <span class="input-group-btn">
				              <button class="btn btn-default" type="button" id="clear-installed-filter-form-name"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
				            </span>
						      </div>
					      </div>
				      </div>
		        </div>
						<div id="modification-installed-list"></div>
		      </div>
		      <div class="tab-pane" id="modification-archive-tab">
			      <div class="well" style="margin-bottom: 5px;">
				      <div class="row">
					      <div class="col-sm-6">
						      <label><?php echo $text_mod_type; ?></label>
						      <div class="input-group">
				            <select name="filter_author" class="form-control">
					            <option value="-all-"><?php echo $text_all_modificators; ?></option>
					            <?php if ($authors_archive) { ?>
					            <?php foreach ($authors_archive as $author) { ?>
					            <option value="<?php echo $author; ?>"><?php echo $author; ?></option>
					            <?php } ?>
					            <?php } ?>
				            </select>
				            <span class="input-group-btn">
				              <button class="btn btn-default" type="button" id="clear-archive-filter-form-author"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
				            </span>
				          </div>
					      </div>
					      <div class="col-sm-6">
						      <label><?php echo $text_filter_name; ?></label>
						      <div class="input-group">
						        <input value="" name="filter_name" class="form-control" />
							      <span class="input-group-btn">
				              <button class="btn btn-default" type="button" id="clear-archive-filter-form-name"><i class="fa fa-eraser"></i> <?php echo $button_clear_filter; ?></button>
				            </span>
						      </div>
					      </div>
							</div>
		        </div>
						<div id="modification-archive-list"></div>
			    </div>
		      <div class="tab-pane" id="system-information">
						<div class="form-group" style="display: inline-block;width: 100%;">
	            <label class="col-sm-2 control-label"><?php echo $text_php_version; ?></label>
	            <div class="col-sm-10"><?php echo $php_version; ?></div>
	          </div>
			      <div class="form-group" style="display: inline-block;width: 100%;">
	            <label class="col-sm-2 control-label"><?php echo $text_curl; ?></label>
	            <div class="col-sm-10"><?php echo $curl_status; ?></div>
	          </div>
			      <div class="form-group" style="display: inline-block;width: 100%;">
	            <label class="col-sm-2 control-label"><?php echo $text_ioncube; ?></label>
	            <div class="col-sm-10"><?php echo $ioncube_status; ?></div>
	          </div>
			      <div class="form-group" style="display: inline-block;width: 100%;">
	            <label class="col-sm-2 control-label"><?php echo $text_phpinfo; ?></label>
				      <div class="col-sm-10"><button type="button" onclick="get_php_info();" class="btn btn-sm btn-primary"><?php echo $button_viewphpinfo; ?></button></div>
	          </div>
		      </div>
	      </div>
      </div>
    </div>
  </div>
 </div>
<style>
#modal-container .modal-dialog {
  width: 90%;
}
#modal-container .modal-content {
  overflow-y: auto;
}
.CodeMirror {
  height: 100%;
	min-height: 200px;
}
.CodeMirror-scroll {
	overflow: auto;
	min-height: 200px;
}
.dropdown-menu > li > a:hover,
.dropdown-menu > li > a:focus {
  cursor: pointer;
}
.table-responsive {
	overflow: visible;
}
</style>
<script type="text/javascript">
$(function() {
  $('a[href=#modification-system-tab]').on('click', function() {
    $('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-system-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-system-tab input[name=\'filter_name\']').val()));
    $('#modification-system-tab .alert, #modification-system-tab .text-danger').remove();
  });

  $('a[href=#modification-installed-tab]').on('click', function() {
    $('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-installed-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-installed-tab input[name=\'filter_name\']').val()));
    $('#modification-installed-tab .alert, #modification-installed-tab .text-danger').remove();
  });

  $('a[href=#modification-archive-tab]').on('click', function() {
    $('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-archive-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-archive-tab input[name=\'filter_name\']').val()));
    $('#modification-archive-tab .alert, #modification-archive-tab .text-danger').remove();
    $('#modification-archive-tab .well').before('<div class="alert special-alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $tab_archive_faq; ?></div>');
  });
});

$('#modification-system-list').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
  $('#modification-system-list').load(this.href);
});

$('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-system-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-system-tab input[name=\'filter_name\']').val()));

$('#modification-system-tab select[name=\'filter_author\']').on('change', function () {
	$('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($(this).val())+'&filter_name='+encodeURIComponent($('#modification-system-tab input[name=\'filter_name\']').val()));
});

$('#modification-system-tab input[name=\'filter_name\']').on('change', function () {
	$('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-system-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($(this).val()));
});

$('#modification-system-tab #clear-system-filter-form-author').on('click', function() {
  $('#modification-system-tab select[name=\'filter_author\']').val('-all-');
  $('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-system-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-system-tab input[name=\'filter_name\']').val()));
});

$('#modification-system-tab #clear-system-filter-form-name').on('click', function() {
  $('#modification-system-tab input[name=\'filter_name\']').val('');
  $('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-system-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-system-tab input[name=\'filter_name\']').val()));
});

function delete_selected(modification, mod_type) {
  $.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/delete_selected&token=<?php echo $token; ?>&modification='+modification+'&mod_type='+mod_type,
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger').remove();

      if (json['error']) {
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
	      $('#modification-'+mod_type+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+mod_type+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+mod_type+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+mod_type+'-tab input[name=\'filter_name\']').val()));
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

function delete_all_selected(mod_type) {
  $.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/delete_all_selected&token=<?php echo $token; ?>&mod_type='+mod_type,
    data: $('#modification-'+mod_type+'-list input[type=\'checkbox\']:checked'),
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger').remove();

      if (json['error']) {
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
	      $('#modification-'+mod_type+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+mod_type+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+mod_type+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+mod_type+'-tab input[name=\'filter_name\']').val()));
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

function archive_selected(modification, mod_type) {
	$.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/archive_selected&token=<?php echo $token; ?>&modification='+modification+'&mod_type='+mod_type,
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger').remove();

      if (json['error']) {
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
	      $('#modification-'+mod_type+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+mod_type+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+mod_type+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+mod_type+'-tab input[name=\'filter_name\']').val()));
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

function unarchive_selected(modification, mod_type) {
	$.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/unarchive_selected&token=<?php echo $token; ?>&modification='+modification+'&mod_type='+mod_type,
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger').remove();

      if (json['error']) {
	      $('#modification-archive-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      $('#modification-archive-tab .well').before('<div class="alert special-alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $tab_archive_faq; ?></div>');
      }
      if (json['success']) {
        $('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-archive-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-archive-tab input[name=\'filter_name\']').val()));
	      $('#modification-archive-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      $('#modification-archive-tab .well').before('<div class="alert special-alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $tab_archive_faq; ?></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

function service_modification(service_type) {
  $.ajax({
    type: 'get',
    url: 'index.php?route=tool/phpner_modification_manager/'+service_type+'&token=<?php echo $token; ?>',
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger').remove();

      if (json['error']) {
	      $('#modification-container').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
	      $('#modification-system-list').load('index.php?route=tool/phpner_modification_manager/history_system&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-system-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-system-tab input[name=\'filter_name\']').val()));
	      $('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-installed-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-installed-tab input[name=\'filter_name\']').val()));
	      $('#modification-container').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

function change_status(modification, action_type, mod_type) {
	$.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/change_status&token=<?php echo $token; ?>&modification='+modification+'&action_type='+action_type+'&mod_type='+mod_type,
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger').remove();

      if (json['error']) {
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
	      $('#modification-'+mod_type+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+mod_type+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+mod_type+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+mod_type+'-tab input[name=\'filter_name\']').val()));
	      $('#modification-'+mod_type+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

function get_php_info() {
	html  = '';
  html += '<div id="modal-php-info-container" class="modal fade">';
  html += '  <div class="modal-dialog modal-lg">';
  html += '    <div id="modal-php-info-container-list">';
  html += '    <div class="modal-content">';
	html += '      <div class="modal-header">';
	html += '        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>';
	html += '        <h4 class="modal-title" id="myModalLabel"><?php echo $text_phpinfo; ?></h4>';
	html += '      </div>';
	html += '      <div class="modal-body" id="source-phpinfo"></div>';
	html += '      <div class="modal-footer">';
	html += '        <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close"><?php echo $button_cancel; ?></button>';
	html += '      </div>';
	html += '    </div>';
	html += '    </div>';
  html += '  </div>';
  html += '</div>';

  $('body').append(html);

  $('#modal-php-info-container-list #source-phpinfo').load('index.php?route=tool/phpner_modification_manager/get_php_info&token=<?php echo $token; ?>');

  $('#modal-php-info-container').modal('show');
}

function open_modificator(modification, mod_type) {
  html  = '';
  html += '<div id="modal-container" class="modal fade">';
  html += '  <div class="modal-dialog modal-lg">';
  html += '    <div id="modal-container-list"></div>';
  html += '  </div>';
  html += '</div>';

  $('body').append(html);

  $('#modal-container-list').load('index.php?route=tool/phpner_modification_manager/modification_info&token=<?php echo $token; ?>&modification='+modification+'&mod_type='+mod_type);

  $('#modal-container').modal('show');

  setTimeout(function() {
    $(this).click();
    codemirror.refresh();
  }, 500);
}

function add_modification() {
	html  = '';
  html += '<div id="modal-container" class="modal fade">';
  html += '  <div class="modal-dialog modal-lg">';
  html += '    <div id="modal-container-list"></div>';
  html += '  </div>';
  html += '</div>';

  $('body').append(html);

  $('#modal-container-list').load('index.php?route=tool/phpner_modification_manager/add_modification_index&token=<?php echo $token; ?>');

  $('#modal-container').modal('show');

  setTimeout(function() {
    $(this).click();
    codemirror.refresh();
  }, 500);
}

function edite_selected(modification, close_type, mod_type) {
  $.ajax({
    type: 'post',
    url: 'index.php?route=tool/phpner_modification_manager/edite_selected&token=<?php echo $token; ?>',
	  data: 'code='+encodeURIComponent(codemirror.getValue())+'&modification='+encodeURIComponent(modification)+'&mod_type='+mod_type,
    dataType: 'json',
    success: function(json) {
      $('#modification-container .alert, #modification-container .text-danger, #modal-container-list .modal-content .modal-body .alert, #modal-container-list .modal-content .modal-body .text-danger').remove();

      if (json['error']) {
	      $('#modal-container-list .modal-content .modal-body').prepend('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

	      if (mod_type == 'archive') {
          $('#modification-'+mod_type+'-tab .well').before('<div class="alert special-alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $tab_archive_faq; ?></div>');
        }
      }

      if (json['success']) {
        $('#modification-'+mod_type+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+mod_type+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+mod_type+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+mod_type+'-tab input[name=\'filter_name\']').val()));

        if (mod_type == 'archive') {
          $('#modification-'+mod_type+'-tab .well').before('<div class="alert special-alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $tab_archive_faq; ?></div>');
        }

        if (close_type == 'close') {
		      $('#modification-'+mod_type+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

		      $('#modal-container').modal('hide');
	      }

	      if (close_type == 'stay') {
	        $('#modal-container-list .modal-content .modal-body').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }

	      if (close_type == 'ctrl_s') {
          html  = '';
				  html += '<div id="modal-container-ctrl-s" class="modal fade bs-example-modal-sm">';
				  html += '  <div class="modal-dialog modal-sm">';
				  html += '    <div class="modal-content">';
				  html += '      <div class="modal-body" style="text-align: center;">'+json['success']+'</div>';
				  html += '    </div>';
				  html += '  </div>';
				  html += '</div>';

				  $('body').append(html);

				  $('#modal-container-ctrl-s').modal('show');

				  setTimeout(function() {
				    $('#modal-container-ctrl-s').modal('hide');
				  }, 2000);
	      }
      }
      $('[role=\'tooltip\']').tooltip('destroy');
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
}

$('#modification-installed-list').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
  $('#modification-installed-list').load(this.href);
});

$('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-installed-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-installed-tab input[name=\'filter_name\']').val()));

$('#modification-installed-tab select[name=\'filter_author\']').on('change', function () {
	$('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($(this).val())+'&filter_name='+encodeURIComponent($('#modification-installed-tab input[name=\'filter_name\']').val()));
});

$('#modification-installed-tab input[name=\'filter_name\']').on('change', function () {
	$('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-installed-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($(this).val()));
});

$('#modification-installed-tab #clear-installed-filter-form-author').on('click', function() {
  $('#modification-installed-tab select[name=\'filter_author\']').val('');
  $('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-installed-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-installed-tab input[name=\'filter_name\']').val()));
});

$('#modification-installed-tab #clear-installed-filter-form-name').on('click', function() {
  $('#modification-installed-tab input[name=\'filter_name\']').val('');
  $('#modification-installed-list').load('index.php?route=tool/phpner_modification_manager/history_installed&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-installed-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-installed-tab input[name=\'filter_name\']').val()));
});


$('#modification-archive-list').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
  $('#modification-archive-list').load(this.href);
});

$('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-archive-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-archive-tab input[name=\'filter_name\']').val()));

$('#modification-archive-tab select[name=\'filter_author\']').on('change', function () {
	$('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($(this).val())+'&filter_name='+encodeURIComponent($('#modification-archive-tab input[name=\'filter_name\']').val()));
});

$('#modification-archive-tab input[name=\'filter_name\']').on('change', function () {
	$('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-archive-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($(this).val()));
});

$('#modification-archive-tab #clear-archive-filter-form-author').on('click', function() {
  $('#modification-archive-tab select[name=\'filter_author\']').val('-all-');
  $('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-archive-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-archive-tab input[name=\'filter_name\']').val()));
});

$('#modification-archive-tab #clear-archive-filter-form-name').on('click', function() {
  $('#modification-archive-tab input[name=\'filter_name\']').val('');
  $('#modification-archive-list').load('index.php?route=tool/phpner_modification_manager/history_archive&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-archive-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-archive-tab input[name=\'filter_name\']').val()));
});


$(document).on('click', 'input[data-toggle=\'system-selected-values\']', function(e) {
	var $element = $(this);
	var $popover = $element.data('bs.popover');

	// e.preventDefault();

	$('input[data-toggle="system-selected-values"]').popover('destroy');

	if ($popover) {
		return;
	}

	$element.popover({
		html: true,
		placement: 'right',
		trigger: 'focus',
		content: function() {
			return '<button type="button" id="delete-selected" class="btn btn-warning"><i class="fa fa-trash-o"></i> <?php echo $button_delete_selected; ?></button>';
		}
	});

	$element.popover('show');

	$('#delete-selected').on('click', function() {

	  if (!confirm('<?php echo $text_confirm; ?>')) {
	    return false;
	  }

	  $.ajax({
	    type: 'post',
	    url: 'index.php?route=tool/phpner_modification_manager/delete_all_selected&token=<?php echo $token; ?>&mod_type='+$element.data('mod-type'),
	    data: $('#modification-'+$element.data('mod-type')+'-list input[type=\'checkbox\']:checked'),
	    dataType: 'json',
	    success: function(json) {
	      $('#modification-container .alert, #modification-container .text-danger').remove();

	      if (json['error']) {
		      $('#modification-'+$element.data('mod-type')+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }
	      if (json['success']) {
		      $('#modification-'+$element.data('mod-type')+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+$element.data('mod-type')+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+$element.data('mod-type')+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+$element.data('mod-type')+'-tab input[name=\'filter_name\']').val()));
		      $('#modification-'+$element.data('mod-type')+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }
	      $('[role=\'tooltip\']').tooltip('destroy');
	    },
	    error: function(xhr, ajaxOptions, thrownError) {
	      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    }
	  });

		$element.popover('destroy');
	});
});

$(document).on('click', 'input[data-toggle=\'installed-selected-values\']', function(e) {
	var $element = $(this);
	var $popover = $element.data('bs.popover');

	// e.preventDefault();

	$('input[data-toggle="installed-selected-values"]').popover('destroy');

	if ($popover) {
		return;
	}

	$element.popover({
		html: true,
		placement: 'right',
		trigger: 'focus',
		content: function() {
			return '<button type="button" id="delete-selected" class="btn btn-warning"><i class="fa fa-trash-o"></i> <?php echo $button_delete_selected; ?></button>';
		}
	});

	$element.popover('show');

	$('#delete-selected').on('click', function() {

	  if (!confirm('<?php echo $text_confirm; ?>')) {
	    return false;
	  }

	  $.ajax({
	    type: 'post',
	    url: 'index.php?route=tool/phpner_modification_manager/delete_all_selected&token=<?php echo $token; ?>&mod_type='+$element.data('mod-type'),
	    data: $('#modification-'+$element.data('mod-type')+'-list input[type=\'checkbox\']:checked'),
	    dataType: 'json',
	    success: function(json) {
	      $('#modification-container .alert, #modification-container .text-danger').remove();

	      if (json['error']) {
		      $('#modification-'+$element.data('mod-type')+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }
	      if (json['success']) {
		      $('#modification-'+$element.data('mod-type')+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+$element.data('mod-type')+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+$element.data('mod-type')+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+$element.data('mod-type')+'-tab input[name=\'filter_name\']').val()));
		      $('#modification-'+$element.data('mod-type')+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }
	      $('[role=\'tooltip\']').tooltip('destroy');
	    },
	    error: function(xhr, ajaxOptions, thrownError) {
	      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    }
	  });

		$element.popover('destroy');
	});
});

$(document).on('click', 'input[data-toggle=\'archive-selected-values\']', function(e) {
	var $element = $(this);
	var $popover = $element.data('bs.popover');

	// e.preventDefault();

	$('input[data-toggle="archive-selected-values"]').popover('destroy');

	if ($popover) {
		return;
	}

	$element.popover({
		html: true,
		placement: 'right',
		trigger: 'focus',
		content: function() {
			return '<button type="button" id="delete-selected" class="btn btn-warning"><i class="fa fa-trash-o"></i> <?php echo $button_delete_selected; ?></button>';
		}
	});

	$element.popover('show');

	$('#delete-selected').on('click', function() {

	  if (!confirm('<?php echo $text_confirm; ?>')) {
	    return false;
	  }

	  $.ajax({
	    type: 'post',
	    url: 'index.php?route=tool/phpner_modification_manager/delete_all_selected&token=<?php echo $token; ?>&mod_type='+$element.data('mod-type'),
	    data: $('#modification-'+$element.data('mod-type')+'-list input[type=\'checkbox\']:checked'),
	    dataType: 'json',
	    success: function(json) {
	      $('#modification-container .alert, #modification-container .text-danger').remove();

	      if (json['error']) {
		      $('#modification-'+$element.data('mod-type')+'-list').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> '+json['error']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }
	      if (json['success']) {
		      $('#modification-'+$element.data('mod-type')+'-list').load('index.php?route=tool/phpner_modification_manager/history_'+$element.data('mod-type')+'&token=<?php echo $token; ?>&filter_author='+encodeURIComponent($('#modification-'+$element.data('mod-type')+'-tab select[name=\'filter_author\']').val())+'&filter_name='+encodeURIComponent($('#modification-'+$element.data('mod-type')+'-tab input[name=\'filter_name\']').val()));
		      $('#modification-'+$element.data('mod-type')+'-list').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+json['success']+' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
	      }
	      $('[role=\'tooltip\']').tooltip('destroy');
	    },
	    error: function(xhr, ajaxOptions, thrownError) {
	      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    }
	  });

		$element.popover('destroy');
	});
});

$('body').on('hidden.bs.modal', function () {
  if ($('.modal.in').length > 0) {
    $('body').addClass('modal-open');
  }
});
</script>
<?php echo $footer; ?>