<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerProductFilter extends Controller {
    private $error = array();
    private $_session_token;
    private $_ssl_code;
    
    public function __construct($registry) {
        parent::__construct($registry);
        
        if (version_compare(VERSION, '2.2.0.0', '>=')) {
            $this->_ssl_code = true;
        } else {
            $this->_ssl_code = 'SSL';
        }
        
        if (version_compare(VERSION, '3.0.0.0', '>=')) {
            $this->_session_token = 'user_token=' . $this->session->data['user_token'];
        } else {
            $this->_session_token = 'token=' . $this->session->data['token'];
        }
    }
    
    public function index() {
        $data = array();
        $data = array_merge($data, $this->load->language('extension/module/phpner_product_filter'));
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        $this->load->model('extension/module/phpner_product_filter');
        
        $scripts = array();
        
        if (version_compare(VERSION, '2.3.0.2', '<')) {
            $scripts[] = 'http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js';
        }
        
        if (version_compare(VERSION, '2.3.0.2', '>=')) {
            $scripts[] = 'view/javascript/summernote/summernote.js';
            $scripts[] = 'view/javascript/summernote/opencart.js';
        }
        
        foreach ($scripts as $script) {
            if ($script) {
                $this->document->addScript($script);
            }
        }
        
        $styles = array();
        
        if (version_compare(VERSION, '2.3.0.2', '<')) {
            $styles[] = 'http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css';
        }
        
        if (version_compare(VERSION, '2.3.0.2', '>=')) {
            $styles[] = 'view/javascript/summernote/summernote.css';
        }
        
        foreach ($styles as $style) {
            if ($style) {
                $this->document->addStyle($style);
            }
        }
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('phpner_product_filter', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            if (isset($this->request->post['actionstay']) && $this->request->post['actionstay'] == 1) {
                $this->response->redirect($this->url->link('extension/module/phpner_product_filter', $this->_session_token, $this->_ssl_code));
            } else {
                $this->response->redirect($this->url->link('extension/extension', $this->_session_token . '&type=module', $this->_ssl_code));
            }
        }
        
        $data['error_warning']                      = (isset($this->error['warning'])) ? $this->error['warning'] : '';
        $data['error_show_more_limit']              = (isset($this->error['show_more_limit'])) ? $this->error['show_more_limit'] : '';
        $data['error_visible_items_in_block_limit'] = (isset($this->error['visible_items_in_block_limit'])) ? $this->error['visible_items_in_block_limit'] : '';
        $data['error_custom_sort']                  = (isset($this->error['custom_sort'])) ? $this->error['custom_sort'] : '';
        $data['error_custom_limit']                 = (isset($this->error['custom_limit'])) ? $this->error['custom_limit'] : '';
        $data['error_price_sort_order']             = (isset($this->error['price_sort_order'])) ? $this->error['price_sort_order'] : '';
        $data['error_option_sort_order']            = (isset($this->error['option_sort_order'])) ? $this->error['option_sort_order'] : '';
        $data['error_option_image_width']           = (isset($this->error['option_image_width'])) ? $this->error['option_image_width'] : '';
        $data['error_option_image_height']          = (isset($this->error['option_image_height'])) ? $this->error['option_image_height'] : '';
        $data['error_attribute_sort_order']         = (isset($this->error['attribute_sort_order'])) ? $this->error['attribute_sort_order'] : '';
        $data['error_manufacturer_sort_order']      = (isset($this->error['manufacturer_sort_order'])) ? $this->error['manufacturer_sort_order'] : '';
        $data['error_stock_sort_order']             = (isset($this->error['stock_sort_order'])) ? $this->error['stock_sort_order'] : '';
        $data['error_review_sort_order']            = (isset($this->error['review_sort_order'])) ? $this->error['review_sort_order'] : '';
        $data['error_tag_sort_order']               = (isset($this->error['tag_sort_order'])) ? $this->error['tag_sort_order'] : '';
        $data['error_sticker_sort_order']           = (isset($this->error['sticker_sort_order'])) ? $this->error['sticker_sort_order'] : '';
        $data['error_standard_sort_order']          = (isset($this->error['standard_sort_order'])) ? $this->error['standard_sort_order'] : '';
        $data['error_manufacturer_image_width']     = (isset($this->error['manufacturer_image_width'])) ? $this->error['manufacturer_image_width'] : '';
        $data['error_manufacturer_image_height']    = (isset($this->error['manufacturer_image_height'])) ? $this->error['manufacturer_image_height'] : '';
        $data['error_stock_ending_value']           = (isset($this->error['stock_ending_value'])) ? $this->error['stock_ending_value'] : '';
        
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }
        
        if (isset($this->session->data['warning'])) {
            $data['warning'] = $this->session->data['warning'];
            
            unset($this->session->data['warning']);
        } else {
            $data['warning'] = '';
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', $this->_session_token, $this->_ssl_code)
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', $this->_session_token . '&type=module', $this->_ssl_code)
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/phpner_product_filter', $this->_session_token, $this->_ssl_code)
        );
        
        $data['action'] = $this->url->link('extension/module/phpner_product_filter', $this->_session_token, $this->_ssl_code);
        $data['cache']  = $this->url->link('extension/module/phpner_product_filter/cache', $this->_session_token, $this->_ssl_code);
        $data['cancel'] = $this->url->link('extension/extension', $this->_session_token . '&type=module', $this->_ssl_code);
        
        $data['token'] = $this->_session_token;
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_attribute", 'sort_order')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_attribute` ADD `sort_order` int(3) NOT NULL DEFAULT '0' AFTER `attribute_name`");
        }
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_option", 'option_name_mod')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_option` ADD `option_name_mod` text NOT NULL AFTER `option_name`");
        }
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_option", 'option_value_name_mod')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_option` ADD `option_value_name_mod` text NOT NULL AFTER `option_value_name`");
        }
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_standard", 'sort_order')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_standard` ADD `sort_order` int(3) NOT NULL DEFAULT '0' AFTER `filter_name`");
        }
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_standard", 'filter_name_mod')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_standard` ADD `filter_name_mod` text NOT NULL AFTER `filter_name`");
        }
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_attribute", 'attribute_name_mod')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_attribute` ADD `attribute_name_mod` text NOT NULL AFTER `attribute_name`");
        }
        
        if (!$this->checkIfColumnExist(DB_PREFIX . "phpner_filter_product_sticker", 'product_sticker_value_mod')) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . "phpner_filter_product_sticker` ADD `product_sticker_value_mod` text NOT NULL AFTER `product_sticker_value`");
        }
        
        if (!$this->checkIfTableExist(DB_PREFIX . "phpner_filter_product_seo")) {
            $sql1 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_filter_product_seo` (";
            $sql1 .= "`seo_id` int(11) NOT NULL AUTO_INCREMENT, ";
            $sql1 .= "`status` tinyint(1) NOT NULL DEFAULT '1', ";
            $sql1 .= "`date_added` datetime NOT NULL, ";
            $sql1 .= "`date_modified` datetime NOT NULL, ";
            $sql1 .= "PRIMARY KEY (`seo_id`) ";
            $sql1 .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci AUTO_INCREMENT=1 ;";
            
            $this->db->query($sql1);
        }
        
        if (!$this->checkIfTableExist(DB_PREFIX . "phpner_filter_product_seo_description")) {
            $sql2 = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "phpner_filter_product_seo_description` (";
            $sql2 .= "`seo_id` int(11) NOT NULL, ";
            $sql2 .= "`language_id` int(11) NOT NULL, ";
            $sql2 .= "`seo_url` text COLLATE utf8_general_ci NOT NULL, ";
            $sql2 .= "`seo_title` varchar(255) COLLATE utf8_general_ci NOT NULL, ";
            $sql2 .= "`seo_h1` varchar(255) COLLATE utf8_general_ci NOT NULL, ";
            $sql2 .= "`seo_meta_description` varchar(255) COLLATE utf8_general_ci NOT NULL, ";
            $sql2 .= "`seo_meta_keywords` varchar(255) COLLATE utf8_general_ci NOT NULL, ";
            $sql2 .= "`seo_description` text COLLATE utf8_general_ci NOT NULL ";
            $sql2 .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci; ";
            
            $this->db->query($sql2);
        }
        
        if (isset($this->request->post['phpner_product_filter_status'])) {
            $data['phpner_product_filter_status'] = $this->request->post['phpner_product_filter_status'];
        } else {
            $data['phpner_product_filter_status'] = $this->config->get('phpner_product_filter_status');
        }
        
        if (isset($this->request->post['phpner_product_filter_data'])) {
            $data['phpner_product_filter_data'] = $this->request->post['phpner_product_filter_data'];
        } else {
            $data['phpner_product_filter_data'] = $this->config->get('phpner_product_filter_data');
        }
        
		/*3359*/
		if (!isset($data['phpner_product_filter_data']['show_no_quantity_products'])) {
			$data['phpner_product_filter_data']['show_no_quantity_products'] = 1;
		}
		
		if (!isset($data['phpner_product_filter_data']['no_quantity_last'])) {
			$data['phpner_product_filter_data']['no_quantity_last'] = 1;
		}
		
		if (!isset($data['phpner_product_filter_data']['display_empty_totals'])) {
			$data['phpner_product_filter_data']['display_empty_totals'] = 1;
		}
		/*3359*/
		
        $standard_filters = $this->model_extension_module_phpner_product_filter->getFilterGroups();
        
        $data['standard_filters'] = array();
        
        foreach ($standard_filters as $standard_filter) {
            $data['standard_filters'][] = array(
                'filter_group_id' => $standard_filter['filter_group_id'],
                'name' => $standard_filter['filter_name']
            );
        }
        
        $attribute_filters = $this->model_extension_module_phpner_product_filter->getAttributes();
        
        $data['attribute_filters'] = array();
        
        foreach ($attribute_filters as $attribute_filter) {
            $data['attribute_filters'][] = array(
                'attribute_id' => $attribute_filter['attribute_id'],
                'name' => $attribute_filter['attribute_name']
            );
        }
        
        $option_filters = $this->model_extension_module_phpner_product_filter->getOptions();
        
        $data['option_filters'] = array();
        
        foreach ($option_filters as $option_filter) {
            $data['option_filters'][] = array(
                'option_id' => $option_filter['option_id'],
                'name' => $option_filter['option_name']
            );
        }
        
        $data['data_feed'] = HTTP_CATALOG . 'index.php?route=extension/module/phpner_product_filter/sitemap';
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/phpner_product_filter', $data));
    }
    
    public function checkIfColumnExist($table_name, $table_column) {
        $query = $this->db->query("SELECT COUNT(*) as total FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '" . DB_DATABASE . "' AND TABLE_NAME = '" . $table_name . "' AND COLUMN_NAME  = '" . $table_column . "'")->row['total'];
        
        return $query;
    }
    
    public function checkIfTableExist($table_name) {
        $query = $this->db->query("SELECT COUNT(*) as total FROM information_schema.TABLES WHERE TABLE_SCHEMA = '" . DB_DATABASE . "' AND TABLE_NAME = '" . $table_name . "'")->row['total'];
        
        return $query;
    }
    
    public function install() {
        $this->load->language('extension/module/phpner_product_filter');
        
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('user/user_group');
        $this->load->model('extension/module/phpner_product_filter');
        $this->load->model('catalog/product');
        
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/phpner_product_filter');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/phpner_product_filter');
        
        $this->model_extension_module_phpner_product_filter->makeDB();
        
        $standard_display_type_filters = array();
        
        foreach ($this->model_extension_module_phpner_product_filter->getFilterGroups() as $standard_filter) {
            if ($standard_filter) {
                $standard_display_type_filters[$standard_filter['filter_group_id']] = '3';
            }
        }
        
        $attribute_display_status_filters = array();
        $attribute_display_type_filters   = array();
        
        foreach ($this->model_extension_module_phpner_product_filter->getAttributes() as $attribute_filter) {
            if ($attribute_filter) {
                $attribute_display_status_filters[$attribute_filter['attribute_id']] = '1';
                $attribute_display_type_filters[$attribute_filter['attribute_id']]   = '3';
            }
        }
        
        $option_display_status_filters = array();
        $option_display_type_filters   = array();
        $option_display_image_filters  = array();
        
        foreach ($this->model_extension_module_phpner_product_filter->getOptions() as $option_filter) {
            if ($option_filter) {
                $option_display_status_filters[$option_filter['option_id']] = '1';
                $option_display_type_filters[$option_filter['option_id']]   = '3';
                $option_display_image_filters[$option_filter['option_id']]  = '1';
            }
        }
        
        $this->model_setting_setting->editSetting('phpner_product_filter', array(
            'phpner_product_filter_status' => '1',
            'phpner_product_filter_data' => array(
                'show_more_limit_show' => '1',
                'show_more_limit' => '15',
                'visible_items_in_block_limit' => '5',
                'collapse_expand_type' => array(
                    '1',
                    '2',
                    '3'
                ),
                'mask_on_filtering' => '1',
                'selected_values_position' => '1',
                'custom_sort' => array(
                    'pd.name|order=ASC',
                    'pd.name|order=DESC',
                    'p.model|order=ASC',
                    'p.model|order=DESC',
                    'p.sort_order|order=ASC',
                    'p.sort_order|order=DESC',
                    'p.price|order=ASC',
                    'p.price|order=DESC',
                    'rating|order=ASC',
                    'rating|order=DESC',
                    'p.quantity|order=ASC',
                    'p.quantity|order=DESC',
                    'p.viewed|order=ASC',
                    'p.viewed|order=DESC',
                    'p.date_added|order=ASC',
                    'p.date_added|order=DESC'
                ),
                'default_sort' => 'p.quantity|order=ASC',
                'custom_limit' => '15,25,50,75,100',
                'show_totals' => '1',
				/*3359*/
                'show_no_quantity_products' => '1',
                'no_quantity_last' => '1',
                'display_empty_totals' => '1',
				/*3359*/
                'enable_seo' => '0',
                'price_status' => '1',
                'price_sort_order' => '1',
                'price_input_status' => '1',
                'show_special_only_bytton' => '1',
                'price_collapsed' => '0',
                'option_status' => '1',
                'option_sort_order' => '4',
                'option_display_status' => $option_display_status_filters,
                'option_display_type' => $option_display_type_filters,
                'option_display_image' => $option_display_image_filters,
                'option_logic_with_other' => 'AND',
                'option_logic_between_option' => 'OR',
                'option_display_image' => '1',
                'option_image_width' => '20',
                'option_image_height' => '20',
                'option_collapsed' => '0',
                'attribute_status' => '1',
                'attribute_sort_order' => '5',
                'attribute_display_status' => $attribute_display_status_filters,
                'attribute_display_type' => $attribute_display_type_filters,
                'attribute_logic_with_other' => 'AND',
                'attribute_logic_between_attribute' => 'OR',
                'attribute_collapsed' => '0',
                'manufacturer_status' => '1',
                'manufacturer_sort_order' => '3',
                'manufacturer_display_type' => '3',
                'manufacturer_logic_with_other' => 'AND',
                'manufacturer_image_width' => '20',
                'manufacturer_image_height' => '20',
                'manufacturer_collapsed' => '0',
                'stock_status' => '1',
                'stock_sort_order' => '8',
                'stock_display_type' => '3',
                'stock_ending_value_status' => '1',
                'stock_logic_with_other' => 'AND',
                'stock_logic_between_stock' => 'OR',
                'stock_ending_value' => '5',
                'stock_collapsed' => '0',
                'review_status' => '1',
                'review_sort_order' => '9',
                'review_display_type' => '3',
                'review_logic_with_other' => 'AND',
                'review_logic_between_review' => 'OR',
                'review_collapsed' => '0',
                'tag_status' => '1',
                'tag_sort_order' => '2',
                'tag_logic_with_other' => 'AND',
                'tag_collapsed' => '0',
                'sticker_status' => '1',
                'sticker_sort_order' => '6',
                'sticker_display_type' => '3',
                'sticker_logic_with_other' => 'AND',
                'sticker_logic_between_sticker' => 'OR',
                'sticker_collapsed' => '0',
                'standard_status' => '1',
                'standard_sort_order' => '7',
                'standard_display_type' => $standard_display_type_filters,
                'standard_logic_with_other' => 'AND',
                'standard_logic_between_standard' => 'OR',
                'standard_collapsed' => '0'
            )
        ));
        
        if (!in_array('phpner_product_filter', $this->model_extension_extension->getInstalled('module'))) {
            $this->model_extension_extension->install('module', 'phpner_product_filter');
        }
        
        $this->session->data['success'] = $this->language->get('text_success_install');
    }
    
    public function refresh() {
        $json = array();
        
        $this->load->language('extension/module/phpner_product_filter');
        
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $this->session->data['warning'] = $this->language->get('error_permission');
        } else {
            if (isset($this->request->get['type'])) {
                $this->load->model('catalog/product');
                
                $this->model_catalog_product->refreshphpner_ProductFilterData($this->request->get['type']);
                
                $json['success'] = $this->language->get('text_success_refresh');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function cache() {
        $this->load->language('extension/module/phpner_product_filter');
        
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $this->session->data['warning'] = $this->language->get('error_permission');
        } else {
            $this->cache->delete('phpner.product_filter_pids');
            $this->cache->delete('phpner.seo_page');
            
            $this->session->data['success'] = $this->language->get('text_success_cache');
        }
        
        $this->response->redirect($this->url->link('extension/module/phpner_product_filter', $this->_session_token, true));
    }
    
    public function uninstall() {
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('extension/module/phpner_product_filter');
        
        $this->model_extension_module_phpner_product_filter->removeDB();
        $this->model_extension_extension->uninstall('module', 'phpner_product_filter');
        $this->model_setting_setting->deleteSetting('phpner_product_filter_data');
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        foreach ($this->request->post['phpner_product_filter_data'] as $key => $field) {
            if (empty($field) && $key == "show_more_limit") {
                $this->error['show_more_limit'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "visible_items_in_block_limit") {
                $this->error['visible_items_in_block_limit'] = $this->language->get('error_empty_some_field');
            }
            
            if (!isset($this->request->post['phpner_product_filter_data']['custom_sort'])) {
                $this->error['custom_sort'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "custom_limit") {
                $this->error['custom_limit'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "price_sort_order") {
                $this->error['price_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "option_sort_order") {
                $this->error['option_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "option_image_width") {
                $this->error['option_image_width'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "option_image_height") {
                $this->error['option_image_height'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "attribute_sort_order") {
                $this->error['attribute_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "manufacturer_sort_order") {
                $this->error['manufacturer_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "stock_sort_order") {
                $this->error['stock_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "review_sort_order") {
                $this->error['review_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "tag_sort_order") {
                $this->error['tag_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "sticker_sort_order") {
                $this->error['sticker_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "standard_sort_order") {
                $this->error['standard_sort_order'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "manufacturer_image_width") {
                $this->error['manufacturer_image_width'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "manufacturer_image_height") {
                $this->error['manufacturer_image_height'] = $this->language->get('error_empty_some_field');
            }
            
            if (empty($field) && $key == "stock_ending_value") {
                $this->error['stock_ending_value'] = $this->language->get('error_empty_some_field');
            }
        }
        
        if (isset($this->error) && $this->error) {
            $this->session->data['warning'] = $this->language->get('error_check_from');
        }
        
        return !$this->error;
    }
    
    public function history_seo() {
        $data = array();
        
        $this->load->model('extension/module/phpner_product_filter');
        $this->load->model('localisation/language');
        
        $data = array_merge($data, $this->language->load('extension/module/phpner_product_filter'));
        
        $data['text_seo'] = (isset($this->request->get['seo_id']) && $this->request->get['seo_id']) ? $this->language->get('text_edit_seo') : $this->language->get('text_add_seo');
        
        $data['default_language_id'] = $this->config->get('config_language_id');
        $data['token']               = $this->_session_token;
        
        if (isset($this->request->get['seo_id'])) {
            $data['seo_id'] = $this->request->get['seo_id'];
        } else {
            $data['seo_id'] = 0;
        }
        
        if ((isset($this->request->get['seo_id']) && $this->request->get['seo_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $form_info = $this->model_extension_module_phpner_product_filter->getSeo($this->request->get['seo_id']);
        }
        
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (isset($this->request->get['seo_id']) && $form_info) {
            $data['status'] = $form_info['status'];
        } else {
            $data['status'] = '1';
        }
        
        if (isset($this->request->post['form_description'])) {
            $data['form_description'] = $this->request->post['form_description'];
        } elseif (isset($this->request->get['seo_id']) && $form_info) {
            $data['form_description'] = $this->model_extension_module_phpner_product_filter->getSeoDescription($this->request->get['seo_id']);
        } else {
            foreach ($this->model_localisation_language->getLanguages() as $language) {
                $data['form_description'][$language['language_id']] = array(
                    'seo_url' => '',
                    'seo_title' => '',
                    'seo_h1' => '',
                    'seo_meta_description' => '',
                    'seo_meta_keywords' => '',
                    'seo_description' => ''
                );
            }
        }
        
        $data['languages'] = array();
        
        foreach ($this->model_localisation_language->getLanguages() as $language) {
            if (version_compare(VERSION, '2.1.0.2', '<=')) {
                $data['languages'][] = array(
                    'language_id' => $language['language_id'],
                    'code' => $language['code'],
                    'name' => $language['name'],
                    'image' => 'view/image/flags/' . $language['image']
                );
            } else {
                $data['languages'][] = array(
                    'language_id' => $language['language_id'],
                    'code' => $language['code'],
                    'name' => $language['name'],
                    'image' => 'language/' . $language['code'] . '/' . $language['code'] . '.png'
                );
            }
        }
        
        if (version_compare(VERSION, '3.0.0.0', '>=')) {
            $this->response->setOutput($this->load->view('extension/module/phpner_product_filter_seo_index', $data));
        } else {
            $this->response->setOutput($this->load->view('extension/module/phpner_product_filter_seo_index.tpl', $data));
        }
    }
    
    public function history_seo_action() {
        $json = array();
        
        $this->language->load('extension/module/phpner_product_filter');
        
        $this->load->model('extension/module/phpner_product_filter');
        $this->load->model('localisation/language');
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            foreach ($this->request->post['form_description'] as $language_id => $value) {
                if (utf8_strlen($value['seo_url']) < 1) {
                    $json['error']['form_description_language']['seo_url'][$language_id] = $this->language->get('error_for_all_field');
                }
                
                if ((utf8_strlen($value['seo_title']) < 1) || (utf8_strlen($value['seo_title']) > 255)) {
                    $json['error']['form_description_language']['seo_title'][$language_id] = $this->language->get('error_for_all_field');
                }
                
                if ((utf8_strlen($value['seo_h1']) < 1) || (utf8_strlen($value['seo_h1']) > 255)) {
                    $json['error']['form_description_language']['seo_h1'][$language_id] = $this->language->get('error_for_all_field');
                }
                
                if ((utf8_strlen($value['seo_meta_description']) < 1) || (utf8_strlen($value['seo_meta_description']) > 255)) {
                    $json['error']['form_description_language']['seo_meta_description'][$language_id] = $this->language->get('error_for_all_field');
                }
                
                if ((utf8_strlen($value['seo_meta_keywords']) < 1) || (utf8_strlen($value['seo_meta_keywords']) > 255)) {
                    $json['error']['form_description_language']['seo_meta_keywords'][$language_id] = $this->language->get('error_for_all_field');
                }
                
                if (utf8_strlen($value['seo_description']) < 1) {
                    $json['error']['form_description_language']['seo_description'][$language_id] = $this->language->get('error_for_all_field');
                }
            }
            
            if (isset($json['error']) && !isset($json['error']['warning'])) {
                $json['error']['warning'] = $this->language->get('error_warning');
            }
            
            if (!isset($json['error'])) {
                if (isset($this->request->post['seo_id']) && $this->request->post['seo_id']) {
                    $this->model_extension_module_phpner_product_filter->editSeo($this->request->post['seo_id'], $this->request->post);
                } else {
                    $this->model_extension_module_phpner_product_filter->addSeo($this->request->post);
                }
                
                $json['success'] = $this->language->get('text_success_form');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function history_seo_list() {
        $data = array();
        
        $this->load->model('extension/module/phpner_product_filter');
        
        $data          = array_merge($data, $this->language->load('extension/module/phpner_product_filter'));
        $page          = (isset($this->request->get['page'])) ? $this->request->get['page'] : 1;
        $data['token'] = $this->_session_token;
        
        $data['histories'] = array();
        
        $filter_data = array(
            'filter_seo_url' => (isset($this->request->get['filter_seo_url'])) ? trim($this->request->get['filter_seo_url']) : '',
            'start' => ($page - 1) * 10,
            'limit' => 50,
            'sort' => 'f.date_added',
            'order' => 'DESC'
        );
        
        $results = $this->model_extension_module_phpner_product_filter->getSeos($filter_data);
        
        foreach ($results as $result) {
            $protocol = strtolower(substr($this->request->server["SERVER_PROTOCOL"], 0, 5)) == 'https' ? HTTPS_CATALOG : HTTP_CATALOG;
            
            $data['histories'][] = array(
                'seo_id' => $result['seo_id'],
                'seo_title' => $result['seo_title'],
                'seo_url_name' => utf8_substr(strip_tags($result['seo_url']), 0, 100) . '...',
                'seo_url' => $protocol . $result['seo_url'],
                'date_added' => $result['date_added'],
                'date_modified' => $result['date_modified'],
                'status' => $result['status'] ? $this->language->get('text_status_enabled') : $this->language->get('text_status_disabled')
            );
        }
        
        $history_total = $this->model_extension_module_phpner_product_filter->getTotalSeos($filter_data);
        
        $pagination        = new Pagination();
        $pagination->total = $history_total;
        $pagination->page  = $page;
        $pagination->limit = 50;
        $pagination->url   = $this->url->link('extension/module/phpner_product_filter/history_seo_list', $this->_session_token . '&page={page}', $this->_ssl_code);
        
        $data['pagination'] = $pagination->render();
        
        $data['results'] = sprintf($this->language->get('text_pagination'), ($history_total) ? (($page - 1) * 50) + 1 : 0, ((($page - 1) * 50) > ($history_total - 50)) ? $history_total : ((($page - 1) * 50) + 50), $history_total, ceil($history_total / 50));
        
        if (version_compare(VERSION, '3.0.0.0', '>=')) {
            $this->response->setOutput($this->load->view('extension/module/phpner_product_filter_history_seo', $data));
        } else {
            $this->response->setOutput($this->load->view('extension/module/phpner_product_filter_history_seo.tpl', $data));
        }
    }
    
    public function delete_all() {
        $json = array();
        
        $this->load->model('extension/module/phpner_product_filter');
        
        $this->language->load('extension/module/phpner_product_filter');
        
        if (isset($this->request->get['type']) && $this->request->get['type']) {
            $type = $this->request->get['type'];
        } else {
            $type = '';
        }
        
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            if ($type) {
                $result = $this->model_extension_module_phpner_product_filter->deleteSeos();
                
                if (!isset($result) || !$result) {
                    $json['error'] = $this->language->get('error_task');
                } else {
                    $json['success'] = $this->language->get('text_success_task');
                }
            } else {
                $json['error'] = $this->language->get('error_task');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function delete_selected() {
        $json = array();
        
        $this->load->model('extension/module/phpner_product_filter');
        
        $this->language->load('extension/module/phpner_product_filter');
        
        if (isset($this->request->get['type']) && $this->request->get['type']) {
            $type = $this->request->get['type'];
        } else {
            $type = '';
        }
        
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            if ($type) {
                $info = $this->model_extension_module_phpner_product_filter->getSeo((int) $this->request->get['delete']);
                
                if ($info) {
                    $result = $this->model_extension_module_phpner_product_filter->deleteSeo((int) $this->request->get['delete']);
                }
                
                if (!isset($result) || !$result) {
                    $json['error'] = $this->language->get('error_task');
                } else {
                    $json['success'] = $this->language->get('text_success_task');
                }
            } else {
                $json['error'] = $this->language->get('error_task');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function delete_all_selected() {
        $json = array();
        
        $this->load->model('extension/module/phpner_product_filter');
        
        $this->language->load('extension/module/phpner_product_filter');
        
        if (isset($this->request->get['type']) && $this->request->get['type']) {
            $type = $this->request->get['type'];
        } else {
            $type = '';
        }
        
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            if ($type) {
                if (isset($this->request->request['selected'])) {
                    foreach ($this->request->request['selected'] as $seo_id) {
                        $info = $this->model_extension_module_phpner_product_filter->getSeo((int) $seo_id);
                        
                        if ($info) {
                            $result = $this->model_extension_module_phpner_product_filter->deleteSeo((int) $seo_id);
                        }
                    }
                }
                
                if (!isset($result) || !$result) {
                    $json['error'] = $this->language->get('error_task');
                } else {
                    $json['success'] = $this->language->get('text_success_task');
                }
            } else {
                $json['error'] = $this->language->get('error_task');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function copy_selected() {
        $json = array();
        
        $this->load->model('extension/module/phpner_product_filter');
        
        $this->language->load('extension/module/phpner_product_filter');
        
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_product_filter')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            if (isset($this->request->get['copy']) && $this->request->get['copy']) {
                $info = $this->model_extension_module_phpner_product_filter->getSeo((int) $this->request->get['copy']);
                
                if ($info) {
                    $result = $this->model_extension_module_phpner_product_filter->copySeo((int) $this->request->get['copy']);
                }
                
                if (!isset($result) || !$result) {
                    $json['error'] = $this->language->get('error_task');
                } else {
                    $json['success'] = $this->language->get('text_success_task');
                }
            } else {
                $json['error'] = $this->language->get('error_task');
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function autocomplete_seo_url() {
        $json = array();
        
        if (isset($this->request->request['filter_seo_url'])) {
            $this->load->model('extension/module/phpner_product_filter');
            
            $filter_data = array(
                'filter_seo_url' => $this->request->request['filter_seo_url'],
                'filter_group_seo_url' => true
            );
            
            $results = $this->model_extension_module_phpner_product_filter->getSeos($filter_data);
            
            foreach ($results as $result) {
                $json[] = array(
                    'seo_url' => $result['seo_url'],
                    'seo_id' => $result['seo_id']
                );
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}