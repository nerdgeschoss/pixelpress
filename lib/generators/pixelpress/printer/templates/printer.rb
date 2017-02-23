<% module_namespacing do -%>
class <%= class_name %>Printer < ApplicationPrinter

  <% passed_methods.each do |m| %>
  def <%= m %>
    #put your code here, if you want :)
  end  	
  <% end %>
end
<% end -%>