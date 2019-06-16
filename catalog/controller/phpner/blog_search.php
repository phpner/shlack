<?php
/**************************************************************/
/*	@copyright	Phpner 2019							  */
/*	@support	http://phpner.ru					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerPhpnerBlogSearch extends Controller {
    public function index() {
        $this->load->language('phpner/blog_search');
        
        $this->load->model('phpner/blog_article');
        
        $this->load->model('tool/image');
        
        $phpner_blog_setting_data = $this->config->get('phpner_blog_setting_data');
        
        if (isset($this->request->get['search'])) {
            $search = $this->request->get['search'];
        } else {
            $search = '';
        }
        
        if (isset($this->request->get['tag'])) {
            $tag = $this->request->get['tag'];
        } elseif (isset($this->request->get['search'])) {
            $tag = $this->request->get['search'];
        } else {
            $tag = '';
        }
        
        if (isset($this->request->get['description'])) {
            $description = $this->request->get['description'];
        } else {
            $description = '';
        }
        
        if (isset($this->request->get['category_id'])) {
            $category_id = $this->request->get['category_id'];
        } else {
            $category_id = 0;
        }
        
        if (isset($this->request->get['sub_category'])) {
            $sub_category = $this->request->get['sub_category'];
        } else {
            $sub_category = '';
        }
        
        $sort = 'a.date_added_desc';
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        
        $limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
        
        if (isset($this->request->get['search'])) {
            $this->document->setTitle($this->language->get('heading_title') . ' - ' . $this->request->get['search']);
        } elseif (isset($this->request->get['tag'])) {
            $this->document->setTitle($this->language->get('heading_title') . ' - ' . $this->language->get('heading_tag') . $this->request->get['tag']);
        } else {
            $this->document->setTitle($this->language->get('heading_title'));
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        
        $url = '';
        
        if (isset($this->request->get['search'])) {
            $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
        }
        
        if (isset($this->request->get['tag'])) {
            $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
        }
        
        if (isset($this->request->get['description'])) {
            $url .= '&description=' . $this->request->get['description'];
        }
        
        if (isset($this->request->get['category_id'])) {
            $url .= '&category_id=' . $this->request->get['category_id'];
        }
        
        if (isset($this->request->get['sub_category'])) {
            $url .= '&sub_category=' . $this->request->get['sub_category'];
        }
        
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('phpner/blog_search', $url)
        );
        
        if (isset($this->request->get['search'])) {
            $data['heading_title'] = $this->language->get('heading_title') . ' - ' . $this->request->get['search'];
        } else {
            $data['heading_title'] = $this->language->get('heading_title');
        }
        
        $data['text_empty']        = $this->language->get('text_empty');
        $data['text_search']       = $this->language->get('text_search');
        $data['text_keyword']      = $this->language->get('text_keyword');
        $data['text_category']     = $this->language->get('text_category');
        $data['text_sub_category'] = $this->language->get('text_sub_category');
        
        $data['entry_search']      = $this->language->get('entry_search');
        $data['entry_description'] = $this->language->get('entry_description');
        
        $data['button_search'] = $this->language->get('button_search');
        
        $this->load->model('phpner/blog_category');
        
        // 3 Level Category Search
        $data['categories'] = array();
        
        $categories_1 = $this->model_phpner_blog_category->getCategories(0);
        
        foreach ($categories_1 as $category_1) {
            $level_2_data = array();
            
            $categories_2 = $this->model_phpner_blog_category->getCategories($category_1['phpner_blog_category_id']);
            
            foreach ($categories_2 as $category_2) {
                $level_3_data = array();
                
                $categories_3 = $this->model_phpner_blog_category->getCategories($category_2['phpner_blog_category_id']);
                
                foreach ($categories_3 as $category_3) {
                    $level_3_data[] = array(
                        'category_id' => $category_3['phpner_blog_category_id'],
                        'name' => $category_3['name']
                    );
                }
                
                $level_2_data[] = array(
                    'category_id' => $category_2['phpner_blog_category_id'],
                    'name' => $category_2['name'],
                    'children' => $level_3_data
                );
            }
            
            $data['categories'][] = array(
                'category_id' => $category_1['phpner_blog_category_id'],
                'name' => $category_1['name'],
                'children' => $level_2_data
            );
        }
        
        $data['articles'] = array();
        
        if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
            $filter_data = array(
                'filter_name' => $search,
                'filter_tag' => $tag,
                'filter_description' => $description,
                'filter_category_id' => $category_id,
                'filter_sub_category' => $sub_category,
                'sort' => $sort,
                'start' => ($page - 1) * $limit,
                'limit' => $limit
            );
            
            $article_total = $this->model_phpner_blog_article->getTotalArticles($filter_data);
            
            $a_results = $this->model_phpner_blog_article->getArticles($filter_data);
            
            foreach ($a_results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $phpner_blog_setting_data['a_image_width_in_category'], $phpner_blog_setting_data['a_image_height_in_category']);
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $phpner_blog_setting_data['a_image_width_in_category'], $phpner_blog_setting_data['a_image_height_in_category']);
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = (int) $result['rating'];
                } else {
                    $rating = false;
                }
                
                $data['articles'][] = array(
                    'phpner_blog_article_id' => $result['phpner_blog_article_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                    'comments' => $result['comments'] ? $result['comments'] : 0,
                    'viewed' => $result['viewed'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $phpner_blog_setting_data['desc_limit']) . '..',
                    'rating' => $rating,
                    'href' => $this->url->link('phpner/blog_article', 'phpner_blog_article_id=' . $result['phpner_blog_article_id'])
                );
            }
            
            $url = '';
            
            if (isset($this->request->get['search'])) {
                $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }
            
            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }
            
            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }
            
            $url = '';
            
            if (isset($this->request->get['search'])) {
                $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }
            
            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }
            
            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }
            
            $url = '';
            
            if (isset($this->request->get['search'])) {
                $url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            
            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }
            
            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }
            
            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }
            
            $pagination        = new Pagination();
            $pagination->total = $article_total;
            $pagination->page  = $page;
            $pagination->limit = $limit;
            $pagination->url   = $this->url->link('phpner/blog_search', $url . '&page={page}');
            
            $data['pagination'] = $pagination->render();
            
            $data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($article_total - $limit)) ? $article_total : ((($page - 1) * $limit) + $limit), $article_total, ceil($article_total / $limit));
            
            // http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
            if ($page == 1) {
                $this->document->addLink($this->url->link('phpner/blog_search', '', true), 'canonical');
            } elseif ($page == 2) {
                $this->document->addLink($this->url->link('phpner/blog_search', '', true), 'prev');
            } else {
                $this->document->addLink($this->url->link('phpner/blog_search', $url . '&page=' . ($page - 1), true), 'prev');
            }
            
            if ($limit && ceil($article_total / $limit) > $page) {
                $this->document->addLink($this->url->link('phpner/blog_search', $url . '&page=' . ($page + 1), true), 'next');
            }
        }
        
        $data['search']       = $search;
        $data['description']  = $description;
        $data['category_id']  = $category_id;
        $data['sub_category'] = $sub_category;
        
        $data['column_left']    = $this->load->controller('common/column_left');
        $data['column_right']   = $this->load->controller('common/column_right');
        $data['content_top']    = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer']         = $this->load->controller('common/footer');
        $data['header']         = $this->load->controller('common/header');
        
        $this->response->setOutput($this->load->view('phpner_store/blog_search', $data));
    }
}