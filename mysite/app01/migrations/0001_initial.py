# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True)),
            ],
        ),
        migrations.CreateModel(
            name='Coin',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('amount', models.DecimalField(max_digits=9, decimal_places=2)),
                ('is_gotten', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True)),
                ('product_name', models.CharField(default='', max_length=50)),
                ('product_id', models.CharField(default='', max_length=50)),
                ('product_amount', models.IntegerField(default='')),
                ('address', models.TextField(default='', max_length=200)),
                ('phone', models.TextField(default='', max_length=11)),
                ('remarks', models.TextField(default='', max_length=200)),
                ('cart', models.ManyToManyField(to='app01.Cart')),
            ],
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True)),
                ('name', models.CharField(max_length=50, verbose_name='\u540d\u79f0')),
                ('time', models.DateField(auto_now=True, verbose_name='\u4e0a\u4f20\u65f6\u95f4', null=True)),
                ('old_time', models.DateField(null=True, verbose_name='\u539f\u8d2d\u4e70\u65f6\u95f4', blank=True)),
                ('img', models.ImageField(default='', upload_to='img', verbose_name='\u56fe\u7247')),
                ('description', models.CharField(max_length=500, verbose_name='\u63cf\u8ff0')),
                ('price', models.DecimalField(verbose_name='\u4ef7\u683c', max_digits=9, decimal_places=2)),
                ('old_price', models.DecimalField(verbose_name='\u539f\u4ef7', max_digits=9, decimal_places=2)),
                ('classification', models.CharField(max_length=50, verbose_name='\u78e8\u635f\u7a0b\u5ea6')),
                ('quantity', models.IntegerField(verbose_name='\u6570\u91cf')),
                ('buy_quantity', models.IntegerField(default=1, verbose_name='\u8d2d\u4e70\u6570\u91cf')),
                ('remained', models.IntegerField(default=0, verbose_name='\u5269\u4f59\u6570\u91cf')),
                ('is_exist', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='Transaction',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('amount', models.DecimalField(max_digits=9, decimal_places=2)),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('username', models.CharField(max_length=50)),
                ('password', models.CharField(max_length=50)),
                ('email', models.EmailField(max_length=254)),
                ('money', models.DecimalField(default='0', max_digits=9, decimal_places=2)),
                ('is_changed', models.BooleanField(default=True)),
            ],
        ),
        migrations.AddField(
            model_name='transaction',
            name='buyer',
            field=models.ForeignKey(related_name='buyer', to='app01.User'),
        ),
        migrations.AddField(
            model_name='transaction',
            name='order',
            field=models.ForeignKey(default='', to='app01.Order'),
        ),
        migrations.AddField(
            model_name='transaction',
            name='product',
            field=models.ForeignKey(to='app01.Product'),
        ),
        migrations.AddField(
            model_name='transaction',
            name='seller',
            field=models.ForeignKey(related_name='seller', to='app01.User'),
        ),
        migrations.AddField(
            model_name='product',
            name='user',
            field=models.ForeignKey(default='', to='app01.User'),
        ),
        migrations.AddField(
            model_name='order',
            name='products',
            field=models.ManyToManyField(to='app01.Product'),
        ),
        migrations.AddField(
            model_name='order',
            name='user',
            field=models.ForeignKey(default='', to='app01.User'),
        ),
        migrations.AddField(
            model_name='coin',
            name='owner',
            field=models.OneToOneField(default='', to='app01.User'),
        ),
        migrations.AddField(
            model_name='cart',
            name='owner',
            field=models.OneToOneField(default='', to='app01.User'),
        ),
        migrations.AddField(
            model_name='cart',
            name='products',
            field=models.ManyToManyField(to='app01.Product'),
        ),
    ]
