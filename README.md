
# Legends-Tasks 🤠

A **RedM** script for managing mission tasks

![Legends Tasks Preview](https://i.ibb.co/6gYCLLV/Screenshot-2025-01-14-030538.png)  

---

## Features ✨
- Show/Hide a task list UI.
- Display progress (e.g., `0/4`, `1/4`, etc.) for each task.
- Toggle display of task numbers.
- Mark tasks as complete/incomplete.
- Set or reset tasks via commands or exports.

---

## Quick Setup 🏇
1. **Download or Clone** this repository.
2. Place the **`legends-tasks`** folder in your RedM server’s `resources` directory.
3. Add `ensure legends-tasks` to your `server.cfg` (or equivalent).

Example:
```
ensure legends-tasks
```

---

## Commands 💬
- **`/missiontest`**: Shows the UI and sets some example tasks.  
- **`/missionhide`**: Hides the UI.  
- **`/missionshow`**: Shows the UI again.  
- **`/missionnumbers show/hide`**: Toggles the display of task numbers.  
- **`/missionupdate <index> <stage>`**: Updates a specific task’s current stage.  
- **`/missioncomplete <index>`**: Toggles completion for a given task.  
- **`/missionreset`**: Resets completion for all tasks.  
- **`/missionsetall`**: Sets a brand-new list of tasks.

---

## Client Exports ⚙️
You can call these from any other client-side script.  
*(Make sure your resource is named `legends-tasks`.)*

```lua
--------------------------------------------------------------------------------
-- Show or Hide UI
exports["legends-tasks"]:ShowMissionUI(true)
exports["legends-tasks"]:ShowMissionUI(false)

--------------------------------------------------------------------------------
-- Toggle Task Number Visibility
exports["legends-tasks"]:ToggleTaskNumberVisibility(true)
exports["legends-tasks"]:ToggleTaskNumberVisibility(false)

--------------------------------------------------------------------------------
-- Update All Task Amounts (sets same current stage for all tasks)
exports["legends-tasks"]:UpdateAllTaskAmounts(1)

--------------------------------------------------------------------------------
-- Update Single Task Progress
exports["legends-tasks"]:UpdateSingleTaskProgress(index, newStage)

--------------------------------------------------------------------------------
-- Toggle Completion for a Task
exports["legends-tasks"]:ToggleCompletionForTask(index)

--------------------------------------------------------------------------------
-- Set All Tasks (pass a table of {text, current, total})
local newTasks = {
  { text = "Rob the bank", current = 0, total = 4 },
  { text = "Deliver 5 letters", current = 0, total = 5 }
}
exports["legends-tasks"]:SetAllTasks(newTasks)

--------------------------------------------------------------------------------
-- Reset All Task Completions
exports["legends-tasks"]:ResetAllTaskCompletions()
```

---

## Simple Example 🛠
```lua
RegisterCommand('showmymissions', function(source, args, rawCommand)
    -- Show UI
    exports["legends-tasks"]:ShowMissionUI(true)

    -- Create some tasks
    local tasks = {
        { text = "Collect 3 Pelts", current = 0, total = 3 },
        { text = "Deliver them to the Butcher", current = 0, total = 1 }
    }

    -- Set tasks
    exports["legends-tasks"]:SetAllTasks(tasks)
end)
```

---

## Contributing 🤝
- Feel free to open issues or submit pull requests with suggestions/fixes.

---