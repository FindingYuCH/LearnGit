##通用布局属性

| 布局属性 | 描述 |赋值方法|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
| x,left | 设置定位元素左外边距边界与其包含块左边界之间的偏移| 5px |  0 | 
| y,top | 设置定位元素的上外边距边界与其包含块上边界之间的偏移| 5px |  0 | 
| right | 设置定位元素右外边距边界与其包含块右边界之间的偏移| 5px |  0 | 
| bottom | 设置定位元素下外边距边界与其包含块下边界之间的偏移| 5px |  0 | 
| w,width | 设置元素的宽度| 5px;50%;auto(BeeLabel根据content自适应) |  0 | 
| h,height | 设置元素的高度| 5px;50%;auto(BeeLabel根据content自适应) |  0 | 
| position | 规定元素的定位类型| absolute;relative |  0 | 
| orient,orientation | 规定元素布局的类型| h,horzonal;v,vertical |  vertical | 
| margin | 设置所有外边距属性| 0px(4个边距);0px(top,bottom) 0px(right,left);0px(top) 0px(right) 0px(bottom) 0px(left); |  0 | 
| padding | 设置所有内边距属性| 0px(4个边距);0px(top,bottom) 0px(right,left);0px(top) 0px(right) 0px(bottom) 0px(left); |  0 | 

##UIButton常用属性
| 布局属性 | 描述 |赋值方法|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
|__背景属性__ |||| 
| background-image,button-backround-nomal | 按钮的背景|  #FFFFFF;url( qq.com/logo.gif ) |  nil |
| background-image-highlighted,button-backround-highlighted | 按钮的高亮背景| #FFFFFF url( qq.com/logo.gif ) |   $("background-image") |
| background-image-disable,button-backround-disable | 按钮禁用时背景| #FFFFFF url( qq.com/logo.gif )  |  $("background-image") |
| background-image-selected,button-backround-selected | 按钮选中时背景| #FFFFFF url( qq.com/logo.gif )  |  $("background-image") |
|__ 前景属性__  |||| 
| image,button-image | 按钮的前景|#FFFFFF;url( qq.com/logo.gif ) |  nil |
| image-highlighted,button-image-highlighted |按钮的高亮前景| #FFFFFF url( qq.com/logo.gif ) |  $(@"image") |
| image-disable,button-image-disable | 按钮禁用时前景| #FFFFFF url( qq.com/logo.gif )  |  $(@"image") |
| image-selected,button-image-selected | 按钮选中时前景| #FFFFFF url( qq.com/logo.gif )  |  $(@"image") |
|__文本属性__  |||| 
| text,button-title | 按钮文本| hello  |  nil|
| text-highlighted,button-title-highlighted | 按钮高亮文本| hello  |  $(@"text") |
| text-disable,button-title-disabled | 按钮禁用文本| hello  |   $(@"text") |
| text-selected,button-title-selected | 按钮选中文本| hello |   $(@"text") |
| color,button-title-color | 按钮文本颜色| #FFFFF 0.6;red 0.9  | blackColor  |
| color-highlighted,button-title-color-highlighted | #FFFFF 0.6;red 0.9| hello  |  $(@"color") |
| color-disable,button-title-color-disabled | 按钮禁用文本颜色| #FFFFF 0.6;red 0.9  |  $(@"color") |
| color-selected,button-title-color-selected | 按钮选中文本颜色| #FFFFF 0.6;red 0.9 |  $(@"color") |



##UILabel常用属性
| 布局属性 | 描述 |赋值方法|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
| text,content | 标签的文本| hello |  nil |
| color,text-color | 文本颜色| #FFFFFF;red |  blackColor |
| text-align | 文本的水平对齐方式| left;center;right  |  left |
| text-valign | 文本的垂直对齐方式| top;center;bottom  |  center |
| line-break | 换行规则 | word-wrap;char-wrap;clip;head-trunc;tail-trunc;mid-trunc; |  tail-trunc |
| line-num | 最大显示行数| 100  |  999999 |
| fit-width | 是否自适应字体大小到文本宽度 | NO;YES |  NO |
| word-wrap | 允许对长的不可分割的单词进行分割并换行到下一行 | normal;break-word |  normal |

##UITextField,UITextView常用属性
| 布局属性 | 描述 |赋值方法|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
|__共有__ |||| 
| text | 文本框文本内容| hello |  nil |
| placeholder | 文本框预留文本内容| hello |  nil |
| color,text-color | 文本颜色| #FFFFFF;red |  blackColor |
| text-align | 文本的水平对齐方式| left;center;right  |  left |
| disable | 是否禁用|NO;YES  |  NO |
| readonly | 是否可以编辑| NO;YES  |  NO |
| maxlength | 文本框的最大长度| 100  |  0 |
|__UITextField独有__ |||| 
| return,input-return,return-key,input-return-key | 键盘的返回类型 | done;search;join;send;next;go | Default |
| keyboard,input-keyboard | 键盘呈现的类型 |abc;123;pin;phone;contact;email | Default |
| secure,input-secure| 是否是密码| NO;YES  |  NO |
| border-style,input-border-style | 输入框的边框 | line;bezel;round |  none |

##UIImageView常用属性
| 布局属性 | 描述 |赋值方法content-mode|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
| src,image-src | 图片的地址| url( qq.com/logo.gif ) |  nil |

##UIPageControl常用属性
| 布局属性 | 描述 |赋值方法content-mode|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
| color,dot-color | 点的颜色 | #FFFFFF;red|  nil |
| color-highlighted,dot-color-highlighted | 点的高亮颜色 | #FFFFFF;red|  nil |
| image,dot-image | 点的图像 | url( qq.com/logo.gif )|  nil |
| image-highlighted,dot-image-highlighted | 点的高亮图像 |url( qq.com/logo.gif )|  nil |
| size,dot-size | 点的尺寸大小 |5px(width) 5px(height)|  nil |

##UIScrollView常用属性
| 布局属性 | 描述 |赋值方法content-mode|缺省值|
| :-------- | :--------| :------------ |  :------------ | 
| orientation,direction | 滑动方向 | h,horizonal;v,vertical|  vertical |
| insets,scoll-insets | 设置scroll的定位区域| 0px(top) 0px(right) 0px(bottom) 0px(left) |  0px |
| mode,scroll-mode | 是否翻页模式 |paging(翻页);continue(连续滑动)|  continue |

