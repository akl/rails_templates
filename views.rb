


file 'app/views/layouts/_flashes.html.erb',
%q{<div id="flash">
<% flash.each do |key, value| -%>
<div id="flash_<%= key %>"><%=h value %></div>
<% end -%>
</div>
}
