// Shared UI behaviors
const initSearchFocus = () => {
    const searchInput = document.querySelector('input[type="text"]');
    if (!searchInput) return;

    searchInput.addEventListener('focus', () => {
        searchInput.parentElement?.classList.add('ring-2', 'ring-primary-container');
    });
    searchInput.addEventListener('blur', () => {
        searchInput.parentElement?.classList.remove('ring-2', 'ring-primary-container');
    });
};

const initToasts = () => {
    const toast = document.getElementById('toast');
    if (!toast) return;

    toast.showMessage = (message) => {
        const messageElement = toast.querySelector('span:last-child');
        if (messageElement) {
            messageElement.textContent = message;
        }
        toast.classList.remove('translate-y-20', 'opacity-0');
        setTimeout(() => {
            toast.classList.add('translate-y-20', 'opacity-0');
        }, 3000);
    };
};

document.addEventListener('DOMContentLoaded', () => {
    initSearchFocus();
    initToasts();
});
