 #coding=utf-8
from django.conf.urls import url,include
from django.contrib import admin
from app01 import views
from django.conf import settings
from django.conf.urls.static import static
admin.autodiscover()

urlpatterns = [
    url(r'^index/$',views.index),           #主页
    url(r'^login/$',views.login),           #登录
    url(r'^regist/$',views.regist),         #注册
    url(r'^logout/$',views.logout),         #注销
    url(r'^account/$',views.account),       #账户信息

    url(r'^account/cart/$',views.show_cart),                            #购物车
    url(r'^product/(\d*)/add_to_cart/$',views.add_to_cart),             #加入购物车
    url(r'^account/delete_cart_item/(\d*)/$',views.delete_cart_item),   #删除购物车条目
    url(r'^account/clear_cart/$',views.clear_cart),                     #清空购物车

    url(r'^product/(\d*)/$',views.show_product),            #商品页
    url(r'^account/my_product/$',views.my_product),         #上传的商品
    url(r'^account/upload/$',views.upload),                 #上传商品
    url(r'^account/delete_product/$',views.delete_product), #删除商品

    url(r'^account/cart/(\d*)/create_order/$',views.place_order),   #创建订单
    url(r'^order_info/(\d*)/(\d*)/$',views.order_info),             #显示订单详情
    url(r'^account/my_orders/$',views.show_orders),                 #显示订单
    url(r'^account/delete_orders/$',views.delete_orders),           #删除订单

    #url(r'^account/change_name/$',views.change_username),   #修改用户名
    #url(r'^account/change_email/$',views.change_email),    #修改邮箱
    url(r'^account/change_password/$',views.show_change_password),  #修改密码页面
    url(r'^account/changepassword/$',views.change_password),        #修改密码
    url(r'^account/trading_record/$',views.show_transaction),       #显示交易记录
    url(r'^search_result/$',views.search),      #搜索

    url(r'^recharge/$',views.recharge),     #充值
    
    url(r'^$',views.index),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)