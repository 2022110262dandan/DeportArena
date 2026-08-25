// Simple Micro-interaction: Update time every minute
function updateClock() {
    const now = new Date();
    console.log("Dashboard refreshed at: " + now.toLocaleTimeString());
}
setInterval(updateClock, 60000);

// Tab switching visual logic
document.querySelectorAll('nav a').forEach(tab => {
    tab.addEventListener('click', (e) => {
        document.querySelectorAll('nav a').forEach(t => {
            t.classList.remove('bg-primary-container', 'text-on-primary-container', 'font-bold');
            t.classList.add('text-on-surface-variant');
        });
        tab.classList.add('bg-primary-container', 'text-on-primary-container', 'font-bold');
        tab.classList.remove('text-on-surface-variant');
    });
});