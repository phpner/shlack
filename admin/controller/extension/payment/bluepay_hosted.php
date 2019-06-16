<?php
class ControllerExtensionPaymentBluePayHosted extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/payment/bluepay_hosted');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('bluepay_hosted', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_sim'] = $this->language->get('text_sim');
		$data['text_test'] = $this->language->get('text_test');
		$data['text_live'] = $this->language->get('text_live');
		$data['text_sale'] = $this->language->get('text_sale');
		$data['text_authenticate'] = $this->language->get('text_authenticate');
		$data['text_amex'] = $this->language->get('text_amex');
		$data['text_discover'] = $this->language->get('text_discover');

		$data['entry_account_name'] = $this->language->get('entry_account_name');
		$data['entry_account_id'] = $this->language->get('entry_account_id');
		$data['entry_secret_key'] = $this->language->get('entry_secret_key');
		$data['entry_test'] = $this->language->get('entry_test');
		$data['entry_transaction'] = $this->language->get('entry_transaction');
		$data['entry_card_amex'] = $this->language->get('entry_card_amex');
		$data['entry_card_discover'] = $this->language->get('entry_card_discover');

		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_debug'] = $this->language->get('entry_debug');
		$data['entry_card'] = $this->language->get('entry_card');

		$data['help_total'] = $this->language->get('help_total');
		$data['help_debug'] = $this->language->get('help_debug');
		$data['help_transaction'] = $this->language->get('help_transaction');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['accoun