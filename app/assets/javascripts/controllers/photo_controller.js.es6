(() => {
  const PhotoController = (() => {
    function generateComment(comment, username) {
      return `<li class="single-comment">
          <a href="user/${comment.user_id}" class="comment-username">${username}</a>
          <span class="comment-text">${comment.text}</span>
        </li>`;
    }

    function postComment(e) {
      e.preventDefault();
      e.stopPropagation();

      $.ajax({
        url: this.action,
        type: this.method,
        data: $(this).serializeArray(),
        dataType: 'json',
        success: (data) => {
          const commentBox = $(this).parent().siblings('.comment-box').find('.comment-list');

          $('#comment_text').val('');
          commentBox.append(generateComment(data.comment, data.username));
        }
      });
    };

    function postLike(e) {
      e.preventDefault();
      e.stopPropagation();

      $.ajax({
        url: this.href,
        type: "POST",
        dataType: 'json',
        success: (data) => {
          const likeCounter = $(this).closest('.single-photo').find('.like-counter span');
          const likesAmountBefore = +(likeCounter.text());
          const likeImage = $(this).children('img');

          likeCounter.text(data);

          if (likesAmountBefore < data) {
            likeImage.attr('src', "/assets/heart-icon-filled.png");
          } else {
            likeImage.attr('src', "/assets/heart-icon.png");
          }
        }
      });
    }

    function loadEvents() {
      $('.like-button').on('click', postLike);
      $('.new_comment').on('submit', postComment);
    }

    return ({
      loadEvents: loadEvents
    });

  })();

  PhotoController.loadEvents();
})();
