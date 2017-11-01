const LoginController = (() => {
  const loginUser = (e) => {
    e.preventDefault();
    e.stopPropagation();

    $.ajax({
      url: e.currentTarget.action,
      type: e.currentTarget.method,
      data: $(e.currentTarget).serializeArray(),
      dataType: 'json',
      success: (data) => {
        if (data.redirect) {
          window.location.href = data.redirect;
        } else if (data.error) {
          $(e.currentTarget).find('.form__error').text(data.error);
        }
      },
    });
  };

  const loadEvents = () => {
    $('[data-login-form]').on('submit', loginUser);
  };

  return {
    loadEvents,
  };
})();

LoginController.loadEvents();
