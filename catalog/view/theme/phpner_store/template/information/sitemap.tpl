<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row">
    <div class="breadcrumb-box">
      	 <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
		    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
			    <?php if($count == 0) { ?>
				  <li>
					<a href="<?php echo $breadcrumb['href']; ?>">
					  <?php echo $breadcrumb['text']; ?>
					</a>
				  </li>
		        <?php } elseif($count+1<count($breadcrumbs)) { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
					<a itemscope itemtype="https://schema.org/Thing" itemprop="item" href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>">
					  <span itemprop="name" class="breadcrumbsitem"><?php echo $breadcrumb['text']; ?></span>
					  <?php echo $breadcrumb['text']; ?>
					</a>
					<meta itemprop="position" content="<?php echo $count; ?>" />
					</li>
		        <?php } else { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
		        	<span itemscope itemtype="https://schema.org/Thing" itemprop="item">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</span>
					<meta itemprop="position" content="<?php echo $count; ?>" />
		        	</li>
		        <?php } ?>
			<?php } ?>
	  </ul>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <h1 class="cat-header"><?php echo $heading_title; ?></h1>
      </div>
    </div>
    <div class="row">
      <?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>">
        <div class="row">
          <div class="col-sm-6">
            <ul>
              <?php foreach ($categories as $category_1) { ?>
              <li>
                <a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
                <?php if ($category_1['children']) { ?>
                <ul>
                  <?php foreach ($category_1['children'] as $category_2) { ?>
                  <li>
                    <a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>
                    <?php if ($category_2['children']) { ?>
                    <ul>
                      <?php foreach ($category_2['children'] as $category_3) { ?>
                      <li><a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a></li>
                      <?php } ?>
                    </ul>
                    <?php } ?>
                  </li>
                  <?php } ?>
                </ul>
                <?php } ?>
              </li>
              <?php } ?>
            </ul>
          </div>
          <div class="col-sm-6">
            <ul>
              <li>
                <a href="<?php echo $phpner_blog; ?>"><?php echo (isset($phpner_blog_text['text_articles'])) ? $phpner_blog_text['text_articles'] : ''; ?></a>
                <?php if ($phpner_blog_categories) { ?>
                  <?php foreach ($phpner_blog_categories as $phpner_blog_category) { ?>
                    <ul>
                      <li>
                        <a href="<?php echo $phpner_blog_category['href']; ?>"><?php echo $phpner_blog_category['name']; ?></a>
                        <?php if ($phpner_blog_category['articles']) { ?>
                        <ul>
                          <?php foreach ($phpner_blog_category['articles'] as $phpner_blog_child_article) { ?>
                          <li>
                            <a href="<?php echo $phpner_blog_child_article['href']; ?>"><?php echo $phpner_blog_child_article['name']; ?></a>
                          </li>
                          <?php } ?>
                        </ul>
                        <?php } ?>
                        <?php if ($phpner_blog_category['children']) { ?>
                        <ul>
                          <?php foreach ($phpner_blog_category['children'] as $phpner_blog_child) { ?>
                          <li>
                            <a href="<?php echo $phpner_blog_child['href']; ?>"><?php echo $phpner_blog_child['name']; ?></a>
                            <?php if ($phpner_blog_child['articles']) { ?>
                              <ul>
                                <?php foreach ($phpner_blog_child['articles'] as $phpner_blog_child_inner) { ?>
                                <li><a href="<?php echo $phpner_blog_child_inner['href']; ?>"><?php echo $phpner_blog_child_inner['name']; ?></a></li>
                                <?php } ?>
                              </ul>
                            <?php } ?>
                          </li>
                          <?php } ?>
                        </ul>
                        <?php } ?>
                      </li>
                    </ul>
                  <?php } ?>
                <?php } ?>
              </li>
              <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
              <li>
                <a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
                <ul>
                  <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
                  <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
                  <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
                  <li><a href="<?php echo $history; ?>"><?php echo $text_history; ?></a></li>
                  <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                </ul>
              </li>
              <li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>
              <li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
              <li><a href="<?php echo $search; ?>"><?php echo $text_search; ?></a></li>
              <li>
                <?php echo $text_information; ?>
                <ul>
                  <?php foreach ($informations as $information) { ?>
                  <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                  <?php } ?>
                  <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>