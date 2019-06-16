<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerPopupAddToWishlist extends Controller {
    public function index() {
        $data = array();
        
        $this->load->model('catalog/product');
        $this->load->language('extension/module/phpner_popup_add_to_wishlist');
        
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }
        
        $data['button_ok'] = $this->language->get('button_ok');
        
        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        if ($product_info) {
            if (!$this->customer->isLogged()) {
                $data['heading_title'] = $this->language->get('heading_title_no');
                $data['success_add']   = false;
                
                $data['text_warning_add'] = sprintf($this->language->get('text_warning_add'), $this->url->link('product/product', 'product_id=' . (int) $product_id), $product_info['name'], $this->url->link('account/wishlist'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
            } else {
                $data['heading_title']    = $this->language->get('heading_title_ok');
                $data['success_add']      = true;
                $data['text_success_add'] = $this->language->get('text_success_add');
                $data['text_wishlist']    = $this->language->get('text_wishlist');
                
                $data['wishlist_url'] = $this->url->link('account/wishlist');
            }
            
            $data['product_name'] = $product_info['name'];
            $data['product_link'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
            
            $this->response->setOutput($this->load->view('extension/module/phpner_popup_add_to_wishlist', $data));
        }
    }
}