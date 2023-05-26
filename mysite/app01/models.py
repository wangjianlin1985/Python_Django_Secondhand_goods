#coding=utf-8
from __future__ import unicode_literals
#from PIL import Image
from django.contrib import admin
from django.db import models

# Create your models here.

class User(models.Model):
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    email = models.EmailField()
    money = models.DecimalField(max_digits=9, decimal_places=2, default="0")
    is_changed = models.BooleanField(default=True)
    def __unicode__(self):
        return self.username

    def __str__(self):
        return self.username
 
class Product(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, default="", on_delete=models.CASCADE)
    name = models.CharField('名称', max_length=50)
    time = models.DateField('上传时间', null=True, blank=True, auto_now=True)
    old_time = models.DateField('原购买时间', null=True, blank=True)
    img = models.ImageField('图片', upload_to='img', default="")
    description = models.CharField('描述', max_length=500)
    price = models.DecimalField("价格", max_digits=9, decimal_places=2)
    old_price = models.DecimalField("原价", max_digits=9, decimal_places=2)
    classification = models.CharField('磨损程度', max_length=50)
    quantity = models.IntegerField('数量')
    buy_quantity = models.IntegerField("购买数量", default=1)
    remained = models.IntegerField('剩余数量', default=0)
    is_exist = models.BooleanField(default=True)
    def __unicode__(self):
        return self.name

    def __str__(self):
        return self.name

class Cart(models.Model):
    id = models.AutoField(primary_key=True)
    owner = models.OneToOneField(User, default="", on_delete=models.CASCADE)
    products = models.ManyToManyField(Product)

class Order(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, default="", on_delete=models.CASCADE)
    products = models.ManyToManyField(Product)
    product_name = models.CharField(max_length=50, default='')
    product_id = models.CharField(max_length=50, default='')
    product_amount = models.IntegerField(default="")
    cart = models.ManyToManyField(Cart)
    address = models.TextField(max_length=200, default='')
    phone = models.TextField(max_length=11, default='')
    remarks = models.TextField(max_length=200, default='')

class Coin(models.Model):
    amount = models.DecimalField(max_digits=9, decimal_places=2)
    owner = models.OneToOneField(User, default="", on_delete=models.CASCADE)
    is_gotten = models.BooleanField(default=False)
    # def __unicode__(self):
    #     return self.amount

class Transaction(models.Model):
    seller = models.ForeignKey(User, related_name="seller",on_delete=models.CASCADE)
    buyer = models.ForeignKey(User, related_name="buyer",on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=9, decimal_places=2)
    product = models.ForeignKey(Product,on_delete=models.CASCADE)
    order = models.ForeignKey(Order, default="",on_delete=models.CASCADE)