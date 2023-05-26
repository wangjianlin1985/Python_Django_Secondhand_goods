from django.contrib import admin
from django.db import models
from app01.models import User, Product, Cart, Order, Coin, Transaction
# Register your models here.

class ProductAdmin(admin.ModelAdmin):
	list_display = ('name', 'user', 'quantity', 'remained', 'price', 'is_exist')
	list_display_link = ('name', 'user') 

class CartAdmin(admin.ModelAdmin):
	list_display = ('id', 'owner')
	list_display_link = ('id', 'owner')

class OrderAdmin(admin.ModelAdmin):
    list_display = ('user', 'product_id', 'product_name')

class CoinAdmin(admin.ModelAdmin):
	list_display = ('id', 'amount', 'owner')
	list_display_link = ('id', 'owner')

class TransactionAdmin(admin.ModelAdmin):
	list_display = ('seller', 'buyer', 'amount', 'product')

class ProductInline(admin.StackedInline):
	model = Product
	extra = 0

class CartInline(admin.StackedInline):
	model = Cart
	extra = 0

class OrderInline(admin.StackedInline):
	model = Order
	extra = 0

class UserAdmin(admin.ModelAdmin):
    list_display = ('username','password','email', 'money')
    inlines = [ProductInline, CartInline, OrderInline, ]

admin.site.register(User, UserAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Cart, CartAdmin)
admin.site.register(Order, OrderAdmin)
admin.site.register(Coin, CoinAdmin)
admin.site.register(Transaction, TransactionAdmin)