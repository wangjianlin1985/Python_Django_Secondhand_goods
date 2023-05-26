#coding=utf-8
from django.shortcuts import render,render_to_response
from django.http import HttpResponse,HttpResponseRedirect
from django.template import RequestContext
from django import forms
from app01.models import User, Product, Cart, Order, Coin, Transaction
#from PIL import Image

is_mine = False

#Create your views here.
class UserForm(forms.Form):
	username = forms.CharField(label='用户名',max_length=50)
	password = forms.CharField(label='密__码',widget=forms.PasswordInput())
	email = forms.EmailField(label='邮__箱')

class UploadForm(forms.Form):
	name = forms.CharField(label='名称', max_length=50)
	old_time = forms.DateField(label='原购买时间')
	img = forms.ImageField(label='图片')
	description = forms.CharField(label='描述', max_length=500)
	price = forms.DecimalField(label="价格", max_digits=9, decimal_places=2)
	old_price = forms.DecimalField(label="原价", max_digits=9, decimal_places=2)
	classification = forms.CharField(label='磨损程度', max_length=50)
	quantity = forms.IntegerField(label='数量')		

#注册
def regist(request):
	if request.method == 'POST':
		userform = UserForm(request.POST)
		if userform.is_valid():
			username = userform.cleaned_data['username']
			password = userform.cleaned_data['password']
			email = userform.cleaned_data['email']

			user1 = User.objects.filter(username__exact=request.POST['username'])
			user2 = User.objects.filter(email__exact=request.POST['email'])
			if user1 or user2:
				status = '用户名/邮箱已存在'
				return render_to_response('regist.html', {'userform':userform, 'status':status})

			else:
				new_user = User(username=username,password=password,email=email,money=0)
				new_user.save()
				coin = Coin(owner=new_user, amount=0)
				coin.save()

				#注册新用户同时建立空购物车
				cart = Cart(owner=new_user)
				cart.save()

			return HttpResponseRedirect('/login')

	else:
		userform = UserForm()
	return render_to_response('regist.html',{'userform':userform})

#登录
def login(request):
	if request.method == 'POST':
		userform = UserForm(request.POST)
		if userform.is_valid():
			username = userform.cleaned_data['username']
			password = userform.cleaned_data['password']
			email = userform.cleaned_data['email']
			user = User.objects.filter(username__exact=username,password__exact=password, 
				email__exact=email)
			
			if user:
				request.session['username'] = username
				nextfullurl = request.get_full_path()
				if nextfullurl.find('?next=') != -1:
					R_url = nextfullurl.split('?next=')[1]
				else:
					R_url = '/index/'
				return HttpResponseRedirect(R_url, {'userform':userform})
			else:
				status="用户名/邮箱/密码错误"
				return render_to_response('login.html', {'userform':userform,'status':status})

	else:
		userform = UserForm()
	return render_to_response('login.html',{'userform':userform})

#登陆后主页显示
def index(request):
	username = request.session.get('username')
	if username:
		return render_to_response('index.html', {'username':username})
	else:
		return render_to_response('index.html')

#登出
def logout(request):
	try:
		del request.session['username']
	except KeyError:
		pass
	return HttpResponseRedirect('/index')

#上传物品
def upload(request):
	username = request.session.get('username')
	if username:
		if request.method == 'POST':
			uploadform = UploadForm(request.POST, request.FILES)
			if uploadform.is_valid():
				name = uploadform.cleaned_data['name']
				old_time = uploadform.cleaned_data['old_time']
				img = uploadform.cleaned_data['img']
				description = uploadform.cleaned_data['description']
				price = uploadform.cleaned_data['price']
				old_price = uploadform.cleaned_data['old_price']
				classification = uploadform.cleaned_data['classification']
				quantity = uploadform.cleaned_data['quantity']
				username = request.session.get('username')
				seller = User.objects.get(username=username)
				new_product = Product(name=name, old_time=old_time, description=description, remained=quantity, img=img,
					price=price, old_price=old_price, classification=classification, quantity=quantity, user=seller)
				new_product.save()

				return HttpResponseRedirect('/account', {'username':username})
			else:
				print(uploadform.errors)
		else:
			uploadform = UploadForm()

		return render_to_response('upload.html',{'uploadform':uploadform, 'username':username})

	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#账户界面
def account(request):
	username = request.session.get('username')
	if username:
		user = User.objects.get(username=username)
		user.is_changed = False
		email = user.email
		user.save()
		return render_to_response('account.html', {'username':username, 'user':user})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login/?next=/account/', {'userform':userform})

#商品详情页
def show_product(request, product_id):
	username = request.session.get('username') #当前登陆的用户
	product = Product.objects.get(id=product_id)
	print(product.img)
	user = product.user.username #商品卖家
	global is_mine
	status = ""
	if is_mine == True:
		status = "不能添加自己的商品！！！"
	is_mine = False
	return render_to_response('product.html', {'product':product, 'user':user, 'username':username, 'status':status})

#我上传的物品
def my_product(request):
	username = request.session.get('username')
	if username:
		user = User.objects.get(username__exact=username)
		products_list = user.product_set.all()

		return render_to_response('my_product.html', {'products_list':products_list, 'username':username})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login/?next=/account/my_product/', {'userform':userform})

#加入购物车
def add_to_cart(request, product_id):
	username = request.session.get('username')
	nextfullurl = request.get_full_path()
	global is_mine
	if username:
		owner = User.objects.get(username__exact=username) #买方
		cart = Cart.objects.get(owner=owner)
		product = Product.objects.get(id=product_id)
		user = product.user #商品卖家

		#若买家和卖家是同一人，不能加入购物车
		if owner == user:
			is_mine = True
			R_url = nextfullurl.split('add_to_cart')[0]
			return HttpResponseRedirect(R_url, {'product':product, 'user':user, 'username':username})

		else:
			is_mine = False
			if request.method == 'POST':
				buy_quantity = request.POST.get("buy_quantity")
				product.buy_quantity = int(buy_quantity)
			product.save()
					
			if cart:
				cart = Cart.objects.get(owner=owner)
				cart.products.add(product)
				cart.save()
			else:
				cart = Cart()
				cart.save()
				cart.owner.add(user)
				cart.products.add(product)
			
			products_list = cart.products.all()
			return HttpResponseRedirect('/account/cart/', {'products_list':products_list})
	else:
		userform = UserForm(request.POST)
		R_url = nextfullurl.split('add_to_cart')[0]
		R_url = '/login/?next=' + R_url
		return HttpResponseRedirect(R_url, {'userform':userform})

#购物车页面
def show_cart(request):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		cart = Cart.objects.filter(owner=owner)
		if cart:
			cart = Cart.objects.get(owner=owner)
			products_list = cart.products.all()
		else:
			cart = Cart()
			cart.save()
			cart.owner.add(owner)
			products_list = cart.products.all()
		return render_to_response('cart.html', {'cart':cart, 'owner':owner, 
			'products_list':products_list, 'username':username})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login/?next=/account/cart/', {'userform':userform})

#订单信息
def place_order(request, product_id):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		cart = Cart.objects.get(owner=owner)
		product = Product.objects.get(id=product_id)

		if request.method == 'POST':
			if product.is_exist == True:
				buy_quantity = request.POST.get("buy_quantity")
				product.buy_quantity = int(buy_quantity)
				
				product.save()

				total = product.buy_quantity*product.price
				return render_to_response('create_order.html', {'cart':cart, 'owner':owner, 
					'total':total, 'product':product, 'username':username})
			else:
				return render_to_response('create_order.html', {'cart':cart, 'owner':owner, 
					'order':order, 'product':product, 'username':username})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#订单提交
def order_info(request, product_id, order_id):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		cart = Cart.objects.get(owner=owner)
		product = Product.objects.get(id=product_id)
		if request.method == 'POST':
			phone = request.POST.get("phone")
			address = request.POST.get("address")
			remarks = request.POST.get("remarks")
			order = Order(product_name=product.name, product_id=product.id, 
				user=owner, product_amount=product.buy_quantity, phone=phone,
				address=address, remarks=remarks)
			order.save()

			cart.products.remove(product)
			order.products.add(product)
			order.save()
			cart.save()

			total = product.buy_quantity*product.price

			p_owner = product.user
			owner.money = int(owner.money) - int(total)
			p_owner.money = int(p_owner.money) + int(total)
			p_owner.save()
			owner.save()
			product.remained = product.remained - product.buy_quantity
			product.save()
			transaction = Transaction(seller=p_owner, buyer=owner, 
				product=product, amount=total, order=order)
			transaction.save()
			status = "提交成功！"

			return render_to_response('order_info.html', {'order':order, 'status':status,
				'username':username, 'product':product, 'total':total})
		else:
			order = Order.objects.get(id=order_id)
			total = product.buy_quantity*product.price
			return render_to_response('order_info.html', {'order':order, 
				'username':username, 'product':product, 'total':total})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#我的订单
def show_orders(request):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		orders = Order.objects.filter(user=owner)
		return render_to_response('my_orders.html', {'username':username, 'orders':orders})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login/?next=/account/my_orders', {'userform':userform})

#删除订单
def delete_orders(request):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		orders = Order.objects.filter(user=owner)
		if request.method == 'POST':
			check_box_list = request.POST.getlist("check_box_list")

			for order in orders:
				for i in range(0, len(check_box_list)):
					order_id = int(order.id)
					check_box = int(check_box_list[i])
					if check_box == order_id:
						Order.objects.filter(id=order.id).delete()

		return HttpResponseRedirect('/account/my_orders', {'username':username, 'orders':orders})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#删除购物购物车条目
def delete_cart_item(request, product_id):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		cart = Cart.objects.filter(owner=owner)

		if cart:
			cart = Cart.objects.get(owner=owner)
			products_list = cart.products.all()
		else:
			cart = Cart()
			cart.save()
			cart.owner.add(owner)
			products_list = cart.products.all()

		if request.method == 'POST':
			product = Product.objects.get(id=product_id)
			cart.products.remove(product)

		cart.save()

		return HttpResponseRedirect('/account/cart', {'cart':cart, 'owner':owner, 
			'products_list':products_list, 'username':username})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#清空购物车
def clear_cart(request):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		cart = Cart.objects.filter(owner=owner)

		if cart:
			cart = Cart.objects.get(owner=owner)
			products_list = cart.products.all()
		else:
			cart = Cart()
			cart.save()
			cart.owner.add(owner)
			products_list = cart.products.all()

		if request.method == 'POST':
			for product in products_list:
				cart.products.remove(product)

		cart.save()

		return HttpResponseRedirect('/account/cart', {'cart':cart, 'owner':owner, 
			'products_list':products_list, 'username':username})

	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#删除商品
def delete_product(request):
	username = request.session.get('username')
	if username:
		owner = User.objects.get(username__exact=username)
		products_list = owner.product_set.all()

		if request.method == 'POST':
			check_box_list = request.POST.getlist("check_box_list")

			for product in products_list:
				for i in range(0, len(check_box_list)):
					product_id = int(product.id)
					check_box = int(check_box_list[i])
					if check_box == product_id:
						product.is_exist = False
						product.save()

		return HttpResponseRedirect('/account/my_product', {'username':username, 'products_list':products_list})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#修改密码页面
def show_change_password(request):
	username = request.session.get('username')
	if username:
		user = User.objects.get(username__exact=username)
		# user.is_changed = False
		# user.save()
		return render_to_response('change_password.html', {'username':username, 'user':user})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login/?next=/account/change_password', {'userform':userform})

#修改密码
def change_password(request):
	username = request.session.get('username')

	if username:
		user = User.objects.get(username__exact=username)
		if request.method == 'POST':
			password_1 = request.POST.get("password1")
			password_2 = request.POST.get("password2")

			if password_1 == password_2:
				user.password = password_1
				user.is_changed = True
				user.save()
				return HttpResponseRedirect('/account/change_password', {'username':username, 'user':user})
			else:
				msg = "两次输入不一致"
				return render_to_response('change_password.html', {'username':username, 'msg':msg, 'user':user})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#搜索
def search(request):
	username = request.session.get('username')
	if request.method == 'POST':
		product_name = request.POST.get("pro_name")
		products_list = Product.objects.all()
		search_result = []
		for product in products_list:
			if product_name in product.name or product.name in product_name:
				if product.is_exist == True:
					search_result.append(product)

		if len(search_result) == 0:
			search_status = "Error"
		else:
			search_status = "Success"

		result_len = len(search_result)

		return render_to_response('search_result.html', {'username':username, 'product_name':product_name, 
			'search_result':search_result, 'search_status':search_status, 'result_len':result_len})
	else:
		return HttpResponse("!!!")

#交易记录
def show_transaction(request):
	username = request.session.get('username')
	if username:
		user = User.objects.get(username__exact=username)
		buy_list = Transaction.objects.filter(buyer=user)
		sell_list = Transaction.objects.filter(seller=user)
		return render_to_response('trade_record.html', {'username':username, 'buy_list':buy_list, 'sell_list':sell_list})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})

#充值
def recharge(request):
	username = request.session.get('username')
	if username:
		user = User.objects.get(username__exact=username)
		coin = Coin.objects.get(owner__exact=user)
		if coin.is_gotten == False:
			user.money = int(user.money) + 50
			user.save()
			coin.amount = int(user.money) + 50
			coin.is_gotten = True
			coin.save()
		
		return HttpResponseRedirect('/account', {'username':username, 'user':user})
	else:
		userform = UserForm(request.POST)
		return HttpResponseRedirect('/login', {'userform':userform})