function get_phpner_popup_found_cheaper(product_id) {
	setTimeout(function () {
		$.magnificPopup.open({
			tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
			items: {
				src: 'index.php?route=extension/module/phpner_popup_found_cheaper&product_id=' + product_id,
				type: 'ajax'
			},
			midClick: true,
			removalDelay: 200
		});
	}, 1);
}

function get_phpner_popup_purchase(product_id) {
	setTimeout(function () {
		$.magnificPopup.open({
			tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
			items: {
				src: 'index.php?route=extension/module/phpner_popup_purchase&product_id=' + product_id,
				type: 'ajax'
			},
			midClick: true,
			removalDelay: 200
		});
	}, 1);
}

function get_phpner_popup_subscribe() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/phpner_popup_subscribe',
			type: 'ajax'
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_phpner_popup_call_phone() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/phpner_popup_call_phone',
			type: 'ajax'
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_phpner_product_preorder(product_id) {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/phpner_product_preorder&product_id=' + product_id,
			type: 'ajax'
		},
		midClick: true,
		removalDelay: 200
	});
}

function phpner_get_product_id(data) {
	var product_id = 0;
	var arr = data.split("&");

	for (var i = 0; i < arr.length; i++) {
		var product_id = arr[i].split("=");
		if (product_id[0] === "product_id") {
			return product_id[1];
		}
	}
}

function get_phpner_popup_product_options(product_id) {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/phpner_popup_product_options&product_id=" + product_id,
			type: "ajax"
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_phpner_popup_product_view(product_id) {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/phpner_popup_view&product_id=" + product_id,
			type: "ajax"
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_phpner_popup_login() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/phpner_popup_login",
			type: "ajax"
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_phpner_popup_add_to_wishlist(product_id) {
	$.ajax({
		url: "index.php?route=account/wishlist/add",
		type: "post",
		data: "product_id=" + product_id,
		dataType: "json",
		success: function (json) {
			$.magnificPopup.open({
				tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
				items: {
					src: "index.php?route=extension/module/phpner_popup_add_to_wishlist&product_id=" + product_id,
					type: "ajax"
				},
				midClick: true,
				removalDelay: 200
			});

			$("#wishlist-total span").html(json['total']);
			$("#wishlist-total").attr("title", json['total']);

			$.ajax({
				url: 'index.php?route=extension/module/phpner_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#phpner_-favorite-quantity").html(json['total_wishlist']);
				}
			});

		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function remove_wishlist(product_id) {
	$.ajax({
		url: "index.php?route=extension/module/phpner_page_bar/remove_wishlist&remove=" + product_id,
		type: "get",
		dataType: "json",
		success: function (json) {
			$.ajax({
				url: 'index.php?route=extension/module/phpner_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#phpner_-favorite-quantity").html(json['total_wishlist']);
				}
			});

			$('#phpner_-favorite-content').load('index.php?route=extension/module/phpner_page_bar/block_wishlist');
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function get_phpner_popup_add_to_compare(product_id) {
	$.ajax({
		url: "index.php?route=product/compare/add",
		type: "post",
		data: "product_id=" + product_id,
		dataType: "json",
		success: function (json) {
			$.magnificPopup.open({
				tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
				items: {
					src: "index.php?route=extension/module/phpner_popup_add_to_compare&product_id=" + product_id,
					type: "ajax"
				},
				midClick: true,
				removalDelay: 200
			});

			$("#compare-total").html(json['total']);

			$.ajax({
				url: 'index.php?route=extension/module/phpner_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#phpner_-compare-quantity").html(json['total_compare']);
				}
			});
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function remove_compare(product_id) {
	$.ajax({
		url: "index.php?route=extension/module/phpner_page_bar/remove_compare&remove=" + product_id,
		type: "get",
		dataType: "json",
		success: function (json) {
			$.ajax({
				url: 'index.php?route=extension/module/phpner_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#phpner_-compare-quantity").html(json['total_compare']);
				}
			});

			$('#phpner_-compare-content').load('index.php?route=extension/module/phpner_page_bar/block_compare');
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function get_phpner_popup_cart() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/phpner_popup_cart",
			type: "ajax"
		},
		midClick: !0,
		removalDelay: 200
	})
}

function get_phpner_popup_add_to_cart(product_id, quantity) {
	$.ajax({
		url: "index.php?route=checkout/cart/add",
		type: "post",
		data: "product_id=" + product_id + "&quantity=" + ("undefined" != typeof quantity ? quantity : 1),
		dataType: "json",
		success: function (json) {
			if (json['redirect']) {
				location = json['redirect'];
			}

			if (json['success']) {
				// $.magnificPopup.open({
				//   tLoading: '<img src="catalog/view/theme/phpner_store/image/ring-alt.svg" />',
				//   items: {
				//    src: "index.php?route=extension/module/phpner_popup_add_to_cart&product_id=" + product_id,
				//    type: "ajax"
				//   },
				// midClick: true,
				// removalDelay: 200
				// });

				get_phpner_popup_cart();

				$("#cart-total").html(json['total']);
				$('#cart > ul').load('index.php?route=common/cart/info ul li');

				$.ajax({
					url: 'index.php?route=extension/module/phpner_page_bar/update_html',
					type: 'get',
					dataType: 'json',
					success: function (json) {
						$("#phpner_-bottom-cart-quantity").html(json['total_cart']);
					}
				});
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function validate(input) {
	input.value = input.value.replace(/[^\d,]/g, '');
}

function doLiveSearch(a, b) {
	return 38 != a.keyCode && 40 != a.keyCode && ($("#livesearch_search_results").remove(), updown = -1, !("" == b || b.length < 3 || (b = encodeURI(b), $.ajax({
		url: $("base").attr("href") + "index.php?route=product/search/ajax&keyword=" + b + "&filter_category_id=" + $('#search input[name=category_id]').val(),
		dataType: "json",
		success: function (a) {
			if (a.length > 0) {
				var c = document.createElement("ul");
				c.id = "livesearch_search_results";
				var d, e;
				for (var f in a) {
					if (d = document.createElement("li"), eListHr = document.createElement("hr"), eListDiv = document.createElement("div"), eListDiv.setAttribute("style", "height: 10px; clear: both;"), eListDivpr = document.createElement("span"), eListDivpr.innerHTML = (a[f].price) ? a[f].price : '', eListDivpr.setAttribute("style", "height: 14px; color: #147927;"), eListDivprspec = document.createElement("span"), eListDivprspec.innerHTML = a[f].special, eListDivprspec.setAttribute("style", "font-weight: bold; margin-left: 8px; color: #a70d0d; font-size: 16px;"), eListImg = document.createElement("img"), eListImg.src = a[f].image, eListImg.setAttribute("style", "margin-right: 10px;"), eListImg.align = "left", eListDivstatus = document.createElement("span"), eListDivstatus.innerHTML = a[f].stock, eListDivstatus.setAttribute("style", "height: 14px; color: #337ab7; margin-left: 15px; font-weight: bold;"), e = document.createElement("a"), e.setAttribute("style", "display: block;"), e.appendChild(document.createTextNode(a[f].name)), "undefined" != typeof a[f].href) {
						"" != a[f].special && eListDivpr.setAttribute("style", "text-decoration: line-through;");
						var g = a[f].href;
						e.href = g.replace(/&/g, "&")
					} else e.href = $("base").attr("href") + "index.php?route=product/product&product_id=" + a[f].product_id + "&keyword=" + b;
					d.appendChild(e), c.appendChild(eListImg), c.appendChild(d), c.appendChild(eListDivpr), "" != a[f].special && c.appendChild(eListDivprspec), c.appendChild(eListDivstatus), c.appendChild(eListHr), c.appendChild(eListDiv)
				}
				$("#livesearch_search_results").length > 0 && $("#livesearch_search_results").remove(), $("#search").append(c), $("#livesearch_search_results").css("display", "none"), $("#livesearch_search_results").slideDown("slow"), $("#livesearch_search_results").animate({
					backgroundColor: "rgba(255, 255, 255, 0.98)"
				}, 2e3)
			}
		}
	}), 0)))
}

function doLiveSearchMobile(ev, keywords) {
	if (ev.keyCode == 38 || ev.keyCode == 40) {
		return false;
	}

	$('#livesearch_search_results').remove();
	updown = -1;

	if (keywords == '' || keywords.length < 3) {
		return false;
	}
	keywords = encodeURI(keywords);

	$.ajax({
		url: $('base').attr('href') + 'index.php?route=product/search/ajax&keyword=' + keywords,
		dataType: 'json',
		success: function (result) {
			if (result.length > 0) {
				var eList = document.createElement('ul');
				eList.id = 'msearchresults';
				var eListElem;
				var eLink;
				for (var i in result) {
					eListElem = document.createElement('li');

					eListDiv = document.createElement('div');
					eListDiv.setAttribute("style", "height: 10px; clear: both;");

					eListDivpr = document.createElement("span");
					eListDivpr.innerHTML = result[i].price;
					eListDivpr.setAttribute("style", "height: 14px; color: #147927;");
					"" != result[i].special && eListDivpr.setAttribute("style", "text-decoration: line-through;");

					eListDivprspec = document.createElement("span");
					eListDivprspec.innerHTML = result[i].special;
					eListDivprspec.setAttribute("style", "font-weight: bold; margin-left: 8px; color: #a70d0d; font-size: 16px;");

					eListDivstatus = document.createElement("span");
					eListDivstatus.innerHTML = result[i].stock;
					eListDivstatus.setAttribute("style", "height: 14px; color: #337ab7; margin-left: 15px; font-weight: bold;");

					eListImg = document.createElement('img');
					eListImg.src = result[i].image;
					eListImg.setAttribute("style", "margin-right: 10px;");
					eListImg.align = 'left';

					eLink = document.createElement('a');
					eLink.setAttribute("style", "display: block;");
					eLink.appendChild(document.createTextNode(result[i].name));
					if (typeof (result[i].href) != 'undefined') {
						var convertlink = result[i].href;
						eLink.href = convertlink.replace(/&/g, "&");

					} else {
						eLink.href = $('base').attr('href') + 'index.php?route=product/product&product_id=' + result[i].product_id + '&keyword=' + keywords;
					}
					eListElem.appendChild(eLink);
					eList.appendChild(eListImg);
					eList.appendChild(eListElem);
					eList.appendChild(eListDivpr);
					"" != result[i].special && eList.appendChild(eListDivprspec);
					eList.appendChild(eListDivstatus);
					eList.appendChild(eListDiv);
				}
				if ($('#msearchresults').length > 0) {
					$('#msearchresults').remove();
				}
				$('#searchm').append(eList);
			}
		}
	});

	return true;
}

function upDownEvent(a) {
	var b = document.getElementById("livesearch_search_results");
	if ($("#search").find("[name=search]").first(), b) {
		var c = b.childNodes.length - 1;
		if (updown != -1 && "undefined" != typeof b.childNodes[updown] && $(b.childNodes[updown]).removeClass("highlighted"), 38 == a.keyCode ? updown = updown > 0 ? --updown : updown : 40 == a.keyCode && (updown = updown < c ? ++updown : updown), updown >= 0 && updown <= c) {
			$(b.childNodes[updown]).addClass("highlighted");
			var d = b.childNodes[updown].childNodes[0].text;
			"undefined" == typeof d && (d = b.childNodes[updown].childNodes[0].innerText), $("#search").find("[name=search]").first().val(new String(d).replace(/(\s\(.*?\))$/, ""))
		}
	}
	return !1
}

function viewport() {
	var e = window,
		a = 'inner';
	if (!('innerWidth' in window)) {
		a = 'client';
		e = document.documentElement || document.body;
	}
	return {
		width: e[a + 'Width'],
		height: e[a + 'Height']
	};
}

$(document).ready(function () {
	$("#back-top").hide(), $(function () {
		$(window).scroll(function () {
			$(this).scrollTop() > 450 ? $("#back-top").fadeIn() : $("#back-top").fadeOut()
		}), $("#back-top a").click(function () {
			return $("body,html").animate({
				scrollTop: 0
			}, 800), !1
		})
	})
	$("#search").find("[name=search]").first().keyup(function (a) {
		doLiveSearch(a, this.value)
	}).focus(function (a) {
		doLiveSearch(a, this.value)
	}).keydown(function (a) {
		upDownEvent(a)
	}).blur(function () {
		window.setTimeout("$('#livesearch_search_results').remove();updown=0;", 1500)
	}), $(document).bind("keydown", function (a) {
		try {
			13 == a.keyCode && $(".highlighted").length > 0 && (document.location.href = $(".highlighted").find("a").first().attr("href"))
		} catch (a) {}
	});


	$('.navbar-nav > li > .dropdown-toggle').click(function () {
		if ($(this).attr('href') === undefined) {
			//return false;
		} else {
			window.location = $(this).attr('href');
		}
	});


	$("#msrch").find("[name=search]").first().keyup(function (ev) {
		doLiveSearchMobile(ev, this.value);
	}).focus(function (ev) {
		doLiveSearchMobile(ev, this.value);
	}).keydown(function (ev) {
		upDownEvent(ev);
	}).blur(function () {});
	$(document).bind('keydown', function (ev) {
		try {
			if (ev.keyCode == 13 && $('.highlighted').length > 0) {
				document.location.href = $('.highlighted').find('a').first().attr('href');
			}
		} catch (e) {}
	});

	$('#phpner_-m-search-button').on('click', function () {
		srchurl = $('base').attr('href') + 'index.php?route=product/search';
		var input_value = $('input[name=\'search\']').val();
		if (input_value.length <= 0) {
			return false;
		}
		if (input_value) {
			srchurl += '&search=' + encodeURIComponent(input_value);
		}
		location = srchurl;
	});
	$("#phpner_-mobile-search-box input[name='search']").on("keydown", function (a) {
		if (13 == a.keyCode) {
			var b = $("input[name='search']").val();
			if (b.length <= 0) return !1;
			$("#phpner_-m-search-button").trigger("click");
		}
	});

	$("#phpner_-search-button").on("click", function () {
		srchurl = $("base").attr("href") + "index.php?route=product/search";
		var a = $("#search input[name='search']").val();
		if (a.length <= 0) return !1;
		a && (srchurl += "&search=" + encodeURIComponent(a));
		var b = $("input[name='category_id']").prop("value");
		b > 0 && (srchurl += "&sub_category=true&category_id=" + encodeURIComponent(b)), location = srchurl
	});
	$("#search input[name='search']").on("keydown", function (a) {
		if (13 == a.keyCode) {
			var b = $("input[name='search']").val();
			if (b.length <= 0) return !1;
			$("#phpner_-search-button").trigger("click");
		}
	});
	$("#search a").on('click', function () {
		$(".cats-button").html('<span class="category-name">' + $(this).html() + ' </span><i class="fa fa-caret-down" aria-hidden="true"></i>');
		$(".selected_phpner_cat").val($(this).attr("id"));
	});
});

function hidePanel() {
	$('#hide-slide-panel').fadeOut();
	$('#phpner_-slide-panel .phpner_-slide-panel-content').removeClass('phpner_-slide-panel-content-opened');
	$('#phpner_-bluring-box').removeClass('phpner_-bluring');
	$('.phpner_-slide-panel-item-content').removeClass('phpner_-panel-active');
	$('.phpner_-panel-link-active').removeClass('phpner_-panel-link-active');
}


$(document).ready(function () {

	$('#search .dropdown').on('click', function () {
		$(this).toggleClass('open-dropdown');
	});

	$("#search .dropdown").mouseleave(function () {
		$(this).removeClass('open-dropdown');
	});


	$('.thumbnails a').on('click', function (e) {
		$(".thumbnails a").removeClass("selected-thumb");
		$(this).addClass("selected-thumb");
	});

	//cat-menu

	$('#sstore-3-level li.active').addClass('open').children('ul').show();
	$('#sstore-3-level li.has-sub>a.toggle-a').on('click', function () {
		$(this).removeAttr('href');
		var element = $(this).parent('li');
		if (element.hasClass('open')) {
			element.removeClass('open');
			element.find('li').removeClass('open');
			element.find('ul').slideUp(200);
		} else {
			element.addClass('open');
			element.children('ul').slideDown(200);
			element.siblings('li').children('ul').slideUp(200);
			element.siblings('li').removeClass('open');
			element.siblings('li').find('li').removeClass('open');
			element.siblings('li').find('ul').slideUp(200);
		}
	});

	var url = document.location.toString();
	$("a").filter(function () {
		return url.indexOf(this.href) != -1;
	}).addClass("current-link");

	// bottom-slide-panel
	$('.phpner_-panel-link').on('click', function () {
		if ($(this).parent().hasClass('phpner_-panel-link-active')) {
			$(this).parent().removeClass('phpner_-panel-link-active');
			hidePanel();
		} else {
			$('#hide-slide-panel').fadeIn();
			$("#phpner_-bluring-box").addClass('phpner_-bluring');
			$("#phpner_-slide-panel .phpner_-slide-panel-content").addClass('phpner_-slide-panel-content-opened');
			$('.phpner_-slide-panel-heading > .container > div').removeClass('phpner_-panel-link-active');
			$(this).parent().addClass('phpner_-panel-link-active');
			$('.phpner_-slide-panel-item-content').removeClass('phpner_-panel-active');
			var linkId = $(this).parent()[0].id;
			if (linkId === 'phpner_-last-seen-link') {
				$('#phpner_-last-seen-content').toggleClass('phpner_-panel-active').load('index.php?route=extension/module/phpner_page_bar/block_viewed');
			} else if (linkId === 'phpner_-favorite-link') {
				$('#phpner_-favorite-content').toggleClass("phpner_-panel-active").load('index.php?route=extension/module/phpner_page_bar/block_wishlist');
			} else if (linkId === 'phpner_-compare-link') {
				$('#phpner_-compare-content').toggleClass("phpner_-panel-active").load('index.php?route=extension/module/phpner_page_bar/block_compare');
			} else if (linkId === 'phpner_-bottom-cart-link') {
				$('#phpner_-bottom-cart-content').toggleClass("phpner_-panel-active").load('index.php?route=extension/module/phpner_page_bar/block_cart');
			}
		}
	});
	$('#phpner_-bluring-box, #hide-slide-panel').click(function () {
		hidePanel();
	});


	$('#info-mobile-toggle').on('click', function () {
		$('#info-mobile').slideToggle();
		$('html').toggleClass('noscroll');
	});
	$('#search-mobile-toggle').on('click', function () {
		$('.phpner_-m-search').slideToggle();
		$('html').toggleClass('noscroll');
	});

	$('#phpner_-menu-box').css('overflow', 'visible');

});


$(function () {
	var sheight = $(window).height();


	$('.dropdown-menu button').click(function (e) {
		e.stopPropagation();
	});


	var sulheight = $(window).height() - 58;


	var m4 = viewport().width;

	var $fclone = $('.footer-contacts-ul').clone();

	$(".closempanel").click(function () {
		$(".m-panel-box").fadeOut();
		$('#phpner_-bluring-box').removeAttr("style");
		$('html').removeClass('noscroll');
	});

	if (m4 <= 992) {
		$('#m-wishlist').append($('#phpner_-favorite-quantity'));
		$('#m-compare').append($('#phpner_-compare-quantity'));
		$('#m-cart').append($('#phpner_-bottom-cart-quantity'));
		$('.product-thumb').bind('touchmove', true);
		$(".product-buttons-box a").removeAttr("data-toggle");
		$('#info-mobile-box').html($fclone);
		$('#info-mobile ul').prepend($('.top-left-info-links li'));
		$('#phpner_-mobile-search-box, #menu-mobile-box, #info-mobile-box').css("height", sulheight);
		$('#info-mobile .footer-contacts-ul').prepend($('#language'));
		$('#info-mobile .footer-contacts-ul').prepend($('#currency'));
	} else {
		$('ul.menu.flex').flexMenu();
	}

	if (m4 < 768) {
		$('.content-row .left-info').prepend($('.product-header'));
		$('#content').prepend($('.phpner_-news-panel'));

		$('footer .third-row .h5').on('click', function () {
			$(this).next().slideToggle();
			$(this).toggleClass('open');
		});
	}

	$(window).on('resize', function () {
		var win = $(this);
		if (win.width() <= 992) {
			$('#m-wishlist').append($('#phpner_-favorite-quantity'));
			$('#m-compare').append($('#phpner_-compare-quantity'));
			$('#m-cart').append($('#phpner_-bottom-cart-quantity'));
			$('#info-mobile-box').html($fclone);
			$('#info-mobile ul').append($('.top-left-info-links li.apppli'));
			$('#info-mobile .footer-contacts-ul').prepend($('#language'));
			$('#info-mobile .footer-contacts-ul').prepend($('#currency'));
			$("#menu-mobile-box").prepend($("#menu"));
		} else {
			$('#phpner_-favorite-link .phpner_-panel-link').append($('#phpner_-favorite-quantity'));
			$('#phpner_-compare-link .phpner_-panel-link').append($('#phpner_-compare-quantity'));
			$('#phpner_-bottom-cart-link .phpner_-panel-link').append($('#phpner_-bottom-cart-quantity'));
			$('#top-left-links ul').append($('#info-mobile ul li.apppli'));
			$('.language-currency').prepend($('#currency'));
			$('.language-currency').prepend($('#language'));
			$("#phpner_-menu-box").prepend($("#menu"));
			$('ul.menu.flex').flexMenu();
		}

		if (win.width() < 768) {
			$('.content-row .left-info').prepend($('.product-header'));
		} else {
			$('#product-info-right').prepend($('.product-header'));
		}
	});
});

jQuery.browser = {};
(function () {
	jQuery.browser.msie = false;
	jQuery.browser.version = 0;

	if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
		jQuery.browser.msie = true;
		jQuery.browser.version = RegExp.$1;
	}
})();