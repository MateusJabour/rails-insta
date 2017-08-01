(function ($, win, doc) {
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
        console.log('commentBox', commentBox);
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
      $('.like-button').parent().on('submit', function (e) {
        e.preventDefault();
        e.stopPropagation();

        var likeCounter = $(this).closest('.single-photo').find('.like-counter span');
        var likeButton = $(this).children('.like-button');
        $.ajax({
          url: this.action,
          type: this.method,
          dataType: 'json'
        }).done(function (data) {
          var likesAmountBefore = +(likeCounter.text());
          likeCounter.text(data);
          if (likesAmountBefore < data) {
            likeButton.addClass('selected');
          } else {
            likeButton.removeClass('selected');
          }
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
})(jQuery, window, document);
