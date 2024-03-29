<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerCatalogPhpnerProductTabs extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('catalog/phpner_product_tabs');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('catalog/phpner_product_tabs');
        
        $this->getList();
    }
    
    public function add() {
        $this->load->language('catalog/phpner_product_tabs');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('catalog/phpner_product_tabs');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_catalog_phpner_product_tabs->addProductTab($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $url = '';
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->response->redirect($this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getForm();
    }
    
    public function edit() {
        $this->load->language('catalog/phpner_product_tabs');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('catalog/phpner_product_tabs');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_catalog_phpner_product_tabs->editProductTab($this->request->get['extra_tab_id'], $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $url = '';
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->response->redirect($this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getForm();
    }
    
    public function delete() {
        $this->load->language('catalog/phpner_product_tabs');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('catalog/phpner_product_tabs');
        
        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $extra_tab_id) {
                $this->model_catalog_phpner_product_tabs->deleteProductTab($extra_tab_id);
            }
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $url = '';
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->response->redirect($this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getList();
    }
    
    protected function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'id.title';
        }
        
        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );
        
        $data['add']    = $this->url->link('catalog/phpner_product_tabs/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $data['delete'] = $this->url->link('catalog/phpner_product_tabs/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        $data['phpner_product_tabs'] = array();
        
        $filter_data = array(
            'sort' => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );
        
        $phpner_product_tabs_total = $this->model_catalog_phpner_product_tabs->getTotalProductTabs();
        
        $results = $this->model_catalog_phpner_product_tabs->getProductTabs($filter_data);
        
        foreach ($results as $result) {
            $data['phpner_product_tabs'][] = array(
                'extra_tab_id' => $result['extra_tab_id'],
                'title' => $result['title'],
                'sort_order' => $result['sort_order'],
                'edit' => $this->url->link('catalog/phpner_product_tabs/edit', 'token=' . $this->session->data['token'] . '&extra_tab_id=' . $result['extra_tab_id'] . $url, 'SSL')
            );
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_list']       = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm']    = $this->language->get('text_confirm');
        
        $data['column_title']      = $this->language->get('column_title');
        $data['column_sort_order'] = $this->language->get('column_sort_order');
        $data['column_action']     = $this->language->get('column_action');
        
        $data['button_add']    = $this->language->get('button_add');
        $data['button_edit']   = $this->language->get('button_edit');
        $data['button_delete'] = $this->language->get('button_delete');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }
        
        if (isset($this->request->post['selected'])) {
            $data['selected'] = (array) $this->request->post['selected'];
        } else {
            $data['selected'] = array();
        }
        
        $url = '';
        
        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }
        
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        
        $data['sort_title']      = $this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . '&sort=id.title' . $url, 'SSL');
        $data['sort_sort_order'] = $this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . '&sort=b.sort_order' . $url, 'SSL');
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        $pagination        = new Pagination();
        $pagination->total = $phpner_product_tabs_total;
        $pagination->page  = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url   = $this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
        
        $data['pagination'] = $pagination->render();
        
        $data['results'] = sprintf($this->language->get('text_pagination'), ($phpner_product_tabs_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($phpner_product_tabs_total - $this->config->get('config_limit_admin'))) ? $phpner_product_tabs_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $phpner_product_tabs_total, ceil($phpner_product_tabs_total / $this->config->get('config_limit_admin')));
        
        $data['sort']  = $sort;
        $data['order'] = $order;
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('catalog/phpner_product_tabs_list.tpl', $data));
    }
    
    protected function getForm() {
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_form']     = !isset($this->request->get['extra_tab_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
        $data['text_default']  = $this->language->get('text_default');
        $data['text_enabled']  = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        
        $data['entry_title']      = $this->language->get('entry_title');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $data['entry_status']     = $this->language->get('entry_status');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        $data['tab_general'] = $this->language->get('tab_general');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->error['title'])) {
            $data['error_title'] = $this->error['title'];
        } else {
            $data['error_title'] = array();
        }
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );
        
        if (!isset($this->request->get['extra_tab_id'])) {
            $data['action'] = $this->url->link('catalog/phpner_product_tabs/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $data['action'] = $this->url->link('catalog/phpner_product_tabs/edit', 'token=' . $this->session->data['token'] . '&extra_tab_id=' . $this->request->get['extra_tab_id'] . $url, 'SSL');
        }
        
        $data['cancel'] = $this->url->link('catalog/phpner_product_tabs', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        if (isset($this->request->get['extra_tab_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $phpner_product_tabs_info = $this->model_catalog_phpner_product_tabs->getProductTab($this->request->get['extra_tab_id']);
        }
        
        $data['token'] = $this->session->data['token'];
        
        $this->load->model('localisation/language');
        
        $data['languages'] = $this->model_localisation_language->getLanguages();
        
        if (isset($this->request->post['phpner_product_tabs_description'])) {
            $data['phpner_product_tabs_description'] = $this->request->post['phpner_product_tabs_description'];
        } elseif (isset($this->request->get['extra_tab_id'])) {
            $data['phpner_product_tabs_description'] = $this->model_catalog_phpner_product_tabs->getProductTabsDescriptions($this->request->get['extra_tab_id']);
        } else {
            $data['phpner_product_tabs_description'] = array();
        }
        
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($phpner_product_tabs_info)) {
            $data['status'] = $phpner_product_tabs_info['status'];
        } else {
            $data['status'] = true;
        }
        
        if (isset($this->request->post['sort_order'])) {
            $data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($phpner_product_tabs_info)) {
            $data['sort_order'] = $phpner_product_tabs_info['sort_order'];
        } else {
            $data['sort_order'] = '';
        }
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('catalog/phpner_product_tabs_form.tpl', $data));
    }
    
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/phpner_product_tabs')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        foreach ($this->request->post['phpner_product_tabs_description'] as $language_id => $value) {
            if (empty($value['title'])) {
                $this->error['title'][$language_id] = $this->language->get('error_title');
            }
        }
        
        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }
        
        return !$this->error;
    }
    
    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'catalog/phpner_product_tabs')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
    
    public function autocomplete() {
        $json = array();
        
        if (isset($this->request->get['filter_name'])) {
            $this->load->model('catalog/phpner_product_tabs');
            
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'start' => 0,
                'limit' => 5
            );
            
            $results = $this->model_catalog_phpner_product_tabs->getProductTabs($filter_data);
            
            foreach ($results as $result) {
                $json[] = array(
                    'extra_tab_id' => $result['extra_tab_id'],
                    'title' => strip_tags(html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }
        
        $sort_order = array();
        
        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['title'];
        }
        
        array_multisort($sort_order, SORT_ASC, $json);
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}