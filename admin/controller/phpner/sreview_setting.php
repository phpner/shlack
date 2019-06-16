<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerPhpnerSreviewSetting extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('phpner/sreview_setting');
        
        $this->load->model('setting/setting');
        $this->load->model('extension/extension');
        $this->load->model('user/user_group');
        $this->load->model('phpner/sreview_setting');
        
        if (!in_array('phpner_sreview_setting', $this->model_extension_extension->getInstalled('extension'))) {
            
            $this->model_phpner_sreview_setting->installTables();
            
            $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'phpner/sreview_setting');
            $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'phpner/sreview_setting');
            $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'phpner/sreview_subject');
            $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'phpner/sreview_subject');
            $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'phpner/sreview_subject');
            $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'phpner/sreview_subject');
            
            $this->model_setting_setting->editSetting('phpner_sreview_setting', array(
                'phpner_sreview_setting_data' => array(
                    'status' => '1',
                    'review_moderation' => '1'
                )
            ));
            
            $this->model_extension_extension->install('extension', 'phpner_sreview_setting');
        }
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('phpner_sreview_setting', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->response->redirect($this->url->link('phpner/sreview_setting', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_edit']     = $this->language->get('text_edit');
        $data['text_enabled']  = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        
        $data['tab_setting'] = $this->language->get('tab_setting');
        
        $data['entry_status']            = $this->language->get('entry_status');
        $data['entry_review_moderation'] = $this->language->get('entry_review_moderation');
        $data['entry_desc_limit']        = $this->language->get('entry_desc_limit');
        
        $data['button_save']      = $this->language->get('button_save');
        $data['button_cancel']    = $this->language->get('button_cancel');
        $data['button_uninstall'] = $this->language->get('button_uninstall');
        
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
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('phpner/sreview_setting', 'token=' . $this->session->data['token'], 'SSL')
        );
        
        $data['action']    = $this->url->link('phpner/sreview_setting', 'token=' . $this->session->data['token'], 'SSL');
        $data['uninstall'] = $this->url->link('phpner/sreview_setting/uninstall', 'token=' . $this->session->data['token'], 'SSL');
        $data['cancel']    = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL');
        
        if (isset($this->request->post['phpner_sreview_setting_data'])) {
            $data['phpner_sreview_setting_data'] = $this->request->post['phpner_sreview_setting_data'];
        } else {
            $data['phpner_sreview_setting_data'] = $this->config->get('phpner_sreview_setting_data');
        }
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('phpner/sreview_setting.tpl', $data));
    }
    
    public function uninstall() {
        $this->load->language('phpner/sreview_setting');
        
        $this->load->model('extension/extension');
        
        $this->model_extension_extension->uninstall('extension', 'phpner_sreview_setting');
        
        $this->load->model('setting/setting');
        
        $this->model_setting_setting->deleteSetting('phpner_sreview_setting');
        
        $this->load->model('phpner/sreview_setting');
        
        $this->model_phpner_sreview_setting->deleteTables();
        
        $this->session->data['success'] = $this->language->get('text_success_uninstall');
        
        $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'phpner/sreview_setting')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
}