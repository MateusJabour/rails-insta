(function () {
  'use strict';

  var RelationshipController = (function () {
    function loadEvents() {
      $(document).on('click', '.pending-relationship-control', function (e) {
        e.preventDefault();
        e.stopPropagation();

        $.ajax({
          url: this.href,
          type: 'POST',
          data: [{name: 'relationship_id', value: $(this).data('relationshipId')}],
          dataType: 'json',
          success: function() {
            $('.pending-relationship-control').remove();
          }
        });
      });

      $(document).on('click', '.relationship-control', function (e) {
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
            relationshipForm.action = data.button_action;
            $(relationshipButton).val(data.button_name);

            $('.follower-counter').text(data.follower_amount);
          }
        });
      });
    }

    return ({
      loadEvents: loadEvents
    });

  })();

  RelationshipController.loadEvents();
})();
