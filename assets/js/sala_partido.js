// Micro-interaction: Simple hover effects for team drop zones
const teamContainers = ['team-a', 'team-b'];
teamContainers.forEach(id => {
    const container = document.getElementById(id);
    if (!container) return;
    container.addEventListener('dragover', (e) => {
        e.preventDefault();
        container.classList.add('bg-surface-container-high');
    });
    container.addEventListener('dragleave', () => {
        container.classList.remove('bg-surface-container-high');
    });
    container.addEventListener('drop', (e) => {
        e.preventDefault();
        container.classList.remove('bg-surface-container-high');
    });
});