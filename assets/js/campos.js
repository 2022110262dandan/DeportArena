// Micro-interaction for filter range
const rangeInput = document.querySelector('input[type="range"]');
if (rangeInput) {
    rangeInput.addEventListener('input', (e) => {
        const val = e.target.value;
        // Add logic for dynamic price updates if needed
    });
}

// Search Bar Focus Effect
const searchInput = document.querySelector('input[type="text"]');
if (searchInput) {
    searchInput.addEventListener('focus', () => {
        searchInput.parentElement.classList.add('ring-2', 'ring-primary-container');
    });
    searchInput.addEventListener('blur', () => {
        searchInput.parentElement.classList.remove('ring-2', 'ring-primary-container');
    });
}
