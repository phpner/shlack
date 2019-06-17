<?php

class ControllerExtensionThemePhpnerStore extends Controller
{
    private $error = array(  );

     public function index()
    {
        $data = array(  );
        $this->load->model("extension/extension");
        $this->load->model("setting/setting");
        if( !in_array("phpner_store", $this->model_extension_extension->getInstalled("theme")) )
        {
            $this->response->redirect($this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true));
        }

        $data = array_merge($data, $this->load->language("extension/theme/phpner"));
        $this->document->setTitle($this->language->get("heading_title_sub"));
        if( isset($this->request->get["store_id"]) )
        {
            $store_id = $this->request->get["store_id"];
        }
        else
        {
            $store_id = 0;
        }


        if( isset($this->session->data["success"]) )
        {
            $data["success"] = $this->session->data["success"];
            unset($this->session->data["success"]);
        }
        else
        {
            $data["success"] = "";
        }

        if( isset($this->session->data["warning"]) )
        {
            $data["warning"] = $this->session->data["warning"];
            unset($this->session->data["warning"]);
        }
        else
        {
            $data["warning"] = "";
        }

        $data["error_warning"] = (isset($this->error["warning"]) ? $this->error["warning"] : "");
        $data["error_verification"] = (isset($this->error["verification"]) ? $this->error["verification"] : "");
        $this->document->addStyle("view/stylesheet/phpner.css");
        $data["breadcrumbs"] = array(  );
        $data["breadcrumbs"][] = array( "text" => $this->language->get("text_home"), "href" => $this->url->link("common/dashboard", "token=" . $this->session->data["token"], true) );
        $data["breadcrumbs"][] = array( "text" => $this->language->get("text_module"), "href" => $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true) );
        $data["breadcrumbs"][] = array( "text" => $this->language->get("heading_title"), "href" => $this->url->link("extension/theme/phpner", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true) );
        $data["action"] = $this->url->link("extension/theme/phpner", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true);
        $data["cancel"] = $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true);

        $this->response->redirect($this->url->link("extension/theme/phpner_store/main", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true));


    }

    public function day_format($n, $form1, $form2, $form3)
    {
        $n = abs($n) % 100;
        $n1 = $n % 10;
        if( 10 < $n && $n < 20 )
        {
            return $form3;
        }

        if( 1 < $n1 && $n1 < 5 )
        {
            return $form2;
        }

        if( $n1 == 1 )
        {
            return $form1;
        }

        return $form3;
    }

    public function main()
    {
        $data = array(  );
        $this->load->model("extension/extension");
        $this->load->model("setting/setting");
        $this->load->model("tool/image");
        if( !in_array("phpner_store", $this->model_extension_extension->getInstalled("theme")) )
        {
            $this->response->redirect($this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true));
        }

        $data = array_merge($data, $this->load->language("extension/theme/phpner_store"));
        $this->document->setTitle($this->language->get("heading_title_sub"));
        $this->document->addStyle("view/stylesheet/spectrum.css");
        if( $this->config->get("config_editor_default") )
        {
            $this->document->addScript("view/javascript/ckeditor/ckeditor.js");
            $this->document->addScript("view/javascript/ckeditor/ckeditor_init.js");

        }
        else
        {
            $this->document->addScript("view/javascript/summernote/summernote.js");
            $this->document->addScript("view/javascript/summernote/lang/summernote-" . $this->language->get("lang") . ".js");
            $this->document->addScript("view/javascript/summernote/opencart.js");
            $this->document->addStyle("view/javascript/summernote/summernote.css");
        }

        $data["ckeditor"] = $this->config->get("config_editor_default");
        if( isset($this->request->get["store_id"]) )
        {
            $store_id = $this->request->get["store_id"];
        }
        else
        {
            $store_id = 0;
        }

        if( $this->request->server["REQUEST_METHOD"] == "POST" && $this->validate() )
        {

            $post = $this->request->post;

            $curl_data['phpner_store_data'] = $post['k4a4s474x55444b4o4x5m4k4m5h5b4a4m434'];

            unset($post['k4a4s474x55444b4o4x5m4k4m5h5b4a4m434']);

            $curl_data =  array_merge($post, $curl_data);


            $this->model_setting_setting->editSetting("phpner_store", $curl_data, $store_id);

            $this->session->data["success"] = $this->language->get("text_success");
            $this->style_generate();

            if( isset($this->request->post["actionstay"]) && $this->request->post["actionstay"] == 1 )
            {
                $this->response->redirect($this->url->link("extension/theme/phpner_store/main", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true));
            }
            else
            {
                $this->response->redirect($this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true));
            }

        }

        if( isset($this->session->data["success"]) )
        {
            $data["success"] = $this->session->data["success"];
            unset($this->session->data["success"]);
        }
        else
        {
            $data["success"] = "";
        }

        if( isset($this->session->data["warning"]) )
        {
            $data["warning"] = $this->session->data["warning"];
            unset($this->session->data["warning"]);
        }
        else
        {
            $data["warning"] = "";
        }

        $data["token"] = $this->session->data["token"];
        $data["error_warning"] = (isset($this->error["warning"]) ? $this->error["warning"] : "");
        $data["error_product_limit"] = (isset($this->error["phpner_store_product_limit"]) ? $this->error["phpner_store_product_limit"] : "");
        $data["error_product_description_length"] = (isset($this->error["phpner_store_product_description_length"]) ? $this->error["phpner_store_product_description_length"] : "");
        $data["error_image_category"] = (isset($this->error["phpner_store_image_category"]) ? $this->error["phpner_store_image_category"] : "");
        $data["error_image_thumb"] = (isset($this->error["phpner_store_image_thumb"]) ? $this->error["phpner_store_image_thumb"] : "");
        $data["error_image_popup"] = (isset($this->error["phpner_store_image_popup"]) ? $this->error["phpner_store_image_popup"] : "");
        $data["error_image_product"] = (isset($this->error["phpner_store_image_product"]) ? $this->error["phpner_store_image_product"] : "");
        $data["error_image_additional"] = (isset($this->error["phpner_store_image_additional"]) ? $this->error["phpner_store_image_additional"] : "");
        $data["error_image_related"] = (isset($this->error["phpner_store_image_related"]) ? $this->error["phpner_store_image_related"] : "");
        $data["error_image_compare"] = (isset($this->error["phpner_store_image_compare"]) ? $this->error["phpner_store_image_compare"] : "");
        $data["error_image_wishlist"] = (isset($this->error["phpner_store_image_wishlist"]) ? $this->error["phpner_store_image_wishlist"] : "");
        $data["error_image_cart"] = (isset($this->error["phpner_store_image_cart"]) ? $this->error["phpner_store_image_cart"] : "");
        $data["error_image_location"] = (isset($this->error["phpner_store_image_location"]) ? $this->error["phpner_store_image_location"] : "");
        $this->document->addStyle("view/stylesheet/phpner_store.css");
        $data["breadcrumbs"] = array(  );
        $data["breadcrumbs"][] = array( "text" => $this->language->get("text_home"), "href" => $this->url->link("common/dashboard", "token=" . $this->session->data["token"], true) );
        $data["breadcrumbs"][] = array( "text" => $this->language->get("text_module"), "href" => $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true) );
        $data["breadcrumbs"][] = array( "text" => $this->language->get("heading_title"), "href" => $this->url->link("extension/theme/phpner_store/main", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true) );
        $data["action"] = $this->url->link("extension/theme/phpner_store/main", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true);
        $data["cache"] = $this->url->link("extension/theme/phpner_store/cache", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true);
        $data["cancel"] = $this->url->link("extension/extension", "token=" . $this->session->data["token"] . "&type=theme", true);
        if( $this->request->server["REQUEST_METHOD"] != "POST" )
        {
            $phpner_store_status = $this->model_setting_setting->getSetting("phpner_store", $store_id);

        }


        if( isset($this->request->post["phpner_store_status"]) )
        {
            $data["value_001"] = $this->request->post["phpner_store_status"];
        }
        else
        {
            $data["value_001"] = $phpner_store_status['phpner_store_status'];

        }

        if( isset($this->request->post["k4a4s474x55444b4o4x5m4k4m5h5b4a4m434"]) )
        {
            $data["value_002"] = $this->request->post["k4a4s474x55444b4o4x5m4k4m5h5b4a4m434"];
        } else
        {

            $data["value_002"] = $this->model_setting_setting->getSetting("phpner_store", $store_id);
            $data["value_002"] = $data["value_002"]['phpner_store_data'];
        }

        $config_data = array( "phpner_store_product_limit", "phpner_store_product_description_length", "phpner_store_image_category_width", "phpner_store_image_category_height", "phpner_store_image_thumb_width", "phpner_store_image_thumb_height", "phpner_store_image_popup_width", "phpner_store_image_popup_height", "phpner_store_image_product_width", "phpner_store_image_product_height", "phpner_store_image_additional_width", "phpner_store_image_additional_height", "phpner_store_image_related_width", "phpner_store_image_related_height", "phpner_store_image_compare_width", "phpner_store_image_compare_height", "phpner_store_image_wishlist_width", "phpner_store_image_wishlist_height", "phpner_store_image_cart_width", "phpner_store_image_cart_height", "phpner_store_image_location_width", "phpner_store_image_location_height" );
        foreach( $config_data as $conf )
        {
            if( isset($this->request->post[$conf]) )
            {
                $data[$conf] = $this->request->post[$conf];
            }
            else
            {
                $data[$conf] = $this->config->get($conf);
            }

        }
        $this->load->model("catalog/information");
        $data["informations"] = array(  );
        foreach( $this->model_catalog_information->getInformations() as $information )
        {
            $data["informations"][] = array( "information_id" => $information["information_id"], "title" => $information["title"], "href" => "index.php?route=information/information&information_id=" . $information["information_id"] );
        }
        $this->load->model("catalog/category");
        $data["categories"] = array(  );
        foreach( $this->model_catalog_category->getCategories(array( "sort" => "name", "order" => "ASC" )) as $category )
        {
            $data["categories"][] = array( "category_id" => $category["category_id"], "name" => $category["name"] );
        }
        $this->load->model("localisation/language");
        $data["languages"] = $this->model_localisation_language->getLanguages();
        $data["placeholder"] = $this->model_tool_image->resize("no_image.png", 50, 50);
        if( isset($this->request->post["ps_additional_icons"]) )
        {
            $ps_additional_icons = $this->request->post["ps_additional_icons"];
        }
        else
        {
            if( isset($data["value_002"]["ps_additional_icons"]) )
            {
                $ps_additional_icons = $data["value_002"]["ps_additional_icons"];
            }
            else
            {
                $ps_additional_icons = array(  );
            }

        }

        $data["ps_additional_icons"] = array(  );
        foreach( $ps_additional_icons as $ps_additional_icon )
        {
            if( is_file(DIR_IMAGE . $ps_additional_icon["image"]) )
            {
                $image = $ps_additional_icon["image"];
                $thumb = $ps_additional_icon["image"];
            }
            else
            {
                $image = "";
                $thumb = "no_image.png";
            }

            $data["ps_additional_icons"][] = array( "image" => $image, "thumb" => $this->model_tool_image->resize($thumb, 50, 50), "sort_order" => ($ps_additional_icon["sort_order"] ? $ps_additional_icon["sort_order"] : 0) );
        }
        $data["header"] = $this->load->controller("common/header");
        $data["column_left"] = $this->load->controller("common/column_left");
        $data["footer"] = $this->load->controller("common/footer");

        $this->response->setOutput($this->load->view("extension/theme/phpner_store", $data));
    }

    public function cache()
    {
        $this->load->language("extension/theme/phpner");
        $this->cache->delete("phpner");
        $this->style_generate();
        if( file_exists(DIR_CATALOG . "view/theme/phpner_store/stylesheet/stylesheet_minify.css") )
        {
            unlink(DIR_CATALOG . "view/theme/phpner_store/stylesheet/stylesheet_minify.css");
        }

        if( file_exists(DIR_CATALOG . "view/theme/phpner_store/js/javascript_minify.js") )
        {
            unlink(DIR_CATALOG . "view/theme/phpner_store/js/javascript_minify.js");
        }

        $this->session->data["success"] = $this->language->get("text_success_cache");
        if( isset($this->request->get["store_id"]) )
        {
            $store_id = $this->request->get["store_id"];
        }
        else
        {
            $store_id = 0;
        }

        $this->response->redirect($this->url->link("extension/theme/phpner_store/main", "token=" . $this->session->data["token"] . "&store_id=" . $store_id, true));
    }

    public function install()
    {
        $this->load->language("extension/theme/phpner");
        $this->load->model("extension/extension");
        $this->load->model("setting/setting");
        $this->load->model("user/user_group");
        $this->model_user_user_group->addPermission($this->user->getId(), "access", "extension/theme/phpner");
        $this->model_user_user_group->addPermission($this->user->getId(), "modify", "extension/theme/phpner");
        if( !in_array("phpner", $this->model_extension_extension->getInstalled("theme")) )
        {
            $this->model_extension_extension->install("theme", "phpner_store");


        }

        $this->style_generate();
        $this->session->data["success"] = $this->language->get("text_success_install");
    }

    public function uninstall()
    {
        $this->load->model("extension/extension");
        $this->model_extension_extension->uninstall("theme", "phpner_store");
    }

    private function validate()
    {
        if( !$this->user->hasPermission("modify", "extension/theme/phpner_store") )
        {
            $this->error["warning"] = $this->language->get("error_permission");
        }

        if( empty($this->request->post["phpner_store_product_limit"]) )
        {
            $this->error["product_limit"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_product_description_length"]) )
        {
            $this->error["product_description_length"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_category_width"]) || empty($this->request->post["phpner_store_image_category_height"]) )
        {
            $this->error["image_category"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_thumb_width"]) || empty($this->request->post["phpner_store_image_thumb_height"]) )
        {
            $this->error["image_thumb_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_popup_width"]) || empty($this->request->post["phpner_store_image_popup_height"]) )
        {
            $this->error["image_popup_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_product_width"]) || empty($this->request->post["phpner_store_image_product_height"]) )
        {
            $this->error["image_product_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_additional_width"]) || empty($this->request->post["phpner_store_image_additional_height"]) )
        {
            $this->error["image_additional"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_related_width"]) || empty($this->request->post["phpner_store_image_related_height"]) )
        {
            $this->error["image_related_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_compare_width"]) || empty($this->request->post["phpner_store_image_compare_height"]) )
        {
            $this->error["image_compare_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_wishlist_width"]) || empty($this->request->post["phpner_store_image_wishlist_height"]) )
        {
            $this->error["image_wishlist_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_cart_width"]) || empty($this->request->post["phpner_store_image_cart_height"]) )
        {
            $this->error["image_cart_width"] = $this->language->get("error_warning");
        }

        if( empty($this->request->post["phpner_store_image_location_width"]) || empty($this->request->post["phpner_store_image_location_height"]) )
        {
            $this->error["image_location_width"] = $this->language->get("error_warning");
        }

        return (!$this->error ? true : false);
    }

    public function style_generate()
    {
        $this->load->model("setting/setting");
        if( isset($this->request->get["store_id"]) )
        {
            $store_id = $this->request->get["store_id"];
        }
        else
        {
            $store_id = 0;
        }

        $form_data = $this->model_setting_setting->getSetting("phpner_store", $store_id);
        $form_data =  $form_data['phpner_store_data'];

        $styles = "";
        if( $form_data )
        {
            if( $form_data["maincolor1"] )
            {
                $styles .= "#top, .phpner_-product-tab .owl-carousel .owl-item .cart .phpner_-button.wishlist, .phpner_-product-tab .owl-carousel .owl-item .cart .phpner_-button.compare, .phpner_-carousel-row .owl-carousel .owl-item .cart .phpner_-button.wishlist, .phpner_-carousel-row .owl-carousel .owl-item .cart .phpner_-button.compare, .product-thumb .cart .phpner_-button.wishlist, .product-thumb .cart .phpner_-button.compare, .phpner_-day-goods-box .owl-carousel .owl-item .things-to-buy, .phpner_-product-tab ul.nav-tabs > li.active, .phpner_-product-tab ul.nav-tabs > li:hover, #back-top:hover, #uptocall-mini:hover .uptocall-mini-phone, .field-tip .tip-content, footer, .filtered input[type=checkbox]:checked+label::before, .filtered input[type=radio]:checked+label::before, #sstore-3-level>ul>li>a, .product-buttons-row .button-one-click, .product-buttons-row .button-wishlist, .product-buttons-row .button-compare, .product-tabs-row .nav-tabs>li.active>a, .product-tabs-row .nav-tabs>li.active>a:focus, .product-tabs-row .nav-tabs>li.active>a:hover, footer .actions button:hover, .popup-button:hover, #column-left .list-group, #column-right .list-group, .phpner_-news-panel .list-group {\n";
                $styles .= "\tbackground-color: #" . $form_data["maincolor1"] . ";\n";
                $styles .= "}\n";
                $styles .= ".phpner_-button:hover, .phpner_-button-inv {\n";
                $styles .= "\tbackground-color: #" . $form_data["maincolor1"] . " !important;\n";
                $styles .= "}\n";
                $styles .= "a, #search .btn-lg, .phones-dropdown a, #menu .nav > li > a, .phpner_-carousel-header, .phpner_-category-item-text ul li a, .phpner_-category-item-text ul li a:visited, .phpner_-category-item-text ul li.phpner_-category-see-more a:hover, .phpner_-product-tab .owl-carousel .owl-item .name a, .phpner_-carousel-row .owl-carousel .owl-item .name a, .phpner_-day-goods-box .owl-carousel .owl-wrapper-outer .item .phpner_-day-goods-item .name a, .news-carousel-box .owl-carousel .owl-wrapper-outer .item .phpner_-news-item .name a, .phpner_-product-tab .owl-carousel .owl-buttons div, .phpner_-carousel-row .owl-carousel .owl-buttons div, .phpner_-day-goods-box .owl-carousel .owl-buttons div, .news-carousel-box .owl-carousel .owl-buttons div, .brands-carousel-box .owl-carousel .owl-buttons div, .news-carousel-box .owl-carousel .owl-wrapper-outer .item .phpner_-news-item .news-date, .news-carousel-box .owl-carousel .owl-wrapper-outer .item .phpner_-news-item .news-date span, .breadcrumb > li a, h1.cat-header, .sort-row .input-group-addon, .appearance .btn-group button, .box-heading, a.list-group-item, button.list-group-item, input[type='text'].form-control, select.form-control, input[type='password'].form-control, .filtered .link i, .filtered .checkbox input[type=checkbox]+label, .filtered .checkbox-inline input[type=checkbox]+label, .filtered .radio input[type=radio]+label, .filtered .radio-inline input[type=radio]+label, #sstore-3-level ul ul ul li a, .product-thumb h4 a, .pagination>.active>a, .pagination>.active>a:focus, .pagination>.active>a:hover, .pagination>.active>span, .pagination>.active>span:focus, .pagination>.active>span:hover, .pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus, .pagination>li>span:hover, .product-header, .after-header-item, .found-cheaper a, .found-cheaper a:visited, .product-price h3, .number .btn-minus button i, .number .btn-plus button i, .product-info-li span, .product-info-li a, .product-info-li a:visited, .product-advantages-box a span, h2.popup-header, .popup-form-box input[type='text'], .popup-form-box input[type='tel'], .popup-form-box input[type='email'], #auth-popup .auth-popup-links a.reg-popup-link, .popup-text, .popup-text a, #product .control-label, .popup-form-box textarea, .phpner_-bottom-cart-in-cart p, .account-content .buttons div .button-back, .account-content .table-div table .button-back, .popup-text a:hover, .phpner_-carousel-header a:hover, #column-left .panel-default>.panel-heading, .phpner_-news-panel>.panel-heading, #column-right .panel-default>.panel-heading, #oneclick-popup #main-price {\n";
                $styles .= " color: #" . $form_data["maincolor1"] . ";\n";
                $styles .= "}\n";
                $styles .= "#menu .nav > li:hover, .phpner_-slideshow-box .owl-controls .owl-page span {\n";
                $styles .= "\tborder-color: #" . $form_data["maincolor1"] . ";\n";
                $styles .= "}\n";
                $styles .= "#filter-products-form .expanded .item-content .filter-results:hover .filter-tooltip-corner {\n";
                $styles .= "\tborder-right-color: #" . $form_data["maincolor1"] . ";\n";
                $styles .= "}\n";
                $styles .= ".product-tabs-row .nav-tabs>li.active>a:before {\n";
                $styles .= "\tborder-top-color: #" . $form_data["maincolor1"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["maincolor2"] )
            {
                $styles .= "#menu .nav > li:hover, #menu ul.flexMenu-popup > li:hover, .phpner_-button, .phpner_-button:visited, .phpner_-button:focus, #back-top, #uptocall-mini .uptocall-mini-phone, .phpner_-day-goods-box .owl-carousel .owl-wrapper-outer .item .phpner_-day-goods-item:hover .things-to-buy, .phpner_-day-goods-box .owl-carousel .owl-wrapper-outer .item .phpner_-day-goods-item:hover .things-to-buy .flip-clock-wrapper ul li a div div.inn, footer .actions button, #sstore-3-level ul>li.has-sub>a.toggle-a:before, #sstore-3-level ul>li.has-sub>a.toggle-a:after, .product-tabs-row .nav-tabs>li>a, ul.account-ul li a:hover, .popup-button, .phpner_-fastorder-header span, #column-left .panel-default>.panel-heading, #column-right .panel-default>.panel-heading, .phpner_-news-panel>.panel-heading, #column-left .list-group a.active, #column-left .list-group a.active:hover, #column-left .list-group a:hover, #column-right .list-group a.active, #column-right .list-group a.active:hover, #column-right .list-group a:hover, .phpner_-news-panel .list-group a.active, .phpner_-news-panel .list-group a.active:hover, .phpner_-news-panel .list-group a:hover{\n";
                $styles .= "\tbackground-color: #" . $form_data["maincolor2"] . ";\n";
                $styles .= "}\n";
                $styles .= ".product-thumb .cart .phpner_-button.wishlist:hover, .product-thumb .cart .phpner_-button.compare:hover, .product-buttons-row .button-wishlist:hover, .product-buttons-row .button-compare:hover, .button-one-click:hover, .wishlist-tr, .phpner_-product-tab .owl-carousel .owl-item .cart .phpner_-button.wishlist:hover, .phpner_-product-tab .owl-carousel .owl-item .cart .phpner_-button.compare:hover, .phpner_-carousel-row .owl-carousel .owl-item .cart .phpner_-button.wishlist:hover, .phpner_-carousel-row .owl-carousel .owl-item .cart .phpner_-button.compare:hover, .product-thumb .cart .phpner_-button.wishlist:hover, .product-thumb .cart .phpner_-button.compare:hover, .phpner_-button-inv:hover  {\n";
                $styles .= "\tbackground-color: #" . $form_data["maincolor2"] . "!important;\n";
                $styles .= "}\n";
                $styles .= "#top .btn-link.btn-language:hover, #top .btn-link.btn-currency:hover, #top #top-right-links .dropdown-menu li a:hover, header .dropdown-menu li a:hover, #cart .cart-total-price, .buttons-top-box div a:hover, #menu .sale-ul > div .megamenu-sale-item .dropprice, .phpner_-slideshow-box .owl-controls .owl-buttons div:hover, .phpner_-category-item-text ul li.phpner_-category-see-more a, .phpner_-product-tab .owl-carousel .owl-item .price .price-new, .phpner_-carousel-row .owl-carousel .owl-item .price .price-new, .phpner_-day-goods-box .owl-carousel .owl-item .price .price-new, .phpner_-product-tab .owl-carousel .owl-buttons div:hover, .phpner_-carousel-row .owl-carousel .owl-buttons div:hover, .phpner_-day-goods-box .owl-carousel .owl-buttons div:hover, .news-carousel-box .owl-carousel .owl-buttons div:hover, .brands-carousel-box .owl-carousel .owl-buttons div:hover, footer h5, footer .h5, footer .first-row .socials-box a:hover, footer a:hover, footer .footer-contacts ul li i, .breadcrumb > li span, .appearance .btn-group button.active, .appearance .btn-group button:hover, .product-list .product-thumb h4 a:hover, .rating .fa-star, .rating .fa-star + .fa-star-o, .phpner_-product-stock span, .pagination>li:first-child>a, .pagination>li:first-child>span, .pagination>li>a, .pagination>li>span, .after-header-item .blue, .product-price h2, .number .btn-minus button:hover i, .number .btn-plus button:hover i, .product-advantages-box i, ul.account-ul li a, .account-content form legend, .account-content h2, .account-content .buttons div .button-back:hover, .account-content .table-div table .button-back:hover, .popup-text .item-link, .popup-text .blue, #product-options-popup .blue, #auth-popup .auth-popup-links a.forget-popup-link, #main-price, #cheaper-popup .main-price, .popup-text a, .phpner_-product-tab ul.nav-tabs > li a, .phpner_-fastorder-header, #checkout-fastorder-page .table .phpner_-bottom-cart-table-text, .fastorder-panel-group .phpner_-bottom-cart-total-cart .total-text span, .phpner_-carousel-header a, .phpner_-carousel-header a:visited, .phpner-category-item-box .phpner_-category-item-text .phpner_-category-item-header, .main-advantage-item .main-advantage-item-icon i, #oneclick-popup #main-price.oneclick-main-price, .phpner_-category-item-text ul li a:hover, .breadcrumb > li a:hover, #subcats .subcat-box:hover a, #cart-popup .popup-text span {\n";
                $styles .= "\tcolor: #" . $form_data["maincolor2"] . ";\n";
                $styles .= "}\n";
                $styles .= "#top #top-right-links .dropdown-menu li a:hover, header .dropdown-menu li a:hover, #menu .megamenu-full-width a:hover, #menu .megamenu-full-width a.megamenu-parent-img:hover + a, .phpner_-product-tab .owl-carousel .owl-item .name a:hover, .phpner_-product-tab .owl-carousel .owl-item .image:hover + .name a, .phpner_-carousel-row .owl-carousel .owl-item .name a:hover, .phpner_-carousel-row .owl-carousel .owl-item .image:hover + .name a, .phpner_-day-goods-box .owl-carousel .owl-item .name a:hover, .phpner_-day-goods-box .owl-carousel .owl-item .image:hover + .name a, .news-carousel-box .owl-carousel .owl-item .name a:hover, .news-carousel-box .owl-carousel .owl-item .image:hover + .name a, #top .btn-link.language-select:hover, #top .btn-link.currency-select:hover, #menu .megamenu-full-width .see-all, footer .phpner_-text-terms a:hover, .popup-cart-box .phpner_-popup-cart-link {\n";
                $styles .= "\tcolor: #" . $form_data["maincolor2"] . "!important;\n";
                $styles .= "}\n";
                $styles .= "@media only screen and (min-width: 1024px) {\n";
                $styles .= "\t.product-grid .product-thumb:hover h4 a {\n";
                $styles .= "\t\tcolor: #" . $form_data["maincolor2"] . ";\n";
                $styles .= "\t}\n";
                $styles .= "}\n";
                $styles .= ".phpner_-slideshow-box .owl-controls .owl-page.active span, .phpner_-slideshow-box .owl-controls .owl-page span:hover, .filtered input[type=checkbox]+label::before, .filtered input[type=radio]+label::before {\n";
                $styles .= "\tborder-color: #" . $form_data["maincolor2"] . ";\n";
                $styles .= "}\n";
                $styles .= ".selected-thumb {\n";
                $styles .= "\tborder-color: #" . $form_data["maincolor2"] . "!important;\n";
                $styles .= "}\n";
                $styles .= "#top #top-left-links ul li a:hover, #top #top-right-links > ul > li:hover {\n";
                $styles .= "\tborder-bottom-color: #" . $form_data["maincolor2"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_bg_1line"] )
            {
                $styles .= "#top {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_1line_bg_1line"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_bg_main"] )
            {
                $styles .= "header, .menu-row {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_1line_bg_main"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_color_1line_link"] )
            {
                $styles .= "#top #top-left-links ul li a, #top #top-left-links ul li a:visited, #top .btn-link.btn-language, #top .btn-link.btn-currency, #top #top-right-links > ul > li a, #top #top-right-links > ul > li a:visited, #top #top-right-links > ul > li a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["head_1line_color_1line_link"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_color_1line_link_hover"] )
            {
                $styles .= "#top #top-left-links ul li a:hover, #top .btn-link.btn-language:hover, #top .btn-link.btn-currency:hover, #top #top-right-links > ul > li a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["head_1line_color_1line_link_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_bg_1line_link_hover"] )
            {
                $styles .= "#top #top-left-links ul li a:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_1line_bg_1line_link_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_bg_tine_and_account"] )
            {
                $styles .= "#top #top-right-links > ul > li {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_1line_bg_tine_and_account"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_1line_bg_underscores_hover"] )
            {
                $styles .= "#top #top-left-links ul li a:hover, #top #top-right-links > ul > li:hover {\n";
                $styles .= "\tborder-bottom-color: #" . $form_data["head_1line_bg_underscores_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_dropdown_el_bg"] )
            {
                $styles .= "#top .dropdown-menu, header .dropdown-menu {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_dropdown_el_bg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_dropdown_el_color_link"] )
            {
                $styles .= "#top .btn-link.language-select, #top .btn-link.currency-select, #top-links li, #top-links a, #top #top-right-links .dropdown-menu li span, #top #top-right-links .dropdown-menu li a, header .dropdown-menu li a {\n";
                $styles .= "\tcolor: #" . $form_data["head_dropdown_el_color_link"] . "!important;\n";
                $styles .= "}\n";
            }

            if( $form_data["head_dropdown_el_color_link_hover"] )
            {
                $styles .= "#top #form-currency .currency-select:hover, #top #form-language .language-select:hover, #top #top-right-links .dropdown-menu li a:hover, header .dropdown-menu li a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["head_dropdown_el_color_link_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_2ndline_color_tel_text"] )
            {
                $styles .= ".phones-dropdown a {\n";
                $styles .= "\tcolor: #" . $form_data["head_2ndline_color_tel_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_2ndline_color_tel_icon"] )
            {
                $styles .= ".phones-dropdown a i.fa-phone, .phones-dropdown a.show-phones {\n";
                $styles .= "\tcolor: #" . $form_data["head_2ndline_color_tel_icon"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_2ndline_bg_cart"] )
            {
                $styles .= "#cart {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_2ndline_bg_cart"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_2ndline_color_cart_text"] )
            {
                $styles .= ".buttons-top-box div a {\n";
                $styles .= "\tcolor: #" . $form_data["head_2ndline_color_cart_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_2ndline_color_cart_total"] )
            {
                $styles .= "#cart .cart-total-price {\n";
                $styles .= "\tcolor: #" . $form_data["head_2ndline_color_cart_total"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_2ndline_color_cart_text_hover"] )
            {
                $styles .= ".buttons-top-box div a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["head_2ndline_color_cart_text_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_bg_link"] )
            {
                $styles .= "#menu .nav > li:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_megamenu_bg_link"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_bg_link_underscores_hover"] )
            {
                $styles .= "#menu .nav > li:hover {\n";
                $styles .= "\tborder-color: #" . $form_data["head_megamenu_bg_link_underscores_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_color_link_text"] )
            {
                $styles .= "#menu .nav > li > a {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_color_link_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_color_link_text_hover"] )
            {
                $styles .= "#menu .nav > li:hover > a {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_color_link_text_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_el_bg"] )
            {
                $styles .= "#menu .dropdown-menu {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_megamenu_el_bg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_el_color_link"] )
            {
                $styles .= "#menu .dropdown-inner a {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_el_color_link"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_el_color_link_hover"] )
            {
                $styles .= "#menu .dropdown-menu .has-child:hover i, #menu .dropdown-menu .has-child:hover a, #menu .dropdown-menu .has-child a:hover, #menu .phpner_-mm-info .dropdown-menu .has-child a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_el_color_link_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_el_color_link_2_hover"] )
            {
                $styles .= "@media only screen and (min-width: 992px) {#menu .second-level-li.has-child:hover > a, #menu .second-level-li.has-child:hover > a:visited, #menu .phpner_-mm-info .dropdown-menu ul li.second-level-li:hover a, #menu .phpner_-mm-simplecat .dropdown-menu ul li.second-level-li:hover > a {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_el_color_link_2_hover"] . " !important;\n";
                $styles .= "}}\n";
            }

            if( $form_data["head_megamenu_el_bg_link_hover"] )
            {
                $styles .= "#menu .dropdown-menu li.second-level-li:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["head_megamenu_el_bg_link_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_el_color_price_in_specials"] )
            {
                $styles .= "#menu .sale-ul > div .megamenu-sale-item .dropprice {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_el_color_price_in_specials"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["head_megamenu_el_color_price_old_in_specials"] )
            {
                $styles .= "#menu .sale-ul > div .megamenu-sale-item .dropprice span {\n";
                $styles .= "\tcolor: #" . $form_data["head_megamenu_el_color_price_old_in_specials"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_bg_foot"] )
            {
                $styles .= "footer {\n";
                $styles .= "\tbackground-color: #" . $form_data["foot_bg_foot"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_links"] )
            {
                $styles .= "footer a, footer a:visited, footer .third-row ul li {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_links"] . " !important;\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_links_hover"] )
            {
                $styles .= "footer a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_links_hover"] . " !important;\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_guarantee_icon"] )
            {
                $styles .= "footer .footer-advantages-box .footer-advantages a, footer .footer-advantages-box .footer-advantages a:visited {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_guarantee_icon"] . " !important;\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_guarantee_icon_hover"] )
            {
                $styles .= "footer .footer-advantages-box .footer-advantages:hover a {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_guarantee_icon_hover"] . " !important;\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_guarantee_text"] )
            {
                $styles .= "footer .footer-advantages span, footer .copyright-footer {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_guarantee_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_heading_text"] )
            {
                $styles .= "footer h5, footer .h5 {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_heading_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_contact_icon"] )
            {
                $styles .= "footer .footer-contacts ul li i {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_contact_icon"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_bg_bar"] )
            {
                $styles .= "#phpner_-slide-panel .phpner_-slide-panel-heading {\n";
                $styles .= "\tbackground-color: #" . $form_data["foot_bg_bar"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_bg_bar_el_hover"] )
            {
                $styles .= "#phpner_-last-seen-link:hover, #phpner_-favorite-link:hover, #phpner_-compare-link:hover, #phpner_-bottom-cart-link:hover, .phpner_-panel-link-active, #hide-slide-panel {\n";
                $styles .= "\tbackground-color: #" . $form_data["foot_bg_bar_el_hover"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_bar_el_text"] )
            {
                $styles .= ".phpner_-panel-link, .phpner_-panel-link:focus, .phpner_-panel-link:visited {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_bar_el_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["foot_color_bar_el_text_hover"] )
            {
                $styles .= ".phpner_-panel-link:hover, .phpner_-panel-link-active a {\n";
                $styles .= "\tcolor: #" . $form_data["foot_color_bar_el_text_hover"] . "!important;\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_discountbg"] )
            {
                $styles .= ".phpner_-discount-item {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_discountbg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_discountcolor"] )
            {
                $styles .= ".phpner_-discount-item {\n";
                $styles .= "\tcolor: #" . $form_data["cat_discountcolor"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_color_price"] )
            {
                $styles .= ".product-thumb .price, .phpner_-price-normal  {\n";
                $styles .= "\tcolor: #" . $form_data["cat_color_price"] . " !important;\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_color_price_old"] )
            {
                $styles .= ".product-thumb .price-old, .phpner_-price-old  {\n";
                $styles .= "\tcolor: #" . $form_data["cat_color_price_old"] . " !important;\n";
                $styles .= "}\n";
            }

            if( isset($form_data["cat_color_price_new"]) && $form_data["cat_color_price_new"] )
            {
                $styles .= ".product-thumb .price-new, .phpner_-price-new {\n";
                $styles .= "\tcolor: #" . $form_data["cat_color_price_new"] . " !important;\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_boxtext"] )
            {
                $styles .= ".box-heading {\n";
                $styles .= "\tcolor: #" . $form_data["cat_boxtext"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_boxbg"] )
            {
                $styles .= ".box-heading {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_boxbg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_modulebg"] )
            {
                $styles .= ".box-content, .box-content.filtered {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_modulebg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_itembg"] )
            {
                $styles .= ".filtered .list-group-item.item-name, .filtered .list-group-item.item-name:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_itembg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_plusminus"] )
            {
                $styles .= ".filtered .link i {\n";
                $styles .= "\tcolor: #" . $form_data["cat_plusminus"] . "!important;\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_checkbox"] )
            {
                $styles .= ".filtered input[type=checkbox]+label::before, .filtered input[type=radio]+label::before {\n";
                $styles .= "\tborder-color: #" . $form_data["cat_checkbox"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_checkboxactive"] )
            {
                $styles .= ".filtered input[type=checkbox]:checked+label::before, .filtered input[type=radio]:checked+label::before {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_checkboxactive"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_1levelbg"] )
            {
                $styles .= "#sstore-3-level>ul>li>a {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_1levelbg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_1levelcolor"] )
            {
                $styles .= "#sstore-3-level>ul>li>a {\n";
                $styles .= "\tcolor: #" . $form_data["cat_1levelcolor"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_2levelbg"] )
            {
                $styles .= "#sstore-3-level ul ul li a {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_2levelbg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_2levelcolor"] )
            {
                $styles .= "#sstore-3-level ul ul li a {\n";
                $styles .= "\tcolor: #" . $form_data["cat_2levelcolor"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_3levelbg"] )
            {
                $styles .= "#sstore-3-level ul ul ul li a {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_3levelbg"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_3levelcolor"] )
            {
                $styles .= "#sstore-3-level ul ul ul li a {\n";
                $styles .= "\tcolor: #" . $form_data["cat_3levelcolor"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_3levelbgactive"] )
            {
                $styles .= "#sstore-3-level ul ul ul li a.current-link {\n";
                $styles .= "\tbackground-color: #" . $form_data["cat_3levelbgactive"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["cat_3leveltextactive"] )
            {
                $styles .= "#sstore-3-level ul ul ul li a.current-link {\n";
                $styles .= "\tcolor: #" . $form_data["cat_3leveltextactive"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_button_add_ro_cart"] )
            {
                $styles .= ".product-buttons-box #button-cart {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_color_button_add_ro_cart"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_button_add_ro_cart_hover"] )
            {
                $styles .= ".product-buttons-box #button-cart:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_color_button_add_ro_cart_hover"] . "!important;\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_button_other"] )
            {
                $styles .= ".product-buttons-row .button-one-click, .product-buttons-row .button-wishlist, .product-buttons-row .button-compare {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_color_button_other"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_button_other_hover"] )
            {
                $styles .= ".product-buttons-row .button-one-click:hover, .product-buttons-row .button-wishlist:hover, .product-buttons-row .button-compare:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_color_button_other_hover"] . "!important;\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_bg_block"] )
            {
                $styles .= ".number, .found-cheaper, .after-header-item {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_bg_block"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_bg_tab"] )
            {
                $styles .= ".product-tabs-row .nav-tabs>li>a {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_bg_tab"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_bg_tab_active"] )
            {
                $styles .= ".product-tabs-row .nav-tabs>li.active>a, .product-tabs-row .nav-tabs>li.active>a:focus, .product-tabs-row .nav-tabs>li.active>a:hover {\n";
                $styles .= "\tbackground-color: #" . $form_data["pr_bg_tab_active"] . ";\n";
                $styles .= "}\n";
                $styles .= ".product-tabs-row .nav-tabs>li.active>a:before {\n";
                $styles .= "\tborder-top-color: #" . $form_data["pr_bg_tab_active"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_tab_text"] )
            {
                $styles .= ".product-tabs-row .nav-tabs>li>a, .product-tabs-row .nav-tabs>li.active>a, .product-tabs-row .nav-tabs>li.active>a:focus, .product-tabs-row .nav-tabs>li.active>a:hover {\n";
                $styles .= "\tcolor: #" . $form_data["pr_color_tab_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_image_border"] )
            {
                $styles .= ".selected-thumb {\n";
                $styles .= "\tborder-color: #" . $form_data["pr_color_image_border"] . "!important;\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_guarantee_icon"] )
            {
                $styles .= ".product-advantages-box i {\n";
                $styles .= "\tcolor: #" . $form_data["pr_color_guarantee_icon"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_guarantee_text"] )
            {
                $styles .= ".product-advantages-box a span {\n";
                $styles .= "\tcolor: #" . $form_data["pr_color_guarantee_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_guarantee_text"] )
            {
                $styles .= ".product-advantages-box a span {\n";
                $styles .= "\tcolor: #" . $form_data["pr_color_guarantee_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_block_under_heading_text"] )
            {
                $styles .= ".after-header-item {\n";
                $styles .= "\tcolor: #" . $form_data["pr_color_block_under_heading_text"] . ";\n";
                $styles .= "}\n";
            }

            if( $form_data["pr_color_block_under_heading_text"] )
            {
                $styles .= ".after-header-item .blue {\n";
                $styles .= "\tcolor: #" . $form_data["pr_color_block_under_heading_text"] . ";\n";
                $styles .= "}\n";
            }

            $styles .= "@media only screen and (max-width: 992px) {\n";
            if( $form_data["mob_mainlinebg"] )
            {
                $styles .= " #top {\n";
                $styles .= "\t background-color: #" . $form_data["mob_mainlinebg"] . " !important;\n";
                $styles .= " }\n";
            }

            if( $form_data["mod_mainline_iconcolor"] )
            {
                $styles .= " .top-mobile-item a {\n";
                $styles .= "\t color: #" . $form_data["mod_mainline_iconcolor"] . ";\n";
                $styles .= " }\n";
            }

            if( $form_data["mod_dropdown_headingbg"] )
            {
                $styles .= " .menu-mobile-header {\n";
                $styles .= "\t background-color: #" . $form_data["mod_dropdown_headingbg"] . ";\n";
                $styles .= " }\n";
            }

            if( $form_data["mod_dropdown_heading_and_buttoncolor"] )
            {
                $styles .= " .menu-mobile-header, .close-m-search a {\n";
                $styles .= "\t color: #" . $form_data["mod_dropdown_heading_and_buttoncolor"] . " !important;\n";
                $styles .= " }\n";
            }

            if( $form_data["mod_dropdown_linktextcolor"] )
            {
                $styles .= " #info-mobile-box ul li a, #info-mobile-box > ul > li, #info-mobile ul div .btn-link.btn-language, #info-mobile ul div .btn-link.btn-currency {\n";
                $styles .= "\t color: #" . $form_data["mod_dropdown_linktextcolor"] . " !important;\n";
                $styles .= " }\n";
            }

            if( $form_data["mod_header_iconrcolor"] )
            {
                $styles .= " .mobile-icons-box a {\n";
                $styles .= "\t color: #" . $form_data["mod_header_iconrcolor"] . " !important;\n";
                $styles .= " }\n";
            }

            if( $form_data["mod_header_iconrbg"] )
            {
                $styles .= " .mobile-icons-box a span {\n";
                $styles .= " \t background-color: #" . $form_data["mod_header_iconrbg"] . " !important;\n";
                $styles .= " }\n";
            }

            $styles .= "}\n";
        }

        file_put_contents(DIR_CATALOG . "view/theme/phpner_store/stylesheet/dynamic_stylesheet.css", $styles);
    }

    public function get_icons()
    {
        $data = array(  );
        if( isset($this->request->get["block_id"]) && isset($this->request->get["type"]) )
        {
            $data["block_id"] = $this->request->get["block_id"];
            $data["type"] = $this->request->get["type"];
            $this->response->setOutput($this->load->view("extension/theme/phpner_store_icons", $data));
        }

    }

}


