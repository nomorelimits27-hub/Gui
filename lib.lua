-- ============================================================
-- COMPATIBILITY METHODS (NewToggle, NewButton, NewSlider, NewSection)
-- These just call the Add methods so your main script works!
-- ============================================================

function CustomUI:NewSection(tab, name)
    return self:AddSection(tab, name)
end

function CustomUI:NewToggle(section, name, desc, callback)
    return self:AddToggle(section, name, desc, callback)
end

function CustomUI:NewButton(section, name, desc, callback)
    return self:AddButton(section, name, desc, callback)
end

function CustomUI:NewSlider(section, name, min, max, default, callback)
    return self:AddSlider(section, name, min, max, default, callback)
end
