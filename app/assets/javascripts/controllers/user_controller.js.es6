const UserController = (() => {
  const togglePrivacy = (e) => {
    e.currentTarget.value = !(e.currentTarget.value === 'true');
  };

  const changePassword = (e) => {
    e.preventDefault();

    $.ajax({
      url: e.currentTarget.action,
      type: e.currentTarget.method,
      data: $(e.currentTarget).serializeArray(),
      dataType: 'json',
      success: data => $('.form-notification').text(data.message),
    });
  };

  const changeTab = (e) => {
    e.preventDefault();

    $('.tab-content').addClass('hidden');
    $(`[data-tab=${$(e.currentTarget).data('tab-target')}]`).removeClass('hidden');
    $('.tab').removeClass('tab--selected');
    $(e.currentTarget).addClass('tab--selected');
  };

  const loadEvents = () => {
    $('.privacy-toggle').on('change', togglePrivacy);
    $('.tab').on('click', changeTab);
    $('.change-password-form').on('submit', changePassword);
  };

  return {
    loadEvents,
  };
})();

UserController.loadEvents();
