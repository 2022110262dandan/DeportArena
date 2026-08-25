const modal = document.getElementById('checkoutModal');
const modalContainer = modal.querySelector('div');
const toast = document.getElementById('toast');

function openCheckoutModal(player, amount) {
    document.getElementById('modalPlayer').innerText = `Jugador: ${player}`;
    document.getElementById('modalAmount').innerText = `$${amount}`;
    
    modal.classList.remove('hidden');
    setTimeout(() => {
        modal.classList.remove('opacity-0');
        modalContainer.classList.remove('scale-95');
        modalContainer.classList.add('scale-100');
    }, 10);
}

function closeCheckoutModal() {
    modal.classList.add('opacity-0');
    modalContainer.classList.remove('scale-100');
    modalContainer.classList.add('scale-95');
    setTimeout(() => {
        modal.classList.add('hidden');
    }, 300);
}

function confirmPayment() {
    closeCheckoutModal();
    
    // Show toast
    toast.classList.remove('translate-y-24', 'opacity-0');
    toast.classList.add('translate-y-0', 'opacity-100');
    
    setTimeout(() => {
        toast.classList.add('translate-y-24', 'opacity-0');
        toast.classList.remove('translate-y-0', 'opacity-100');
    }, 3000);
}

// Close modal on background click
modal.addEventListener('click', (e) => {
    if (e.target === modal) closeCheckoutModal();
});