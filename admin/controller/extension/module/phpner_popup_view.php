<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupView extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('extension/module/phpner_popup_view');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        $this->load->model('catalog/option');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('phpner_popup_view', $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_edit']              = $this->language->get('text_edit');
        $data['text_enabled']           = $this->language->get('text_enabled');
        $data['text_disabled']          = $this->language->get('text_disabled');
        $data['text_enabled_required']  = $this->language->get('text_enabled_required');
        $data['text_options']           = $this->language->get('text_options');
        $data['text_select_all']        = $this->language->get('text_select_all');
        $data['text_unselect_all']      = $this->language->get('text_unselect_all');
        $data['text_allow_stock_check'] = $this->language->get('text_allow_stock_check');
        
        $data['tab_setting'] = $this->language->get('tab_setting');
        
        $data['entry_status']            = $this->language->get('entry_status');
        $data['entry_firstname']         = $this->language->get('entry_firstname');
        $data['entry_email']             = $this->language->get('entry_email');
        $data['entry_telephone']         = $this->language->get('entry_telephone');
        $data['entry_comment']           = $this->language->get('entry_comment');
        $data['entry_quantity']          = $this->language->get('entry_quantity');
        $data['entry_description_tab']   = $this->language->get('entry_description_tab');
        $data['entry_specification_tab'] = $this->language->get('entry_specification_tab');
        $data['entry_review_tab']        = $this->language->get('entry_review_tab');
        $data['entry_image']             = $this->language->get('entry_image');
        $data['entry_description_max']   = $this->language->get('entry_description_max');
        $data['entry_height']            = $this->language->get('entry_height');
        $data['entry_width']             = $this->language->get('entry_width');
        $data['entry_allow_page']        = $this->language->get('entry_allow_page');
        $data['entry_wishlist']          = $this->language->get('entry_wishlist');
        $data['entry_compare']           = $this->language->get('entry_compare');
        $data['entry_additional_image']  = $this->language->get('entry_additional_image');
        $data['entry_additional_width']  = $this->language->get('entry_additional_width');
        $data['entry_additional_height'] = $this->language->get('entry_additional_height');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        $data['help_stock_checkout'] = $this->language->get('help_stock_checkout');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
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
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/phpner_popup_view', 'token=' . $this->session->data['token'], true)
        );
        
        $data['action'] = $this->url->link('extension/module/phpner_popup_view', 'token=' . $this->session->data['token'], true);
        
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        
        if (isset($this->request->post['phpner_popup_view_data'])) {
            $data['phpner_popup_view_data'] = $this->request->post['phpner_popup_view_data'];
        } else {
            $data['phpner_popup_view_data'] = $this->config->get('phpner_popup_view_data');
        }
        
        $data['options'] = array();
        
        foreach ($this->model_catalog_option->getOptions() as $product_option) {
            $data['options'][] = array(
                'option_id' => $product_option['option_id'],
                'name' => $product_option['name']
            );
        }
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/phpner_popup_view.tpl', $data));
    }
    
    public function install() {
        $this->load->language('extension/module/phpner_popup_view');
        
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('user/user_group');
        
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/phpner_popup_view');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/phpner_popup_view');
        
        $this->model_setting_setting->editSetting('phpner_popup_view', array(
            'phpner_popup_view_data' => array(
                'status' => '1',
                'quantity' => '1',
                'specification' => '1',
                'review' => '1',
                'wishlist' => '1',
                'compare' => '1',
                'description' => '1',
                'description_max' => '255',
                'image' => '1',
                'image_width' => '228',
                'image_height' => '228',
                'additional_image' => '1',
                'image_additional_width' => '68',
                'image_additional_height' => '68'
            )
        ));
        
        if (!in_array('phpner_popup_view', $this->model_extension_extension->getInstalled('module'))) {
            $this->model_extension_extension->install('module', 'phpner_popup_view');
        }
        
        $this->session->data['success'] = $this->language->get('text_success_install');
    }
    
    public function uninstall() {
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->model_extension_extension->uninstall('module', 'phpner_popup_view');
        $this->model_setting_setting->deleteSetting('phpner_popup_view_data');
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/phpner_popup_view')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
}