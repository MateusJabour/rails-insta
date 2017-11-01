const SignupController = (() => {
  const capitalize = string => string.replace(string.charAt(0), string.charAt(0).toUpperCase());

  const signupUser = (e) => {
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
        } else if (data.errors) {
          const errorsContainer = $(e.currentTarget).find('.form__error');
          errorsContainer.html('');
          Object.keys(data.errors).forEach((field) => {
            errorsContainer.append(`<p>${capitalize(field.split('_').join(' '))} ${data.errors[field][0]}</p>`);
          });
        }
      },
    });
  };

  const loadEvents = () => {
    $('[data-signup-form]').on('submit', signupUser);
  };

  return {
    loadEvents,
  };
})();

SignupController.loadEvents();
