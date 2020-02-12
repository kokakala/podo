function insertComment(targetId, type, content, loginMemberId, parentCommentId) {
	$.ajax({
		url : "insertComment.do",
		data : {
			type : type,
			targetId : targetId,
			content : content,
			memberId : loginMemberId,
			parentId : parentCommentId
		},
		dataType : "text",
		success : function(data) {
			if (data == "success") {
				getCommentList(targetId, type, loginMemberId);
				$("#comment-content").val('');
			} else {
				alert("댓글 작성 실패");
			}
		},
		error : function() {
			console.log("ajax error");
		}
	});
}

function deleteComment(commentId, type, targetId, loginMemberId) {
	$.ajax({
		url : "deleteComment.do",
		dataType : "text",
		data : {
			id : commentId,
			type : type,
			targetId : targetId
		},
		success : function(data) {
			if (data === "success") {
				getCommentList(targetId, type, loginMemberId);
				alert("댓글을 삭제하였습니다.");
			} else {
				alert("댓글 삭제 실패");
			}
		},
		error : function() {
			console.log("ajax error");
		}
	});
}

//댓글 목록 조회
function getCommentList(targetId, type, loginMemberId) {
	$.ajax({
		url: 'commentsList.do',
		data: {
			'tid' : targetId,
			'type' : type
		},
		dataType:"json",
		success:function(data){
			
			$commentsArea = $(".comments-area");
			$commentsArea.html("");
			$commentsArea.append("<h4>COMMENTS</h4>");
			
			if (data.length > 0){
				$.each(data, function(index, value){
					makeCommentList(index, value, loginMemberId);							
				});
			
			} else { // 댓글이 없을 때
				$commentarea = $(".comments-area").append("<span>등록된 댓글이 없습니다.</span>");
			}
		},
		error:function(){
			console.log("ajax error");
		}
	});
}

function makeCommentList(index, value, loginMemberId) {
	//console.log(value);
	$commentList = $("<div class='comment-list'></div>");
	if (value.level != 1) {
		$commentList.css("padding-left", (20 * (value.level - 1)) + 'px');
	}
	
	$single = $("<div class='single-comment justify-content-between d-flex'></div>");
	$commentList.append($single);

	$nickname = $("<h5 class='nickname'></h5>").text(value.nickname);
	$thumbnail = $("<div class='thumbnail'></div>").append("<img src='resources/memberProfileImage/" + value.memberImage + "' alt='member-profile'>");
	$thumbnail.append($nickname);

	var user = value.memberId;
	$cid = $("<input type='hidden' class='cid'>").val(value.id);
	$writer = $("<input type='hidden' class='writerMemId'>").val(user);
	$date = $("<p class='date'></p>").text(value.createDate);

	var parent = value.parentMemberNickname;
	var $content = '';
	if (parent != 'undefined' && parent != '' && parent != null) {
		$content = $("<p class='comment'></p>").html("@" + "<a href='userPage.do?loginUserId=" + loginUser + "&userId=" + value.parentMemberId + "'>" + value.parentMemberNickname + "</a>" + value.content);
	} else {
		$content = $("<p class='comment'></p>").html(value.content);
	}
	
//		$updateBtn = $("<button class='button updateBtn'>수정</button>");
	$deleteBtn = $("<button class='button comment-delete-btn' id='comment-delete-btn'>삭제</button>");
	$replyBtn = $("<button class='button comment-reply-btn' id='comment-reply-btn'>답글</button>");
	$btns = $("<div class='reply-btn'></div>");
	
	$desc = $("<div class='desc'></div>");
	$desc.append($cid)
			 .append($writer)
			 .append($date)
			 .append($content)
			 .append($btns);
	
	$user = $("<div class='user justify-content-between d-flex'></div>");
	$user.append($thumbnail).append($desc);
//	alert(loginMemberId);
	if (parseInt(loginMemberId) === user) {
		$btns.append($replyBtn)
//					 .append($updateBtn)
				 .append($deleteBtn);
	} else {
		$btns.append($replyBtn);
	}
	
	$single.append($user);
	
	$commentsArea.append($commentList);
}

function deleteReviewComment(reviewId){
	if(confirm("댓글을 삭제하시겠습니까")){
		$.ajax({
			type:"post",
			url:"deleteReviewComment.do",
			data:{"id":reviewId},
			error:function(){
				console.log("ajax error");
			}
		});
	}
}