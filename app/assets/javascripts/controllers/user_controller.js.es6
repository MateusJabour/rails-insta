const UserController = (() => {
  function loadEvents () {
    $('.privacy-toggle').on('change', togglePrivacy);
    $('.tab').on('click', changeTab);
    $('.change-password-form').on('submit', changePassword);
  }

  function togglePrivacy(e) {
    this.value = !(this.value === 'true');
  }

  function changePassword(e) {
    e.preventDefault();

    $.ajax({
      url: this.action,
      type: this.method,
      data: $(this).serializeArray(),
      dataType: 'json',
      success: (data) => $('.form-notification').text(data.message)
    });
  }

  function changeTab(e) {
    e.preventDefault();

    $('.tab-content').addClass('hidden');
    $(`[data-tab=${$(this).data('tab-target')}]`).removeClass('hidden');
    $('.tab').removeClass('tab--selected');
    $(this).addClass('tab--selected');
  }

  return {
    loadEvents: loadEvents
  };
})();

UserController.loadEvents();
