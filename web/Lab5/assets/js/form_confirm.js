(function () {
  'use strict';

  function wireCancel(selector) {
    var el = document.querySelector(selector);
    if (!el) return;
    el.addEventListener('click', function (ev) {
      var ok = window.confirm('Leave this page? Unsaved changes will be lost.');
      if (!ok) {
        ev.preventDefault();
      }
    });
  }

  document.addEventListener('DOMContentLoaded', function () {
    wireCancel('#btn-cancel-add');
    wireCancel('#btn-cancel-edit');
  });
})();
