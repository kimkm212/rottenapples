
//부드러운 스크롤스파이----------------------------------------------------
$(document).ready(function(){
  $('body').scrollspy({target: ".navbar", offset: 50});
  $('#myNavbar .scrspy').on('click', function(event) {
    event.preventDefault();
    var hash = this.hash;
    $('html, body').animate({scrollTop: $(hash).offset().top}, 800, function(){
      window.location.hash = hash;
    });
  });
});


//실시간 검색---------------------------------------------------
$(document).ready(function(){
  $('#schBar').keyup(function(){
    var a = $(this).val();
    if(a.length>1){
      var url = "ph_info/getSearch.jsp"
      $.getJSON(url,{search:a}, function(data, status){
        $('.resulCon').empty();
        for(var i in data){
          $('.resulCon').append('<div class="row neviewPhone" id="'+data[i].code_name+'">'+
                '<div class="col-lg-4"><img src="'+data[i].img_location+'" alt="'+data[i].code_name+'" /></div>'+
                '<div class="col-lg-8"><p>'+data[i].manufacturer+'</p><p>'+data[i].phone_name+'</p></div></div>');
        }
        newModal();
      });
    }
  });

  $('#schBar').click(function(){
    $('.resulCon').empty();
  });

//새롭게 기능
function newModal() {
   $('.neviewPhone').click(function(){
    //페이지 초기화
    conPage=1;
    currentView=0;
    totalComment=0;

    //댓글란 초기화
    $('#com_opi').val('');
    $('input:radio[name="isLike"]').prop('checked', false);
    $('#hate_btn').attr('class', 'btn btn-default btn-block');
    $('#like_btn').attr('class', 'btn btn-default btn-block');

    //폰정보 불러오기
    var coName = $(this).attr('id');
    var url = "ph_info/getPhoneInfo.jsp";
    $.getJSON(url,{code_name:coName}, function(data, status){
       $('#phTitle').text(data[0].manufacturer+' '+ data[0].phone_name);
       $('#d_size').text(data[0].display_size+' inch');
       $('#resol').text(data[0].resolution+'x'+data[0].resolution*9/16);
       $('#os').text('Android'+data[0].os);
       $('#cpu').text(data[0].cpu);
       $('#ram').text(data[0].ram+' Gb');
       $('#bttr').text(data[0].battery_capacity+' mah');
       $('#weight').text(data[0].weight+' g');
       $('#r_date').text(data[0].release_date);
       $('#r_app').text(data[0].rottenApples+' %');
       $('#img_loc').attr('src', data[0].img_location);
       $('#com_codeName').val(data[0].code_name);
       $('#getComList').empty();

       //페이지 설정
       totalComment = data[0].comCount;
       currentView = totalComment < 10 ? totalComment : conPage*10;
       //코멘트 불러오기
       moreCom(currentView, totalComment);

       //사과이미지 업데이트
       if(data[0].rottenApples>=70){
         $('#img_app').attr('src', 'images/apple-fresh.png');
       }else{
         $('#img_app').attr('src', 'images/apple-rotten.png');
       }

       //댓글 초기화 후 뿌려줌
       $('#info_com').empty();
       for(var i=1; i<=10; i++){
        showCom(data, i);
       }
    });
    $('#ph_info').modal();
  });
}

//  $('*').not('#searchCon').click(function(){
//    $('.resulCon').empty();
//  });
});

//회원가입 폼 제어 부분----------------------------------------------------
$(document).ready(function(){

//회원가입 제출버튼 제어 함수
  function submitCon(){
    $('#signUp form button').css("display", "none");
    var a=$('.emCheck p').attr('class');
    var b=$('.niCheck p').attr('class');
    var c=$('.pwdHelp p').attr('class');
    var d=$('.pchHelp p').attr('class');
    if(a=='bg-primary'&& b=='bg-primary'&&c=='bg-primary'&&d=='bg-primary'){
      $('#signUp form button').show();
    }else{
      $('#signUp form button').hide();
    }
  }
//아이디 실시간 체크
	$("#email").keyup(function(){
    var emVal = $("#email").val();
    var regCheck = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;
      if(!regCheck.test(emVal)){
        $(".emCheck").html('<p class="bg-danger">유효한 Email형식이 아닙니다.</p>');
        submitCon();
      }else{
        $.post("member/emailCheck.jsp",{email: emVal},function(data, status){
          if(data==1){
            $(".emCheck").html('<p class="bg-danger">이미 존재하는 Email입니다. 다른 Email을 입력해 주세요.</p>');
            submitCon();
          }else{
            $(".emCheck").html('<p class="bg-primary">사용가능한 Email입니다.</p>');
            submitCon();
          }
        });
      }
  });

//닉네임 실시간 체크
	$("#nick").keyup(function(){
    var niVal = $("#nick").val();
    var regCheck = /\s/g;
    if(regCheck.test(niVal)||niVal.length>8 || niVal.length<2){
    	$(".niCheck").html('<p class="bg-danger">닉네임은 2~8자, 공백이 있으면 안됩니다.</p>');
      submitCon();
    }else{
    	$.post("member/nickCheck.jsp",{nick_name: niVal},function(data, status){
    		if(data==1){
    			$(".niCheck").html('<p class="bg-danger">이미 존재하는 별명입니다. 다른 별명을 입력해 주세요.</p>');
          submitCon();
    		}else{
    		  $(".niCheck").html('<p class="bg-primary">사용가능한 별명입니다.</p>');
          submitCon();
    		}
    	 });
    }
  });

//비밀번호 유효성 체크
  $("#pwd").keyup(function(){
    $('#pwdCheck').val('');
    $('.pchHelp').empty();
    var pass = $("#pwd").val();
    if(pass.length>16 || pass.length<6){
      $(".pwdHelp").html('<p class="bg-danger">비밀번호는 6~16자리 사이여야 합니다.</p>');
      submitCon();
    }else{
    	$(".pwdHelp").html('<p class="bg-primary">사용가능합니다.</p>');
      submitCon();
    }
  });

//비밀번호 확인 체크
  $('#pwdCheck').keyup(function(){
    var pass = $('#pwd').val();
    var passCheck = $('#pwdCheck').val();
      if (pass != passCheck) {
          $('.pchHelp').html('<p class="bg-danger">입력한 비밀번호와 다릅니다.</p>');
          submitCon();
      } else {
          $('.pchHelp').html('<p class="bg-primary">비밀번호가 일치합니다.</p>');
          submitCon();
      }
  });
});

//회원정보 수정
$(document).ready(function(){
  function modiCom(){
    $('.modiMem > button').css("display", "none");
    var a=$('.mem_nickHelp p').attr('class');
    var b=$('.new_pwdHelp p').attr('class');
    var c=$('.new_pwdCheckHelp p').attr('class');
    if(a=='bg-primary'&& b=='bg-primary'&&c=='bg-primary'){
      $('.modiMem > button').fadeIn(500);
    }
  }

  //비밀변호 판별 및 변경창 제어
  $('#modiPass').keyup(function(){
    $('.modiMem').css('display', 'none');
    var pwd = $('#modiPass').val();
    $.post("member/passCheck.jsp",{email: sessionEmail, password:pwd},function(data, status){
      if(data==1){
        $('.modiPass').html('<p class="bg-primary">비밀번호가 일치합니다</p>');
        $('.modiMem').fadeIn(1300);
      }else{
        $('.modiPass').html('<p class="bg-danger">비밀번호가 다릅니다.</p>');
      }
    });
  });

  //새로운 별명 확인
  $('#mem_nick').keyup(function(){
    var niVal = $(this).val();
    if(niVal.length>8 || niVal.length<2){
      $(".mem_nickHelp").html('<p class="bg-danger">닉네임은 2~8자로 입력해 주세요.</p>');
      modiCom();
    }else{
      $.post("member/nickCheck.jsp",{nick_name: niVal},function(data, status){
        if(data==1){
          $(".mem_nickHelp").html('<p class="bg-danger">이미 존재하는 별명입니다. 다른 별명을 입력해 주세요.</p>');
          modiCom();
        }else{
          $(".mem_nickHelp").html('<p class="bg-primary">사용가능한 별명입니다.</p>');
          modiCom();
        }
       });
    }
  });

  //새로운 비번 확인
    $("#new_pwd").keyup(function(){
      $('#new_pwdCheck').val('');
      $('.new_pwdCheckHelp').empty();
      var pass = $("#new_pwd").val();
      if(pass.length>16 || pass.length<6){
        $(".new_pwdHelp").html('<p class="bg-danger">비밀번호는 6~16자리 사이여야 합니다.</p>');
        modiCom();
      }else{
      	$(".new_pwdHelp").html('<p class="bg-primary">사용가능합니다.</p>');
        modiCom();
      }
    });

  //새로운 비밀번호 확인 체크
    $('#new_pwdCheck').keyup(function(){
      var pass = $('#new_pwd').val();
      var passCheck = $('#new_pwdCheck').val();
        if (pass != passCheck) {
            $('.new_pwdCheckHelp').html('<p class="bg-danger">입력한 비밀번호와 다릅니다.</p>');
            modiCom();
        } else {
            $('.new_pwdCheckHelp').html('<p class="bg-primary">비밀번호가 일치합니다.</p>');
            modiCom();
        }
    });


    //회원탈퇴 비번 확인
    $('#in_talPass').keyup(function(){
      $('#tal_btn').css('display', 'none');
      var pwd = $('#in_talPass').val();
      $.post("member/passCheck.jsp",{email: sessionEmail, password:pwd},function(data, status){
        if(data==1){
          $('.talPass').html('<p class="bg-primary">비밀번호가 일치합니다</p>');
          $('#tal_btn').fadeIn(1300);
        }else{
          $('.talPass').html('<p class="bg-danger">비밀번호가 다릅니다.</p>');
        }
      });
    });


});

//페이지 제어 전역변수로
var conPage;
var currentView;
var totalComment;
//더보기 버튼 제어 모듈
function moreCom(currentView, totalComment){
  $('#getComList').text('댓글 더보기(' + currentView + ' / ' + totalComment + ')');
}
//댓글 뿌려주는 모듈 함수
function showCom(data, i){
  var isLike;
  if(data[i].isLike==1){
    isLike="images/apple-fresh.png";
  }else{
    isLike="images/apple-rotten.png";
  }
  $('#info_com').append('<div class="col-lg-6 ph_comment" style="display:none;">'+
                          '<div class="container-fluid">'+
                            '<div class="appContainer"><img src="'+isLike+'" alt=""/></div><p>'+data[i].content+'</p>'+
                              '<div class="person"><a href="">'+data[i].nick_name+' '+'</a><span>'+' '+data[i].date+'</span></div></div></div>');
  $('.ph_comment').fadeIn(1300);
}

//폰 정보 보여주기 부분----------------------------------------------------------------------
$(document).ready(function(){
//폰정보 모달 값 바꾸기
  $('.viewPhone').click(function(){
    //페이지 초기화
    conPage=1;
    currentView=0;
    totalComment=0;

    //댓글란 초기화
    $('#com_opi').val('');
    $('input:radio[name="isLike"]').prop('checked', false);
    $('#hate_btn').attr('class', 'btn btn-default btn-block');
    $('#like_btn').attr('class', 'btn btn-default btn-block');

    //폰정보 불러오기
    var coName = $(this).attr('id');
    var url = "ph_info/getPhoneInfo.jsp";
    $.getJSON(url,{code_name:coName}, function(data, status){
  	   $('#phTitle').text(data[0].manufacturer+' '+ data[0].phone_name);
       $('#d_size').text(data[0].display_size+' inch');
       $('#resol').text(data[0].resolution+'x'+data[0].resolution*9/16);
       $('#os').text('Android'+data[0].os);
       $('#cpu').text(data[0].cpu);
       $('#ram').text(data[0].ram+' Gb');
       $('#bttr').text(data[0].battery_capacity+' mah');
       $('#weight').text(data[0].weight+' g');
       $('#r_date').text(data[0].release_date);
       $('#r_app').text(data[0].rottenApples+' %');
       $('#img_loc').attr('src', data[0].img_location);
       $('#com_codeName').val(data[0].code_name);
       $('#getComList').empty();

       //페이지 설정
       totalComment = data[0].comCount;
       currentView = totalComment < 10 ? totalComment : conPage*10;
       //코멘트 불러오기
       moreCom(currentView, totalComment);

       //사과이미지 업데이트
       if(data[0].rottenApples>=70){
         $('#img_app').attr('src', 'images/apple-fresh.png');
       }else{
         $('#img_app').attr('src', 'images/apple-rotten.png');
       }

       //댓글 초기화 후 뿌려줌
       $('#info_com').empty();
       for(var i=1; i<=10; i++){
        showCom(data, i);
       }
  	});
    $('#ph_info').modal();
  });


  //댓글 클릭 로그인상태 판별및 submit 제어
    $('#com_opi').click(function(){
      if(sessionName=='null'){
        alert('댓글을 남기시려면 로그인이 필요합니다');
      }
    });

  //댓글 입력폼 유효성 제어 함수
    var a, b, c, con, conLength, conByte;
    function conCom(){
      a = $('#like_btn').attr('class');
      b = $('#hate_btn').attr('class');
      c = conByte;
      if((a!=b)&&c>=30&&c<=300){
        $('#comInput').show();
      }else{
        $('#comInput').hide();
      }
    }

  // 좋아요 버튼 클릭
    $('#like_btn').click(function(){
      $('input:radio[name="isLike"][value="1"]').prop('checked', true);
      $(this).attr('class', 'btn btn-success btn-block');
      $('#hate_btn').attr('class', 'btn btn-default btn-block');
      conCom();
    });

    $('#hate_btn').click(function(){
      $('input:radio[name="isLike"][value="0"]').prop('checked', true);
      $(this).attr('class', 'btn btn-success btn-block');
      $('#like_btn').attr('class', 'btn btn-default btn-block');
      conCom();
    });

  // 댓글란 글자수 제한
    $('#com_opi').keyup(function(){
      if(sessionName=='null'){
        alert('댓글을 남기시려면 로그인이 필요합니다');
        $('#com_opi').val('');
        return false;
      }
      con = $('#com_opi').val();
      conLength = con.length;
      conByte = 0;
      conByte = (function(s,b,i,c){
                    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
                    return b
                  })(con);
      $('#len_check').text(conByte+' /300');
      if(conByte>300){
        alert('제한된 글자수를 초과하였습니다')
      }
      conCom();
    });

// 댓글 삽입
  $('#comInput').click(function(){
    //파라미터 캐취
    var code_name = $('#com_codeName').val();
    var nick_name = $('#com_nick').val();
    var content = $('#com_opi').val();
    var isLike = $('input:radio[name="isLike"]:checked').val();

    //아쟉스 ㄱㄱ
    $.ajax({
        type:"post",
        url:"ph_info/insertComment.jsp",
  	    data: {
                code_name : code_name,
                nick_name : nick_name,
                content : content,
                isLike : isLike
              },
        dataType:"JSON",
        success : function(data) {
          //댓글란 초기화
          $('#com_opi').val('');
          $('input:radio[name="isLike"]').prop('checked', false);
          $('#hate_btn').attr('class', 'btn btn-default btn-block');
          $('#like_btn').attr('class', 'btn btn-default btn-block');
          //사과지수 업데이트
          if(data[0].rottenApples>=70){
            $('#img_app').attr('src', 'images/apple-fresh.png');
          }else{
            $('#img_app').attr('src', 'images/apple-rotten.png');
          }
           $('#r_app').text(data[0].rottenApples+' %');

          //댓글버튼 업데이트
          totalComment=data[0].comCount;
          currentView = totalComment < 10 ? totalComment : conPage*10;
	        moreCom(currentView, totalComment);

          //코멘트 업데이트
          $('#info_com').empty();
      		 for(var i=1; i<=10; i++){
      		  showCom(data, i);
      		 }
          },
       error : function(xhr, status, error) {
          alert("에러발생");
       }
     });
  });

// 댓글 10개씩 불러오기
  $('#getComList').click(function(){
    conPage+=1;
    var code_name = $('#com_codeName').val();
    $.ajax({
        type:"get",
        url:"ph_info/comLoad.jsp",
        data: {
              page : conPage,
              code_name : code_name
              },
        dataType:"JSON",
        success : function(data) {
          //코멘트 추가
           for(var i in data){
             showCom(data, i);
           }

           //댓글버튼 업데이트
          currentView = currentView+data.length;
          moreCom(currentView, totalComment);
        },
         error : function(xhr, status, error) {
            alert("에러발생");
       }
     });
  });

});

//드래그 앤 드롭
var targetVal="";

function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("phone", ev.target.id);
}

function drop1(ev) {
    ev.preventDefault();
    var data = ev.dataTransfer.getData("phone");
    ev.target.appendChild(document.getElementById(data));
    $(document).ready(function(){
         $("#comP1").val(targetVal);
      });
}

function drop2(ev) {
    ev.preventDefault();
    var data = ev.dataTransfer.getData("phone");
    ev.target.appendChild(document.getElementById(data));
    $(document).ready(function(){
         $("#comP2").val(targetVal);
    });
}

$(document).ready(function(){
   $(".viewPhone").mousedown(function(){
     targetVal = $(this).attr("id");
   });
 });

//버튼 토글
$(document).ready(function(){
  $('.toggle_btn button').click(function(){
    $('#comBar').toggle(1000);
  });
});

$(document).ready(function(){
  //리셋 버튼
  $('#reset_btn').click(function(){
    location.reload();

  });


  function show2Com(data, i, where){
    var isLike;
    if(data[i].isLike==1){
      isLike="images/apple-fresh.png";
    }else{
      isLike="images/apple-rotten.png";
    }
    $(where).append('<div class="ph_comment" style="display:none;">'+
                            '<div class="container-fluid">'+
                              '<div class="appContainer"><img src="'+isLike+'" alt=""/></div><p>'+data[i].content+'</p>'+
                                '<div class="person"><a href="">'+data[i].nick_name+' '+'</a><span>'+' '+data[i].date+'</span></div></div></div>');
    $('.ph_comment').fadeIn(1300);
  }

  //비교버튼 클릭시 모달 열기
  $('#compare_btn').click(function(){
    var p1 = $('#comP1').val();
    var p2 = $('#comP2').val();
    if(p1=="" || p2==""){
      alert('비교할 폰들을 모두 넣어 주세요.');
      return false;
    }
    var url = "ph_info/comparePhone.jsp";
    $.getJSON(url,{p1:p1,p2:p2}, function(data, status){
      //첫번째 폰정보 변경
      $('#p1_name').text(data[0].pn);
      $('#p1_1').text(data[0].ds+'inch');
      $('#p1_2').text(data[0].rs+'x'+data[0].rs*9/16);
      $('#p1_3').text('Android'+data[0].os);
      $('#p1_4').text(data[0].cpu);
      $('#p1_5').text(data[0].ram+'Gb');
      $('#p1_6').text(data[0].bc+'mah');
      $('#p1_7').text(data[0].we+'g');
      $('#p1_8').text(data[0].rd);
      $('#p1_img').attr('src', data[0].il);
      $('#p1_rp').text(data[0].ra+'%');
      $('#p1Name').text(data[0].pn);
        //사과이미지 업데이트
        if(data[0].ra>=70){
          $('#p1_aimg').attr('src', 'images/apple-fresh.png');
        }else{
          $('#p1_aimg').attr('src', 'images/apple-rotten.png');
        }

      //두번째 폰정보 변경
      $('#p2_name').text(data[1].pn);
      $('#p2_1').text(data[1].ds+'inch');
      $('#p2_2').text(data[1].rs+'x'+data[1].rs*9/16);
      $('#p2_3').text('Android'+data[1].os);
      $('#p2_4').text(data[1].cpu);
      $('#p2_5').text(data[1].ram+'Gb');
      $('#p2_6').text(data[1].bc+'mah');
      $('#p2_7').text(data[1].we+'g');
      $('#p2_8').text(data[1].rd);
      $('#p2_img').attr('src', data[1].il);
      $('#p2_rp').text(data[1].ra+'%');
      $('#p2Name').text(data[1].pn);
        //사과이미지 업데이트
        if(data[1].ra>=70){
          $('#p2_aimg').attr('src', 'images/apple-fresh.png');
        }else{
          $('#p2_aimg').attr('src', 'images/apple-rotten.png');
        }

       // 스펙비교 레이아웃 제어
       switch (data[2].coDis) {
         case 1 : $('#p1_1').addClass('success');break;
         case -1 : $('#p2_1').addClass('success');break;
       }
       switch (data[2].coResol) {
         case 1 : $('#p1_2').addClass('success');break;
         case -1 : $('#p2_2').addClass('success');break;
       }
       switch (data[2].coOs) {
         case 1 : $('#p1_3').addClass('success');break;
         case -1 : $('#p2_3').addClass('success');break;
       }
       switch (data[2].coCpu) {
         case 1 : $('#p1_4').addClass('success');break;
         case -1 : $('#p2_4').addClass('success');break;
       }
       switch (data[2].coRam) {
         case 1 : $('#p1_5').addClass('success');break;
         case -1 : $('#p2_5').addClass('success');break;
       }
       switch (data[2].coBat) {
         case 1 : $('#p1_6').addClass('success');break;
         case -1 : $('#p2_6').addClass('success');break;
       }
       switch (data[2].coWe) {
         case 1 : $('#p2_7').addClass('success');break;
         case -1 : $('#p1_7').addClass('success');break;
       }

       //첫번째 폰 댓글
       $('#ph_commentCom1').empty();
         for(var i in data[3]){
           show2Com(data[3], i, '.ph_commentCom1');
         }
       $('#ph_commentCom2').empty();
        //두번째 폰 댓글
         for(var i in data[4]){
            show2Com(data[4], i, '.ph_commentCom2');
         }
       });
    $('#ph_compare').modal();
  });
});
