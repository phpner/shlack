<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModulePhpnerBlogCategory extends Controller {
    public function index($setting) {
        $this->load->language('extension/module/phpner_blog_category');
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $this->load->model('phpner/blog_category');
        $this->load->model('phpner/blog_article');
        
        if (isset($this->request->get['cpath'])) {
            $parts = explode('_', (string) $this->request->get['cpath']);
        } else {
            $parts = array();
        }
        
        if (isset($parts[0])) {
            $data['phpner_blog_category_id'] = $parts[0];
        } else {
            $data['phpner_blog_category_id'] = 0;
        }
        
        if (isset($parts[1])) {
            $data['phpner_blog_category_child_id'] = $parts[1];
        } else {
            $data['phpner_blog_category_child_id'] = 0;
        }
        
        $data['categories'] = array();
        
        $this->load->model('tool/image');
        
        $categories = $this->model_phpner_blog_category->getCategories();
        
        foreach ($categories as $category) {
            $children_data = array();
            
            if ($category['phpner_blog_category_id'] == $data['phpner_blog_category_id']) {
                $children = $this->model_phpner_blog_category->getCategories($category['phpner_blog_category_id']);
                
                foreach ($children as $child) {
                    $filter_data_child = array(
                        'filter_category_id' => $child['phpner_blog_category_id'],
                        'filter_sub_category' => false
                    );
                    
                    if ($child['image']) {
                        $children_image = $this->model_tool_image->resize($child['image'], $setting['width'], $setting['height']);
                    } else {
                        $children_image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                    }
                    
                    $children_data[] = array(
                        'phpner_blog_category_id' => $child['phpner_blog_category_id'],
                        'name' => $child['name'] . ' (' . $this->model_phpner_blog_article->getTotalArticles($filter_data_child) . ')',
                        'thumb' => ($setting['show_image']) ? $children_image : false,
                        'href' => $this->url->link('phpner/blog_category', 'cpath=' . $category['phpner_blog_category_id'] . '_' . $child['phpner_blog_category_id'])
                    );
                }
            }
            
            $filter_data = array(
                'filter_category_id' => $category['phpner_blog_category_id'],
                'filter_sub_category' => false
            );
            
            if ($category['image']) {
                $image = $this->model_tool_image->resize($category['image'], $setting['width'], $setting['height']);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
            }
            
            $data['categories'][] = array(
                'phpner_blog_category_id' => $category['phpner_blog_category_id'],
                'name' => $category['name'] . ' (' . $this->model_phpner_blog_article->getTotalArticles($filter_data) . ')',
                'children' => $children_data,
                'thumb' => ($setting['show_image']) ? $image : false,
                'href' => $this->url->link('phpner/blog_category', 'cpath=' . $category['phpner_blog_category_id'])
            );
        }
        
        return $this->load->view('extension/module/phpner_blog_category', $data);
    }
}