<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupLogin extends Controller {
    public function index() {
        $data = array();
        
        $this->load->language('extension/module/phpner_popup_login');
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_login']     = $this->language->get('text_login');
        $data['entry_email']    = $this->language->get('entry_email');
        $data['entry_password'] = $this->language->get('entry_password');
        
        $data['button_login']     = $this->language->get('button_login');
        $data['button_register']  = $this->language->get('button_register');
        $data['button_forgotten'] = $this->language->get('button_forgotten');
        
        $data['register_url']  = $this->url->link('account/register', '', 'SSL');
        $data['forgotten_url'] = $this->url->link('account/forgotten', '', 'SSL');
        $data['account_url']   = $this->url->link('account/account', '', 'SSL');
        
        $phpner_data = $this->config->get('phpner_store_data');
        
        if (isset($phpner_data['terms']) && $phpner_data['terms']) {
            $this->load->model('catalog/information');
            
            $information_info = $this->model_catalog_information->getInformation($phpner_data['terms']);
            
            if ($information_info) {
                $data['text_terms'] = sprintf($this->language->get('text_phpner_terms'), $this->url->link('information/information', 'information_id=' . $phpner_data['terms'], 'SSL'), $information_info['title'], $information_info['title']);
            } else {
                $data['text_terms'] = '';
            }
        } else {
            $data['text_terms'] = '';
        }
        
        $this->response->setOutput($this->load->view('extension/module/phpner_popup_login', $data));
    }
    
    public function login() {
        $json = array();
        
        $this->load->language('extension/module/phpner_popup_login');
        $this->load->model('account/customer');
        
        // Check how many login attempts have been made.
        $login_info = $this->model_account_customer->getLoginAttempts($this->request->post['email']);
        
        if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
            $json['warning'] = $this->language->get('error_attempts');
        }
        
        // Check if customer has been approved.
        $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
        
        if ($customer_info && !$customer_info['approved']) {
            $json['warning'] = $this->language->get('error_approved');
        }
        
        $phpner_data = $this->config->get('phpner_store_data');
        
        if (isset($phpner_data['terms']) && $phpner_data['terms']) {
            if (!isset($this->request->post['terms'])) {
                $this->load->model('catalog/information');
                
                $information_info = $this->model_catalog_information->getInformation($phpner_data['terms']);
                
                $json['warning'] = sprintf($this->language->get('error_phpner_terms'), $information_info['title']);
            }
        }
        
        if (!isset($json['warning'])) {
            if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
                $json['warning'] = $this->language->get('error_login');
                
                $this->model_account_customer->addLoginAttempt($this->request->post['email']);
            } else {
                $this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
            }
        }
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}