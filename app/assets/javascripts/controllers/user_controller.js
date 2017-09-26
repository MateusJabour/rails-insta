(function() {
  'use strict';

  var userController = (function() {
    function loadEvents () {
      $('.privacy-toggle').on('change', togglePrivacy);
    }

    function togglePrivacy(event) {
      this.value = !(this.value === 'true');
    }

    return {
      loadEvents: loadEvents
    };
  })();

  userController.loadEvents();
})();
