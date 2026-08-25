// Micro-interactions and Drag & Drop Simulation
function togglePanel() {
    const panel = document.getElementById('details-panel');
    panel.classList.toggle('translate-y-full');
}

// Show panel on block click (simulation)
document.querySelectorAll('.reservation-block').forEach(block => {
    block.addEventListener('click', (e) => {
        e.stopPropagation();
        const panel = document.getElementById('details-panel');
        panel.classList.remove('translate-y-full');
    });
});

// Close panel when clicking outside
document.addEventListener('click', () => {
    document.getElementById('details-panel').classList.add('translate-y-full');
});

// Basic Drag and Drop simulation visual effect
let draggedElement = null;

document.querySelectorAll('.reservation-block').forEach(block => {
    block.setAttribute('draggable', true);
    
    block.addEventListener('dragstart', (e) => {
        draggedElement = block;
        block.style.opacity = '0.5';
        block.classList.add('scale-105', 'z-50', 'shadow-xl');
    });

    block.addEventListener('dragend', (e) => {
        block.style.opacity = '1';
        block.classList.remove('scale-105', 'z-50', 'shadow-xl');
        
        // Show success toast
        const toast = document.getElementById('toast');
        toast.classList.remove('translate-y-20', 'opacity-0');
        setTimeout(() => {
            toast.classList.add('translate-y-20', 'opacity-0');
        }, 3000);
    });
});

document.querySelectorAll('.group').forEach(cell => {
    cell.addEventListener('dragover', (e) => {
        e.preventDefault();
        cell.classList.add('bg-primary-container/10');
    });

    cell.addEventListener('dragleave', () => {
        cell.classList.remove('bg-primary-container/10');
    });

    cell.addEventListener('drop', (e) => {
        e.preventDefault();
        cell.classList.remove('bg-primary-container/10');
        if (draggedElement) {
            console.log('Element dropped on new cell');
        }
    });
});

// Time indicator update
function updateTimeLine() {
    // Placeholder for a real-time indicator logic if needed
}
setInterval(updateTimeLine, 60000);