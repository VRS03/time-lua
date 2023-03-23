-- Services --

local TweenService = game:GetService("TweenService")

-- Variables --

local player = game.Players.LocalPlayer
local gui = script.Parent.Parent.UI:WaitForChild("ScreenGui")

local year = gui.Frame.YearInput
local month = gui.Frame.MonthInput
local day = gui.Frame.DayInput
local hour = gui.Frame.HoursInput
local minutes = gui.Frame.MinutesInput

local runButton = gui.Frame.CalculateButton
local endButton = gui.Frame.EndButton
shouldRun = true


-- Functions --


-- Events --

runButton.MouseButton1Click:Connect(function()
	
	shouldRun = true
	
	
	if #year.Text > 0 and tonumber(year.Text) > 0 and #month.Text > 0 and tonumber(month.Text) >= 1 and tonumber(month.Text)<= 12 and #day.Text > 0 and tonumber(day.Text) >= 1 and tonumber(day.Text) <= 31 then
		
		local yearInput = year.Text
		local monthInput = month.Text
		local dayInput = day.Text
		local hourInput = 0
		local minuteInput = 0
		
		-- Activate End Button
		runButton.Visible = false
		endButton.Visible = true
		
		
		if #hour.Text > 0 and tonumber(hour.Text) <= 24 and tonumber(hour.Text) >= 0 then
			hourInput = hour.Text
		else
			--print("Invalid/No Hour Input")
		end
		
		if #minutes.Text > 0 and tonumber(minutes.Text) <= 60 and tonumber(minutes.Text) >= 0 then
			minuteInput = minutes.Text
		else
			--print("Invalid/No minute input")
		end
		
		
		
		while shouldRun do
			
			local unixWanted = DateTime.fromLocalTime(yearInput , monthInput , dayInput , hourInput , minuteInput , 0 , 0)
			local endTime = unixWanted.UnixTimestamp
			local currentTime = os.time()
			local timeDifference = tonumber(endTime) - currentTime
			print(timeDifference)
			
			if timeDifference < 0 then
				
				-- User entered a past time
				timeDifference = math.abs(timeDifference)
				local minutes = timeDifference / 60
				local hours = minutes / 60
				local days = hours / 24
				local remainderOfDay

				if days < 1 then
					remainderOfDay = days % 1
				else
					remainderOfDay = days % math.floor(days)
				end

				local finalDays = math.floor(days)
				local updateHours = remainderOfDay * 24
				local hourRemainder = updateHours % math.floor(updateHours)
				local finalHours = math.floor(updateHours)
				local updateMinutes = hourRemainder * 60 
				local minutesRemainder = updateMinutes % math.floor(updateMinutes)
				local finalMinutes = math.floor(updateMinutes)
				local finalSeconds = math.floor(minutesRemainder * 60)

				print("Days: " , finalDays , " Hours: " , finalHours , " Minutes: " , finalMinutes , " Seconds: " , finalSeconds)
				local dayDisplay = gui.Frame.DayResult
				local hourDisplay = gui.Frame.HourResult
				local minutesDisplay = gui.Frame.MinuteResult
				local secondsDisplay = gui.Frame.SecondResult

				dayDisplay.Text = tostring(finalDays)
				hourDisplay.Text = tostring(finalHours)
				minutesDisplay.Text = tostring(finalMinutes)
				secondsDisplay.Text = tostring(finalSeconds)
				
			end
			
			if timeDifference > 0 then
				
				local minutes = timeDifference / 60
				local hours = minutes / 60
				local days = hours / 24
				local remainderOfDay

				if days < 1 then
					remainderOfDay = days % 1
				else
					remainderOfDay = days % math.floor(days)
				end

				local finalDays = math.floor(days)
				local updateHours = remainderOfDay * 24
				local hourRemainder = updateHours % math.floor(updateHours)
				local finalHours = math.floor(updateHours)
				local updateMinutes = hourRemainder * 60 
				local minutesRemainder = updateMinutes % math.floor(updateMinutes)
				local finalMinutes = math.floor(updateMinutes)
				local finalSeconds = math.floor(minutesRemainder * 60)

				--print("Days: " , finalDays , " Hours: " , finalHours , " Minutes: " , finalMinutes , " Seconds: " , finalSeconds)
				local dayDisplay = gui.Frame.DayResult
				local hourDisplay = gui.Frame.HourResult
				local minutesDisplay = gui.Frame.MinuteResult
				local secondsDisplay = gui.Frame.SecondResult

				dayDisplay.Text = tostring(finalDays)
				hourDisplay.Text = tostring(finalHours)
				minutesDisplay.Text = tostring(finalMinutes)
				secondsDisplay.Text = tostring(finalSeconds)
				
			end
			
			
			task.wait(1)
			
		end
		
	else
		-- Not all required fields were filled out'
		local alert = gui.Frame.Alert
		alert:TweenPosition(
			UDim2.new(0.01 , 0 , 0.645 , 0),
			"Out",
			"Quad",
			0.5,
			false
		)
		
		wait(3)
		
		alert:TweenPosition(
			UDim2.new(-0.25 , 0 , 0.645, 0),
			"In",
			"Quad",
			0.5,
			false
		)
		
	end
	
end)

endButton.MouseButton1Click:Connect(function()
	shouldRun = false
	endButton.Visible = false
	runButton.Visible = true
end)

