<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onclick="$('#form').submit();" type="submit" form="form-carousel" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-success"><i class="fa fa-reply"></i></a>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3> 
        <div class="pull-right"><h3><strong><?php echo $template_version; ?></strong></h3></div>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <div class="row">
            <div class="col-sm-12">
              <div class="tab-content">
              <!-- LICENSE SETTINGS -->       
              <table class="form">
                <tr>
                  <td class="no-style"><?php echo $text_license; ?></td>
                  <td class="no-style">
                    <input type="text" name="phpner_store_verification" value="<?php echo $phpner_store_verification; ?>" placeholder="xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx" class="form-control" />
                    <br/>
                    <?php if ($error_verification) { ?>
                    <div class="text-danger"><?php echo $error_verification; ?></div>
                    <br/>
                    <?php } ?>
                    <div class="alert alert-info" role="alert"><?php echo $text_verification; ?></div>
                  </td>
                </tr>
              </table>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>