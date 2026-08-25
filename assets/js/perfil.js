// Micro-interaction for multi-select UI
const positionBtns = document.querySelectorAll('.position-btn');

positionBtns.forEach(btn => {
    if (btn.classList.contains('active')) {
        btn.classList.add('bg-primary', 'text-on-primary', 'border-primary');
    }

    btn.addEventListener('click', () => {
        const isActive = btn.classList.toggle('active');
        
        if (isActive) {
            btn.classList.add('bg-primary', 'text-on-primary', 'border-primary');
            btn.classList.remove('border-outline-variant');
        } else {
            btn.classList.remove('bg-primary', 'text-on-primary', 'border-primary');
            btn.classList.add('border-outline-variant');
        }
    });
});

// Simple smooth scroll and entry animations logic
window.addEventListener('load', () => {
    const cards = document.querySelectorAll('.rounded-xl');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'all 0.6s cubic-bezier(0.2, 0.8, 0.2, 1)';
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 100);
    });
});