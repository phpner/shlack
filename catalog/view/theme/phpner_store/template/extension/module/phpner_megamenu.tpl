<?php if ($items) { ?>
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
              <?php foreach ($items as $item) { ?>
              <?php if ($item['children']) { ?>
              <?php if ($item['item_type'] == 2) { ?>
              <?php #start menu type - category ?>
              <?php if ($item['display_type'] == 1) { ?>
              <li class="dropdown megamenu-full-width-parrent">
                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a><?php if(count($item['children'])){ ?><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a><?php } ?>
                <div class="dropdown-menu megamenu-full-width phpner_-mm-category">
                  <div class="dropdown-inner clearfix">
                    <div class="col-sm-<?php if ($item['description']) { ?>8<?php } else { ?>12<?php } ?>">
                      <?php $divide_value = ($item['description']) ? 4 : 6; ?>
                      <?php foreach (array_chunk($item['children'], $divide_value) as $children) { ?>
                      <div class="row">
                        <?php foreach ($children as $children_inner) { ?>
                        <div class="megamenu-hassubchild col-md-<?php if ($item['description']) { ?>3<?php } else { ?>2<?php } ?> col-sm-12">
                          <?php if ($children_inner['thumb']) { ?>
                          <a class="megamenu-parent-img" href="<?php echo $children_inner['href']; ?>"><img src="<?php echo $children_inner['thumb']; ?>" alt="<?php echo $children_inner['name']; ?>" title="<?php echo $children_inner['name']; ?>" class="img-responsive" /></a>
                          <?php } ?>
                          <a class="megamenu-parent-title <?php if (!$children_inner['children']) { ?>not-bold<?php } ?>" href="<?php echo $children_inner['href']; ?>"><?php echo $children_inner['name']; ?></a>
                          <?php if ($children_inner['children']) { ?>
                          <a class="parent-title-toggle current-link"></a>
                          <ul class="list-unstyled megamenu-ischild">
                            <?php $countstop = 1; ?>
                            <?php foreach ($children_inner['children'] as $child) { ?>
                            <?php $countstop++; ?>
                            <li><a href="<?php echo $child['href']; ?>" ><?php echo $child['name']; ?></a></li>
                            <?php if($countstop > $item['limit_item']) { ?>
                            <li><a class="see-all" href="<?php echo $children_inner['href']; ?>" ><?php echo $text_all_category; ?></a></li>
                            <?php break; } ?>
                            <?php } ?>
                          </ul>
                          <?php } ?>
                        </div>
                        <?php } ?>
                      </div>
                      <?php } ?>
                    </div>
                    <?php if ($item['description']) { ?>
                    <div class="col-sm-4 megamenu-html-inner">
                      <?php echo $item['description']; ?>
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </li>
              <?php } else { ?>
              <li class="dropdown phpner_-mm-simplecat">
                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a><?php if(count($item['children'])){ ?><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a><?php } ?>
                <div class="dropdown-menu">
                  <div class="dropdown-inner">
                    <ul class="list-unstyled">
                      <?php foreach ($item['children'] as $children) { ?>
                      <?php if ($children['children']) { ?>
                      <li class="second-level-li has-child">
                        <a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a> <span class="angle-right"><i class="fa fa-angle-right" aria-hidden="true"></i></span><?php if(count($children['children'])){ ?><a class="parent-title-toggle"></a><?php } ?>
                        <ul class="megamenu-ischild">
                          <?php foreach ($children['children'] as $child) { ?>
                          <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                            <?php } ?>
                        </ul>
                      </li>
                      <?php } else { ?>
                      <li class="second-level-li"><a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a></li>
                      <?php } ?>
                      <?php } ?>
                    </ul>
                  </div>
                </div>
              </li>
              <?php } ?>
              <?php } ?>
              <?php if ($item['item_type'] == 3) { ?>
              <?php #start menu type - brands ?>
              <li class="dropdown megamenu-full-width-parrent phpner_-mm-brands">
                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a><?php if(count($item['children'])){ ?><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a><?php } ?>
                <div class="dropdown-menu megamenu-full-width">
                  <div class="dropdown-inner brands-dropdown-inner">
                    <div class="row">
                      <?php foreach ($item['children'] as $children) { ?>
                      <div class="megamenu-hassubchild col-md-2 col-sm-12">
                        <?php if ($children['thumb']) { ?>
                        <a class="megamenu-parent-img" href="<?php echo $children['href']; ?>"><img class="img-responsive" src="<?php echo $children['thumb']; ?>" alt="<?php echo $children['name']; ?>" title="<?php echo $children['name']; ?>" /></a>
                        <?php } ?>
                        <a class="megamenu-parent-title" href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a>
                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
              </li>
              <?php #end menu type - brands ?>
              <?php } ?>
              <?php if ($item['item_type'] == 4) { ?>
              <?php #start menu type - products ?>
              <li class="dropdown megamenu-full-width-parrent">
                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a><?php if(count($item['children'])){ ?><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a><?php } ?>
                <div class="dropdown-menu megamenu-full-width phpner_-mm-products">
                  <div class="dropdown-inner">
                    <div class="list-unstyled sale-ul row">
                      <div class="col-md-<?php if ($item['description']) { ?>8<?php } else { ?>12<?php } ?> col-sm-<?php if ($item['description']) { ?>8<?php } else { ?>12<?php } ?>">
                        <?php $divide_value = ($item['description']) ? 4 : 6; ?>
                        <?php foreach (array_chunk($item['children'], $divide_value) as $children) { ?>
                        <div class="row">
                          <?php foreach ($children as $child) { ?>
                          <div class="megamenu-hassubchild col-md-<?php if ($item['description']) { ?>3<?php } else { ?>2<?php } ?> col-sm-12">
                            <div class="megamenu-sale-item">
                              <?php if ($child['thumb']) { ?>
                              <a class="megamenu-parent-img" href="<?php echo $child['href']; ?>"><img class="img-responsive" src="<?php echo $child['thumb']; ?>" alt="<?php echo $child['name']; ?>" title="<?php echo $child['name']; ?>" /></a>
                              <?php } ?>
                              <a class="megamenu-parent-title" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                              <?php if (!$child['special']) { ?>
                              <div class="dropprice"><span class="phpner_-price-normal"><?php echo $child['price']; ?></span></div>
                              <?php } else { ?>
                              <div class="dropprice"><span class="phpner_-price-old"><?php echo $child['price']; ?></span> <span class="phpner_-price-new"><?php echo $child['special']; ?></span></div>
                              <?php } ?>
                            </div>
                          </div>
                          <?php } ?>
                        </div>
                        <?php } ?>
                      </div>
                      <?php if ($item['description']) { ?>
                      <div class="col-sm-4 col-md-4 megamenu-html-inner">
                        <?php echo $item['description']; ?>
                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
              </li>
              <?php #end menu type - products ?>
              <?php } ?>
              <?php if ($item['item_type'] == 5) { ?>
              <?php #start menu type - information ?>
              <li class="dropdown phpner_-mm-info">
                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a><?php if(count($item['children'])){ ?><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a><?php } ?>
                <div class="dropdown-menu">
                  <div class="dropdown-inner">
                    <ul class="list-unstyled">
                      <?php foreach ($item['children'] as $children) { ?>
                      <li class="second-level-li"><a href="<?php echo $children['href']; ?>"><?php echo $children['title']; ?></a></li>
                      <?php } ?>
                    </ul>
                  </div>
                </div>
              </li>
              <?php #end menu type - information ?>
              <?php } ?>
              <?php } else { ?>
              <?php if ($item['item_type'] == 7 && $item['custom_html']) { ?>
              <?php #start menu type - custom html ?>
              <li class="dropdown megamenu-full-width-parrent megamenu-html-parrent">
                <a href="<?php echo $item['href']; ?>" class="dropdown-toggle" data-toggle="dropdown" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a><a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a" data-toggle="dropdown"></a>
                <div class="dropdown-menu html-dropdown-menu megamenu-full-width">
                  <div class="dropdown-inner megamenu-html-block">
                    <?php echo $item['custom_html']; ?>
                  </div>
                </div>
              </li>
              <?php #end menu type - custom html ?>     
              <?php } else { ?>
              <?php #start menu type - link ?>
              <li><a href="<?php echo $item['href']; ?>" <?php echo ($item['open_link_type']) ? 'target="_blank"' : ''; ?>><?php echo $item['title']; ?></a></li>
              <?php #end menu type - link ?>
              <?php } ?>
              <?php } ?>	
              <?php } ?>
            </ul>
          </div>
        </nav>
      </div>
    </div>
  </div>
</div>
<script>
  function viewport() {
    var e = window, a = 'inner';
    if (!('innerWidth' in window)) {
      a = 'client';
      e = document.documentElement || document.body;
    }
    return { width : e[ a+'Width' ] , height : e[ a+'Height' ] };
  }
  
  $(document).ready(function() {
  	var b4 = viewport().width;
  	var sheight = $(window).height();
    if (b4 <= 992) {
  		$("#menu-mobile-box").prepend( $( "#menu" ) );
		} else {
  		$('ul.menu.flex').flexMenu();
      $("ul.flexMenu-popup").mouseleave(function() {
        $(".flexMenu-popup").css("display", "none");
    	});
		}
    		
    $('#menu-mobile-toggle').on('click', function() {
			$('#menu-mobile').slideToggle();
			$('html').toggleClass('noscroll');
			$('#phpner_-bluring-box').css("height",sheight);
		});
		
		$('.megamenu-toggle-a').on('click', function() {
			$(this).parent().toggleClass("open");
		});
		
		$(".parent-title-toggle").on("click", function(t) {
      $(this).toggleClass("opened"), $(this).next().toggleClass("megamenu-ischild-opened"), t.preventDefault(), t.stopPropagation()
		});
		
		$("#menu .navbar-header").on("click", function(t) {
      $(this).next().toggleClass("in"), t.preventDefault(), t.stopPropagation()
    });
  });
</script>
<?php } ?>