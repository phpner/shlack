<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>


  <div class="col-md-12">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_save_header; ?></h3>
      </div>
      <div class="panel-body">
        <a href="index.php?route=extension/module/backup_sql&token=<?php echo $token;?>&save_sql=1"  class="btn btn-success save_sql"> save </a>
        <div class="file_in"></div>
      </div>
        <table class="table">

        <?php 

        if(isset($files_sql)):
          foreach($files_sql as $data):

          $time = explode("-",$data['file']);
        ?>
        <tr>
          <td>
             <a href="<?php echo $data['href']?>" >База: <?php echo $time[0]?> год - <?php echo $time[1]?> месяца - <?php echo $time[2]?> час - <?php echo $time[3]?> минут - <?php echo $time[4];?> сек.
               - <b>Размер файда: <?php echo $data['size']?></b></a>
          </td>
          <td>
            <span class="btn btn-success">
              <a href="<?php echo $data['href']?>" style="color: #fff;">
                Скачать
              </a>
            </span>
          </td>
          <td>
            <span class="btn  btn-danger">
              <a class="dell-sql" data-sql="<?php echo $data['file']?>" href="index.php?route=extension/module/backup_sql/del_sql_zip&token=<?php echo $token;?>&del_sql=<?php echo $data['file']?>" style="color: #fff;">
                Удалить
              </a>
            </span></td>
        </tr>

        <?php
           endforeach;
           endif;
         ?>

       </table>   
    </div>
  </div>
    <div class="col-md-12">
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-category" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <br>
            <br>
            <div class="col-sm-3">
              <select name="category_status" id="input-status" class="form-control">
                <?php if ($category_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="clearfix"></div>
</div>
<script>
  $(function (){

      $(".dell-sql").on('click',function (e) {
          var data_sql = $(this).attr('data-sql');
          var ans = confirm("Удалить файл "+data_sql + " ?" );

          if (!ans) e.preventDefault();
      })


  })
</script>
<?php echo $footer; ?>