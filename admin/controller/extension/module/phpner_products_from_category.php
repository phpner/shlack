<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerProductsFromCategory extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('extension/module/phpner_products_from_category');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('extension/module');
        $this->load->model('localisation/language');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule('phpner_products_from_category', $this->request->post);
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
            }
            
            $this->cache->delete('product');
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_edit']         = $this->language->get('text_edit');
        $data['text_enabled']      = $this->language->get('text_enabled');
        $data['text_disabled']     = $this->language->get('text_disabled');
        $data['text_select_all']   = $this->language->get('text_select_all');
        $data['text_unselect_all'] = $this->language->get('text_unselect_all');
        
        $data['entry_name']               = $this->language->get('entry_name');
        $data['entry_heading']            = $this->language->get('entry_heading');
        $data['entry_link']               = $this->language->get('entry_link');
        $data['entry_product']            = $this->language->get('entry_product');
        $data['entry_category']           = $this->language->get('entry_category');
        $data['entry_show_in_categories'] = $this->language->get('entry_show_in_categories');
        $data['entry_width']              = $this->language->get('entry_width');
        $data['entry_height']             = $this->language->get('entry_height');
        $data['entry_limit']              = $this->language->get('entry_limit');
        $data['entry_auto_play']          = $this->language->get('entry_auto_play');
        $data['entry_status']             = $this->language->get('entry_status');
        
        $data['help_product'] = $this->language->get('help_product');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        $data['token'] = $this->session->data['token'];
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }
        
        if (isset($this->error['heading'])) {
            $data['error_heading'] = $this->error['heading'];
        } else {
            $data['error_heading'] = array();
        }
        
        if (isset($this->error['link'])) {
            $data['error_link'] = $this->error['link'];
        } else {
            $data['error_link'] = array();
        }
        
        if (isset($this->error['width'])) {
            $data['error_width'] = $this->error['width'];
        } else {
            $data['error_width'] = '';
        }
        
        if (isset($this->error['height'])) {
            $data['error_height'] = $this->error['height'];
        } else {
            $data['error_height'] = '';
        }
        
        if (isset($this->error['limit'])) {
            $data['error_limit'] = $this->error['limit'];
        } else {
            $data['error_limit'] = '';
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );
        
        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/phpner_products_from_category', 'token=' . $this->session->data['token'], true)
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/phpner_products_from_category', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
            );
        }
        
        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('extension/module/phpner_products_from_category', 'token=' . $this->session->data['token'], true);
        } else {
            $data['action'] = $this->url->link('extension/module/phpner_products_from_category', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
        }
        
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        
        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }
        
        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }
        
        if (isset($this->request->post['heading'])) {
            $data['heading'] = $this->request->post['heading'];
        } elseif (!empty($module_info)) {
            $data['heading'] = $module_info['heading'];
        } else {
            $data['heading'] = array();
        }
        
        if (isset($this->request->post['link'])) {
            $data['link'] = $this->request->post['link'];
        } elseif (!empty($module_info)) {
            $data['link'] = $module_info['link'];
        } else {
            $data['link'] = array();
        }
        
        $this->load->model('catalog/product');
        
        $data['products'] = array();
        
        if (!empty($this->request->post['product'])) {
            $products = $this->request->post['product'];
        } elseif (!empty($module_info['product'])) {
            $products = (isset($module_info['product'])) ? $module_info['product'] : array();
        } else {
            $products = array();
        }
        
        foreach ($products as $product_id) {
            $product_info = $this->model_catalog_product->getProduct($product_id);
            
            if ($product_info) {
                $data['products'][] = array(
                    'product_id' => $product_info['product_id'],
                    'name' => $product_info['name']
                );
            }
        }
        
        $this->load->model('catalog/category');
        
        $data['categories'] = $this->model_catalog_category->getCategories(0);
        
        if (isset($this->request->post['module_categories'])) {
            $data['module_categories'] = $this->request->post['module_categories'];
        } elseif (!empty($module_info)) {
            $data['module_categories'] = (isset($module_info['module_categories'])) ? $module_info['module_categories'] : array();
        } else {
            $data['module_categories'] = array();
        }
        
        if (isset($this->request->post['module_show_in_categories'])) {
            $data['module_show_in_categories'] = $this->request->post['module_show_in_categories'];
        } elseif (!empty($module_info)) {
            $data['module_show_in_categories'] = (isset($module_info['module_show_in_categories'])) ? $module_info['module_show_in_categories'] : array();
        } else {
            $data['module_show_in_categories'] = array();
        }
        
        if (isset($this->request->post['width'])) {
            $data['width'] = $this->request->post['width'];
        } elseif (!empty($module_info)) {
            $data['width'] = $module_info['width'];
        } else {
            $data['width'] = 200;
        }
        
        if (isset($this->request->post['height'])) {
            $data['height'] = $this->request->post['height'];
        } elseif (!empty($module_info)) {
            $data['height'] = $module_info['height'];
        } else {
            $data['height'] = 200;
        }
        
        if (isset($this->request->post['limit'])) {
            $data['limit'] = $this->request->post['limit'];
        } elseif (!empty($module_info)) {
            $data['limit'] = $module_info['limit'];
        } else {
            $data['limit'] = 5;
        }
        
        if (isset($this->request->post['auto_play'])) {
            $data['auto_play'] = $this->request->post['auto_play'];
        } elseif (!empty($module_info)) {
            $data['auto_play'] = $module_info['auto_play'];
        } else {
            $data['auto_play'] = '';
        }
        
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $data['status'] = $module_info['status'];
        } else {
            $data['status'] = '';
        }
        
        $data['languages'] = $this->model_localisation_language->getLanguages();
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/phpner_products_from_category.tpl', $data));
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_products_from_category')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }
        
        if (!$this->request->post['width']) {
            $this->error['width'] = $this->language->get('error_width');
        }
        
        if (!$this->request->post['height']) {
            $this->error['height'] = $this->language->get('error_height');
        }
        
        if (!$this->request->post['limit']) {
            $this->error['limit'] = $this->language->get('error_limit');
        }
        
        if (is_array($this->request->post['heading'])) {
            foreach ($this->request->post['heading'] as $language_code => $heading) {
                if ((utf8_strlen($heading) < 1) || (utf8_strlen($heading) > 255)) {
                    $this->error['heading'][$language_code] = $this->language->get('error_heading');
                    $this->error['warning']                 = $this->language->get('error_heading');
                }
            }
            
            foreach ($this->request->post['link'] as $language_code => $link) {
                if ((utf8_strlen($link) < 1) || (utf8_strlen($link) > 1000)) {
                    $this->error['link'][$language_code] = $this->language->get('error_link');
                    $this->error['warning']              = $this->language->get('error_link');
                }
            }
        }
        
        return !$this->error;
    }
}