const RelationshipController = (() => {
  const changeRelationshipButton = (el, { button_action: action, button_name: name }) => {
    const relationshipForm = el.parentNode;
    relationshipForm.action = action;
    $(el).val(name);

    if (name === 'Follow') {
      $(el).addClass('button--secondary');
    } else {
      $(el).removeClass('button--secondary');
    }
  };

  const changeRelationship = (e) => {
    e.preventDefault();
    e.stopPropagation();

    const relationshipForm = e.currentTarget.parentNode;

    $.ajax({
      url: relationshipForm.action,
      type: relationshipForm.method,
      data: $(relationshipForm).serializeArray(),
      dataType: 'json',
      success: (data) => {
        changeRelationshipButton(e.currentTarget, data);
        $('.follower-counter').text(data.follower_amount);
      },
    });
  };

  const replyRelationshipInvite = (e) => {
    e.preventDefault();
    e.stopPropagation();

    $.ajax({
      url: e.currentTarget.href,
      type: 'POST',
      data: [{ name: 'relationship_id', value: $(e.currentTarget).data('relationshipId') }],
      dataType: 'json',
      success: () => $('[data-pending-relationship-control], .follow-invite').remove(),
    });
  };

  const loadEvents = () => {
    $(document).on('click', '[data-pending-relationship-control]', replyRelationshipInvite);
    $(document).on('click', '[data-relationship-control]', changeRelationship);
  };

  return ({
    loadEvents,
  });
})();

RelationshipController.loadEvents();
