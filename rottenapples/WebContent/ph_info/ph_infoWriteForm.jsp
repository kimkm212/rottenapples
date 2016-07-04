<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset=UTF-8>
		<title>Insert title here</title>
	</head>
	<body>
		<form action="ph_infoWritePro.jsp" method="post" name="fr">
			Code_name:<input type="text" name="code_name" required><br>
			Phone_name:<input type="text" name="phone_name" required><br>
			Manufacturer:<input list="manufacturer" name="manufacturer"required><br>
							<datalist id="manufacturer">
								<option value="SAMSUNG">
								<option value="LG">
								<option value="XIAOMI">
							</datalist>
			display_size:<input list="display_size" name="display_size" required><br>
						<datalist id="display_size">
							<option value="5.7">
							<option value="5.5">
							<option value="5.3">
							<option value="5.2">
							<option value="5.1">
							<option value="5.0">
							<option value="4.5">
						</datalist>
			Resolution:<input list="resolution" name="resolution" required><br>
						<datalist id="resolution">
							<option value="2560">
							<option value="1920">
							<option value="1280">
						</datalist>
			OS:<input list="os" name="os" required><br>
					<datalist id="os">
						<option value="6.0">
						<option value="5.1">
						<option value="5.0">
						<option value="4.4">
					</datalist>
			CPU:<input list="cpu" name="cpu" required><br>
					<datalist id="cpu">
						<option value="SnapDragon 820">
						<option value="SnapDragon 810">
						<option value="SnapDragon 808">
						<option value="SnapDragon 410">
						<option value="SnapDragon 400">
						<option value="Exynos8 8890">
						<option value="Exynos7 7580">
						<option value="Exynos7 7578">
						<option value="Exynos7 7420">
					</datalist>
			RAM:<input list="ram" name="ram" required><br>
					<datalist id="ram">
						<option value="4">
						<option value="3">
						<option value="2">
						<option value="1.5">
						<option value="1">
					</datalist>
			battery:<input type="text" name="battery_capacity" required><br>
			Weight:<input type="text" name="weight" required><br>
			release_date:<input type="date" name="release_date" required><br>
			img_location:<input type="text" name="img_location" required><br>
			<input type="submit" value="전송">
		</form>
	</body>
</html>