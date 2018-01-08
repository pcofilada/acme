$.onmount('.btn-filter', function () {
  const filterBtn       = $(this);
  const filterContainer = $('.filter');

  filterBtn.on('click', () => {
    filterContainer.toggleClass('show');
  });
});
