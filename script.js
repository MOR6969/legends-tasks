const missionList = document.querySelector('.mission-list');
let taskData = [];

// Handle all incoming NUI messages
window.addEventListener('message', function(event) {
    const data = event.data;

    switch (data.type) {
        case 'toggleUi':
            document.body.style.display = data.table.state ? 'block' : 'none';
            break;

        case 'toggleNumberOfTask':
            document.querySelectorAll('.task-number').forEach(el => {
                el.style.display = data.table.state ? 'inline' : 'none';
            });
            break;

        case 'updateTaskAmount':
            updateTaskProgress(data.table.taskAmount);
            break;

        case 'updateStageAmount':
            updateStageProgress(data.table.index, data.table.currentStage);
            break;

        case 'toggleCompleteByIndex':
            toggleComplete(data.table.index);
            break;

        case 'setTaskData':
            setTasks(data.table);
            break;

        case 'resetCompletes':
            resetAllCompletes();
            break;
    }
});

function updateTaskProgress(amount) {
    document.querySelectorAll('.mission-progress').forEach(el => {
        const [current, total] = el.textContent.split('/');
        el.textContent = `${amount}/${total}`;
    });
}

function updateStageProgress(index, currentStage) {
    const missionItem = missionList.children[index];
    if (missionItem) {
        const progress = missionItem.querySelector('.mission-progress');
        const [_, total] = progress.textContent.split('/');
        progress.textContent = `${currentStage}/${total}`;
    }
}

function toggleComplete(index) {
    const missionItem = missionList.children[index];
    if (missionItem) {
        missionItem.classList.toggle('mission-complete');
    }
}

function setTasks(tasks) {
    taskData = tasks;
    missionList.innerHTML = '';
    
    tasks.forEach((task, index) => {
        const li = document.createElement('li');
        li.className = 'mission-item';
        li.innerHTML = `
            <span class="task-number">${index + 1}</span>
            <div class="mission-progress">${task.current}/${task.total}</div>
            <div class="mission-text">${task.text}</div>
        `;
        missionList.appendChild(li);
    });
}

function resetAllCompletes() {
    document.querySelectorAll('.mission-item').forEach(item => {
        item.classList.remove('mission-complete');
    });
}

// Initialize with some default tasks if needed
// setTasks([
//     { text: "Complete mission 1", current: 0, total: 4 },
//     { text: "Complete mission 2", current: 0, total: 8 },
//     { text: "Complete mission 3", current: 0, total: 5 }
// ]);