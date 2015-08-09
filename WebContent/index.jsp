<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Fabrikam Purchasing</title>
<link href="Content/Site.css" rel="stylesheet" />
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
<script src="Scripts/modernizr-2.5.3.js"></script>
<script src="Scripts/jquery-1.7.1.min.js"></script>
<body>
	<div id="page">
		<header>
		<p class="site-title">
			<a href="">Fabrikam Publishing</a>
		</p>
		<nav>
		<ul>
			<li><a href="index.jsp">Home</a></li>
			<li><a href="about.jsp">About Us</a></li>
		</ul>
		</nav> </header>
		<div id="body">
			<img alt="Welcome to Coffee Shop!" src="Images/banner_coffee.png"
				height="200" />
			<div id="featuredProduct">
				<img alt="Featured Product" src="Images/1.jpg" height="300" />
				<div id="featuredProductInfo">
					<div id="productInfo">
						<h2>Cappuccino</h2>
						<p class="price">$3.45</p>
						<p class="description">Cappuccino</p>
					</div>
					<div id="callToAction">
						<a class="order-button" href="placeorder.jsp?id=10"
							title="Cappuccino">Order Now</a>
					</div>
				</div>
			</div>


			<div id="productsWrapper">
				<ul id="products" data-role="listview" data-inset="true">

					<li class="product"><a href="placeorder.jsp?id=10"
						title="Cappuccino"> <img class="hide-from-desktop"
							src="Images/1.jpg" alt="Image of Cappuccino" />
							<div class="productInfo">
								<h3>Cappuccino</h3>
								<img class="product-image hide-from-mobile" src="Images/1.jpg"
									alt="Image of Cappuccino" />
								<p class="description">Cappuccino</p>
								<p class="price hide-from-desktop">$3.45</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$3.45</p>
							<a class="order-button" href="placeorder.jsp?id=10"
								title="Order Cappuccino">Order Now</a>
						</div></li>
					<li class="product"><a href="placeorder.jsp?id=11"
						title="Espresso"> <img class="hide-from-desktop"
							src="Images/3.jpg" alt="Image of Espresso" />
							<div class="productInfo">
								<h3>Espresso</h3>
								<img class="product-image hide-from-mobile" src="Images/3.jpg"
									alt="Image of Espresso" />
								<p class="description">Espresso</p>
								<p class="price hide-from-desktop">$3.75</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$3.75</p>
							<a class="order-button" href="placeorder.jsp?id=11"
								title="Order Espresso">Order Now</a>
						</div></li>
					<li class="product"><a href="placeorder.jsp?id=12"
						title="Americano"> <img class="hide-from-desktop"
							src="Images/4.jpg" alt="Image of Americano" />
							<div class="productInfo">
								<h3>Americano</h3>
								<img class="product-image hide-from-mobile" src="Images/4.jpg"
									alt="Image of Americano" />
								<p class="description">Americano</p>
								<p class="price hide-from-desktop">$4.75</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$4.75</p>
							<a class="order-button" href="placeorder.jsp?id=12"
								title="Order Americano">Order Now</a>
						</div></li>
					<li class="product"><a href="placeorder.jsp?id=13"
						title="Latte"> <img class="hide-from-desktop"
							src="Images/2.jpg" alt="Image of Latte" />
							<div class="productInfo">
								<h3>Latte</h3>
								<img class="product-image hide-from-mobile" src="Images/2.jpg"
									alt="Image of Latte" />
								<p class="description">Latte</p>
								<p class="price hide-from-desktop">$2.65</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$2.65</p>
							<a class="order-button" href="placeorder.jsp?id=13"
								title="Order Latte">Order Now</a>
						</div></li>

				</ul>
			</div>
		</div>
		<footer> &copy;2014 - Coffee Shop </footer>
	</div>

</body>
</html>