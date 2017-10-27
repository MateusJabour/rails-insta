(() => {
  const RelationshipController = (() => {
    function changeRelationship(e) {
      e.preventDefault();
      e.stopPropagation();

      const relationshipForm = this.parentNode;

      $.ajax({
        url: relationshipForm.action,
        type: relationshipForm.method,
        data: $(relationshipForm).serializeArray(),
        dataType: 'json',
        success: (data) => {
          relationshipForm.action = data.button_action;
          $(this).val(data.button_name);

          if (data.button_name === 'Follow') {
            $(this).addClass('button--secondary');
          } else {
            $(this).removeClass('button--secondary');
          }

          $('.follower-counter').text(data.follower_amount);
        }
      });
    }

    function replyRelationshipInvite(e) {
      e.preventDefault();
      e.stopPropagation();

      $.ajax({
        url: this.href,
        type: 'POST',
        data: [{name: 'relationship_id', value: $(this).data('relationshipId')}],
        dataType: 'json',
        success: () => $('.pending-relationship-control').remove()
      });
    }

    function loadEvents() {
      $(document).on('click', '.pending-relationship-control', replyRelationshipInvite);
      $(document).on('click', '.relationship-control', changeRelationship);
    }

    return ({
      loadEvents: loadEvents
    });

  })();

  RelationshipController.loadEvents();
})();
