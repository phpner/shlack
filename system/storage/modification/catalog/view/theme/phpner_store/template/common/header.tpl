<?php
if (!isset($phpner_store_status) || !$phpner_store_status) {
    exit("<a href=\"http://phpner.ru/install/phpner-store/\" target=\"_blank\"><img style=\"display: block;margin: 100px auto;\" src='http://phpner.ru/install/phpner-store/logo_installer.png' border='0'></a>");
}
?>
<!Dphpner_YPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; if (isset($_GET['page'])) { echo " - ".$text_page ." ". ((int) $_GET['page']);} ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
<meta property="og:type" content="website" />
<?php if (isset($og_url)) { ?><meta property="og:url" content="<?php echo $og_url; ?>" /><?php } ?>
<?php if (isset($og_image)) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<?php if ($phpner_store_data['enable_minify'] == 'off') { ?>
	<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
	<script src="catalog/view/theme/phpner_store/js/jquery-ui.min.js"></script>
	<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
	<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
	<link href="catalog/view/theme/phpner_store/stylesheet/flipclock.css" rel="stylesheet">
	<link href="catalog/view/theme/phpner_store/stylesheet/stylesheet.css" rel="stylesheet">
	<link href="catalog/view/theme/phpner_store/stylesheet/fonts.css" rel="stylesheet">
	<script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js"></script>
	<script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js"></script>
	<link href="catalog/view/theme/phpner_store/stylesheet/autosearch.css" rel="stylesheet" />
	<link href="catalog/view/theme/phpner_store/stylesheet/popup.css" rel="stylesheet" />
	<link href="catalog/view/theme/phpner_store//stylesheet/responsive.css" rel="stylesheet">
	<?php foreach ($styles as $style) { ?>
	<link href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
	<?php } ?>
	<script src="catalog/view/theme/phpner_store//js/main.js"></script>
	<script src="catalog/view/theme/phpner_store//js/common.js"></script>
	<script src="catalog/view/theme/phpner_store//js/flexmenu.min.js"></script>
	<script src="catalog/view/theme/phpner_store//js/flipclock.js"></script>
	<script  src="catalog/view/theme/phpner_store/js/barrating.js"></script>
	<link href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css" rel="stylesheet" />
	<script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js"></script>
	<link href="catalog/view/javascript/jquery/magnific/magnific-popup.css" rel="stylesheet" />
	<script src="catalog/view/theme/phpner_store/js/input-mask.js"></script>
	<link href="catalog/view/theme/phpner_store/js/fancy-box/jquery.fancybox.min.css" rel="stylesheet" />
	<script src="catalog/view/theme/phpner_store/js/fancy-box/jquery.fancybox.min.js"></script>
	<link href="catalog/view/theme/phpner_store/stylesheet/jquery-ui.min.css" rel="stylesheet" />
	<?php foreach ($scripts as $script) { ?>
	<script src="<?php echo $script; ?>"></script>
	<?php } ?>
	<?php foreach ($analytics as $analytic) { ?>
	<?php echo $analytic; ?>
	<?php } ?>
	<?php if ($phpner_store_customcss) { ?>
	<style>
		<?php echo $phpner_store_customcss; ?>
	</style>
	<?php } ?>
	<?php if ($phpner_store_customjavascrip) { ?>
			<?php echo $phpner_store_customjavascrip; ?>
	<?php } ?>
	<link href="catalog/view/theme/phpner_store/stylesheet/dynamic_stylesheet.css?v=<?php echo rand(10,100); ?>" rel="stylesheet" />
<?php } else { ?>
	<script src="catalog/view/theme/phpner_store/js/javascript_minify.js"></script>
	<link rel="stylesheet" href="catalog/view/theme/phpner_store/stylesheet/stylesheet_minify.css" />
		<?php if ($phpner_store_customjavascrip) { ?>
			<?php echo $phpner_store_customjavascrip; ?>
	<?php } ?>
	<?php foreach ($styles as $style) { ?>
	<link href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
	<?php } ?>
	<?php foreach ($scripts as $script) { ?>
	<script src="<?php echo $script; ?>"></script>
	<?php } ?>
	<?php foreach ($analytics as $analytic) { ?>
	<?php echo $analytic; ?>
	<?php } ?>
<?php } ?>
<link href="catalog/view/theme/phpner_store/stylesheet/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
</head>
<body class="<?php echo $class; ?>">
	<div id="menu-mobile" class="m-panel-box">
	  <div class="menu-mobile-header"><?php echo $phpner_store_mmenu; ?></div>
	  <div id="menu-mobile-box"></div>
	  <div class="close-m-search">
	    <a class="phpner_-button closempanel">×</a>
	  </div>
	</div>
	<div id="info-mobile" class="m-panel-box">
	  <div class="menu-mobile-header"><?php echo $phpner_store_minfo; ?></div>
	  <div class="close-m-search">
	    <a class="phpner_-button closempanel">×</a>
	  </div>
	  <div id="info-mobile-box"></div>
	</div>
	<div class="phpner_-m-search m-panel-box" id="msrch">
	  <div class="menu-mobile-header"><?php echo $phpner_store_msearch; ?></div>
	  <div id="phpner_-mobile-search-box">
	    <div id="phpner_-mobile-search">
	      <div class="input-group">
	        <input type="text" name="search" class="form-control" placeholder="<?php echo $phpner_store_msearch; ?>">
	        <span class="input-group-btn">
	        <input type="button" id="phpner_-m-search-button" value="<?php echo $phpner_store_msearchb; ?>" class="phpner_-button">
	        </span>
	      </div>
	      <div class="phpner_-msearchresults" id="searchm">
	        <div id="msearchresults"></div>
	      </div>
	    </div>
	    <p>&nbsp;</p>
	  </div>
	  <div class="close-m-search">
	    <a class="phpner_-button closempanel">×</a>
	  </div>
	</div>
	<div id="phpner_-bluring-box">
	<div id="phpner_-bluring-box-item"></div>
	<nav id="top" >
	  <div class="top-container">
	    <div class="container mobile-container">
	      <div class="row">
	        <div class="col-xs-3 top-mobile-item">
	          <a class="new-menu-toggle" id="menu-mobile-toggle">
	          <i class="fa fa-bars" aria-hidden="true"></i>
	          </a>
	        </div>
	        <div class="col-xs-3 top-mobile-item">
	          <a class="new-menu-toggle" id="info-mobile-toggle">
	          <i class="fa fa-info" aria-hidden="true"></i>
	          </a>
	        </div>
	        <div class="col-xs-3 top-mobile-item">
	          <a href="<?php echo $link_login; ?>" class="new-menu-toggle" id="user-mobile-toggle">
	          <i class="fa fa-id-badge" aria-hidden="true"></i>
	          </a>
	        </div>
	        <div class="col-xs-3 top-mobile-item">
	          <a class="new-menu-toggle" id="search-mobile-toggle">
	          <i class="fa fa-search" aria-hidden="true"></i>
	          </a>
	        </div>
	      </div>
	    </div>
	    <div class="container not-mobile-container">
	      <div class="row">
	        <div class="col-sm-12">
	          <div id="top-left-links" class="pull-left">
	            <ul class="list-inline top-left-info-links">
	              <?php if ($phpner_store_header_information_links) { ?>
		              <?php foreach ($phpner_store_header_information_links as $information) { ?>
		              	<li class="apppli"><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
		              <?php } ?>
	              <?php } ?>
	              <?php if ($phpner_store_data['shownews'] == 'on') { ?>
	              	<li><a href="<?php echo $phpner_store_news; ?>"><?php echo $text_news; ?></a></li>
	              <?php } ?>
	              <?php if ($phpner_store_data['showcontacts'] == 'on') { ?>
	              	<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
	              <?php } ?>
	            </ul>
	          </div>
	          <div id="top-right-links" class="pull-right">
	            <?php if (!empty($language) && $language != "" OR !empty($currency) && $currency != "") { ?>
	            <div class="language-currency">
	              <?php echo $language; ?>
	              <?php echo $currency; ?>
	            </div>
	            <?php } ?>
	            <ul class="list-inline">
	              <?php if ($phpner_store_cont_clock) { ?>
	              <li class="dropdown">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" data-hover="dropdown"><i class="fa fa-clock-o" aria-hidden="true"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_clock; ?></span> <i class="fa fa-caret-down"></i></a>
	                <ul class="dropdown-menu">
	                  <?php foreach ($phpner_store_cont_clock as $clock) { ?>
	                  	<li><span><?php echo $clock; ?></span></li>
	                  <?php } ?>
	                </ul>
	              </li>
	              <?php } ?>
	              <li class="dropdown user-dropdown">
	                <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" data-hover="dropdown"><i class="fa fa-user" aria-hidden="true"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_client_center; ?></span> <i class="fa fa-caret-down"></i></a>
	                <ul class="dropdown-menu user-dropdown-menu">
	                  <?php if ($logged) { ?>
		                  <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
		                  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
		                  <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
		                  <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
		                  <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
	                  <?php } else { ?>
		                  <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
		                  <li><a onclick="get_phpner_popup_login();"><?php echo $text_login; ?></a></li>
	                  <?php } ?>
	                </ul>
	              </li>
	            </ul>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</nav>
	<header>
	  <div class="container">
	    <div class="row middle-header">
	      <div class="col-md-2 col-sm-6 ts-logo-box">
	        <div id="logo">
	          <?php if ($logo) { ?>
		          <?php if($_SERVER['REQUEST_URI'] == "/index.php?route=common/home" OR $_SERVER['REQUEST_URI'] == "/") { ?>
		          	<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
		          <?php } else { ?>
		          	<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
		          <?php } ?>
	          <?php } else { ?>
	          	<h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
	          <?php } ?>
	        </div>
	      </div>
	      <div class="col-sm-5 ts-search-box"><?php echo $search; ?></div>
	      <div class="col-sm-2 phones-top-box">
	        <?php if ($phpner_store_cont_phones) { ?>
		        <div class="dropdown phones-dropdown">
		          <?php if (count($phpner_store_cont_phones) >= 1) { ?>
		          	<a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" data-hover="dropdown"><i class="fa fa-phone"></i> <span><?php echo $phpner_store_cont_phones[0]; ?></span> <i class="fa fa-caret-down"></i></a>
			          <?php if (isset($phpner_popup_call_phone_data['status']) && $phpner_popup_call_phone_data['status'] == 1) { ?>
			          	<a class="field-tip show-phones" onclick="get_phpner_popup_call_phone();"><?php echo $popup_call_phone_text['call_back']; ?></a>
			          <?php } else { ?>
			          	<a href="#" class="show-phones"><?php echo $text_see_more; ?></a>
			          <?php } ?>
			          <ul class="dropdown-menu">
			            <?php foreach($phpner_store_cont_phones as $element) { ?>
			              <li><i class="fa fa-volume-control-phone" aria-hidden="true"></i><a href="#" class="phoneclick" onclick="window.location.href='tel:+<?php echo preg_replace('/\D/', '', $element); ?>';return false;"><?php echo $element; ?></a></li>
			            <?php } ?>
			          </ul>
		          <?php } else { ?>
		          	<a href="#"><i class="fa fa-phone"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $phpner_store_cont_phones[0]; ?></span> <i class="fa fa-caret-down"></i></a>
		          <?php } ?>
		        </div>
	        <?php } ?>
	      </div>
	      <div class="col-sm-3 buttons-top-box">
	        <?php echo $cart; ?>
	      </div>
	      <div class="col-sm-6 mobile-icons-box">
	        <a href="<?php echo $link_wishlist; ?>" id="m-wishlist"><i class="fa fa-heart" aria-hidden="true"></i></a>
	        <a href="<?php echo $link_compare; ?>" id="m-compare"><i class="fa fa-sliders" aria-hidden="true"></i></a>
	        <a onclick="javascript:get_phpner_popup_cart(); return false;" href="#" id="m-cart"><i class="fa fa-shopping-cart"></i></a>
	      </div>
	    </div>
	  </div>
	</header>

			<?php if($_SERVER['HTTP_HOST'] == "tech-store.octemplates.net" && $lang == "ru") { ?>
				    <div id="left-buttons">
        	<div class="buy-supplement">
        		<a class="field-tip" href="http://tech-store.octemplates.net/admin/" target="_blank"><i class="fa fa-cogs" aria-hidden="true"></i><span class="tip-content">Админ-панель<br>логин и пароль: demo</span></a>
        	</div>
        	<div class="documentation">
        		<a class="field-tip" href="http://tech-store.octemplates.net/docs/" target="_blank"><i class="fa fa-file-text-o" aria-hidden="true"></i><span class="tip-content">Документация</span></a>
        	</div>
        	<div class="support">
        		<a class="field-tip" href="https://octemplates.net/open.php" target="_blank"><i class="fa fa-users" aria-hidden="true"></i><span class="tip-content">Техническая поддержка</span></a>
        	</div>
        </div>
        <?php } ?>
    
	<?php if ($phpner_megamenu) { ?>
		<?php echo $phpner_megamenu; ?>
	<?php } else { ?>
		<?php if ($categories) { ?>
		<div class="menu-row">
		  <div class="container">
		    <div class="row">
		      <div id="phpner_-menu-box" class="col-sm-12">
		        <nav id="menu" class="navbar">
		          <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
		            <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
		          </div>
		          <div class="collapse navbar-collapse navbar-ex1-collapse">
		            <ul class="nav navbar-nav flex menu">
		              <?php foreach ($categories as $item) { ?>
			              <li class="dropdown phpner_-mm-simplecat">
			                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $item['name']; ?></a><?php if(count($item['children'])){ ?><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a><?php } ?>
			                <div class="dropdown-menu">
			                  <div class="dropdown-inner">
			                    <ul class="list-unstyled">
			                      <?php foreach ($item['children'] as $children) { ?>
			                      <?php if ($children['children']) { ?>
			                      <li class="second-level-li has-child">
			                        <a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a> <?php if(count($children['children'])){ ?><a class="parent-title-toggle"></a><?php } ?>
			                      </li>
			                      <?php } else { ?>
			                      <li class="second-level-li"><a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a></li>
			                      <?php } ?>
			                      <?php } ?>
			                      <li class="second-level-li has-child"><a href="<?php echo $item['href']; ?>" class="see-all"><?php echo $text_all; ?></a></li>
			                    </ul>
			                  </div>
			                </div>
			              </li>
		              <?php } ?>
		            </ul>
		          </div>
		        </nav>
		      </div>
		    </div>
		  </div>
		</div>
		<?php } ?>
	<?php } ?>
