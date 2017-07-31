(function ($, win, doc) {
  var PhotoController = (function () {
    function generateComment(comment, username) {
      var li = $('<li class="single-comment"></li>');
      var a = $('<a href="user/' + comment.user_id +'" class="comment-username">' + username +'</a>');
      var span = $('<span class="comment-text"> ' + comment.text + '</span>');

      return li.append(a).append(span);
    }

    function loadEvents() {
      $('.like-button').parent().on('submit', function (e) {
        e.preventDefault();
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

      $('.new_comment').on('submit', function (e) {
        e.preventDefault();
        var commentBox = $(this).siblings('.comment-box').find('.comment-list');

        $.ajax({
          url: this.action,
          type: this.method,
          data: $(this).serializeArray(),
          dataType: 'json'
        }).done(function (data) {
          $('#comment_text').val('');
          commentBox.append(generateComment(data.comment, data.username));
        });
      });
    }

    return ({
      loadEvents: loadEvents
    });

  })();

  PhotoController.loadEvents();
})(jQuery, window, document);
