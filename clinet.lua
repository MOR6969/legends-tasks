--------------------------------------------------------------------------------
--  NUI Message Handler
--------------------------------------------------------------------------------

local function SendNUIEvent(eventType, data)
  SendNUIMessage({
      type  = eventType,
      table = data
  })
end

--------------------------------------------------------------------------------
--  UI Visibility
--------------------------------------------------------------------------------

local function ShowMissionUI(isVisible)
  SendNUIEvent('toggleUi', { state = isVisible })
end

exports('ShowMissionUI', ShowMissionUI)

--------------------------------------------------------------------------------
--  Task Number Toggle
--------------------------------------------------------------------------------

local function ToggleTaskNumberVisibility(isVisible)
  SendNUIEvent('toggleNumberOfTask', { state = isVisible })
end

exports('ToggleTaskNumberVisibility', ToggleTaskNumberVisibility)

--------------------------------------------------------------------------------
--  Task Amount Update
--------------------------------------------------------------------------------

local function UpdateAllTaskAmounts(taskAmount)
  SendNUIEvent('updateTaskAmount', { taskAmount = taskAmount })
end

exports('UpdateAllTaskAmounts', UpdateAllTaskAmounts)

--------------------------------------------------------------------------------
--  Stage Amount Update (for a specific task)
--------------------------------------------------------------------------------

local function UpdateSingleTaskProgress(taskIndex, currentStage)
  SendNUIEvent('updateStageAmount', {
      index        = taskIndex,
      currentStage = currentStage
  })
end

exports('UpdateSingleTaskProgress', UpdateSingleTaskProgress)

--------------------------------------------------------------------------------
--  Toggle Completion By Index
--------------------------------------------------------------------------------

local function ToggleCompletionForTask(taskIndex)
  SendNUIEvent('toggleCompleteByIndex', { index = taskIndex })
end

exports('ToggleCompletionForTask', ToggleCompletionForTask)

--------------------------------------------------------------------------------
--  Set Entire Task Table
--------------------------------------------------------------------------------

local function SetAllTasks(taskData)
  -- taskData should be a table of tasks: { { text = "Task Name", current=0, total=4 }, ... }
  SendNUIEvent('setTaskData', taskData)
end

exports('SetAllTasks', SetAllTasks)

--------------------------------------------------------------------------------
--  Reset All Completion States
--------------------------------------------------------------------------------

local function ResetAllTaskCompletions()
  SendNUIEvent('resetCompletes')
end

exports('ResetAllTaskCompletions', ResetAllTaskCompletions)

--------------------------------------------------------------------------------
--  TEST COMMANDS (Rename as you see fit)
--------------------------------------------------------------------------------

-- Example: /missiontest
RegisterCommand('missiontest', function(source, args, rawCommand)
  -- Show UI
  exports["legends-tasks"]:ShowMissionUI(true)

  -- Initialize some example tasks
  local exampleTasks = {
      { text = "Steal supplies from Valentine general store", current = 0, total = 4 },
      { text = "Hunt legendary bear in Tall Trees",          current = 0, total = 3 },
      { text = "Deliver mail packages to Rhodes",            current = 0, total = 5 }
  }

  exports["legends-tasks"]:SetAllTasks(exampleTasks)
end)

-- Example: /missionhide
RegisterCommand('missionhide', function(source, args, rawCommand)
  exports["legends-tasks"]:ShowMissionUI(false)
end)

-- Example: /missionshow
RegisterCommand('missionshow', function(source, args, rawCommand)
  exports["legends-tasks"]:ShowMissionUI(true)
end)

-- Example: /missionnumbers show  OR  /missionnumbers hide
RegisterCommand('missionnumbers', function(source, args, rawCommand)
  if args[1] == 'show' then
      exports["legends-tasks"]:ToggleTaskNumberVisibility(true)
  elseif args[1] == 'hide' then
      exports["legends-tasks"]:ToggleTaskNumberVisibility(false)
  end
end)

-- Example: /missionupdate 1 2
-- Updates the current stage for the 1st task to 2
RegisterCommand('missionupdate', function(source, args, rawCommand)
  local taskIndex = tonumber(args[1]) or 0
  local newStage  = tonumber(args[2]) or 0
  exports["legends-tasks"]:UpdateSingleTaskProgress(taskIndex, newStage)
end)

-- Example: /missioncomplete 1
RegisterCommand('missioncomplete', function(source, args, rawCommand)
  local taskIndex = tonumber(args[1]) or 0
  exports["legends-tasks"]:ToggleCompletionForTask(taskIndex)
end)

-- Example: /missionreset
RegisterCommand('missionreset', function(source, args, rawCommand)
  exports["legends-tasks"]:ResetAllTaskCompletions()
end)

-- Example: /missionsetall
RegisterCommand('missionsetall', function(source, args, rawCommand)
  local newTasks = {
      { text = "Rob the Saint Denis bank",                current = 0, total = 6 },
      { text = "Find treasure near Blackwater",           current = 0, total = 4 },
      { text = "Help locals in Armadillo",                current = 0, total = 3 },
      { text = "Clear gang hideout in Thieves Landing",   current = 0, total = 5 }
  }

  exports["legends-tasks"]:SetAllTasks(newTasks)
end)
