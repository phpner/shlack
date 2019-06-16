<?php
class ControllerCommonSearch extends Controller {
	public function index() {
		$this->load->language('common/search');

		$data['text_search'] = $this->language->get('text_search');


				$this->load->language('phpner/phpner_store');
				$data['phpner_search_cat'] = $this->language->get('phpner_search_cat');
        
        if (isset($this->request->get['category_id'])) {
					$category_id = $this->request->get['category_id'];
				} else {
					$category_id = 0;
				}

				$data['category_id'] = $category_id;
				$data['search_phpner_cat'] = array();
				
				$search_cats = $this->model_catalog_category->getCategories(0);
				
				foreach ($search_cats as $search_cat) {
					$data['search_phpner_cat'][] = array(
						'category_id' => $search_cat['category_id'],
						'name'        => $search_cat['name']
					);
				}
      
		if (isset($this->request->get['search'])) {
			$data['search'] = $this->request->get['search'];
		} else {
			$data['search'] = '';
		}

		return $this->load->view('common/search', $data);
	}
}