<?php echo $header; ?>
<?php echo $column_left; ?>
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <button onclick="$('#form').submit();" type="button" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                    <a class="btn btn-warning" onclick="$('#actionstay').val('1');$('#form').submit();" data-toggle="tooltip" title="<?php echo $button_stay_in_module; ?>"><i class="fa fa-save"></i> + <i class="fa fa-refresh" aria-hidden="true"></i></a>
                    <a href="<?php echo $cache; ?>" data-toggle="tooltip" title="<?php echo $button_cache; ?>" class="btn btn-warning"><i class="fa fa-trash-o"></i></a>
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
                        <input type="hidden" id="actionstay" name="actionstay" value="0" />
                        <!-- <input type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[template_version]" value="<?php /*echo $value_002['template_version']; */?>" />-->
                        <div class="row">
                            <div class="col-sm-2">
                                <ul class="nav nav-pills nav-stacked">
                                    <li class="active"><a href="#tab_main" data-toggle="tab"><i class="fa fa-cog"></i> <?php echo $tab_main; ?></a></li>
                                    <li><a href="#tab_header" data-toggle="tab"><i class="fa fa-arrow-up"></i> <?php echo $tab_header; ?></a></li>
                                    <li><a href="#tab_footer" data-toggle="tab"><i class="fa fa-arrow-down"></i> <?php echo $tab_footer; ?></a></li>
                                    <li><a href="#tab_category" data-toggle="tab"><i class="fa fa-folder-open"></i> <?php echo $tab_category; ?></a></li>
                                    <li><a href="#tab_product" data-toggle="tab"><i class="fa fa-tv"></i> <?php echo $tab_product; ?></a></li>
                                    <li><a href="#tab_mobile" data-toggle="tab"><i class="fa fa-phone-square"></i> <?php echo $tab_mobile; ?></a></li>
                                    <li><a href="#tab_contacts" data-toggle="tab"><i class="fa fa-users"></i> <?php echo $tab_contacts; ?></a></li>
                                    <li><a href="#tab_payment_soc" data-toggle="tab"><i class="fa fa-list-alt"></i> <?php echo $tab_payment_soc; ?></a></li>
                                    <li><a href="#tab_cssjs" data-toggle="tab"><i class="fa fa-cog"></i> <?php echo $tab_css_js; ?></a></li>
                                    <li><a href="#tab-limit-and-image" data-toggle="tab"><i class="fa fa-picture-o"></i> <?php echo $tab_limit_and_image; ?></a></li>

                                </ul>
                            </div>
                            <div class="col-sm-10">
                                <div class="tab-content">
                                    <!-- MAIN SETTINGS -->
                                    <div id="tab_main" class="tab-pane active in">
                                        <table class="form">
                                            <tr>
                                                <td><?php echo $text_status; ?></td>
                                                <td>
                                                    <div class="btn-group" data-toggle="buttons">
                                                        <label class="btn btn-info btn-info-green <?php echo $value_001 == '1' ? 'active' : ''; ?>">
                                                            <input type="radio"
                                                                   name="phpner_store_status"
                                                                   value="1"
                                                                   autocomplete="off"
                                                                   style="display: none;"
                                                                <?php echo $value_001 == '1' ? 'checked="checked"' : ''; ?>
                                                            /><?php echo $text_yes; ?>
                                                        </label>
                                                        <label class="btn btn-info btn-info-red <?php echo $value_001 == '0' ? 'active' : ''; ?>">
                                                            <input type="radio"
                                                                   name="phpner_store_status"
                                                                   value="0"
                                                                   autocomplete="off"
                                                                   style="display: none;"
                                                                <?php echo $value_001 == '0' ? 'checked="checked"' : ''; ?>
                                                            /><?php echo $text_no; ?>
                                                        </label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_showmanlogos; ?></td>
                                                <td>
                                                    <div class="btn-group" data-toggle="buttons">
                                                        <label class="btn btn-info <?php echo $value_002['showmanlogos'] == 'on' ? 'active' : ''; ?>">
                                                            <input type="radio"
                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[showmanlogos]"
                                                                   value="on"
                                                                   autocomplete="off"
                                                                   style="display: none;"
                                                                <?php echo $value_002['showmanlogos'] == 'on' ? 'checked="checked"' : ''; ?>
                                                            /><?php echo $text_yes; ?>
                                                        </label>
                                                        <label class="btn btn-info <?php echo $value_002['showmanlogos'] == 'off' ? 'active' : ''; ?>">
                                                            <input type="radio"
                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[showmanlogos]"
                                                                   value="off"
                                                                   autocomplete="off"
                                                                   style="display: none;"
                                                                <?php echo $value_002['showmanlogos'] == 'off' ? 'checked="checked"' : ''; ?>
                                                            /><?php echo $text_no; ?>
                                                        </label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_terms; ?></td>
                                                <td>
                                                    <select name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[terms]" class="form-control">
                                                        <option value="0"><?php echo $text_none; ?></option>
                                                        <?php foreach ($informations as $information) { ?>
                                                            <?php if (isset($value_002['terms']) && $information['information_id'] == $value_002['terms']) { ?>
                                                                <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_maincolor1; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[maincolor1]" value="<?php echo $value_002['maincolor1']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_maincolor2; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[maincolor2]" value="<?php echo $value_002['maincolor2']; ?>" size="6" class="spectrum" /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cat_color_price; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_color_price]" value="<?php echo $value_002['cat_color_price']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cat_color_price_old; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_color_price_old]" value="<?php echo $value_002['cat_color_price_old']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cat_color_price_new; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_color_price_new]" value="<?php echo (isset($value_002['cat_color_price_new']) && $value_002['cat_color_price_new']) ? $value_002['cat_color_price_new'] : 'CE0E5A'; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_enable_minify; ?></td>
                                                <td>
                                                    <div class="btn-group" data-toggle="buttons">
                                                        <label class="btn btn-info <?php echo $value_002['enable_minify'] == 'on' ? 'active' : ''; ?>">
                                                            <input type="radio"
                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[enable_minify]"
                                                                   value="on"
                                                                   autocomplete="off"
                                                                   style="display: none;"
                                                                <?php echo $value_002['enable_minify'] == 'on' ? 'checked="checked"' : ''; ?>
                                                            /><?php echo $text_yes; ?>
                                                        </label>
                                                        <label class="btn btn-info <?php echo $value_002['enable_minify'] == 'off' ? 'active' : ''; ?>">
                                                            <input type="radio"
                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[enable_minify]"
                                                                   value="off"
                                                                   autocomplete="off"
                                                                   style="display: none;"
                                                                <?php echo $value_002['enable_minify'] == 'off' ? 'checked="checked"' : ''; ?>
                                                            /><?php echo $text_no; ?>
                                                        </label>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                    <!-- HEADER SETTINGS -->
                                    <div class="tab-pane fade" id="tab_header">
                                        <div class="tab-content">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a href="#sub_h_settings"><i class="fa fa-cog"></i> <?php echo $text_head_settings; ?></a></li>
                                                <li><a href="#sub_h_colors"><i class="fa fa-paint-brush"></i> <?php echo $text_head_colors; ?></a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane fade active in" id="sub_h_settings">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_shownews; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['shownews'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[shownews]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['shownews'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['shownews'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[shownews]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['shownews'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_showcontacts; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['showcontacts'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[showcontacts]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['showcontacts'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['showcontacts'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[showcontacts]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['showcontacts'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_infolinks; ?></td>
                                                            <td>
                                                                <div class="form-group">
                                                                    <div class="well well-sm">
                                                                        <table class="table table-striped">
                                                                            <?php foreach ($informations as $information) { ?>
                                                                                <tr>
                                                                                    <td class="checkbox">
                                                                                        <label class="labelcheck">
                                                                                            <input type="checkbox" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[header_information_links][]" value="<?php echo $information['information_id']; ?>" <?php if (isset($value_002['header_information_links']) && in_array($information['information_id'], $value_002['header_information_links'])) { ?>checked="checked"<?php } ?> />
                                                                                            <?php echo $information['title']; ?>
                                                                                        </label>
                                                                                    </td>
                                                                                </tr>
                                                                            <?php } ?>
                                                                        </table>
                                                                    </div>
                                                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="tab-pane fade" id="sub_h_colors">
                                                    <h2 class="titletd"><span><?php echo $text_head_1stline; ?></span></h2>
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_head_1line_bg_1line; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_bg_1line]" value="<?php echo $value_002['head_1line_bg_1line']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_1line_bg_main; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_bg_main]" value="<?php echo $value_002['head_1line_bg_main']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_1line_color_1line_link; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_color_1line_link]" value="<?php echo $value_002['head_1line_color_1line_link']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_1line_color_1line_link_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_color_1line_link_hover]" value="<?php echo $value_002['head_1line_color_1line_link_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_1line_bg_1line_link_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_bg_1line_link_hover]" value="<?php echo $value_002['head_1line_bg_1line_link_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_1line_bg_tine_and_account; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_bg_tine_and_account]" value="<?php echo $value_002['head_1line_bg_tine_and_account']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_1line_bg_underscores_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_1line_bg_underscores_hover]" value="<?php echo $value_002['head_1line_bg_underscores_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                    <h2 class="titletd"><span><?php echo $text_head_dropdown_el; ?></span></h2>
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_head_dropdown_el_bg; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_dropdown_el_bg]" value="<?php echo $value_002['head_dropdown_el_bg']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_dropdown_el_color_link; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_dropdown_el_color_link]" value="<?php echo $value_002['head_dropdown_el_color_link']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_dropdown_el_color_link_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_dropdown_el_color_link_hover]" value="<?php echo $value_002['head_dropdown_el_color_link_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                    <h2 class="titletd"><span><?php echo $text_head_2ndline; ?></span></h2>
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_head_2ndline_color_tel_text; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_2ndline_color_tel_text]" value="<?php echo $value_002['head_2ndline_color_tel_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_2ndline_color_tel_icon; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_2ndline_color_tel_icon]" value="<?php echo $value_002['head_2ndline_color_tel_icon']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_2ndline_bg_cart; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_2ndline_bg_cart]" value="<?php echo $value_002['head_2ndline_bg_cart']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_2ndline_color_cart_text; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_2ndline_color_cart_text]" value="<?php echo $value_002['head_2ndline_color_cart_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_2ndline_color_cart_total; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_2ndline_color_cart_total]" value="<?php echo $value_002['head_2ndline_color_cart_total']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_2ndline_color_cart_text_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_2ndline_color_cart_text_hover]" value="<?php echo $value_002['head_2ndline_color_cart_text_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                    <h2 class="titletd"><span><?php echo $text_head_megamenu; ?></span></h2>
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_bg_link; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_bg_link]" value="<?php echo $value_002['head_megamenu_bg_link']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_bg_link_underscores_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_bg_link_underscores_hover]" value="<?php echo $value_002['head_megamenu_bg_link_underscores_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_color_link_text; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_color_link_text]" value="<?php echo $value_002['head_megamenu_color_link_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_color_link_text_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_color_link_text_hover]" value="<?php echo $value_002['head_megamenu_color_link_text_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                    <h2 class="titletd"><span><?php echo $text_head_megamenu_el; ?></span></h2>
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_bg; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_bg]" value="<?php echo $value_002['head_megamenu_el_bg']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_color_link; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_color_link]" value="<?php echo $value_002['head_megamenu_el_color_link']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_color_link_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_color_link_hover]" value="<?php echo $value_002['head_megamenu_el_color_link_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_color_link_2_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_color_link_2_hover]" value="<?php echo $value_002['head_megamenu_el_color_link_2_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_bg_link_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_bg_link_hover]" value="<?php echo $value_002['head_megamenu_el_bg_link_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_color_price_in_specials; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_color_price_in_specials]" value="<?php echo $value_002['head_megamenu_el_color_price_in_specials']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_head_megamenu_el_color_price_old_in_specials; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[head_megamenu_el_color_price_old_in_specials]" value="<?php echo $value_002['head_megamenu_el_color_price_old_in_specials']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- FOOTER SETTINGS -->
                                    <div class="tab-pane fade" id="tab_footer">
                                        <div class="tab-content">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a href="#sub_f_settings"><i class="fa fa-cog"></i> <?php echo $text_foot_settings; ?></a></li>
                                                <li><a href="#sub_f_colors"><i class="fa fa-paint-brush"></i> <?php echo $text_foot_colors; ?></a></li>
                                                <li><a href="#sub_f_bar"><i class="fa fa-paint-brush"></i> <?php echo $text_foot_bar; ?></a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane fade active in" id="sub_f_settings">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_foot_show_soclinks; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_soclinks'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_soclinks]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_soclinks'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_soclinks'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_soclinks]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_soclinks'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_contact_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_contact_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_contact_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_contact_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_contact_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_contact_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_contact_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_copy_and_payment; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_copy_and_payment'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_copy_and_payment]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_copy_and_payment'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_copy_and_payment'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_copy_and_payment]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_copy_and_payment'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_contact_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_contact_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_contact_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_contact_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_contact_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_contact_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_contact_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_return_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_return_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_return_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_return_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_return_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_return_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_return_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_sitemap_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_sitemap_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_sitemap_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_sitemap_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_sitemap_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_sitemap_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_sitemap_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_manufacturer_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_manufacturer_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_manufacturer_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_manufacturer_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_manufacturer_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_manufacturer_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_manufacturer_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_voucher_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_voucher_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_voucher_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_voucher_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_voucher_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_voucher_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_voucher_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_affiliate_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_affiliate_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_affiliate_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_affiliate_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_affiliate_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_affiliate_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_affiliate_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_show_block_special_link; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_special_link'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_special_link]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_special_link'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_show_block_special_link'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_show_block_special_link]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_show_block_special_link'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_info_links; ?></td>
                                                            <td>
                                                                <div class="form-group">
                                                                    <div class="well well-sm">
                                                                        <table class="table table-striped">
                                                                            <?php foreach ($informations as $information) { ?>
                                                                                <tr>
                                                                                    <td class="checkbox">
                                                                                        <label class="labelcheck">
                                                                                            <input type="checkbox" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_info_links][]" value="<?php echo $information['information_id']; ?>" <?php if (isset($value_002['foot_info_links']) && in_array($information['information_id'], $value_002['foot_info_links'])) { ?>checked="checked"<?php } ?> />
                                                                                            <?php echo $information['title']; ?>
                                                                                        </label>
                                                                                    </td>
                                                                                </tr>
                                                                            <?php } ?>
                                                                        </table>
                                                                    </div>
                                                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_cat_links; ?></td>
                                                            <td>
                                                                <div class="form-group">
                                                                    <div class="well well-sm" style="height: 200px;overflow: auto;">
                                                                        <table class="table table-striped">
                                                                            <?php foreach ($categories as $category) { ?>
                                                                                <tr>
                                                                                    <td class="checkbox">
                                                                                        <label class="labelcheck">
                                                                                            <input type="checkbox" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_cat_links][]" value="<?php echo $category['category_id']; ?>" <?php if (isset($value_002['foot_cat_links']) && in_array($category['category_id'], $value_002['foot_cat_links'])) { ?>checked="checked"<?php } ?> />
                                                                                            <?php echo $category['name']; ?>
                                                                                        </label>
                                                                                    </td>
                                                                                </tr>
                                                                            <?php } ?>
                                                                        </table>
                                                                    </div>
                                                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_garantedtext_show; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['foot_garantedtext_show'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext_show]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_garantedtext_show'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['foot_garantedtext_show'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext_show]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['foot_garantedtext_show'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <?php echo $text_foot_garantedtext; ?>
                                                                <br/><br/>
                                                                <table id="foot_garantedtext" class="table table-bordered">
                                                                    <thead>
                                                                    <tr>
                                                                        <td><?php echo $text_foot_garantedtext_col_icon; ?></td>
                                                                        <td><?php echo $text_foot_garantedtext_col_name_and_link; ?></td>
                                                                        <td><?php echo $text_foot_garantedtext_col_popup; ?></td>
                                                                        <td><?php echo $text_foot_garantedtext_col_text; ?></td>
                                                                        <td><?php echo $text_foot_garantedtext_col_action; ?></td>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <?php
                                                                    $foot_garantedtext_row = 0; if (!empty($value_002['foot_garantedtext'])) { ?>
                                                                        <?php foreach ($value_002['foot_garantedtext'] as $foot_garantedtext) { ?>
                                                                            <tr id="foot_garantedtext-row<?php echo $foot_garantedtext_row; ?>">
                                                                                <td>
                                                                                    <span data-toggle="tooltip" title="<?php echo $text_foot_garantedtext_get_icons; ?>" class="btn btn-default" onclick="font_icons('<?php echo $foot_garantedtext_row; ?>', '2');"><i class="<?php echo $foot_garantedtext['icon']; ?>" id="foot_garantedtext_icon-<?php echo $foot_garantedtext_row; ?>"></i></span>
                                                                                    <input id="foot_garantedtext_icon-input-<?php echo $foot_garantedtext_row; ?>" type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][<?php echo $foot_garantedtext_row; ?>][icon]" value="<?php echo $foot_garantedtext['icon']; ?>" />
                                                                                </td>
                                                                                <td>
                                                                                    <div class="row">
                                                                                        <div class="col-sm-6">
                                                                                            <?php foreach ($languages as $language) { ?>
                                                                                                <div class="input-group">
                                                                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                                                    <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][<?php echo $foot_garantedtext_row; ?>][description][<?php echo $language['code']; ?>][name]" value="<?php echo isset($foot_garantedtext['description'][$language['code']]) ? $foot_garantedtext['description'][$language['code']]['name'] : ''; ?>" placeholder="<?php echo $text_foot_garantedtext_placeholder_name; ?>" />
                                                                                                </div>
                                                                                            <?php } ?>
                                                                                        </div>
                                                                                        <div class="col-sm-6">
                                                                                            <?php foreach ($languages as $language) { ?>
                                                                                                <div class="input-group">
                                                                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                                                    <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][<?php echo $foot_garantedtext_row; ?>][description][<?php echo $language['code']; ?>][link]" value="<?php echo isset($foot_garantedtext['description'][$language['code']]) ? $foot_garantedtext['description'][$language['code']]['link'] : ''; ?>" placeholder="<?php echo $text_foot_garantedtext_placeholder_link; ?>" />
                                                                                                </div>
                                                                                            <?php } ?>
                                                                                        </div>
                                                                                    </div>
                                                                                    <?php if ($informations) { ?>
                                                                                        <div class="row" style="margin-top: 7px;">
                                                                                            <div class="col-sm-12">
                                                                                                <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#foot-collapse-info-link-<?php echo $foot_garantedtext_row; ?>" aria-expanded="false" aria-controls="foot-collapse-info-link-<?php echo $foot_garantedtext_row; ?>"><?php echo $text_foot_garantedtext_get_information; ?></button>
                                                                                                <div class="collapse" id="foot-collapse-info-link-<?php echo $foot_garantedtext_row; ?>">
                                                                                                    <div class="well">
                                                                                                        <?php foreach ($informations as $information) { ?>
                                                                                                            <a onclick="$(this).parent().parent().parent().parent().prev().find('[name*=name]').val('<?php echo $information['title']; ?>');$(this).parent().parent().parent().parent().prev().find('[name*=link]').val('<?php echo $information['href']; ?>');"><?php echo $information['title']; ?></a>
                                                                                                            <br/>
                                                                                                        <?php } ?>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    <?php } ?>
                                                                                </td>
                                                                                <td>
                                                                                    <div class="btn-group" data-toggle="buttons">
                                                                                        <label class="btn btn-info <?php echo $foot_garantedtext['popup'] == 'on' ? 'active' : ''; ?>">
                                                                                            <input type="radio"
                                                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][<?php echo $foot_garantedtext_row; ?>][popup]"
                                                                                                   value="on"
                                                                                                   autocomplete="off"
                                                                                                   style="display: none;"
                                                                                                <?php echo $foot_garantedtext['popup'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                                            /><?php echo $text_yes; ?>
                                                                                        </label>
                                                                                        <label class="btn btn-info <?php echo $foot_garantedtext['popup'] == 'off' ? 'active' : ''; ?>">
                                                                                            <input type="radio"
                                                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][<?php echo $foot_garantedtext_row; ?>][popup]"
                                                                                                   value="off"
                                                                                                   autocomplete="off"
                                                                                                   style="display: none;"
                                                                                                <?php echo $foot_garantedtext['popup'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                                            /><?php echo $text_no; ?>
                                                                                        </label>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <div class="row">
                                                                                        <div class="col-sm-12">
                                                                                            <?php foreach ($languages as $language) { ?>
                                                                                                <div class="input-group">
                                                                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                                                    <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][<?php echo $foot_garantedtext_row; ?>][description][<?php echo $language['code']; ?>][text]" value="<?php echo isset($foot_garantedtext['description'][$language['code']]) ? $foot_garantedtext['description'][$language['code']]['text'] : ''; ?>" placeholder="<?php echo $text_foot_garantedtext_placeholder_text; ?>" />
                                                                                                </div>
                                                                                            <?php } ?>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <button type="button" onclick="$(this).parent().parent().remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_delete; ?></button>
                                                                                </td>
                                                                            </tr>
                                                                            <?php $foot_garantedtext_row++; } ?>
                                                                    <?php } ?>
                                                                    </tbody>
                                                                    <tfoot>
                                                                    <tr>
                                                                        <td colspan="4"></td>
                                                                        <td>
                                                                            <button type="button" onclick="addFoot_garantedtext();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add; ?></button>
                                                                        </td>
                                                                    </tr>
                                                                    </tfoot>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="tab-pane fade" id="sub_f_colors">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_foot_bg_foot; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_bg_foot]" value="<?php echo $value_002['foot_bg_foot']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_guarantee_icon; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_guarantee_icon]" value="<?php echo $value_002['foot_color_guarantee_icon']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_guarantee_icon_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_guarantee_icon_hover]" value="<?php echo $value_002['foot_color_guarantee_icon_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_guarantee_text; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_guarantee_text]" value="<?php echo $value_002['foot_color_guarantee_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_heading_text; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_heading_text]" value="<?php echo $value_002['foot_color_heading_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_links; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_links]" value="<?php echo $value_002['foot_color_links']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_links_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_links_hover]" value="<?php echo $value_002['foot_color_links_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_contact_icon; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_contact_icon]" value="<?php echo $value_002['foot_color_contact_icon']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="tab-pane fade" id="sub_f_bar">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_foot_bg_bar; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_bg_bar]" value="<?php echo $value_002['foot_bg_bar']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_bg_bar_el_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_bg_bar_el_hover]" value="<?php echo $value_002['foot_bg_bar_el_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_bar_el_text; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_bar_el_text]" value="<?php echo $value_002['foot_color_bar_el_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_foot_color_bar_el_text_hover; ?></td>
                                                            <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_color_bar_el_text_hover]" value="<?php echo $value_002['foot_color_bar_el_text_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- CATEGORY SETTINGS -->
                                    <div class="tab-pane fade" id="tab_category">
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a href="#tab_cat_main_settings"><i class="fa fa-cog"></i> <?php echo $text_cat_main; ?></a></li>
                                            <li><a href="#tab_cat_filterset_settings"><i class="fa fa-cog"></i> <?php echo $text_cat_filterset; ?></a></li>
                                            <li><a href="#tab_cat_moduleset_settings"><i class="fa fa-cog"></i> <?php echo $text_cat_modulecat; ?></a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active in" id="tab_cat_main_settings">
                                                <table class="form">
                                                    <tr>
                                                        <td><?php echo $text_cat_show_subcat; ?></td>
                                                        <td>
                                                            <div class="btn-group" data-toggle="buttons">
                                                                <label class="btn btn-info <?php echo $value_002['cat_show_subcat'] == 'on' ? 'active' : ''; ?>">
                                                                    <input type="radio"
                                                                           name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_show_subcat]"
                                                                           value="on"
                                                                           autocomplete="off"
                                                                           style="display: none;"
                                                                        <?php echo $value_002['cat_show_subcat'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                    /><?php echo $text_yes; ?>
                                                                </label>
                                                                <label class="btn btn-info <?php echo $value_002['cat_show_subcat'] == 'off' ? 'active' : ''; ?>">
                                                                    <input type="radio"
                                                                           name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_show_subcat]"
                                                                           value="off"
                                                                           autocomplete="off"
                                                                           style="display: none;"
                                                                        <?php echo $value_002['cat_show_subcat'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                    /><?php echo $text_no; ?>
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_sorttype; ?></td>
                                                        <td>
                                                            <div class="btn-group" data-toggle="buttons">
                                                                <label class="btn btn-info <?php echo $value_002['cat_sorttype'] == 'on' ? 'active' : ''; ?>">
                                                                    <input type="radio"
                                                                           name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_sorttype]"
                                                                           value="on"
                                                                           autocomplete="off"
                                                                           style="display: none;"
                                                                        <?php echo $value_002['cat_sorttype'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                    /><?php echo $text_yes; ?>
                                                                </label>
                                                                <label class="btn btn-info <?php echo $value_002['cat_sorttype'] == 'off' ? 'active' : ''; ?>">
                                                                    <input type="radio"
                                                                           name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_sorttype]"
                                                                           value="off"
                                                                           autocomplete="off"
                                                                           style="display: none;"
                                                                        <?php echo $value_002['cat_sorttype'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                    /><?php echo $text_no; ?>
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr style="display:none;">
                                                        <td><?php echo $text_cat_pricelist_view; ?></td>
                                                        <td>
                                                            <div class="btn-group" data-toggle="buttons">
                                                                <label class="btn btn-info <?php echo (isset($value_002['cat_pricelist_view']) && $value_002['cat_pricelist_view'] == 'on') ? 'active' : ''; ?>">
                                                                    <input type="radio"
                                                                           name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_pricelist_view]"
                                                                           value="on"
                                                                           autocomplete="off"
                                                                           style="display: none;"
                                                                        <?php echo (isset($value_002['cat_pricelist_view']) && $value_002['cat_pricelist_view'] == 'on') ? 'checked="checked"' : ''; ?>
                                                                    /><?php echo $text_yes; ?>
                                                                </label>
                                                                <label class="btn btn-info <?php echo (isset($value_002['cat_pricelist_view']) && $value_002['cat_pricelist_view'] == 'off') ? 'active' : ''; ?>">
                                                                    <input type="radio"
                                                                           name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_pricelist_view]"
                                                                           value="off"
                                                                           autocomplete="off"
                                                                           style="display: none;"
                                                                        <?php echo (isset($value_002['cat_pricelist_view']) && $value_002['cat_pricelist_view'] == 'off') ? 'checked="checked"' : ''; ?>
                                                                    /><?php echo $text_no; ?>
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_discountbg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_discountbg]" value="<?php echo $value_002['cat_discountbg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_discountcolor; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_discountcolor]" value="<?php echo $value_002['cat_discountcolor']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane fade" id="tab_cat_filterset_settings">
                                                <table class="form">
                                                    <tr>
                                                        <td><?php echo $text_cat_boxtext; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_boxtext]" value="<?php echo $value_002['cat_boxtext']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_boxbg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_boxbg]" value="<?php echo $value_002['cat_boxbg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_modulebg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_modulebg]" value="<?php echo $value_002['cat_modulebg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_itembg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_itembg]" value="<?php echo $value_002['cat_itembg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_plusminus; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_plusminus]" value="<?php echo $value_002['cat_plusminus']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_checkbox; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_checkbox]" value="<?php echo $value_002['cat_checkbox']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_checkboxactive; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_checkboxactive]" value="<?php echo $value_002['cat_checkboxactive']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="tab-pane fade" id="tab_cat_moduleset_settings">
                                                <table class="form">
                                                    <tr>
                                                        <td><?php echo $text_cat_1levelbg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_1levelbg]" value="<?php echo $value_002['cat_1levelbg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_1levelcolor; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_1levelcolor]" value="<?php echo $value_002['cat_1levelcolor']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_2levelbg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_2levelbg]" value="<?php echo $value_002['cat_2levelbg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_2levelcolor; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_2levelcolor]" value="<?php echo $value_002['cat_2levelcolor']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_3levelbg; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_3levelbg]" value="<?php echo $value_002['cat_3levelbg']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_3levelcolor; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_3levelcolor]" value="<?php echo $value_002['cat_3levelcolor']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_3levelbgactive; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_3levelbgactive]" value="<?php echo $value_002['cat_3levelbgactive']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                    <tr>
                                                        <td><?php echo $text_cat_3leveltextactive; ?></td>
                                                        <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cat_3leveltextactive]" value="<?php echo $value_002['cat_3leveltextactive']; ?>" size="6" class="spectrum"  /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- PRODUCT SETTINGS -->
                                    <div class="tab-pane fade" id="tab_product">
                                        <div class="tab-content">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a href="#sub_p_settings"><i class="fa fa-cog"></i> <?php echo $text_pr_settings; ?></a></li>
                                                <li><a href="#sub_p_colors"><i class="fa fa-paint-brush"></i> <?php echo $text_pr_colors; ?></a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane fade active in" id="sub_p_settings">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_pr_micro; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['pr_micro'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_micro]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['pr_micro'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['pr_micro'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_micro]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['pr_micro'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_additional_tab_show; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['pr_additional_tab_show'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_additional_tab_show]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['pr_additional_tab_show'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['pr_additional_tab_show'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_additional_tab_show]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['pr_additional_tab_show'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_additional_tab_heading; ?></td>
                                                            <td>
                                                                <?php foreach ($languages as $language) { ?>
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                        <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_additional_tab_heading][<?php echo $language['code']; ?>]" value="<?php echo isset($value_002['pr_additional_tab_heading'][$language['code']]) ? $value_002['pr_additional_tab_heading'][$language['code']] : ''; ?>" />
                                                                    </div>
                                                                <?php } ?>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_additional_tab_text; ?></td>
                                                            <td>
                                                                <?php foreach ($languages as $language) { ?>
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                        <textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_additional_tab_text][<?php echo $language['code']; ?>]" class="form-control" id="pr_additional_tab_text-<?php echo $language['code']; ?>"><?php echo isset($value_002['pr_additional_tab_text'][$language['code']]) ? $value_002['pr_additional_tab_text'][$language['code']] : ''; ?></textarea>
                                                                    </div><br />
                                                                <?php } ?>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_social_button_script; ?></td>
                                                            <td>
                                                                <textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_social_button_script]" class="form-control"><?php echo isset($value_002['pr_social_button_script']) ? $value_002['pr_social_button_script'] : ''; ?></textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_garantedtext_show; ?></td>
                                                            <td>
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['pr_garantedtext_show'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext_show]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['pr_garantedtext_show'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['pr_garantedtext_show'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext_show]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['pr_garantedtext_show'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <?php echo $text_pr_garantedtext; ?>
                                                                <br/><br/>
                                                                <table id="pr_garantedtext" class="table table-bordered">
                                                                    <thead>
                                                                    <tr>
                                                                        <td><?php echo $text_pr_garantedtext_col_icon; ?></td>
                                                                        <td><?php echo $text_pr_garantedtext_col_name_and_link; ?></td>
                                                                        <td><?php echo $text_pr_garantedtext_col_popup; ?></td>
                                                                        <td><?php echo $text_pr_garantedtext_col_action; ?></td>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <?php $pr_garantedtext_row = 0; if (isset($value_002['pr_garantedtext'])) { ?>
                                                                        <?php foreach ($value_002['pr_garantedtext'] as $pr_garantedtext) { ?>
                                                                            <tr id="pr_garantedtext-row<?php echo $pr_garantedtext_row; ?>">
                                                                                <td>
                                                                                    <span data-toggle="tooltip" title="<?php echo $text_pr_garantedtext_get_icons; ?>" class="btn btn-default" onclick="font_icons('<?php echo $pr_garantedtext_row; ?>', '1');"><i class="<?php echo $pr_garantedtext['icon']; ?>" id="pr_garantedtext_icon-<?php echo $pr_garantedtext_row; ?>"></i></span>
                                                                                    <input id="pr_garantedtext_icon-input-<?php echo $pr_garantedtext_row; ?>" type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][<?php echo $pr_garantedtext_row; ?>][icon]" value="<?php echo $pr_garantedtext['icon']; ?>" />
                                                                                </td>
                                                                                <td>
                                                                                    <div class="row">
                                                                                        <div class="col-sm-6">
                                                                                            <?php foreach ($languages as $language) { ?>
                                                                                                <div class="input-group">
                                                                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                                                    <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][<?php echo $pr_garantedtext_row; ?>][description][<?php echo $language['code']; ?>][name]" value="<?php echo isset($pr_garantedtext['description'][$language['code']]) ? $pr_garantedtext['description'][$language['code']]['name'] : ''; ?>" placeholder="<?php echo $text_pr_garantedtext_placeholder_name; ?>" />
                                                                                                </div>
                                                                                            <?php } ?>
                                                                                        </div>
                                                                                        <div class="col-sm-6">
                                                                                            <?php foreach ($languages as $language) { ?>
                                                                                                <div class="input-group">
                                                                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                                                                    <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][<?php echo $pr_garantedtext_row; ?>][description][<?php echo $language['code']; ?>][link]" value="<?php echo isset($pr_garantedtext['description'][$language['code']]) ? $pr_garantedtext['description'][$language['code']]['link'] : ''; ?>" placeholder="<?php echo $text_pr_garantedtext_placeholder_link; ?>" />
                                                                                                </div>
                                                                                            <?php } ?>
                                                                                        </div>
                                                                                    </div>
                                                                                    <?php if ($informations) { ?>
                                                                                        <div class="row" style="margin-top: 7px;">
                                                                                            <div class="col-sm-12">
                                                                                                <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapse-info-link-<?php echo $pr_garantedtext_row; ?>" aria-expanded="false" aria-controls="collapse-info-link-<?php echo $pr_garantedtext_row; ?>"><?php echo $text_pr_garantedtext_get_information; ?></button>
                                                                                                <div class="collapse" id="collapse-info-link-<?php echo $pr_garantedtext_row; ?>">
                                                                                                    <div class="well">
                                                                                                        <?php foreach ($informations as $information) { ?>
                                                                                                            <a onclick="$(this).parent().parent().parent().parent().prev().find('[name*=name]').val('<?php echo $information['title']; ?>');$(this).parent().parent().parent().parent().prev().find('[name*=link]').val('<?php echo $information['href']; ?>');"><?php echo $information['title']; ?></a>
                                                                                                            <br/>
                                                                                                        <?php } ?>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    <?php } ?>
                                                                                </td>
                                                                                <td>
                                                                                    <div class="btn-group" data-toggle="buttons">
                                                                                        <label class="btn btn-info <?php echo $pr_garantedtext['popup'] == 'on' ? 'active' : ''; ?>">
                                                                                            <input type="radio"
                                                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][<?php echo $pr_garantedtext_row; ?>][popup]"
                                                                                                   value="on"
                                                                                                   autocomplete="off"
                                                                                                   style="display: none;"
                                                                                                <?php echo $pr_garantedtext['popup'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                                            /><?php echo $text_yes; ?>
                                                                                        </label>
                                                                                        <label class="btn btn-info <?php echo $pr_garantedtext['popup'] == 'off' ? 'active' : ''; ?>">
                                                                                            <input type="radio"
                                                                                                   name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][<?php echo $pr_garantedtext_row; ?>][popup]"
                                                                                                   value="off"
                                                                                                   autocomplete="off"
                                                                                                   style="display: none;"
                                                                                                <?php echo $pr_garantedtext['popup'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                                            /><?php echo $text_no; ?>
                                                                                        </label>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <button type="button" onclick="$(this).parent().parent().remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_delete; ?></button>
                                                                                </td>
                                                                            </tr>
                                                                            <?php $pr_garantedtext_row++; } ?>
                                                                    <?php } ?>
                                                                    </tbody>
                                                                    <tfoot>
                                                                    <tr>
                                                                        <td colspan="3"></td>
                                                                        <td>
                                                                            <button type="button" onclick="addPr_garantedtext();" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add; ?></button>
                                                                        </td>
                                                                    </tr>
                                                                    </tfoot>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="tab-pane fade" id="sub_p_colors">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_pr_color_button_add_ro_cart; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_button_add_ro_cart]" value="<?php echo $value_002['pr_color_button_add_ro_cart']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_button_add_ro_cart_hover; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_button_add_ro_cart_hover]" value="<?php echo $value_002['pr_color_button_add_ro_cart_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_button_other; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_button_other]" value="<?php echo $value_002['pr_color_button_other']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_button_other_hover; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_button_other_hover]" value="<?php echo $value_002['pr_color_button_other_hover']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_bg_block; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_bg_block]" value="<?php echo $value_002['pr_bg_block']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_bg_tab; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_bg_tab]" value="<?php echo $value_002['pr_bg_tab']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_bg_tab_active; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_bg_tab_active]" value="<?php echo $value_002['pr_bg_tab_active']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_tab_text; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_tab_text]" value="<?php echo $value_002['pr_color_tab_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_image_border; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_image_border]" value="<?php echo $value_002['pr_color_image_border']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_guarantee_icon; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_guarantee_icon]" value="<?php echo $value_002['pr_color_guarantee_icon']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_guarantee_text; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_guarantee_text]" value="<?php echo $value_002['pr_color_guarantee_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_block_under_heading_text; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_block_under_heading_text]" value="<?php echo $value_002['pr_color_block_under_heading_text']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_pr_color_block_under_heading_icon; ?></td>
                                                            <td width="25%"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_color_block_under_heading_icon]" value="<?php echo $value_002['pr_color_block_under_heading_icon']; ?>" size="6" class="spectrum" /></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- MOBILE SETTINGS -->
                                    <div id="tab_mobile" class="tab-pane fade">
                                        <table class="form">
                                            <tr>
                                                <td><?php echo $text_mob_mainlinebg; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mob_mainlinebg]" value="<?php echo $value_002['mob_mainlinebg']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_mod_mainline_iconcolor; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mod_mainline_iconcolor]" value="<?php echo $value_002['mod_mainline_iconcolor']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_mod_dropdown_headingbg; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mod_dropdown_headingbg]" value="<?php echo $value_002['mod_dropdown_headingbg']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_mod_dropdown_heading_and_buttoncolor; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mod_dropdown_heading_and_buttoncolor]" value="<?php echo $value_002['mod_dropdown_heading_and_buttoncolor']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_mod_dropdown_linktextcolor; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mod_dropdown_linktextcolor]" value="<?php echo $value_002['mod_dropdown_linktextcolor']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_mod_header_iconrcolor; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mod_header_iconrcolor]" value="<?php echo $value_002['mod_header_iconrcolor']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_mod_header_iconrbg; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[mod_header_iconrbg]" value="<?php echo $value_002['mod_header_iconrbg']; ?>" size="6" class="spectrum"  /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <!-- CONTACT SETTINGS -->
                                    <div id="tab_contacts" class="tab-pane fade">
                                        <table class="form">
                                            <tr>
                                                <td><?php echo $text_cont_phones; ?></td>
                                                <td><textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_phones]" id="phpner_store_cont_phones" class="form-control"><?php echo $value_002['cont_phones']; ?></textarea></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cont_skype; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_skype]" value="<?php echo $value_002['cont_skype']; ?>"  style="width: 100%"/></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cont_email; ?></td>
                                                <td><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_email]" value="<?php echo $value_002['cont_email']; ?>"  style="width: 100%"/></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cont_adress; ?></td>
                                                <td>
                                                    <?php foreach ($languages as $language) { ?>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                            <textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_adress][<?php echo $language['code']; ?>]" id="phpner_store_cont_adress<?php echo $language['code']; ?>" class="form-control"><?php echo isset($value_002['cont_adress'][$language['code']]) ? $value_002['cont_adress'][$language['code']] : ''; ?></textarea>
                                                        </div><br />
                                                    <?php } ?>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cont_clock; ?></td>
                                                <td>
                                                    <?php foreach ($languages as $language) { ?>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                            <textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_clock][<?php echo $language['code']; ?>]" id="phpner_store_cont_clock<?php echo $language['code']; ?>" class="form-control"><?php echo isset($value_002['cont_clock'][$language['code']]) ? $value_002['cont_clock'][$language['code']] : ''; ?></textarea>
                                                        </div><br />
                                                    <?php } ?>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cont_contacthtml; ?></td>
                                                <td>
                                                    <?php foreach ($languages as $language) { ?>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                                                            <textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_contacthtml][<?php echo $language['code']; ?>]" id="phpner_store_cont_contacthtml<?php echo $language['code']; ?>" class="form-control"><?php echo isset($value_002['cont_contacthtml'][$language['code']]) ? $value_002['cont_contacthtml'][$language['code']] : ''; ?></textarea>
                                                        </div><br />
                                                    <?php } ?>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_cont_contactmap; ?></td>
                                                <td><textarea style="min-height: 100px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[cont_contactmap]" id="phpner_store_cont_contactmap" class="form-control"><?php echo $value_002['cont_contactmap']; ?></textarea></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <!-- PAYMENN SOCIALS SETTINGS -->
                                    <div id="tab_payment_soc" class="tab-pane fade">
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a href="#tab_ps_soc_settings"><i class="fa fa-cog"></i> <?php echo $text_ps_soc; ?></a></li>
                                            <li><a href="#tab_ps_methots_settings"><i class="fa fa-cog"></i> <?php echo $text_ps_methots; ?></a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active in" id="tab_ps_soc_settings">
                                                <div class="leftdivs">
                                                    <table class="form">
                                                        <tr>
                                                            <td style="width: 20%;"><?php echo $text_ps_facebook_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_facebook_id]" value="<?php echo $value_002['ps_facebook_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_vk_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_vk_id]" value="<?php echo $value_002['ps_vk_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_gplus_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_gplus_id]" value="<?php echo $value_002['ps_gplus_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_odnoklass_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_odnoklass_id]" value="<?php echo $value_002['ps_odnoklass_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_twitter_username; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_twitter_username]" value="<?php echo $value_002['ps_twitter_username']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_whatsapp_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_whatsapp_id]" value="<?php echo (isset($value_002['ps_whatsapp_id']) && $value_002['ps_whatsapp_id']) ? $value_002['ps_whatsapp_id'] : ''; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_telegram_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_telegram_id]" value="<?php echo (isset($value_002['ps_telegram_id']) && $value_002['ps_telegram_id']) ? $value_002['ps_telegram_id'] : ''; ?>" /></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="leftdivs">
                                                    <table class="form">
                                                        <tr>
                                                            <td><?php echo $text_ps_vimeo_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_vimeo_id]" value="<?php echo $value_002['ps_vimeo_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_pinterest_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_pinterest_id]" value="<?php echo $value_002['ps_pinterest_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_flick_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_flick_id]" value="<?php echo $value_002['ps_flick_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_instagram; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_instagram]" value="<?php echo $value_002['ps_instagram']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_youtube_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_youtube_id]" value="<?php echo $value_002['ps_youtube_id']; ?>" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td><?php echo $text_ps_viber_id; ?></td>
                                                            <td><input class="form-control" type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_viber_id]" value="<?php echo (isset($value_002['ps_viber_id']) && $value_002['ps_viber_id']) ? $value_002['ps_viber_id'] : ''; ?>" /></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="tab_ps_methots_settings">
                                                <table class="form">
                                                    <tr>
                                                        <td colspan="2">
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/sberbank.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_sberbank'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_sberbank]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_sberbank'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_sberbank'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_sberbank]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_sberbank'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/privat.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_privat'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_privat]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_privat'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_privat'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_privat]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_privat'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/yamoney.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_yamoney'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_yamoney]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_yamoney'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_yamoney'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_yamoney]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_yamoney'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/webmoney.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_webmoney'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_webmoney]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_webmoney'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_webmoney'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_webmoney]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_webmoney'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/visa.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_visa'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_visa]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_visa'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_visa'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_visa]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_visa'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/qiwi.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_qiwi'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_qiwi]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_qiwi'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_qiwi'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_qiwi]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_qiwi'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/skrill.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_skrill'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_skrill]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_skrill'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_skrill'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_skrill]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_skrill'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/interkassa.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_interkassa'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_interkassa]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_interkassa'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_interkassa'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_interkassa]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_interkassa'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/liqpay.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_liqpay'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_liqpay]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_liqpay'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_liqpay'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_liqpay]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_liqpay'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/paypal.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_paypal'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_paypal]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_paypal'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_paypal'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_paypal]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_paypal'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/robokassa.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo $value_002['ps_robokassa'] == 'on' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_robokassa]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_robokassa'] == 'on' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo $value_002['ps_robokassa'] == 'off' ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_robokassa]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo $value_002['ps_robokassa'] == 'off' ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/mastercard.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo (isset($value_002['ps_mastercard']) && $value_002['ps_mastercard'] == 'on') ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_mastercard]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo (isset($value_002['ps_mastercard']) && $value_002['ps_mastercard'] == 'on') ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo (isset($value_002['ps_mastercard']) && $value_002['ps_mastercard'] == 'off') ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_mastercard]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo (isset($value_002['ps_mastercard']) && $value_002['ps_mastercard'] == 'off') ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="pay-methods">
                                                                <img src="view/image/pay/maestro.png" /><br />
                                                                <div class="btn-group" data-toggle="buttons">
                                                                    <label class="btn btn-info <?php echo (isset($value_002['ps_maestro']) && $value_002['ps_maestro'] == 'on') ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_maestro]"
                                                                               value="on"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo (isset($value_002['ps_maestro']) && $value_002['ps_maestro'] == 'on') ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_yes; ?>
                                                                    </label>
                                                                    <label class="btn btn-info <?php echo (isset($value_002['ps_maestro']) && $value_002['ps_maestro'] == 'off') ? 'active' : ''; ?>">
                                                                        <input type="radio"
                                                                               name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_maestro]"
                                                                               value="off"
                                                                               autocomplete="off"
                                                                               style="display: none;"
                                                                            <?php echo (isset($value_002['ps_maestro']) && $value_002['ps_maestro'] == 'off') ? 'checked="checked"' : ''; ?>
                                                                        /><?php echo $text_no; ?>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div class="table-responsive">
                                                    <br/>
                                                    <h3>Дополнительные иконки платежных систем</h3>
                                                    <table id="ps-additional-icons" class="table table-bordered">
                                                        <thead>
                                                        <tr>
                                                            <td class="text-left"><?php echo $entry_ps_additional_icon; ?></td>
                                                            <td class="text-right"><?php echo $entry_ps_additional_sort_order; ?></td>
                                                            <td></td>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <?php $ps_additional_icon_row = 0; ?>
                                                        <?php if ($ps_additional_icons) { ?>
                                                            <?php foreach ($ps_additional_icons as $ps_additional_icon) { ?>
                                                                <tr id="ps-additional-icon<?php echo $ps_additional_icon_row; ?>">
                                                                    <td class="text-left"><a href="" id="thumb-image<?php echo $ps_additional_icon_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $ps_additional_icon['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_additional_icons][<?php echo $ps_additional_icon_row; ?>][image]" value="<?php echo $ps_additional_icon['image']; ?>" id="input-image<?php echo $ps_additional_icon_row; ?>" /></td>
                                                                    <td class="text-right"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_additional_icons][<?php echo $ps_additional_icon_row; ?>][sort_order]" value="<?php echo $ps_additional_icon['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
                                                                    <td class="text-left"><button type="button" onclick="$('#ps-additional-icon<?php echo $ps_additional_icon_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>
                                                                </tr>
                                                                <?php $ps_additional_icon_row++; ?>
                                                            <?php } ?>
                                                        <?php } ?>
                                                        </tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <td colspan="2"></td>
                                                            <td class="text-left"><button type="button" onclick="addPsAdditionalIcon();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add; ?></button></td>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- CUSTOM CSS - JAVSCRIPT -->
                                    <div id="tab_cssjs" class="tab-pane fade">
                                        <table class="form">
                                            <tr>
                                                <td><?php echo $text_css; ?></td>
                                                <td><textarea style="min-height: 280px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[customcss]" class="form-control"><?php echo $value_002['customcss']; ?></textarea></td>
                                            </tr>
                                            <tr>
                                                <td><?php echo $text_javascript; ?></td>
                                                <td><textarea style="min-height: 280px;" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[customjavascrip]" class="form-control"><?php echo $value_002['customjavascrip']; ?></textarea></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <!-- IMAGES AND LIMITS -->
                                    <div id="tab-limit-and-image" class="tab-pane fade">
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a href="#tab_product_settings"><i class="fa fa-cog"></i> <?php echo $text_product; ?></a></li>
                                            <li><a href="#tab_image_settings"><i class="fa fa-cog"></i> <?php echo $text_image; ?></a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane fade active in" id="tab_product_settings">
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-catalog-limit"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>"><?php echo $entry_product_limit; ?></span></label>
                                                    <div class="col-sm-9">
                                                        <input type="text" name="phpner_store_product_limit" value="<?php echo $phpner_store_product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-catalog-limit" class="form-control" />
                                                        <?php if ($error_product_limit) { ?>
                                                            <div class="text-danger"><?php echo $error_product_limit; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-description-limit"><span data-toggle="tooltip" title="<?php echo $help_product_description_length; ?>"><?php echo $entry_product_description_length; ?></span></label>
                                                    <div class="col-sm-9">
                                                        <input type="text" name="phpner_store_product_description_length" value="<?php echo $phpner_store_product_description_length; ?>" placeholder="<?php echo $entry_product_description_length; ?>" id="input-description-limit" class="form-control" />
                                                        <?php if ($error_product_description_length) { ?>
                                                            <div class="text-danger"><?php echo $error_product_description_length; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="tab_image_settings">
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_category_width" value="<?php echo $phpner_store_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-category-width" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_category_height" value="<?php echo $phpner_store_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_category) { ?>
                                                            <div class="text-danger"><?php echo $error_image_category; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_thumb_width" value="<?php echo $phpner_store_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-thumb-width" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_thumb_height" value="<?php echo $phpner_store_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_thumb) { ?>
                                                            <div class="text-danger"><?php echo $error_image_thumb; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_popup_width" value="<?php echo $phpner_store_image_popup_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-popup-width" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_popup_height" value="<?php echo $phpner_store_image_popup_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_popup) { ?>
                                                            <div class="text-danger"><?php echo $error_image_popup; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_product_width" value="<?php echo $phpner_store_image_product_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-product-width" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_product_height" value="<?php echo $phpner_store_image_product_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_product) { ?>
                                                            <div class="text-danger"><?php echo $error_image_product; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_additional_width" value="<?php echo $phpner_store_image_additional_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-additional-width" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_additional_height" value="<?php echo $phpner_store_image_additional_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_additional) { ?>
                                                            <div class="text-danger"><?php echo $error_image_additional; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-related"><?php echo $entry_image_related; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_related_width" value="<?php echo $phpner_store_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-related" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_related_height" value="<?php echo $phpner_store_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_related) { ?>
                                                            <div class="text-danger"><?php echo $error_image_related; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_compare_width" value="<?php echo $phpner_store_image_compare_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-compare" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_compare_height" value="<?php echo $phpner_store_image_compare_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_compare) { ?>
                                                            <div class="text-danger"><?php echo $error_image_compare; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_wishlist_width" value="<?php echo $phpner_store_image_wishlist_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wishlist" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_wishlist_height" value="<?php echo $phpner_store_image_wishlist_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_wishlist) { ?>
                                                            <div class="text-danger"><?php echo $error_image_wishlist; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_cart_width" value="<?php echo $phpner_store_image_cart_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_cart_height" value="<?php echo $phpner_store_image_cart_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_cart) { ?>
                                                            <div class="text-danger"><?php echo $error_image_cart; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <label class="col-sm-3 control-label" for="input-image-location"><?php echo $entry_image_location; ?></label>
                                                    <div class="col-sm-9">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_location_width" value="<?php echo $phpner_store_image_location_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input type="text" name="phpner_store_image_location_height" value="<?php echo $phpner_store_image_location_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <?php if ($error_image_location) { ?>
                                                            <div class="text-danger"><?php echo $error_image_location; ?></div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
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
    <script type="text/javascript" src="view/javascript/phpner_store/spectrum.js"></script>
    <script>
        $(".spectrum").spectrum({
            preferredFormat: "rgb",
            showInitial: true,
            showInput: true,
            showAlpha: true,
            showPalette: true,
            palette: [["red", "rgba(0, 255, 0, .5)", "rgb(0, 0, 255)"]]
        });
    </script>
    <script type="text/javascript"><!--
        $("ul.nav-tabs a").click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
        <?php foreach ($languages as $language) { ?>
        <?php if ($ckeditor) { ?>
        ckeditorInit('pr_additional_tab_text-<?php echo $language['code']; ?>', '<?php echo $token; ?>');
        <?php } else { ?>
        $('#pr_additional_tab_text-<?php echo $language['code']; ?>').summernote({height: 300, lang:'<?php echo $lang; ?>'});
        <?php } ?>
        <?php } ?>
        //--></script>
    <script type="text/javascript"><!--
        var pr_garantedtext_row = <?php echo $pr_garantedtext_row; ?>;

        function addPr_garantedtext() {
            html  = '<tr id="pr_garantedtext-row' + pr_garantedtext_row + '">';
            html += '  <td>';
            html += '    <span data-toggle="tooltip" title="<?php echo $text_pr_garantedtext_get_icons; ?>" class="btn btn-default" onclick="font_icons(' + pr_garantedtext_row + ', 1);"><i class="fa fa-info-circle" id="pr_garantedtext_icon-' + pr_garantedtext_row + '"></i></span>';
            html += '    <input id="pr_garantedtext_icon-input-' + pr_garantedtext_row + '" type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][' + pr_garantedtext_row + '][icon]" value="fa fa-info-circle" />';
            html += '  </td>';
            html += '  <td>';
            html += '    <div class="row">';
            html += '      <div class="col-sm-6">';
            <?php foreach ($languages as $language) { ?>
            html += '        <div class="input-group">';
            html += '          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>';
            html += '          <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][' + pr_garantedtext_row + '][description][<?php echo $language['code']; ?>][name]" value="" placeholder="<?php echo $text_pr_garantedtext_placeholder_name; ?>" />';
            html += '        </div>';
            <?php } ?>
            html += '      </div>';
            html += '      <div class="col-sm-6">';
            <?php foreach ($languages as $language) { ?>
            html += '        <div class="input-group">';
            html += '          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>';
            html += '          <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][' + pr_garantedtext_row + '][description][<?php echo $language['code']; ?>][link]" value="" placeholder="<?php echo $text_pr_garantedtext_placeholder_link; ?>" />';
            html += '        </div>';
            <?php } ?>
            html += '      </div>';
            html += '    </div>';
            <?php if ($informations) { ?>
            html += '    <div class="row" style="margin-top: 7px;">';
            html += '      <div class="col-sm-12">';
            html += '        <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#collapse-info-link-' + pr_garantedtext_row + '" aria-expanded="false" aria-controls="collapse-info-link-' + pr_garantedtext_row + '"><?php echo $text_pr_garantedtext_get_information; ?></button>';
            html += '        <div class="collapse" id="collapse-info-link-' + pr_garantedtext_row + '">';
            html += '          <div class="well">';
            <?php foreach ($informations as $information) { ?>
            html += '            <a onclick="$(this).parent().parent().parent().parent().prev().find(\'[name*=name]\').val(\'<?php echo $information['title']; ?>\');$(this).parent().parent().parent().parent().prev().find(\'[name*=link]\').val(\'<?php echo $information['href']; ?>\');"><?php echo $information['title']; ?></a>';
            html += '            <br/>';
            <?php } ?>
            html += '          </div>';
            html += '        </div>';
            html += '      </div>';
            html += '    </div>';
            <?php } ?>
            html += '  </td>';
            html += '  <td>';
            html += '    <div class="btn-group" data-toggle="buttons">';
            html += '      <label class="btn btn-info active">';
            html += '        <input type="radio"';
            html += '          name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][' + pr_garantedtext_row + '][popup]"';
            html += '          value="on"';
            html += '          autocomplete="off"';
            html += '          style="display: none;"';
            html += '          checked="checked"';
            html += '        /><?php echo $text_yes; ?>';
            html += '      </label>';
            html += '      <label class="btn btn-info">';
            html += '        <input type="radio"';
            html += '          name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[pr_garantedtext][' + pr_garantedtext_row + '][popup]"';
            html += '          value="off"';
            html += '          autocomplete="off"';
            html += '          style="display: none;"';
            html += '        /><?php echo $text_no; ?>';
            html += '      </label>';
            html += '    </div>';
            html += '  </td>';
            html += '  <td><button type="button" onclick="$(\'#pr_garantedtext-row' + pr_garantedtext_row  + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_delete; ?></button></td>';
            html += '</tr>';

            $('#pr_garantedtext tbody').append(html);

            pr_garantedtext_row++;
        }
        //--></script>
    <script type="text/javascript"><!--
        var foot_garantedtext_row = <?php echo $foot_garantedtext_row; ?>;

        function addFoot_garantedtext() {
            html  = '<tr id="foot_garantedtext-row' + foot_garantedtext_row + '">';
            html += '  <td>';
            html += '    <span data-toggle="tooltip" title="<?php echo $text_foot_garantedtext_get_icons; ?>" class="btn btn-default" onclick="font_icons(' + foot_garantedtext_row + ', 2);"><i class="fa fa-info-circle" id="foot_garantedtext_icon-' + foot_garantedtext_row + '"></i></span>';
            html += '    <input id="foot_garantedtext_icon-input-' + foot_garantedtext_row + '" type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][' + foot_garantedtext_row + '][icon]" value="fa fa-info-circle" />';
            html += '  </td>';
            html += '  <td>';
            html += '    <div class="row">';
            html += '      <div class="col-sm-6">';
            <?php foreach ($languages as $language) { ?>
            html += '        <div class="input-group">';
            html += '          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>';
            html += '          <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][' + foot_garantedtext_row + '][description][<?php echo $language['code']; ?>][name]" value="" placeholder="<?php echo $text_foot_garantedtext_placeholder_name; ?>" />';
            html += '        </div>';
            <?php } ?>
            html += '      </div>';
            html += '      <div class="col-sm-6">';
            <?php foreach ($languages as $language) { ?>
            html += '        <div class="input-group">';
            html += '          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>';
            html += '          <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][' + foot_garantedtext_row + '][description][<?php echo $language['code']; ?>][link]" value="" placeholder="<?php echo $text_foot_garantedtext_placeholder_link; ?>" />';
            html += '        </div>';
            <?php } ?>
            html += '      </div>';
            html += '    </div>';
            <?php if ($informations) { ?>
            html += '    <div class="row" style="margin-top: 7px;">';
            html += '      <div class="col-sm-12">';
            html += '        <button class="btn btn-primary btn-sm" type="button" data-toggle="collapse" data-target="#foot-collapse-info-link-' + foot_garantedtext_row + '" aria-expanded="false" aria-controls="foot-collapse-info-link-' + foot_garantedtext_row + '"><?php echo $text_foot_garantedtext_get_information; ?></button>';
            html += '        <div class="collapse" id="foot-collapse-info-link-' + foot_garantedtext_row + '">';
            html += '          <div class="well">';
            <?php foreach ($informations as $information) { ?>
            html += '            <a onclick="$(this).parent().parent().parent().parent().prev().find(\'[name*=name]\').val(\'<?php echo $information['title']; ?>\');$(this).parent().parent().parent().parent().prev().find(\'[name*=link]\').val(\'<?php echo $information['href']; ?>\');"><?php echo $information['title']; ?></a>';
            html += '            <br/>';
            <?php } ?>
            html += '          </div>';
            html += '        </div>';
            html += '      </div>';
            html += '    </div>';
            <?php } ?>
            html += '  </td>';
            html += '  <td>';
            html += '    <div class="btn-group" data-toggle="buttons">';
            html += '      <label class="btn btn-info active">';
            html += '        <input type="radio"';
            html += '          name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][' + foot_garantedtext_row + '][popup]"';
            html += '          value="on"';
            html += '          autocomplete="off"';
            html += '          style="display: none;"';
            html += '          checked="checked"';
            html += '        /><?php echo $text_yes; ?>';
            html += '      </label>';
            html += '      <label class="btn btn-info">';
            html += '        <input type="radio"';
            html += '          name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][' + foot_garantedtext_row + '][popup]"';
            html += '          value="off"';
            html += '          autocomplete="off"';
            html += '          style="display: none;"';
            html += '        /><?php echo $text_no; ?>';
            html += '      </label>';
            html += '    </div>';
            html += '  </td>';
            html += '  <td>';
            html += '   <div class="row">';
            html += '      <div class="col-sm-12">';
            <?php foreach ($languages as $language) { ?>
            html += '        <div class="input-group">';
            html += '          <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>';
            html += '          <input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[foot_garantedtext][' + foot_garantedtext_row + '][description][<?php echo $language['code']; ?>][text]" value="" placeholder="<?php echo $text_foot_garantedtext_placeholder_text; ?>" />';
            html += '        </div>';
            <?php } ?>
            html += '      </div>';
            html += '    </div>';
            html += '  </td>';
            html += '  <td><button type="button" onclick="$(\'#foot_garantedtext-row' + foot_garantedtext_row  + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_delete; ?></button></td>';
            html += '</tr>';

            $('#foot_garantedtext tbody').append(html);

            foot_garantedtext_row++;
        }
        //--></script>
    <script type="text/javascript"><!--
        function font_icons(block_id, type) {
            $.ajax({
                url: 'index.php?route=extension/theme/phpner_store/get_icons&token=<?php echo $token; ?>',
                type: 'get',
                dataType: 'html',
                success: function(data) {
                    html  = '<div id="modal-icons" class="modal">';
                    html += '  <div class="modal-dialog">';
                    html += '    <div class="modal-content">';
                    html += '      <div class="modal-header">';
                    html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
                    html += '        <h4 class="modal-title">Font Awesome Icons</h4>';
                    html += '      </div>';
                    html += '      <div class="modal-body"></div>';
                    html += '    </div';
                    html += '  </div>';
                    html += '</div>';

                    $('body').append(html);

                    $('#modal-icons .modal-body').load('index.php?route=extension/theme/phpner_store/get_icons&token=<?php echo $token; ?>&block_id=' + block_id + '&type=' + type);

                    $('#modal-icons').modal('show');
                }
            });
        }
        //--></script>
    <script type="text/javascript"><!--
        var ps_additional_icon_row = <?php echo $ps_additional_icon_row; ?>;

        function addPsAdditionalIcon() {
            html  = '<tr id="ps-additional-icon-row' + ps_additional_icon_row + '">';
            html += '  <td class="text-left"><a href="" id="thumb-image' + ps_additional_icon_row + '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_additional_icons][' + ps_additional_icon_row + '][image]" value="" id="input-image' + ps_additional_icon_row + '" /></td>';
            html += '  <td class="text-right"><input type="text" name="k4a4s474x55444b4o4x5m4k4m5h5b4a4m434[ps_additional_icons][' + ps_additional_icon_row + '][sort_order]" value="0" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
            html += '  <td class="text-left"><button type="button" onclick="$(\'#ps-additional-icon-row' + ps_additional_icon_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
            html += '</tr>';

            $('#ps-additional-icons tbody').append(html);

            ps_additional_icon_row++;
        }
        //--></script>
<?php echo $footer; ?>