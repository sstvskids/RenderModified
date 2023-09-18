--[[
    List of things u could change: 
    BackgroundColor - Gradient color of the main background
    BackgroundTransparency - Changes the transparency of the main background
    ProfilePictureBoxTransparency - Changes the transparency of the Profile Picture Box
    ProfilePictureBoxColor - Color of the ProfilePictureBoxColor
    NameTextColor - Changes the text that would contain the target's name
    HealthInfoTextColor - Changes the color of the text that would contain the target's health
    HealthbarBackgroundColor - Changes the healthbar's background color
    HealthbarColor - Changes the color or the healthbar
    ----------
    Make sure to add commas to each table value.
]]

local themetable = {
    Blood = {
        BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 0, 0))}),
        ProfilePictureBoxColor = Color3.fromRGB(48, 0, 1),
        NameTextColor = Color3.fromRGB(255, 255, 255),
        HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
        HealthbarBackgroundColor = Color3.fromRGB(59, 0, 88),
        HealthbarColor = Color3.fromRGB(255, 255, 255)
    },
    Green = {
        BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(79, 255, 3)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 154, 0))}),
        ProfilePictureBoxColor = Color3.fromRGB(25, 68, 29),
        NameTextColor = Color3.fromRGB(255, 255, 255),
        HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
        HealthbarBackgroundColor = Color3.fromRGB(1, 88, 7),
        HealthbarColor = Color3.fromRGB(255, 255, 255)
    },
    Ocean = {
        BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 77, 232)), ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 157, 255))}),
        ProfilePictureBoxColor = Color3.fromRGB(10, 85, 206),
        NameTextColor = Color3.fromRGB(255, 255, 255),
        HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
        HealthbarBackgroundColor = Color3.fromRGB(12, 129, 255),
        HealthbarColor = Color3.fromRGB(255, 255, 255)
    },
    Cupid = {
        BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 195)), ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 52, 157)), ColorSequenceKeypoint.new(1, Color3.fromRGB(249, 1, 245))}),
        ProfilePictureBoxColor = Color3.fromRGB(125, 0, 63),
        NameTextColor = Color3.fromRGB(255, 255, 255),
        HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
        HealthbarBackgroundColor = Color3.fromRGB(207, 2, 159),
        HealthbarColor = Color3.fromRGB(255, 255, 255)
    },
    Sunset = {
        BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 255, 15))}),
        ProfilePictureBoxColor = Color3.fromRGB(144, 47, 9),
        NameTextColor = Color3.fromRGB(255, 255, 255),
        HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
        HealthbarBackgroundColor = Color3.fromRGB(207, 2, 159),
        HealthbarColor = Color3.fromRGB(255, 255, 255)
    },
    Midnight = {
        BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 128))}),
        ProfilePictureBoxColor = Color3.fromRGB(0, 0, 128),
        NameTextColor = Color3.fromRGB(255, 255, 255),
        HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
        HealthbarBackgroundColor = Color3.fromRGB(0, 0, 128),
        HealthbarColor = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0
    },
}

return themetable