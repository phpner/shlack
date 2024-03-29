<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerPhpnerBlogCategory extends Controller {
    private $error = array();
    private $phpner_blog_category_id = 0;
    private $phpner_blog_category_path = array();
    
    public function index() {
        $phpner_blog_setting = $this->config->get('phpner_blog_setting_data');
        
        if (!isset($phpner_blog_setting['status']) || $phpner_blog_setting['status'] != 1) {
            $this->response->redirect($this->url->link('phpner/blog_setting', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        $this->language->load('phpner/blog_category');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/blog_category');
        
        $this->getList();
    }
    
    public function add() {
        $this->language->load('phpner/blog_category');
        
        $this->document->addScript('view/javascript/phpner/seo-blog.js');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/blog_category');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_phpner_blog_category->addCategory($this->request->post);
            
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
            
            $this->response->redirect($this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getForm();
    }
    
    public function edit() {
        $this->language->load('phpner/blog_category');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/blog_category');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_phpner_blog_category->editCategory($this->request->get['phpner_blog_category_id'], $this->request->post);
            
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
            
            $this->response->redirect($this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getForm();
    }
    
    public function delete() {
        $this->language->load('phpner/blog_category');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/blog_category');
        
        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $phpner_blog_category_id) {
                $this->model_phpner_blog_category->deleteCategory($phpner_blog_category_id);
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
            
            $this->response->redirect($this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getList();
    }
    
    protected function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'name';
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
            'href' => $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );
        
        $data['add']    = $this->url->link('phpner/blog_category/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $data['delete'] = $this->url->link('phpner/blog_category/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        if (isset($this->request->get['cpath'])) {
            if ($this->request->get['cpath'] != '') {
                $this->phpner_blog_category_path = explode('_', $this->request->get['cpath']);
                $this->phpner_blog_category_id   = end($this->phpner_blog_category_path);
                $this->session->data['cpath'] = $this->request->get['cpath'];
            } else {
                unset($this->session->data['cpath']);
            }
        } elseif (isset($this->session->data['cpath'])) {
            $this->phpner_blog_category_path = explode('_', $this->session->data['cpath']);
            $this->phpner_blog_category_id   = end($this->phpner_blog_category_path);
        }
        
        $data['categories'] = $this->getCategories(0);
        
        $category_total = count($data['categories']);
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_list']       = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm']    = $this->language->get('text_confirm');
        
        $data['column_name']       = $this->language->get('column_name');
        $data['column_sort_order'] = $this->language->get('column_sort_order');
        $data['column_action']     = $this->language->get('column_action');
        
        $data['button_add']     = $this->language->get('button_add');
        $data['button_edit']    = $this->language->get('button_edit');
        $data['button_delete']  = $this->language->get('button_delete');
        $data['button_rebuild'] = $this->language->get('button_rebuild');
        
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
        
        $data['sort_name']       = $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
        $data['sort_sort_order'] = $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, 'SSL');
        
        $url = '';
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        if (isset($this->request->get['cpath'])) {
            $url .= '&cpath=' . $this->request->get['cpath'];
        }
        
        $pagination        = new Pagination();
        $pagination->total = $category_total;
        $pagination->page  = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url   = $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
        
        $data['pagination'] = $pagination->render();
        
        $data['results'] = sprintf($this->language->get('text_pagination'), ($category_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($category_total - $this->config->get('config_limit_admin'))) ? $category_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $category_total, ceil($category_total / $this->config->get('config_limit_admin')));
        
        $data['sort']  = $sort;
        $data['order'] = $order;
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('phpner/blog_category_list.tpl', $data));
    }
    
    protected function getForm() {
        $data['heading_title'] = $this->language->get('heading_title');
        
        //CKEditor
        if ($this->config->get('config_editor_default')) {
            $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
            $this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
        } else {
            $this->document->addScript('view/javascript/summernote/summernote.js');
            $this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
            $this->document->addScript('view/javascript/summernote/opencart.js');
            $this->document->addStyle('view/javascript/summernote/summernote.css');
        }
        
        $data['ckeditor'] = $this->config->get('config_editor_default');
        
        $data['text_form']     = !isset($this->request->get['phpner_blog_category_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
        $data['text_none']     = $this->language->get('text_none');
        $data['text_default']  = $this->language->get('text_default');
        $data['text_enabled']  = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        
        $data['entry_name']             = $this->language->get('entry_name');
        $data['entry_description']      = $this->language->get('entry_description');
        $data['entry_meta_title']       = $this->language->get('entry_meta_title');
        $data['entry_meta_description'] = $this->language->get('entry_meta_description');
        $data['entry_meta_keyword']     = $this->language->get('entry_meta_keyword');
        $data['entry_keyword']          = $this->language->get('entry_keyword');
        $data['entry_parent']           = $this->language->get('entry_parent');
        $data['entry_store']            = $this->language->get('entry_store');
        $data['entry_image']            = $this->language->get('entry_image');
        $data['entry_sort_order']       = $this->language->get('entry_sort_order');
        $data['entry_status']           = $this->language->get('entry_status');
        $data['entry_layout']           = $this->language->get('entry_layout');
        
        $data['help_keyword'] = $this->language->get('help_keyword');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        $data['tab_general'] = $this->language->get('tab_general');
        $data['tab_data']    = $this->language->get('tab_data');
        $data['tab_design']  = $this->language->get('tab_design');
        
        $data['lang'] = $this->language->get('lang');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = array();
        }
        
        if (isset($this->error['meta_title'])) {
            $data['error_meta_title'] = $this->error['meta_title'];
        } else {
            $data['error_meta_title'] = array();
        }
        
        if (isset($this->error['keyword'])) {
            $data['error_keyword'] = $this->error['keyword'];
        } else {
            $data['error_keyword'] = '';
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
            'href' => $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );
        
        if (!isset($this->request->get['phpner_blog_category_id'])) {
            $data['action'] = $this->url->link('phpner/blog_category/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $data['action'] = $this->url->link('phpner/blog_category/edit', 'token=' . $this->session->data['token'] . '&phpner_blog_category_id=' . $this->request->get['phpner_blog_category_id'] . $url, 'SSL');
        }
        
        $data['cancel'] = $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        if (isset($this->request->get['phpner_blog_category_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $category_info = $this->model_phpner_blog_category->getCategory($this->request->get['phpner_blog_category_id']);
        }
        
        $data['token'] = $this->session->data['token'];
        
        $this->load->model('localisation/language');
        
        $data['languages'] = $this->model_localisation_language->getLanguages();
        
        if (isset($this->request->post['category_description'])) {
            $data['category_description'] = $this->request->post['category_description'];
        } elseif (isset($this->request->get['phpner_blog_category_id'])) {
            $data['category_description'] = $this->model_phpner_blog_category->getCategoryDescriptions($this->request->get['phpner_blog_category_id']);
        } else {
            $data['category_description'] = array();
        }
        
        if (isset($this->request->post['cpath'])) {
            $data['cpath'] = $this->request->post['cpath'];
        } elseif (!empty($category_info)) {
            $data['cpath'] = $category_info['cpath'];
        } else {
            $data['cpath'] = '';
        }
        
        // Categories
        $categories = $this->model_phpner_blog_category->getAllCategories();
        
        $data['categories'] = $this->getAllCategories($categories);
        
        if (isset($category_info)) {
            unset($data['categories'][$category_info['phpner_blog_category_id']]);
        }
        
        if (isset($this->request->post['phpner_blog_category_parent_id'])) {
            $data['phpner_blog_category_parent_id'] = $this->request->post['phpner_blog_category_parent_id'];
        } elseif (!empty($category_info)) {
            $data['phpner_blog_category_parent_id'] = $category_info['phpner_blog_category_parent_id'];
        } else {
            $data['phpner_blog_category_parent_id'] = 0;
        }
        
        $this->load->model('setting/store');
        
        $data['stores'] = $this->model_setting_store->getStores();
        
        if (isset($this->request->post['category_store'])) {
            $data['category_store'] = $this->request->post['category_store'];
        } elseif (isset($this->request->get['phpner_blog_category_id'])) {
            $data['category_store'] = $this->model_phpner_blog_category->getCategoryStores($this->request->get['phpner_blog_category_id']);
        } else {
            $data['category_store'] = array(
                0
            );
        }
        
        if (isset($this->request->post['keyword'])) {
            $data['keyword'] = $this->request->post['keyword'];
        } elseif (!empty($category_info)) {
            $data['keyword'] = $category_info['keyword'];
        } else {
            $data['keyword'] = '';
        }
        
        if (isset($this->request->post['image'])) {
            $data['image'] = $this->request->post['image'];
        } elseif (!empty($category_info)) {
            $data['image'] = $category_info['image'];
        } else {
            $data['image'] = '';
        }
        
        $this->load->model('tool/image');
        
        if (isset($this->request->post['image']) && is_file(DIR_IMAGE . $this->request->post['image'])) {
            $data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
        } elseif (!empty($category_info) && is_file(DIR_IMAGE . $category_info['image'])) {
            $data['thumb'] = $this->model_tool_image->resize($category_info['image'], 100, 100);
        } else {
            $data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }
        
        $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        
        if (isset($this->request->post['sort_order'])) {
            $data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($category_info)) {
            $data['sort_order'] = $category_info['sort_order'];
        } else {
            $data['sort_order'] = 0;
        }
        
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($category_info)) {
            $data['status'] = $category_info['status'];
        } else {
            $data['status'] = true;
        }
        
        if (isset($this->request->post['category_layout'])) {
            $data['category_layout'] = $this->request->post['category_layout'];
        } elseif (isset($this->request->get['phpner_blog_category_id'])) {
            $data['category_layout'] = $this->model_phpner_blog_category->getCategoryLayouts($this->request->get['phpner_blog_category_id']);
        } else {
            $data['category_layout'] = array();
        }
        
        $this->load->model('design/layout');
        
        $data['layouts'] = $this->model_design_layout->getLayouts();
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('phpner/blog_category_form.tpl', $data));
    }
    
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'phpner/blog_category')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        foreach ($this->request->post['category_description'] as $language_id => $value) {
            if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
                $this->error['name'][$language_id] = $this->language->get('error_name');
            }
            
            if ((utf8_strlen($value['meta_title']) < 3) || (utf8_strlen($value['meta_title']) > 255)) {
                $this->error['meta_title'][$language_id] = $this->language->get('error_meta_title');
            }
        }
        
        if (utf8_strlen($this->request->post['keyword']) > 0) {
            $this->load->model('catalog/url_alias');
            
            $url_alias_info = $this->model_catalog_url_alias->getUrlAlias($this->request->post['keyword']);
            
            if ($url_alias_info && isset($this->request->get['phpner_blog_category_id']) && $url_alias_info['query'] != 'phpner_blog_category_id=' . $this->request->get['phpner_blog_category_id']) {
                $this->error['keyword'] = sprintf($this->language->get('error_keyword'));
            }
            
            if ($url_alias_info && !isset($this->request->get['phpner_blog_category_id'])) {
                $this->error['keyword'] = sprintf($this->language->get('error_keyword'));
            }
            
            if ($this->error && !isset($this->error['warning'])) {
                $this->error['warning'] = $this->language->get('error_warning');
            }
        }
        
        return !$this->error;
    }
    
    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'phpner/blog_category')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
    
    private function getCategories($phpner_blog_category_parent_id, $parent_path = '', $indent = '') {
        $phpner_blog_category_id = array_shift($this->phpner_blog_category_path);
        
        $output = array();
        
        static $href_category = null;
        static $href_action = null;
        
        if ($href_category === null) {
            $href_category = $this->url->link('phpner/blog_category', 'token=' . $this->session->data['token'] . '&cpath=', 'SSL');
            $href_action   = $this->url->link('phpner/blog_category/update', 'token=' . $this->session->data['token'] . '&phpner_blog_category_id=', 'SSL');
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
        
        $results = $this->model_phpner_blog_category->getCategoriesByParentId($phpner_blog_category_parent_id);
        
        foreach ($results as $result) {
            $path = $parent_path . $result['phpner_blog_category_id'];
            
            $href = ($result['children']) ? $href_category . $path : '';
            
            $name = $result['name'];
            
            if ($phpner_blog_category_id == $result['phpner_blog_category_id']) {
                $name = '<b>' . $name . '</b>';
                
                $data['breadcrumbs'][] = array(
                    'text' => $result['name'],
                    'href' => $href,
                    'separator' => ' :: '
                );
                
                $href = '';
            }
            
            $selected = isset($this->request->post['selected']) && in_array($result['phpner_blog_category_id'], $this->request->post['selected']);
            
            $action = array();
            
            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $href_action . $result['phpner_blog_category_id']
            );
            
            $output[$result['phpner_blog_category_id']] = array(
                'phpner_blog_category_id' => $result['phpner_blog_category_id'],
                'name' => $name,
                'sort_order' => $result['sort_order'],
                'selected' => $selected,
                'action' => $action,
                'edit' => $this->url->link('phpner/blog_category/edit', 'token=' . $this->session->data['token'] . '&phpner_blog_category_id=' . $result['phpner_blog_category_id'] . $url, 'SSL'),
                'delete' => $this->url->link('phpner/blog_category/delete', 'token=' . $this->session->data['token'] . '&phpner_blog_category_id=' . $result['phpner_blog_category_id'] . $url, 'SSL'),
                'href' => $href,
                'indent' => $indent
            );
            
            if ($phpner_blog_category_id == $result['phpner_blog_category_id']) {
                $output += $this->getCategories($result['phpner_blog_category_id'], $path . '_', $indent . str_repeat('&nbsp;', 8));
            }
        }
        
        return $output;
    }
    
    private function getAllCategories($categories, $phpner_blog_category_parent_id = 0, $parent_name = '') {
        $output = array();
        
        if (array_key_exists($phpner_blog_category_parent_id, $categories)) {
            if ($parent_name != '') {
                //$parent_name .= $this->language->get('text_separator');
                $parent_name .= ' &gt; ';
            }
            
            foreach ($categories[$phpner_blog_category_parent_id] as $category) {
                $output[$category['phpner_blog_category_id']] = array(
                    'phpner_blog_category_id' => $category['phpner_blog_category_id'],
                    'name' => $parent_name . $category['name']
                );
                
                $output += $this->getAllCategories($categories, $category['phpner_blog_category_id'], $parent_name . $category['name']);
            }
        }
        
        uasort($output, array(
            $this,
            'sortByName'
        ));
        
        return $output;
    }
    
    function sortByName($a, $b) {
        return strcmp($a['name'], $b['name']);
    }
    
    public function autocomplete() {
        $json = array();
        
        if (isset($this->request->get['filter_name'])) {
            $this->load->model('phpner/blog_category');
            
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'sort' => 'name',
                'order' => 'ASC',
                'start' => 0,
                'limit' => 5
            );
            
            $results = $this->model_phpner_blog_category->getCategories($filter_data);
            
            foreach ($results as $result) {
                $json[] = array(
                    'phpner_blog_category_id' => $result['phpner_blog_category_id'],
                    'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }
        
        $sort_order = array();
        
        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }
        
        array_multisort($sort_order, SORT_ASC, $json);
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}