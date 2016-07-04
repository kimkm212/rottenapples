<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.ArrayList,
			phoneBoard.PhoneBean,
			member.MemberBean"%>
<jsp:useBean id="pdao" class="phoneBoard.PhoneDAO"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<%
	String sessionName=(String)session.getAttribute("nick_name");
	String sessionEmail=(String)session.getAttribute("email");
	String emailInfo=null, nickInfo=null, dateInfo=null;
	if(sessionName!=null){
		MemberBean mb = mdao.getMember(sessionEmail);
		emailInfo=mb.getEmail();
		nickInfo=mb.getNick_name();
		dateInfo=mb.getRegi_date().toString();
	}

	ArrayList<PhoneBean> smList, lgList, xiList;
	smList = pdao.getPhoneList("SAMSUNG");
	lgList = pdao.getPhoneList("LG");
	xiList = pdao.getPhoneList("XIAOMI");

%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>RottenApples</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
	<script>
		var sessionName = '<%=sessionName%>';
		var sessionEmail = '<%=sessionEmail%>';
	</script>
  </head>
  <body>
<!--해더 시작---------------------------------------------------------------------------------->
    <header>
      <nav class="navbar navbar-fixed-top hnav">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp"><span><img src="images/apple-freshmark.png" alt="logo"/></span> RottenApples</a>
          </div>
          <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav" id="ul1">
              <li class="active"><a href="#section1" class="scrspy">Home</a></li>
              <li><a href="#section2" class="scrspy">SAMSUNG</a></li>
              <li><a href="#section3" class="scrspy">LG</a></li>
              <li><a href="#section4" class="scrspy">ECT</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
							<li>
								<div class="conSearch">
									<span class="glyphicon glyphicon-search"></span><input type="search" value="" id="schBar">
									<!-- 검색결과 나오는 부분-->
									<div id="searchCon">
										<div class="container-fluid resulCon">
<!--
											<div class="row neviewPhone" id="sm-g935" draggable="true" ondragstart="drag(event)">
												<div class="col-lg-4">
													<img src="images/phone/sm-g935.png" alt="" />
												</div>
												<div class="col-lg-8">
													<p>SAMSUNG</p>
													<p>Galaxy s7</p>
												</div>
											</div>
										</div>
				-->
										</div>
									</div>
								</div>
							</li>
            <%if(sessionName==null){%>
              <li data-toggle="modal" data-target="#signUp"><a href="#"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
              <li data-toggle="modal" data-target="#logIn"><a href="#"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
            <%}else{%>
							<li data-toggle="modal" data-target="#memberInfo" id="info_btn"><a href="#"><span class="glyphicon glyphicon-user"></span> <%=sessionName%>님. 안녕하세요.</a></li>
            	<li><a href="member/logout.jsp"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
            <%}%>
            </ul>
          </div>
        </div>
      </nav>
      <!--모달 시작--------------------------------------------------------------------------------------->
      <!--회원가입 폼 모달---------------------------------------------------->
      <div id="signUp" class="modal fade" role="dialog">
        <div class="modal-dialog">
          <!--회원가입 폼-->
          <div class="modal-content">
            <div class="modal-body">
							<div style="width:100%; text-align:center;">
								<img src="images/signup.png" alt="회원가입" />
							</div>

              <form role="form" action="member/joinPro.jsp" method="post">
                <div class="form-group">
                  <label for="email">이메일 주소:</label>
                  <input type="email" class="form-control" id="email" name="email" autocomplete="off" placeholder="Example@rottenApples.com" required autofocus>
									<span class="help-block emCheck"></span>
                </div>
                <div class="form-group">
                  <label for="nick">별명:</label>
                  <input type="text" class="form-control" id="nick" name="nick_name" autocomplete="off" placeholder="2~8자 입력해주세요." required>
									<span class="help-block niCheck"></span>
                </div>
                <div class="form-group">
                  <label for="pwd">비밀번호:</label>
                  <input type="password" class="form-control" id="pwd" name="password" autocomplete="off" placeholder="6~16자리 입력해주세요." required>
									<span class="help-block pwdHelp"></span>
                </div>
                <div class="form-group">
                  <label for="pwdCheck">비밀번호 확인:</label>
                  <input type="password" class="form-control" id="pwdCheck" autocomplete="off" required>
									<span class="help-block pchHelp"></span>
                </div>
                <!--버튼 제어-->
								<button type="submit" class="btn btn-success btn-block" style="display:none">회원가입</button>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
      <!--회원가입 폼 모달 끝------------------------------------------------->
      <!--로그인 폼 모달---------------------------------------------------->
      <div id="logIn" class="modal fade" role="dialog">
        <div class="modal-dialog">
          <!--로그인 폼-->
          <div class="modal-content">
            <div class="modal-body">
							<div style="width:100%; text-align:center;">
								<img src="images/login.png" style="margin:0 auto;" alt="로그인" />
							</div>
              <form role="form" action="member/loginPro.jsp" method="post">
                <div class="form-group">
                  <label for="email">이메일 주소:</label>
                  <input type="email" class="form-control" id="email" name="email" placeholder="Example@rottenApples.com" required autofocus>
                </div>
                <div class="form-group">
                  <label for="pwd">비밀번호:</label>
                  <input type="password" class="form-control" id="pwd" name="password">
                </div>
                <button type="submit" class="btn btn-success btn-block">로그인</button>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
      <!--로그인 폼 모달 끝------------------------------------------------->
		<!-- 회원정보 모달폼 -->
		<div id="memberInfo" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">회원정보</h4>
		      </div>
		      <div class="modal-body">
		        <table class="table table-bordered">
	            	<tr><td>이메일</td><td><%=emailInfo%></td></tr>
	    			<tr><td>별명</td><td><%=nickInfo%></td></tr>
	    			<tr><td>가입일</td><td><%=dateInfo%></td></tr>
		        </table>
				<div class="panel-group" id="accordion">
				  <div class="panel panel-default">
				    <div class="panel-heading">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">회원정보 변경</a>
				      </h4>
				    </div>
				    <div id="collapse1" class="panel-collapse collapse">
				      <div class="panel-body">
								<div class="form-group">
									<label for="modiPass">비밀번호</label>
				      		<input type="password" id="modiPass" class="form-control">
									<span class="help-block modiPass"></span>
								</div>
							<!-- 변경 폼 들어가는 부분-->
								<form role="form" class="modiMem" style="display:none" action="member/updatePro.jsp" method="post">
									<div class="form-group">
	                  <label for="mem_nick">새로운 별명:</label>
	                  <input type="text" class="form-control" id="mem_nick" name="nick_name" autocomplete="off">
										<span class="help-block mem_nickHelp"></span>
										<button type="button" class="btn btn-success btn-block" style="display:none">별명만 변경</button>
	                </div>
	                <div class="form-group">
	                  <label for="new_pwd">새로운 비밀번호:</label>
	                  <input type="password" class="form-control" id="new_pwd" name="password" autocomplete="off">
										<span class="help-block new_pwdHelp"></span>
	                </div>
	                <div class="form-group">
	                  <label for="new_pwdCheck">새로운 비밀번호 확인:</label>
	                  <input type="password" class="form-control" id="new_pwdCheck" autocomplete="off">
										<span class="help-block new_pwdCheckHelp"></span>
	                </div>
									<input type="hidden" name="email" value="<%=sessionEmail%>">
									<button type="submit" class="btn btn-success btn-block" style="display:none">변경하기</button>
								</form>
				      </div>
				    </div>
				  </div>
				  <div class="panel panel-default">
				    <div class="panel-heading">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">회원탈퇴</a>
				      </h4>
				    </div>
				    <div id="collapse2" class="panel-collapse collapse">
				      <div class="panel-body">
								<form role="form" action="member/deletePro.jsp" method="post">
									<div class="form-group">
										<label for="talPass">비밀번호</label>
					      		<input type="password" id="in_talPass" class="form-control" name="password">
										<span class="help-block talPass"></span>
									</div>
									<input type="hidden" name="email" value="<%=sessionEmail%>">
								<!-- 탈퇴 확인 버튼 -->
								<button type="submit" class="btn btn-success btn-block" style="display:none" id="tal_btn">누르시면 탈퇴과정이 완료됩니다.</button>
								</form>
				      </div>
				    </div>
				  </div>
				  <div class="panel panel-default">
				    <div class="panel-heading">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
				        쓴글 보기</a>
				      </h4>
				    </div>
				    <div id="collapse3" class="panel-collapse collapse">
				      <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit,
				      sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
				      minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
				      commodo consequat.</div>
				    </div>
				  </div>
				</div>
			</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
	    </div>
	  </div>
	</div>
    <!--모달 끝--------------------------------------------------------------------------------------->
    </header>
<!--해더 끝----------------------------------------------------------------------------------->
    <section>
      <!--돌아가는 그림------------------------------------------------->
      <div class="container-fluid">
        <div id="section1" class="container">
          <div class="row">
            <div class="col-lg-6">
              <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                  <li data-target="#myCarousel" data-slide-to="1"></li>

                </ol>
                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                  <div class="item active">
                    <img src="images/sm_cf.jpg" alt="">
                  </div>
                  <div class="item">
                    <img src="images/lg_cf.jpg" alt="">
                  </div>

                </div>
                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </a>
              </div>
              <!--돌아가는 그림 끝------------------------------------------------->
            </div>
						<div class="col-lg-2">

						</div>
          </div>
          <!--인기휴대폰 목록-------------------------------------------------->
          <div id="gradePhone" class="row">
            <div class="col-lg-4">
              <table class="table">
                <thead>
                  <tr>
                    <td colspan="2">인기휴대폰 TOP5</td>
                    <td>출시일</td>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>80%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>66%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>77%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>88%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>55%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="col-lg-4">
              <table class="table">
                <thead>
                  <tr>
                    <td colspan="2">인기휴대폰 TOP5</td>
                    <td>출시일</td>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>80%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>66%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>77%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>88%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>55%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="col-lg-4" style="background:none;">
              <table class="table">
                <thead>
                  <tr>
                    <td colspan="2">인기휴대폰 TOP5</td>
                    <td>출시일</td>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>80%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>66%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>77%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>88%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                  <tr>
                    <td><img src="images/apple-fresh.png" alt="싱싱사과" /><span>55%</span></td>
                    <td>Galaxy S7</td>
                    <td>2016-03-11</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <!--인기휴대폰 목록 끝----------------------------------------------->
        </div>
      </div>
      <!--폰 리스트------------------------------------------------------->
      <div class="container-fluid">
        <div id="section2" class="container">
          <h2>SAMSUNG</h2>
          <div class="row">
            <%
            for(PhoneBean e : smList){
           	%>
            <div class="col-lg-3">
              <div class="thumbnail viewPhone" id="<%=e.getCode_name()%>"  draggable="true" ondragstart="drag(event)">
								<div class="aaa"></div>
                <img src="<%=e.getImg_location()%>" class="phoneList" alt="<%=e.getCode_name()%>"/>
                <p><%=e.getPhone_name()%></p>
              </div>
            </div>
            <%}%>
          </div>
        </div>
      </div>
      <div class="container-fluid">
        <div id="section3" class="container">
          <h2>LG</h2>
          <div class="row">
            <%
            for(PhoneBean e : lgList){
           	%>
            <div class="col-lg-3">
              <div class="thumbnail viewPhone" id="<%=e.getCode_name()%>" draggable="true" ondragstart="drag(event)">
								<div class="aaa"></div>
								<img src="<%=e.getImg_location()%>" class="phoneList" alt="<%=e.getCode_name()%>"/>
                <p><%=e.getPhone_name()%></p>
              </div>
            </div>
            <%}%>
          </div>
        </div>
      </div>
			<div class="container-fluid">
        <div id="section4" class="container">
          <h2>XIAOMI</h2>
          <div class="row">
            <%
            for(PhoneBean e : xiList){
           	%>
            <div class="col-lg-3">
              <div class="thumbnail viewPhone" id="<%=e.getCode_name()%>" draggable="true" ondragstart="drag(event)">
								<div class="aaa"></div>
								<img src="<%=e.getImg_location()%>" class="phoneList" alt="<%=e.getCode_name()%>"/>
                <p><%=e.getPhone_name()%></p>
              </div>
            </div>
            <%}%>
          </div>
        </div>
      </div>
    </section>
    <footer class="container-fluid">
      <ul>
        <li><a href="#">SAMSUNG</a></li>
        <li><a href="#">S 시리즈</a></li>
        <li><a href="#">NOTE 시리즈</a></li>
        <li><a href="#">A 시리즈</a></li>
      </ul>

    </footer>
		<!----------------------------------------------------------->
		<!-- 비교 바-->
		<div class="container-fluid" id="comBar" style="display:none;">
			<div class="navbar navbar-fixed-bottom in">
		    <div class="container" id="comContainer" style="background:none;">
					<div class="comArea1" id="div1" ondrop="drop1(event)" ondragover="allowDrop(event)">
						  <input id="comP1" class="test1" type="hidden" value="">
					</div>
					<div class="butArea">
						<button type="button" class="btn btn-default btn-success" id="compare_btn">비교</button>
						<button type="button" class="btn btn-default btn-info" id="reset_btn">리셋</button>
					</div>
					<div class="comArea2" id="div2" ondrop="drop2(event)" ondragover="allowDrop(event)">
						<input id="comP2" class="test2" type="hidden" value="">
					</div>
		    </div>
		  </div>
		</div>
<!-- 토글 버튼 -->
	<div class="toggle_btn">
		<button type="button" class="btn btn-warning">스마트폰 비교하기</button>
	</div>
  </body>
</html>
<!--모달-->
<!-- 폰정보 모달 -->
<div id="ph_info" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h3 class="modal-title" id="phTitle">SAMSUNG Galaxy S7</h3>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-lg-5" id="ph_info_img">
            <img src="images/phone/sm-g935.png" id="img_loc" alt="코드네임" />
            <h3><img src="images/apple-fresh.png" alt="싱싱사과" id="img_app"/><span id="r_app"> 99%</span></h3>
          </div>
          <div class="col-lg-7" id="ph_spec">
            <table class="table table-bordered">
              <tr><td>화면크기</td><td id="d_size">5.1인치</td></tr>
              <tr><td>해상도</td><td id="resol">1920x1080</td></tr>
              <tr><td>OS</td><td id="os">안드로이드 6.0</td></tr>
              <tr><td>CPU</td><td id="cpu">엑시노스8 8000</td></tr>
              <tr><td>RAM</td><td id="ram">4Gb</td></tr>
              <tr><td>배터리용량</td><td id="bttr">3000mah</td></tr>
              <tr><td>무게</td><td id="weight">140g</td></tr>
              <tr><td>출시일</td><td id="r_date">2016-03-11</td></tr>
            </table>
            <form role="form" id="comForm">
              <div class="row">
								<div class="col-lg-12">

								</div>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<!--의견 박스영역 좋아요부분-->
									<label for="like_rad">
									<button type="button" class="btn btn-default btn-block" id="like_btn"><img src="images/apple-fresh.png" alt="싱싱사과" class="islike"/></button>
									<input type="radio" name="isLike" id="like_rad" value="1">
									</label>
								</div>
								<div class="col-lg-6">
									<!--의견 박스영역 싫어요부분-->
									<label for="hate_rad">
									<button type="button" class="btn btn-default btn-block" id="hate_btn"><img src="images/apple-rotten.png" alt="썩은사과" class="islike"/></button>
									<input type="radio" name="isLike" id="hate_rad" value="0">
									</label>

								</div>
							</div>
              <input type="hidden" name="nick_name" value="<%=sessionName%>" class="form-control" id="com_nick">
              <div class="form-group">
                <textarea name="content" rows="5" cols="40" class="form-control" id="com_opi" placeholder="의견을 남겨주세요"></textarea>
								<%
									if(sessionName!=null){
								%>
								<h4 style="float:right;">-<%=sessionName%></h4>
								<%}%>
									<span class="help-block">30바이트 이상 입력하고 사과 선택해 주세요.</span>
								<span class="help-block" id="len_check"></span>
              </div>
							<input type="hidden" name="code_name" id="com_codeName">
							<button type="button" style="display:none;" class="btn btn-success btn-block" id="comInput">확인</button>
					  </form>
          </div>
        </div>
        <div class="row comment_area" id="info_com">
			<!-- 제이쿼리로 댓글 삽입되는 부분
				<div class="col-lg-6 ph_comment">
					<div class="">
						<img src="이미지경로" alt=""/>
						<p> 글 내용 </p>
						<a href=""> 닉네임 </a><span> 댓글날짜</span>
					</div>
				</div>
			-->
        </div>
			<div class="row">
				<div class="col-lg-12">
	         <!--댓글 버튼 불러오는 영역-->
				<button type="button" class="btn btn-info btn-block" id="getComList">1</button>
	      </div>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<!--비교페이지 모달-->
<div id="ph_compare" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">ComparePhone</h4>
      </div>
      <div class="modal-body">
        <div class="row">
          <!-- 폰 이미지 영역 -->
          <div class="col-lg-3 comp_imgArea">
            <img id="p1_img" src="images/phone/sm-g935.png" class="comp_img" alt="코드네임" />
            <h3><img id="p1_aimg" src="images/apple-fresh.png" alt="싱싱사과" /><span id="p1_rp">99%</span></h3>
          </div>
          <div class="col-lg-6">
						<div class="row">
							<div class="col-lg-4" style="text-align:center;">
								<h3 id="p1Name">갤럭시 s3</h3>
							</div>
							<div class="col-lg-4" style="text-align:center;">
								<h3>v s</h3>
							</div>
							<div class="col-lg-4" style="text-align:center;">
								<h3 id="p2Name">Lg G5</h3>
							</div>
						</div>
            <table class="table table-bordered">
              <tr><td id="p1_1"></td><td>화면크기</td><td id="p2_1"></td></tr>
              <tr><td id="p1_2"></td><td>해상도</td><td id="p2_2"></td></tr>
              <tr><td id="p1_3"></td><td>OS</td><td id="p2_3"></td></tr>
              <tr><td id="p1_4"></td><td>CPU</td><td id="p2_4"></td></tr>
              <tr><td id="p1_5"></td><td>RAM</td><td id="p2_5"></td></tr>
              <tr><td id="p1_6"></td><td>배터리용량</td><td id="p2_6"></td></tr>
              <tr><td id="p1_7"></td><td>무게</td><td id="p2_7"></td></tr>
              <tr><td id="p1_8"></td><td>출시일</td><td id="p2_8"></td></tr>
            </table>
            <div class="progress">
              <div id="p1_name" class="progress-bar progress-bar-success" role="progressbar" style="width:50%">
                갤럭시 S7
              </div>
              <div id="p2_name" class="progress-bar progress-bar-warning" role="progressbar" style="width:50%">
                LG G5
              </div>
            </div>
          </div>
          <!-- 폰 이미지 영역 -->
          <div class="col-lg-3 comp_imgArea">
            <img id="p2_img" src="images/phone/sm-g935.png" class="comp_img" alt="코드네임" />
            <h3><img id="p2_aimg" src="images/apple-fresh.png" alt="싱싱사과" /> <span id="p2_rp">99%</span></h3>
          </div>
        </div>
        <!-- 댓글영역 -->
        <div class="row comment_area">
          <div class="col-lg-6 ph_commentCom1" >
<!-- 첫번째 폰 코맨트 들어오는 부분 -->
          </div>

          <div class="col-lg-6 ph_commentCom2" >
<!-- 두번째 폰 코멘트 들어오는 부분-->
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
