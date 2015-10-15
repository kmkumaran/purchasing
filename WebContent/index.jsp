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
			<a href="">Fabrikam Purchasing</a>
		</p>
		<nav>
		<ul>
			<li><a href="index.jsp">Home</a></li>
			<li><a href="about.jsp">About Us</a></li>
			<li><a href="about.jsp">Contact Us</a></li>
		</ul>
		</nav> </header>
		<div id="body">
			<img alt="Welcome to Fabrikam Purchasing!" src="Images/banner_fabrikam.png"
				height="200" />
			<div id="featuredProduct">
				<img alt="Featured Product" src="Images/1.png" height="300" />
				<div id="featuredProductInfo">
					<div id="productInfo">
						<h2>AV Cables</h2>
						<p class="price">$345</p>
						<p class="description">AV Cables</p>
					</div>
					<div id="callToAction">
						<a class="order-button" href="placeorder.jsp?id=10"
							title="AV Cables">Order Now</a>
					</div>
				</div>
			</div>


			<div id="productsWrapper">
				<ul id="products" data-role="listview" data-inset="true">

					<li class="product"><a href="placeorder.jsp?id=10"
						title="AV Cables"> <img class="hide-from-desktop"
							src="Images/1.png" alt="Image of AV Cables" />
							<div class="productInfo">
								<h3>AV Cables</h3>
								<img class="product-image hide-from-mobile" src="Images/1.png"
									alt="Image of AV Cables" />
								<p class="description">AV Cables</p>
								<p class="price hide-from-desktop">$3.45</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$345</p>
							<a class="order-button" href="placeorder.jsp?id=10"
								title="Order AV Cables">Order Now</a>
						</div></li>
					<li class="product"><a href="placeorder.jsp?id=11"
						title="HDMI"> <img class="hide-from-desktop"
							src="Images/3.jpg" alt="Image of HDMI" />
							<div class="productInfo">
								<h3>HDMI</h3>
								<img class="product-image hide-from-mobile" src="Images/3.jpg"
									alt="Image of HDMI" />
								<p class="description">HDMI</p>
								<p class="price hide-from-desktop">$375</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$375</p>
							<a class="order-button" href="placeorder.jsp?id=11"
								title="Order HDMI">Order Now</a>
						</div></li>
					<li class="product"><a href="placeorder.jsp?id=12"
						title="Set Top Box"> <img class="hide-from-desktop"
							src="Images/4.jpg" alt="Image of Set Top Box" />
							<div class="productInfo">
								<h3>Set Top Box</h3>
								<img class="product-image hide-from-mobile" src="Images/4.jpg"
									alt="Image of Set Top Box" />
								<p class="description">Set Top Box</p>
								<p class="price hide-from-desktop">$475</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$475</p>
							<a class="order-button" href="placeorder.jsp?id=12"
								title="Order Set Top Box">Order Now</a>
						</div></li>
					<li class="product"><a href="placeorder.jsp?id=13"
						title="Power Cables"> <img class="hide-from-desktop"
							src="Images/2.jpg" alt="Image of Power Cables" />
							<div class="productInfo">
								<h3>Power Cables</h3>
								<img class="product-image hide-from-mobile" src="Images/2.jpg"
									alt="Image of Power Cables" />
								<p class="description">Power Cables</p>
								<p class="price hide-from-desktop">$265</p>
							</div>
					</a>
						<div class="action  hide-from-mobile">
							<p class="price">$265</p>
							<a class="order-button" href="placeorder.jsp?id=13"
								title="Order Power Cables">Order Now</a>
						</div></li>

				</ul>
			</div>
		</div>
		<footer> &copy;2014 - Fabrikam Purchasing</footer>
	</div>

</body>
</html>