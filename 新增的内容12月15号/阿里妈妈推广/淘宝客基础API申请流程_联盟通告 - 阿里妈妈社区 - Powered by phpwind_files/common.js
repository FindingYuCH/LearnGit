KISSY.use('dom, event, switchable', function(S, DOM, Event, Switchable){
	S.ready(function(S){
        S.one('#J_nav').delegate('click','.trigger', function(e){
            var target = S.one(e.currentTarget);
            var ischild = target.siblings('ul').hasClass('second_lay');
            if(ischild) {
                e.preventDefault();
            }
            target.parent().siblings().removeClass('current');
            target.parent().addClass('current');
            S.all('.second_lay').css('display','none');
            target.siblings('ul').css('display','block');
        });

        S.one('#J_seconditem').delegate('click', '.second_item', function(e){
            e.preventDefault();
            var target = S.one(e.currentTarget);
            S.one('#J_seconditem').all('.third_lay').css('display','none');
            S.one('#J_seconditem').all('em').css('display','none');
            target.children('em').css('display','inline');
            target.siblings('.third_lay').css('display','block');
        });
        
        S.one('.quick-menu').delegate('click', '.product', function(e){
            e.preventDefault();
            var curNode = S.one(e.currentTarget);
            var header = S.one('#header');
            var headerBottom = header.offset().top + header.height();
            var productsNav = S.one('.products-nav');
            productsNav.css({top:headerBottom});
            if(curNode.hasClass('selected')){
                productsNav.animate({height : 0},{duration : 0.3, easing : 'easeOut', complete : function(){
                    productsNav.hide();
                    curNode.removeClass('selected');
                }});
            }
            else{
                curNode.addClass('selected');
                productsNav.show();
                productsNav.animate({height : 151},{duration : 0.3, easing : 'easeOut'});
            }
        });
        
    });
});