(function () {
  'use strict';

  var STORAGE_ID = 'lab5_last_category_id';
  var STORAGE_NAME = 'lab5_last_category_name';

  function $(id) {
    return document.getElementById(id);
  }

  function setLastFilterDisplay() {
    var el = $('js-last-filter-display');
    if (!el) return;
    var id = sessionStorage.getItem(STORAGE_ID);
    var name = sessionStorage.getItem(STORAGE_NAME);
    if (id && name) {
      el.textContent = 'Last browsing filter (JavaScript): ' + name + ' (category id ' + id + ')';
    } else {
      el.textContent = 'Last browsing filter (JavaScript): none stored yet in this browser.';
    }
  }

  function rememberFilter(categoryId, categoryName) {
    sessionStorage.setItem(STORAGE_ID, String(categoryId));
    sessionStorage.setItem(STORAGE_NAME, categoryName);
    setLastFilterDisplay();
  }

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  function renderCars(payload) {
    var box = $('cars-results');
    var status = $('browse-status');
    if (!box || !status) return;

    var cars = payload.cars || [];
    if (cars.length === 0) {
      status.textContent = 'No cars in this category yet.';
      box.innerHTML = '';
      return;
    }

    status.textContent = 'Showing ' + cars.length + ' car(s).';

    var rows = cars.map(function (car) {
      var price = Number(car.price);
      var priceStr = isNaN(price) ? escapeHtml(String(car.price)) : price.toFixed(2);
      return (
        '<tr>' +
        '<td>' + escapeHtml(String(car.model)) + '</td>' +
        '<td>' + escapeHtml(String(car.engine_power)) + ' HP</td>' +
        '<td>' + escapeHtml(String(car.fuel)) + '</td>' +
        '<td>' + priceStr + '</td>' +
        '<td>' + escapeHtml(String(car.color)) + '</td>' +
        '<td>' + escapeHtml(String(car.age_years)) + '</td>' +
        '<td class="cell-actions">' +
        '<a class="button button-small" href="edit.php?id=' + encodeURIComponent(String(car.id)) + '">Edit</a> ' +
        '<form class="inline-form" method="post" action="actions/delete_car.php" data-confirm-delete="1">' +
        '<input type="hidden" name="id" value="' + escapeHtml(String(car.id)) + '">' +
        '<button type="submit" class="button button-small button-danger">Delete</button>' +
        '</form>' +
        '</td>' +
        '</tr>'
      );
    });

    box.innerHTML =
      '<table class="data-table">' +
      '<thead><tr>' +
      '<th>Model</th><th>Power</th><th>Fuel</th><th>Price</th><th>Color</th><th>Age (y)</th><th>Actions</th>' +
      '</tr></thead><tbody>' +
      rows.join('') +
      '</tbody></table>';
  }

  function wireDeleteConfirm() {
    var box = $('cars-results');
    if (!box) return;
    box.addEventListener('submit', function (ev) {
      var form = ev.target;
      if (!(form instanceof HTMLFormElement)) return;
      if (form.getAttribute('data-confirm-delete') !== '1') return;
      var ok = window.confirm('Remove this car from inventory? This cannot be undone.');
      if (!ok) {
        ev.preventDefault();
      }
    });
  }

  function loadCars() {
    var sel = $('category_id');
    var status = $('browse-status');
    if (!sel || !status) return;

    var categoryId = sel.value;
    if (!categoryId) {
      status.textContent = 'Please choose a category first.';
      return;
    }

    var opt = sel.options[sel.selectedIndex];
    var categoryName = opt ? opt.text : '';

    status.textContent = 'Loading…';

    fetch('api/cars_by_category.php?category_id=' + encodeURIComponent(categoryId), {
      headers: { Accept: 'application/json' },
    })
      .then(function (res) {
        return res.text().then(function (text) {
          try {
            return { ok: res.ok, body: JSON.parse(text) };
          } catch (e) {
            return { ok: false, body: { ok: false, error: 'Unexpected server response.' } };
          }
        });
      })
      .then(function (wrapped) {
        if (!wrapped.ok || !wrapped.body || wrapped.body.ok !== true) {
          var err = (wrapped.body && wrapped.body.error) || 'Request failed';
          status.textContent = err;
          var boxErr = $('cars-results');
          if (boxErr) {
            boxErr.innerHTML = '';
          }
          return;
        }
        rememberFilter(categoryId, categoryName);
        renderCars(wrapped.body);
      })
      .catch(function () {
        status.textContent = 'Network or server error.';
      });
  }

  document.addEventListener('DOMContentLoaded', function () {
    setLastFilterDisplay();
    wireDeleteConfirm();

    var sel = $('category_id');
    var lastId = sessionStorage.getItem(STORAGE_ID);
    if (sel && lastId) {
      sel.value = lastId;
    }

    var btn = $('btn-load-cars');
    if (btn) {
      btn.addEventListener('click', loadCars);
    }
  });
})();
