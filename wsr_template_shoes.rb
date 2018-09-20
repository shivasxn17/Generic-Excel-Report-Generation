# event_handling.rb
# Interactive Shoes elements take an event handler as a block
require 'green_shoes'

Shoes.app(title: "WSR Generation", width: 200, height: 240) do
  flow width: 200, height: 240 do
    flow do
      background rgb(0, 157, 228)
      
    end
  end
end

#   # Shoes.app {
#   #   image "tcs.png"
#   # }



# Shoes.app do
# background "#EFC"
# border("#BE8",
#        strokewidth: 6)

# 	stack(margin: 12) do
# 	  para "Enter From Date"
# 	  flow do
# 	    edit_line
# 	    button "OK"
# 	  end
# 	  para "Enter To Date"
# 	  flow do
# 	    edit_line
# 	    button "OK"
# 	  end
# 	end

# 	@push = button "Create WSR"
#     @note = para "Click to Generated"
#     @push.click {
#       @note.replace "In Progress"
#     }

# end