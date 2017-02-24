class <%= class_name %>Preview < Pixelpress::Preview<% passed_methods.each do |m| %>
  def <%= m %>
    <%= class_name %>Printer.<%= m %>
  end<% end %>
end
