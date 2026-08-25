// Simple scroll reveal effect
const observerOptions = {
    threshold: 0.1
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('opacity-100', 'translate-y-0');
            entry.target.classList.remove('opacity-0', 'translate-y-10');
        }
    });
}, observerOptions);

document.querySelectorAll('.pitch-card').forEach(el => {
    el.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-700');
    observer.observe(el);
});