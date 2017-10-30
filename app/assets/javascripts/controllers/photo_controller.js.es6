const PhotoController = (() => {
  const imageUploader = $('[data-image-uploader]');
  const imagePreview = $('[data-image-preview]');

  const generateComment = (comment, username) => `
    <li class="single-comment">
      <a href="user/${comment.user_id}" class="comment-username">${username}</a>
      <span class="comment-text">${comment.text}</span>
    </li>
  `;

  const updateComments = (el, data) => {
    $(el).children('.comment-text-input').val('');
    $(`#${el.dataset.commentListId}`).append(generateComment(data.comment, data.username));
  };

  const postComment = (e) => {
    e.preventDefault();
    e.stopPropagation();

    $.ajax({
      url: e.currentTarget.action,
      type: e.currentTarget.method,
      data: $(e.currentTarget).serializeArray(),
      dataType: 'json',
      success: data => updateComments(e.currentTarget, data),
    });
  };


  const previewPhoto = (e) => {
    const image = e.target.files[0];
    const reader = new FileReader();

    reader.onload = (file) => {
      const img = new Image();
      img.src = file.target.result;
      imagePreview.html(img);
    };

    reader.readAsDataURL(image);
  };

  const changeLikeButtonImage = (el, amountIncreased) => {
    const likeButtonImage = $(el).children('img');
    if (amountIncreased) {
      likeButtonImage.attr('src', '/assets/heart-icon-filled.png');
    } else {
      likeButtonImage.attr('src', '/assets/heart-icon.png');
    }
  };

  const updateLikeCounter = (counter, likeAmount) => {
    counter.text(likeAmount);
  };

  function postLike(e) {
    e.preventDefault();
    e.stopPropagation();

    $.ajax({
      url: e.currentTarget.href,
      type: 'POST',
      dataType: 'json',
      success: (data) => {
        const likeCounter = $(`#${e.currentTarget.dataset.likeCounterId} span`);
        const likeAmountIncreased = data > +(likeCounter.text());

        changeLikeButtonImage(e.currentTarget, likeAmountIncreased);
        updateLikeCounter(likeCounter, data);
      },
    });
  }

  const loadEvents = () => {
    $('.like-button').on('click', postLike);
    $('.new_comment').on('submit', postComment);
    imageUploader.on('change', previewPhoto);

    imagePreview.on('click keydown', (e) => {
      if (e.keyCode === 13 || e.type === 'click') {
        imageUploader.trigger('click');
      }
    });
  };

  return ({
    loadEvents,
  });
})();

PhotoController.loadEvents();
