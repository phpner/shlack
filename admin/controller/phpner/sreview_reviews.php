<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerPhpnerSreviewReviews extends Controller {
    private $error = array();
    
    public function index() {
        $phpner_sreview_setting = $this->config->get('phpner_sreview_setting_data');
        
        if (!isset($phpner_sreview_setting['status']) || $phpner_sreview_setting['status'] != 1) {
            $this->response->redirect($this->url->link('phpner/sreview_setting', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        $this->load->language('phpner/sreview_reviews');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/sreview_reviews');
        
        $this->getList();
    }
    
    public function add() {
        $this->load->language('phpner/sreview_reviews');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/sreview_reviews');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_phpner_sreview_reviews->addReview($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $url = '';
            
            if (isset($this->request->get['filter_author'])) {
                $url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['filter_status'])) {
                $url .= '&filter_status=' . $this->request->get['filter_status'];
            }
            
            if (isset($this->request->get['filter_date_added'])) {
                $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
            }
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->response->redirect($this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getForm();
    }
    
    public function edit() {
        $this->load->language('phpner/sreview_reviews');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/sreview_reviews');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_phpner_sreview_reviews->editReview($this->request->get['phpner_sreview_review_id'], $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $url = '';
            
            if (isset($this->request->get['filter_author'])) {
                $url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['filter_status'])) {
                $url .= '&filter_status=' . $this->request->get['filter_status'];
            }
            
            if (isset($this->request->get['filter_date_added'])) {
                $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
            }
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->response->redirect($this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getForm();
    }
    
    public function delete() {
        $this->load->language('phpner/sreview_reviews');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('phpner/sreview_reviews');
        
        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $phpner_sreview_review_id) {
                $this->model_phpner_sreview_reviews->deleteReview($phpner_sreview_review_id);
            }
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $url = '';
            
            if (isset($this->request->get['filter_author'])) {
                $url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['filter_status'])) {
                $url .= '&filter_status=' . $this->request->get['filter_status'];
            }
            
            if (isset($this->request->get['filter_date_added'])) {
                $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
            }
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->response->redirect($this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
        
        $this->getList();
    }
    
    protected function getList() {
        
        if (isset($this->request->get['filter_author'])) {
            $filter_author = $this->request->get['filter_author'];
        } else {
            $filter_author = null;
        }
        
        if (isset($this->request->get['filter_status'])) {
            $filter_status = $this->request->get['filter_status'];
        } else {
            $filter_status = null;
        }
        
        if (isset($this->request->get['filter_date_added'])) {
            $filter_date_added = $this->request->get['filter_date_added'];
        } else {
            $filter_date_added = null;
        }
        
        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }
        
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort  = 'date_added';
            $order = 'DESC';
        }
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        
        $url = '';
        
        if (isset($this->request->get['filter_author'])) {
            $url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
        }
        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }
        
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }
        
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
            'href' => $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );
        
        $data['add']    = $this->url->link('phpner/sreview_reviews/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $data['delete'] = $this->url->link('phpner/sreview_reviews/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        $data['reviews'] = array();
        
        $filter_data = array(
            'filter_author' => $filter_author,
            'filter_status' => $filter_status,
            'filter_date_added' => $filter_date_added,
            'sort' => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );
        
        $review_total = $this->model_phpner_sreview_reviews->getTotalReviews($filter_data);
        
        $results = $this->model_phpner_sreview_reviews->getReviews($filter_data);
        
        foreach ($results as $result) {
            $data['reviews'][] = array(
                'phpner_sreview_review_id' => $result['phpner_sreview_review_id'],
                'author' => $result['author'],
                'status' => ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                'edit' => $this->url->link('phpner/sreview_reviews/edit', 'token=' . $this->session->data['token'] . '&phpner_sreview_review_id=' . $result['phpner_sreview_review_id'] . $url, 'SSL')
            );
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_list']       = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm']    = $this->language->get('text_confirm');
        $data['text_enabled']    = $this->language->get('text_enabled');
        $data['text_disabled']   = $this->language->get('text_disabled');
        
        $data['column_author']     = $this->language->get('column_author');
        $data['column_status']     = $this->language->get('column_status');
        $data['column_date_added'] = $this->language->get('column_date_added');
        $data['column_action']     = $this->language->get('column_action');
        
        $data['entry_author']     = $this->language->get('entry_author');
        $data['entry_status']     = $this->language->get('entry_status');
        $data['entry_date_added'] = $this->language->get('entry_date_added');
        
        $data['button_add']    = $this->language->get('button_add');
        $data['button_edit']   = $this->language->get('button_edit');
        $data['button_delete'] = $this->language->get('button_delete');
        $data['button_filter'] = $this->language->get('button_filter');
        
        $data['token'] = $this->session->data['token'];
        
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
        
        $data['sort_author']     = $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . '&sort=author' . $url, 'SSL');
        $data['sort_rating']     = $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . '&sort=rating' . $url, 'SSL');
        $data['sort_status']     = $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');
        $data['sort_date_added'] = $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . '&sort=date_added' . $url, 'SSL');
        
        $url = '';
        
        if (isset($this->request->get['filter_author'])) {
            $url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
        }
        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }
        
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }
        
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        $pagination        = new Pagination();
        $pagination->total = $review_total;
        $pagination->page  = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url   = $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
        
        $data['pagination'] = $pagination->render();
        
        $data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($review_total - $this->config->get('config_limit_admin'))) ? $review_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $review_total, ceil($review_total / $this->config->get('config_limit_admin')));
        
        $data['filter_author']     = $filter_author;
        $data['filter_status']     = $filter_status;
        $data['filter_date_added'] = $filter_date_added;
        
        $data['sort']  = $sort;
        $data['order'] = $order;
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('phpner/sreview_reviews_list.tpl', $data));
    }
    
    protected function getForm() {
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_form']     = !isset($this->request->get['phpner_sreview_review_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
        $data['text_enabled']  = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        
        $data['entry_author'] = $this->language->get('entry_author');
        $data['entry_rating'] = $this->language->get('entry_rating');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_text']   = $this->language->get('entry_text');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->error['author'])) {
            $data['error_author'] = $this->error['author'];
        } else {
            $data['error_author'] = '';
        }
        
        if (isset($this->error['text'])) {
            $data['error_text'] = $this->error['text'];
        } else {
            $data['error_text'] = '';
        }
        
        if (isset($this->error['rating'])) {
            $data['error_rating'] = $this->error['rating'];
        } else {
            $data['error_rating'] = '';
        }
        
        $url = '';
        
        if (isset($this->request->get['filter_author'])) {
            $url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
        }
        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }
        
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }
        
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
            'href' => $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );
        
        if (!isset($this->request->get['phpner_sreview_review_id'])) {
            $data['action'] = $this->url->link('phpner/sreview_reviews/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $data['action'] = $this->url->link('phpner/sreview_reviews/edit', 'token=' . $this->session->data['token'] . '&phpner_sreview_review_id=' . $this->request->get['phpner_sreview_review_id'] . $url, 'SSL');
        }
        
        $data['cancel'] = $this->url->link('phpner/sreview_reviews', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        if (isset($this->request->get['phpner_sreview_review_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $review_info = $this->model_phpner_sreview_reviews->getReview($this->request->get['phpner_sreview_review_id']);
        }
        
        $data['token'] = $this->session->data['token'];
        
        if (isset($this->request->post['author'])) {
            $data['author'] = $this->request->post['author'];
        } elseif (!empty($review_info)) {
            $data['author'] = $review_info['author'];
        } else {
            $data['author'] = '';
        }
        
        if (isset($this->request->post['text'])) {
            $data['text'] = $this->request->post['text'];
        } elseif (!empty($review_info)) {
            $data['text'] = $review_info['text'];
        } else {
            $data['text'] = '';
        }
        
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($review_info)) {
            $data['status'] = $review_info['status'];
        } else {
            $data['status'] = '';
        }
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('phpner/sreview_reviews_form.tpl', $data));
    }
    
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'phpner/sreview_reviews')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 64)) {
            $this->error['author'] = $this->language->get('error_author');
        }
        
        if (utf8_strlen($this->request->post['text']) < 1) {
            $this->error['text'] = $this->language->get('error_text');
        }
        
        return !$this->error;
    }
    
    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'phpner/sreview_reviews')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
    
    public function autocomplete() {
        $json = array();
        
        if (isset($this->request->get['filter_author'])) {
            $this->load->model('phpner/sreview_reviews');
            
            if (isset($this->request->get['filter_author'])) {
                $filter_author = $this->request->get['filter_author'];
            } else {
                $filter_author = '';
            }
            
            if (isset($this->request->get['limit'])) {
                $limit = $this->request->get['limit'];
            } else {
                $limit = 5;
            }
            
            $filter_data = array(
                'filter_author' => $filter_author,
                'start' => 0,
                'limit' => $limit
            );
            
            $results = $this->model_phpner_sreview_reviews->getReviews($filter_data);
            
            foreach ($results as $result) {
                $json[] = array(
                    'phpner_sreview_review_id' => $result['phpner_sreview_review_id'],
                    'author' => strip_tags(html_entity_decode($result['author'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}