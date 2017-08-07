(function ($, win, doc) {
  var RelationshipController = (function () {
    function loadEvents() {
      $(doc).on('click', '.relationship-control', function (e) {
          e.preventDefault();
          e.stopPropagation();

          var relationshipButton = this;
          var relationshipForm = this.parentNode;

          $.ajax({
            url: relationshipForm.action,
            type: relationshipForm.method,
            data: $(relationshipForm).serializeArray(),
            dataType: 'json',
            success: function(data) {
              var newName = $(relationshipButton).data('inverse');
              var newAction = $(relationshipButton).data('inverse-action');

              $(relationshipButton).data('inverse', $(relationshipButton).val());
              $(relationshipButton).data('inverse-action', relationshipForm.action);

              relationshipForm.action = newAction;
              $(relationshipButton).val(newName);

              $('.user-profile__follower-counter').text(data);
            }
          });
        });
    }

    return ({
      loadEvents: loadEvents
    });

  })();

  RelationshipController.loadEvents();
})(jQuery, window, document);
