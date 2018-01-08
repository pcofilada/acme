$.onmount('[data-toggle="modal"]', function () {
  const button = $(this);

  button.on('click', function () {
    const modalTarget = $($(this).data('target'));

    modalTarget.addClass('show');

    $('body').append('<div class="modal-backdrop"></div>');

    $(document).on('click', '.modal-backdrop', () => {
      modalTarget.removeClass('show');
      $('.modal-backdrop').remove();
    });
  });
});
