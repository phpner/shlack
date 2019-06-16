<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupAddToCart extends Controller {
    public function index() {
        $data = array();
        
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $this->load->language('extension/module/phpner_popup_add_to_cart');
        
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }
        
        $data['heading_title']              = $this->language->get('heading_title');
        $data['button_close']               = $this->language->get('button_close');
        $data['button_checkout']            = $this->language->get('button_checkout');
        $data['text_go_to_checkout']        = $this->language->get('text_go_to_checkout');
        $data['text_continue_shopping']     = $this->language->get('text_continue_shopping');
        $data['text_already_in_the_basket'] = $this->language->get('text_already_in_the_basket');
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        if ($product_info) {
            $data['checkout_url'] = $this->url->link('checkout/checkout');
            
            $data['product_name'] = $product_info['name'];
            
            if ($product_info['image']) {
                $data['product_thumb'] = $this->model_tool_image->resize($product_info['image'], 287, 385);
            } else {
                $data['product_thumb'] = $this->model_tool_image->resize('placeholder.png', 287, 385);
            }
            
            $this->response->setOutput($this->load->view('extension/module/phpner_popup_add_to_cart', $data));
        }
    }
}