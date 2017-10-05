(function () {
  'use strict';

  var PhotoController = (function () {
    function generateComment(comment, username) {
      var li = $('<li class="single-comment"></li>');
      var a = $('<a href="user/' + comment.user_id +'" class="comment-username">' + username +'</a>');
      var span = $('<span class="comment-text"> ' + comment.text + '</span>');

      return li.append(a).append(span);
    }

    function handleCommentSuccess(commentBox) {
      return (function (data) {
        $('#comment_text').val('');
        commentBox.append(generateComment(data.comment, data.username));
      })
    }

    function handleComment(section) {
      return (function (e) {
        e.preventDefault();
        e.stopPropagation();
        var commentBox;

        if (section === "timeline") {
          commentBox = $(this).siblings('.comment-box').find('.comment-list');
        } else if (section === "single-photo") {
          commentBox = $(this).parent().siblings('.comment-box').find('.comment-list');
        }

        $.ajax({
          url: this.action,
          type: this.method,
          data: $(this).serializeArray(),
          dataType: 'json',
          success: handleCommentSuccess(commentBox)
        });
      });
    }

    function loadEvents() {
      $('.like-button').on('click', function (e) {
        e.preventDefault();
        e.stopPropagation();

        var likeCounter = $(this).closest('.single-photo').find('.like-counter span');
        var likeButton = $(this);
        $.ajax({
          url: this.href,
          type: "POST",
          dataType: 'json'
        }).done(function (data) {
          var likesAmountBefore = +(likeCounter.text());
          likeCounter.text(data);
          if (likesAmountBefore < data) {
            likeButton.children('img').attr('src', "/assets/heart-icon-filled.png");
          } else {
            likeButton.children('img').attr('src', "/assets/heart-icon.png");
          }
          console.log(likeButton);
        })
      })


      $('.timeline .new_comment').on('submit', handleComment('timeline'));

      $('.single-photo .new_comment').on('submit', handleComment('single-photo'));
    }

    return ({
      loadEvents: loadEvents
    });

  })();

  PhotoController.loadEvents();
})();
