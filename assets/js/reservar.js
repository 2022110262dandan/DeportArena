// Micro-interactions for calendar and slots
if (document.querySelectorAll('.calendar-grid button').length) {
    document.querySelectorAll('.calendar-grid button').forEach(button => {
        button.addEventListener('click', function() {
            if(this.classList.contains('pointer-events-none')) return;
            document.querySelectorAll('.calendar-grid button').forEach(b => {
                b.classList.remove('bg-primary', 'text-white', 'shadow-md', 'font-bold');
                if(!b.classList.contains('text-surface-dim')) {
                    b.classList.add('hover:bg-surface-container-high', 'text-on-surface', 'font-medium', 'border-transparent');
                }
            });
            this.classList.add('bg-primary', 'text-white', 'shadow-md', 'font-bold');
            this.classList.remove('hover:bg-surface-container-high', 'text-on-surface', 'font-medium', 'border-transparent');
        });
    });
}

if (document.querySelectorAll('.time-slot-grid button').length) {
    document.querySelectorAll('.time-slot-grid button').forEach(button => {
        button.addEventListener('click', function() {
            if(this.classList.contains('cursor-not-allowed')) return;
            
            document.querySelectorAll('.time-slot-grid button').forEach(b => {
                if(!b.classList.contains('cursor-not-allowed')) {
                    b.className = "p-3 rounded-lg border border-outline-variant hover:bg-primary hover:text-white transition-all text-center";
                    const p = b.querySelector('p');
                    if(p) p.textContent = "Libre";
                    if(p) p.classList.remove('opacity-70');
                    if(p) p.classList.add('opacity-70');
                }
            });

            this.className = "p-3 rounded-lg bg-primary-container text-on-primary-container border border-primary-container font-bold text-center";
            const p = this.querySelector('p');
            if(p) p.textContent = "Selecc.";
            if(p) p.classList.remove('opacity-70');
        });
    });
}

// Calendar grid dynamic filler (keeps original behavior)
const grid = document.querySelector('.calendar-grid');
if (grid) {
    for (let i = 13; i <= 31; i++) {
        const btn = document.createElement('button');
        btn.className = "p-4 rounded-lg hover:bg-surface-container-high transition-all text-on-surface font-medium border border-transparent";
        btn.textContent = i;
        grid.appendChild(btn);
    }
}