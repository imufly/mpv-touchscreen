require 'mp.options'

local options = {
  step = 5,
}

read_options(options,'touchscreen-seek')

function touch_seek()
  local pos = get_mouse_area()
  local step = options.step

  if pos == 'left' then
    mp.commandv('seek', -1*step)
  elseif pos == 'right' then
    mp.commandv('seek', step)
  else
    toggle_fullscreen()
  end

end

function get_mouse_area()
  local mouse_x,mouse_y = mp.get_mouse_pos()
  local winX,winY = mp.get_property('osd-width'), mp.get_property('osd-height')

  if mouse_x < winX/3 then
    return 'left'
  elseif mouse_x < winX/3*2 then
    return 'middle'
  else
    return 'right'
end

end

function toggle_fullscreen()
  local screen_stat = mp.get_property('fullscreen')

  if screen_stat == 'yes' then
    screen_stat = 'no'
  else
    screen_stat = 'yes'
  end

  mp.set_property('fullscreen', screen_stat)

end

mp.add_key_binding(nil, "touchscreen-seek", touch_seek)
mp.msg.info("Loaded touchscreen-seek Lua flavor")