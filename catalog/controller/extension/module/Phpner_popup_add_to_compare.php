<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupAddToCompare extends Controller {
	public function index() {
		$data = array();

		$this->load->model('catalog/product');
		$this->load->language('extension/module/phpner_popup_add_to_compare');

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_success_add'] = $this->language->get('text_success_add');
		$data['text_compare'] = $this->language->get('text_compare');
		$data['button_ok'] = $this->language->get('button_ok');
		$data['compare_url'] = $this->url->link('product/compare');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
		  $data['product_name'] = $product_info['name'];
		  $data['product_link'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);

			$this->response->setOutput($this->load->view('extension/module/phpner_popup_add_to_compare', $data));
		}
	}
}