/*
Copyright 2012, KISSY UI Library v1.20
MIT Licensed
build time: Jun 6 13:51
*/
KISSY.add("switchable/base",function(c,d,g,j){function e(b,a){a=a||{};"markupType"in a||(a.panelCls?a.markupType=1:a.panels&&(a.markupType=2));for(var m=this.constructor;m;)a=c.merge(m.Config,a),m=m.superclass?m.superclass.constructor:null;this.container=d.get(b);this.config=a;this.activeIndex=this.completedIndex=a.activeIndex;!(-1<this.activeIndex)&&"number"!=typeof a.switchTo&&(this.completedIndex=this.activeIndex=0);this._init();this._initPlugins();this.fire(l);-1<this.activeIndex||"number"==typeof a.switchTo&&
this.switchTo(a.switchTo)}function k(b){var a={};a.type=b.originalEvent.type;a.target=b.originalEvent.target||b.originalEvent.srcElement;return{originalEvent:a}}var h=c.makeArray,f=g.Target,l="init";e.getDomEvent=k;e.Config={markupType:0,navCls:"ks-switchable-nav",contentCls:"ks-switchable-content",triggerCls:"ks-switchable-trigger",panelCls:"ks-switchable-panel",triggers:[],panels:[],hasTriggers:!0,triggerType:"mouse",delay:0.1,activeIndex:-1,activeTriggerCls:"ks-active",steps:1,viewSize:[]};e.Plugins=
[];c.augment(e,f,{_initPlugins:function(){for(var b=this,a=b.constructor;a;)c.each(a.Plugins,function(a){a.init&&a.init(b)}),a=a.superclass?a.superclass.constructor:null},_init:function(){var b=this.config;this._parseMarkup();b.hasTriggers&&this._bindTriggers()},_parseMarkup:function(){var b=this.container,a=this.config,m,f,i=[],c=[];switch(a.markupType){case 0:(m=d.get("."+a.navCls,b))&&(i=d.children(m));f=d.get("."+a.contentCls,b);c=d.children(f);break;case 1:i=d.query("."+a.triggerCls,b);c=d.query("."+
a.panelCls,b);break;case 2:i=a.triggers,c=a.panels}b=c.length;this.length=Math.ceil(b/a.steps);a.hasTriggers&&0<b&&0===i.length&&(i=this._generateTriggersMarkup(this.length));this.triggers=h(i);this.panels=h(c);this.content=f||c[0].parentNode;this.nav=m||a.hasTriggers&&i[0].parentNode},_generateTriggersMarkup:function(b){var a=this.config,c=d.create("<ul>"),f,i;c.className=a.navCls;for(i=0;i<b;i++)f=d.create("<li>"),i===this.activeIndex&&(f.className=a.activeTriggerCls),f.innerHTML=i+1,c.appendChild(f);
this.container.appendChild(c);return d.children(c)},_bindTriggers:function(){var b=this,a=b.config,d=b.triggers,c,f,e=d.length;for(f=0;f<e;f++)(function(f){c=d[f];g.on(c,"click",function(a){b._onFocusTrigger(f,a)});"mouse"===a.triggerType&&(g.on(c,"mouseenter",function(a){b._onMouseEnterTrigger(f,a)}),g.on(c,"mouseleave",function(){b._onMouseLeaveTrigger(f)}))})(f)},_onFocusTrigger:function(b,a){this._triggerIsValid(b)&&(this._cancelSwitchTimer(),this.switchTo(b,j,k(a)))},_onMouseEnterTrigger:function(b,
a){var f=this;if(f._triggerIsValid(b)){var d=k(a);f.switchTimer=c.later(function(){f.switchTo(b,j,d)},1E3*f.config.delay)}},_onMouseLeaveTrigger:function(){this._cancelSwitchTimer()},_triggerIsValid:function(b){return this.activeIndex!==b},_cancelSwitchTimer:function(){this.switchTimer&&(this.switchTimer.cancel(),this.switchTimer=j)},switchTo:function(b,a,f,d){var c=this,e=c.config,l=c.triggers,g=c.panels,n=c.activeIndex,h=e.steps,p=n*h,k=b*h;if(!c._triggerIsValid(b)||!1===c.fire("beforeSwitch",{toIndex:b}))return c;
e.hasTriggers&&c._switchTrigger(-1<n?l[n]:null,l[b]);a===j&&(a=b>n?"forward":"backward");c._switchView(-1<n?g.slice(p,p+h):null,g.slice(k,k+h),b,a,f,function(){d&&d.call(c,b);c.completedIndex=b});c.activeIndex=b;return c},_switchTrigger:function(b,a){var c=this.config.activeTriggerCls;b&&d.removeClass(b,c);d.addClass(a,c)},_switchView:function(b,a,c,f,e,l){b&&d.css(b,"display","none");d.css(a,"display","block");this._fireOnSwitch(c,e);l&&l.call(this)},_fireOnSwitch:function(b,a){this.fire("switch",
c.mix(a||{},{currentIndex:b}))},prev:function(c){var a=this.activeIndex;this.switchTo(0<a?a-1:this.length-1,"backward",c)},next:function(c){var a=this.activeIndex;this.switchTo(a<this.length-1?a+1:0,"forward",c)}});return e},{requires:["dom","event"]});
KISSY.add("switchable/aria",function(c,d,g,j){function e(){this.stop&&this.stop()}function k(){this.start&&this.start()}j.Plugins.push({name:"aria",init:function(c){if(c.config.aria){var d=c.container;g.on(d,"focusin",e,c);g.on(d,"focusout",k,c)}}});var h=["a","input","button","object"];return{setTabIndex:function(f,e){f.tabIndex=e;d.query("*",f).each(function(b){var a=b.nodeName.toLowerCase();c.inArray(a,h)&&(d.hasAttr(b,"oriTabIndex")||d.attr(b,"oriTabIndex",b.tabIndex),b.tabIndex=-1!=e?d.attr(b,
"oriTabIndex"):e)})}}},{requires:["dom","event","./base"]});
KISSY.add("switchable/accordion/base",function(c,d,g){function j(c,d){if(!(this instanceof j))return new j(c,d);j.superclass.constructor.apply(this,arguments)}c.extend(j,g,{_switchTrigger:function(c,g){var h=this.config;h.multiple?d.toggleClass(g,h.activeTriggerCls):j.superclass._switchTrigger.apply(this,arguments)},_triggerIsValid:function(c){return this.config.multiple||j.superclass._triggerIsValid.call(this,c)},_switchView:function(c,g,h,f,l,b){var a=g[0];this.config.multiple?(d.toggle(a),this._fireOnSwitch(h,
l),b&&b.call(this)):j.superclass._switchView.apply(this,arguments)}});j.Plugins=[];j.Config={markupType:1,triggerType:"click",multiple:!1};return j},{requires:["dom","../base"]});
KISSY.add("switchable/accordion/aria",function(c,d,g,j,e){function k(a){var b;c.each(this.triggers,function(c){if(c==a||d.contains(c,a))b=c});return b}function h(a){var b;c.each(this.panels,function(c){if(c==a||d.contains(c,a))b=c});return b}function f(a){var b=k.call(this,a);b||(a=h.call(this,a),b=this.triggers[c.indexOf(a,this.panels)]);return b}function l(a){switch(a.keyCode){case u:case q:a.ctrlKey&&!a.altKey&&!a.shiftKey&&a.halt();break;case v:a.ctrlKey&&!a.altKey&&a.halt()}}function b(b){var d=
b.target,e=this.triggers,g=!b.ctrlKey&&!b.shiftKey&&!b.altKey,l=b.ctrlKey&&!b.shiftKey&&!b.altKey;switch(b.keyCode){case x:case D:if((d=k.call(this,d))&&g)this.switchTo(c.indexOf(d,this.triggers)),b.halt();break;case t:case p:if(d=k.call(this,d))m.call(this,d),b.halt();break;case z:case o:if(d=k.call(this,d))r.call(this,d),b.halt();break;case q:l&&(b.halt(),d=f.call(this,d),r.call(this,d));break;case u:l&&(b.halt(),d=f.call(this,d),m.call(this,d));break;case n:g&&(f.call(this,d),a.call(this,0,!0),
b.halt());break;case s:g&&(f.call(this,d),a.call(this,e.length-1,!0),b.halt());break;case v:b.ctrlKey&&!b.altKey&&(b.halt(),d=f.call(this,d),b.shiftKey?m.call(this,d):r.call(this,d))}}function a(a,b){var f=this.triggers,o=f[a];c.each(f,function(a){a!==o&&(w(a,"-1"),d.removeClass(a,"ks-switchable-select"),a.setAttribute("aria-selected","false"))});b&&o.focus();w(o,"0");d.addClass(o,"ks-switchable-select");o.setAttribute("aria-selected","true")}function m(b){var d=this.triggers,b=c.indexOf(b,d);a.call(this,
0==b?d.length-1:b-1,!0)}function r(b){var d=this.triggers,b=c.indexOf(b,d);a.call(this,b==d.length-1?0:b+1,!0)}function i(b){var d=!(!b.originalEvent.target&&!b.originalEvent.srcElement),b=b.currentIndex,f=this.panels,o=this.triggers,e=o[b],p=f[b];this.config.multiple||(c.each(f,function(a){a!==p&&a.setAttribute("aria-hidden","true")}),c.each(o,function(a){a!==e&&a.setAttribute("aria-hidden","true")}));f=p.getAttribute("aria-hidden");p.setAttribute("aria-hidden","false"==f?"true":"false");e.setAttribute("aria-expanded",
"false"==f?"false":"true");a.call(this,b,d)}var u=33,q=34,s=35,n=36,t=37,p=38,z=39,o=40,v=9,D=32,x=13;c.mix(e.Config,{aria:!0});e.Plugins.push({name:"aria",init:function(a){if(a.config.aria){var f=a.container,o=a.activeIndex;d.attr(f,"aria-multiselectable",a.config.multiple?"true":"false");a.nav&&d.attr(a.nav,"role","tablist");var e=a.triggers,p=a.panels,v=0;c.each(p,function(a){a.id||(a.id=c.guid("ks-accordion-tab-panel"))});c.each(e,function(a){a.id||(a.id=c.guid("ks-accordion-tab"))});c.each(e,
function(a){a.setAttribute("role","tab");a.setAttribute("aria-expanded",o==v?"true":"false");a.setAttribute("aria-selected",o==v?"true":"false");a.setAttribute("aria-controls",p[v].id);w(a,o==v?"0":"-1");v++});v=0;c.each(p,function(a){var b=e[v];a.setAttribute("role","tabpanel");a.setAttribute("aria-hidden",o==v?"false":"true");a.setAttribute("aria-labelledby",b.id);v++});a.on("switch",i,a);g.on(f,"keydown",b,a);g.on(f,"keypress",l,a)}}});var w=j.setTabIndex},{requires:["dom","event","../aria","./base"]});
KISSY.add("switchable/autoplay",function(c,d,g,j){c.mix(g.Config,{autoplay:!1,interval:5,pauseOnHover:!0});g.Plugins.push({name:"autoplay",init:function(e){function g(){l=c.later(function(){e.paused||e.switchTo(e.activeIndex<e.length-1?e.activeIndex+1:0,"forward")},f,!0)}var h=e.config,f=1E3*h.interval,l;h.autoplay&&(g(),e.stop=function(){l&&(l.cancel(),l=j);e.paused=!0},e.start=function(){l&&(l.cancel(),l=j);e.paused=!1;g()},h.pauseOnHover&&(d.on(e.container,"mouseenter",e.stop,e),d.on(e.container,
"mouseleave",e.start,e)))}});return g},{requires:["event","./base"]});KISSY.add("switchable/autorender",function(c,d,g,j){j.autoRender=function(e,j){d.query("."+(e||"KS_Widget"),j).each(function(d){var f=d.getAttribute("data-widget-type"),e;if(f&&-1<"Switchable Tabs Slide Carousel Accordion".indexOf(f))try{(e=d.getAttribute("data-widget-config"))&&(e=e.replace(/'/g,'"')),new c[f](d,g.parse(e))}catch(b){}})}},{requires:["dom","json","switchable/base"]});
KISSY.add("switchable/carousel/base",function(c,d,g,j,e){function k(d,c){if(!(this instanceof k))return new k(d,c);k.superclass.constructor.apply(this,arguments)}var h={originalEvent:{target:1}};k.Config={circular:!0,prevBtnCls:"ks-switchable-prev-btn",nextBtnCls:"ks-switchable-next-btn",disableBtnCls:"ks-switchable-disable-btn"};k.Plugins=[];c.extend(k,j,{_init:function(){var f=this;k.superclass._init.call(f);var l=f.config,b=l.disableBtnCls;c.each(["prev","next"],function(a){var b=f[a+"Btn"]=d.get("."+
l[a+"BtnCls"],f.container);g.on(b,"mousedown",function(b){b.preventDefault();b=f.activeIndex;if("prev"==a&&(0!=b||l.circular))f[a](h);if("next"==a&&(b!=f.length-1||l.circular))f[a](h)})});if(!l.circular)f.on("switch",function(a){a=a.currentIndex;a=0===a?f.prevBtn:a===f.length-1?f.nextBtn:e;d.removeClass([f.prevBtn,f.nextBtn],b);a&&d.addClass(a,b)});g.on(f.panels,"click",function(){f.fire("itemSelected",{item:this})})}});return k},{requires:["dom","event","../base"]});
KISSY.add("switchable/carousel/aria",function(c,d,g,j,e){function k(a){var b=a.currentIndex,d=this.activeIndex,f=this.panels,e=f[b*this.config.steps],p=this.triggers,b=p[b];if((a=!(!a.originalEvent.target&&!a.originalEvent.srcElement))||-1==d)c.each(p,function(a){n(a,-1)}),c.each(f,function(a){n(a,-1)}),b&&n(b,0),n(e,0),a&&e.focus()}function h(a){var b;c.each(this.triggers,function(c){if(c==a||d.contains(c,a))return b=c,!1});return b}function f(a){var b=a.target;switch(a.keyCode){case u:case i:if(b=
h.call(this,b)){var f=d.next(b),e=this.triggers;f||(f=e[0]);n(b,-1);f&&(n(f,0),f.focus());a.halt()}break;case r:case m:if(b=h.call(this,b))f=d.prev(b),e=this.triggers,f||(f=e[e.length-1]),n(b,-1),f&&(n(f,0),f.focus()),a.halt();break;case s:case q:if(b=h.call(this,b))this.switchTo(c.indexOf(b,this.triggers),void 0,t),a.halt()}}function l(a){var b;c.each(this.panels,function(c){if(c==a||d.contains(c,a))return b=c,!1});return b}function b(a,b){var d=c.indexOf(a,this.panels),f=this.config.steps,e=Math.floor(d/
f);return e==this.activeIndex?1:0==d%f||d%f==f-1?(this.switchTo(e,b,t),0):1}function a(a){var c=a.target;switch(a.keyCode){case u:case i:if(c=l.call(this,c)){var f=d.next(c),e=this.panels;f||(f=e[0]);n(c,-1);n(f,0);b.call(this,f,p)&&f.focus();a.halt()}break;case r:case m:if(c=l.call(this,c))f=d.prev(c),e=this.panels,f||(f=e[e.length-1]),n(c,-1),n(f,0),b.call(this,f,z)&&f.focus(),a.halt();break;case s:case q:if(c=l.call(this,c))this.fire("itemSelected",{item:c}),a.halt()}}var m=37,r=38,i=39,u=40,q=
32,s=13,n=j.setTabIndex,t={originalEvent:{target:1}},p="forward",z="backward";c.mix(e.Config,{aria:!1});e.Plugins.push({name:"aria",init:function(b){if(b.config.aria){var d=b.triggers,e=b.panels,p=b.content,l=b.activeIndex;p.id||(p.id=c.guid("ks-switchbale-content"));p.setAttribute("role","listbox");var i=0;c.each(d,function(a){n(a,l==i?"0":"-1");a.setAttribute("role","button");a.setAttribute("aria-controls",p.id);i++});i=0;c.each(e,function(a){n(a,"-1");a.setAttribute("role","option");i++});b.on("switch",
k,b);if(d=b.nav)g.on(d,"keydown",f,b);g.on(p,"keydown",a,b);d=b.prevBtn;e=b.nextBtn;d&&(n(d,0),d.setAttribute("role","button"),g.on(d,"keydown",function(a){if(a.keyCode==s||a.keyCode==q){b.prev(t);a.preventDefault()}}));e&&(n(e,0),e.setAttribute("role","button"),g.on(e,"keydown",function(a){if(a.keyCode==s||a.keyCode==q){b.next(t);a.preventDefault()}}))}}})},{requires:["dom","event","../aria","./base"]});
KISSY.add("switchable/effect",function(c,d,g,j,e,k){var h;c.mix(e.Config,{effect:"none",duration:0.5,easing:"easeNone"});e.Effects={none:function(c,e,b){c&&d.css(c,"display","none");d.css(e,"display","block");b&&b()},fade:function(c,e,b){var a=this,g=a.config,h=c?c[0]:null,i=e[0];a.anim&&(a.anim.stop(),d.css(a.anim.fromEl,{zIndex:1,opacity:0}),d.css(a.anim.toEl,"zIndex",9));d.css(i,"opacity",1);h?(a.anim=(new j(h,{opacity:0},g.duration,g.easing,function(){a.anim=k;d.css(i,"z-index",9);d.css(h,"z-index",
1);b&&b()})).run(),a.anim.toEl=i,a.anim.fromEl=h):(d.css(i,"z-index",9),b&&b())},scroll:function(c,e,b,a){var g=this,e=g.config,h="scrollx"===e.effect,i={};i[h?"left":"top"]=-(g.viewSize[h?0:1]*a)+"px";g.anim&&g.anim.stop();c?g.anim=(new j(g.content,i,e.duration,e.easing,function(){g.anim=k;b&&b()})).run():(d.css(g.content,i),b&&b())}};h=e.Effects;h.scrollx=h.scrolly=h.scroll;e.Plugins.push({name:"effect",init:function(f){var e=f.config,b=e.effect,a=f.panels,g=f.content,h=e.steps,i=f.activeIndex,
j=a.length;f.viewSize=[e.viewSize[0]||a[0].offsetWidth*h,e.viewSize[1]||a[0].offsetHeight*h];if("none"!==b)switch(d.css(a,"display","block"),b){case "scrollx":case "scrolly":d.css(g,"position","absolute");"static"==d.css(g.parentNode,"position")&&d.css(g.parentNode,"position","relative");"scrollx"===b&&(d.css(a,"float","left"),d.width(g,f.viewSize[0]*(j/h)));break;case "fade":var k=i*h,s=k+h-1,n;c.each(a,function(a,b){n=b>=k&&b<=s;d.css(a,{opacity:n?1:0,position:"absolute",zIndex:n?9:1})})}}});c.augment(e,
{_switchView:function(d,e,b,a,g,j){var i=this,k=i.config.effect;(c.isFunction(k)?k:h[k]).call(i,d,e,function(){i._fireOnSwitch(b,g);j&&j.call(i)},b,a)}});return e},{requires:["dom","event","anim","switchable/base"]});
KISSY.add("switchable/circular",function(c,d,g,j){function e(c,f,e,p,j){var o=this,f=o.config,l=o.length,m=o.activeIndex,x=f.scrollType===q,w=x?b:a,y=o.viewSize[x?0:1],x=-y*p,A={},C,B=j===u;(C=B&&0===m&&p===l-1||j===i&&m===l-1&&0===p)&&(x=k.call(o,o.panels,p,B,w,y));A[w]=x+r;o.anim&&(o.anim.stop(),"relative"==o.panels[m*f.steps].style.position&&h.call(o,o.panels,m,m,w,y));c?o.anim=(new g(o.content,A,f.duration,f.easing,function(){C&&h.call(o,o.panels,p,B,w,y);o.anim=void 0;e&&e()})).run():(d.css(o.content,
A),e&&e())}function k(a,b,c,e,g){var h=this.config.steps,b=this.length,i=c?b-1:0,a=a.slice(i*h,(i+1)*h);d.css(a,f,l);d.css(a,e,(c?-1:1)*g*b);return c?g:-g*b}function h(a,b,c,e,g){var h=this.config.steps,b=this.length,i=c?b-1:0,a=a.slice(i*h,(i+1)*h);d.css(a,f,m);d.css(a,e,m);d.css(this.content,e,c?-g*(b-1):m)}var f="position",l="relative",b="left",a="top",m="",r="px",i="forward",u="backward",q="scrollx";c.mix(j.Config,{circular:!1});j.Plugins.push({name:"circular",init:function(a){a=a.config;if(a.circular&&
(a.effect===q||"scrolly"===a.effect))a.scrollType=a.effect,a.effect=e}})},{requires:["dom","anim","./base","./effect"]});
KISSY.add("switchable/countdown",function(c,d,g,j,e,k){c.mix(e.Config,{countdown:!1,countdownFromStyle:"",countdownToStyle:"width: 0"});e.Plugins.push({name:"countdown",init:function(e){function f(a){l();q=(new j(r[a],u,m-1)).run()}function l(){a&&(clearTimeout(a),a=null);q&&(q.stop(),q=k)}var b=e.config,a,m=b.interval,r=[],i=b.countdownFromStyle,u=b.countdownToStyle,q;b.autoplay&&b.hasTriggers&&b.countdown&&(c.each(e.triggers,function(a,b){a.innerHTML='<div class="ks-switchable-trigger-mask"></div><div class="ks-switchable-trigger-content">'+
a.innerHTML+"</div>";r[b]=a.firstChild}),b.pauseOnHover&&(g.on(e.container,"mouseenter",function(){l();var a=r[e.activeIndex];i?q=(new j(a,i,0.2,"easeOut")).run():d.attr(a,"style","")}),g.on(e.container,"mouseleave",function(){l();var b=e.activeIndex;d.attr(r[b],"style",i);a=setTimeout(function(){f(b)},200)})),e.on("beforeSwitch",function(){l();r[e.activeIndex]&&d.attr(r[e.activeIndex],"style",i||"")}),e.on("switch",function(a){e.paused||f(a.currentIndex)}),-1<e.activeIndex&&f(e.activeIndex))}});
return e},{requires:["dom","event","anim","./base"]});
KISSY.add("switchable/lazyload",function(c,d,g){var j="beforeSwitch",e="img",k="textarea",h={};h[e]="data-ks-lazyload-custom";h[k]="ks-datalazyload-custom";c.mix(g.Config,{lazyDataType:k});g.Plugins.push({name:"lazyload",init:function(f){function g(c){var h=a.steps,c=c.toIndex*h;b.loadCustomLazyData(f.panels.slice(c,c+h),m);a:{if(c=(h=m===e)?"img":m===k?"textarea":"")for(var c=d.query(c,f.container),q=0,s=c.length;q<s;q++){var n=c[q];if(h?d.attr(n,r):d.hasClass(n,r)){h=!1;break a}}h=!0}h&&f.detach(j,
g)}var b=c.require("datalazyload"),a=f.config,m,r;"img-src"===a.lazyDataType&&(a.lazyDataType=e);"area-data"===a.lazyDataType&&(a.lazyDataType=k);m=a.lazyDataType;r=h[m];if(b&&m&&r)f.on(j,g)}});return g},{requires:["dom","./base"]});KISSY.add("switchable/slide/base",function(c,d){function g(c,d){if(!(this instanceof g))return new g(c,d);g.superclass.constructor.apply(this,arguments)}g.Config={autoplay:!0,circular:!0};g.Plugins=[];c.extend(g,d);return g},{requires:["../base"]});
KISSY.add("switchable/slide/aria",function(c,d,g,j,e){function k(c){switch(c.keyCode){case b:case l:this.next(a);c.halt();break;case f:case h:this.prev(a),c.halt()}}var h=37,f=38,l=39,b=40;c.mix(e.Config,{aria:!1});var a={originalEvent:{target:1}},m=j.setTabIndex;e.Plugins.push({name:"aria",init:function(a){if(a.config.aria){var b=a.panels,e=0,f=a.activeIndex;c.each(a.triggers,function(a){m(a,"-1");e++});e=0;c.each(b,function(a){m(a,f==e?"0":"-1");d.attr(a,"role","option");e++});var h=a.content;d.attr(h,
"role","listbox");g.on(h,"keydown",k,a);m(b[0],0);a.on("switch",function(c){var d=c.currentIndex,c=!(!c.originalEvent.target&&!c.originalEvent.srcElement),e=a.completedIndex;-1<e&&m(b[e],-1);m(b[d],0);c&&b[d].focus()})}}})},{requires:["dom","event","../aria","./base"]});KISSY.add("switchable/tabs/base",function(c,d){function g(c,d){if(!(this instanceof g))return new g(c,d);g.superclass.constructor.call(this,c,d);return 0}c.extend(g,d);g.Config={};g.Plugins=[];return g},{requires:["../base"]});
KISSY.add("switchable/tabs/aria",function(c,d,g,j,e,k){function h(a){var b;c.each(this.triggers,function(c){if(c==a||d.contains(c,a))b=c});return b}function f(b){switch(b.keyCode){case a:case m:b.ctrlKey&&!b.altKey&&!b.shiftKey&&b.halt();break;case s:b.ctrlKey&&!b.altKey&&b.halt()}}function l(b){var c=b.target,d=b.ctrlKey&&!b.shiftKey&&!b.altKey;switch(b.keyCode){case r:case i:h.call(this,c)&&(this.prev(t(b)),b.halt());break;case u:case q:h.call(this,c)&&(this.next(t(b)),b.halt());break;case m:d&&
(b.halt(),this.next(t(b)));break;case a:d&&(b.halt(),this.prev(t(b)));break;case s:b.ctrlKey&&!b.altKey&&(b.halt(),b.shiftKey?this.prev(t(b)):this.next(t(b)))}}function b(a){var b=!(!a.originalEvent.target&&!a.originalEvent.srcElement),c=this.completedIndex,d=a.currentIndex;if(c!=d){var a=this.triggers[c],e=this.triggers[d],c=this.panels[c],d=this.panels[d];a&&n(a,"-1");n(e,"0");b&&e.focus();c&&c.setAttribute("aria-hidden","true");d.setAttribute("aria-hidden","false")}}var a=33,m=34,r=37,i=38,u=39,
q=40,s=9;c.mix(k.Config,{aria:!0});k.Plugins.push({name:"aria",init:function(a){if(a.config.aria){var e=a.triggers,h=a.activeIndex,j=a.panels,i=a.container;a.nav&&d.attr(a.nav,"role","tablist");var k=0;c.each(e,function(a){a.setAttribute("role","tab");n(a,h==k?"0":"-1");a.id||(a.id=c.guid("ks-switchable"));k++});k=0;c.each(j,function(a){var b=e[k];a.setAttribute("role","tabpanel");a.setAttribute("aria-hidden",h==k?"false":"true");a.setAttribute("aria-labelledby",b.id);k++});a.on("switch",b,a);g.on(i,
"keydown",l,a);g.on(i,"keypress",f,a)}}});var n=e.setTabIndex,t=j.getDomEvent},{requires:["dom","event","../base","../aria","./base"]});KISSY.add("switchable",function(c,d,g,j,e,k,h,f,l,b,a,m,r,i,u,q){c.Switchable=d;g={Accordion:j,Carousel:f,Slide:i,Tabs:q};c.mix(c,g);c.mix(d,g);return d},{requires:"switchable/base,switchable/aria,switchable/accordion/base,switchable/accordion/aria,switchable/autoplay,switchable/autorender,switchable/carousel/base,switchable/carousel/aria,switchable/circular,switchable/countdown,switchable/effect,switchable/lazyload,switchable/slide/base,switchable/slide/aria,switchable/tabs/base,switchable/tabs/aria".split(",")});