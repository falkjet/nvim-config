local pattern = require 'config.snippetutils'.pattern
local auto = require 'config.snippetutils'.auto_c
local tab = require 'config.snippetutils'.tab_c

return {
	tab('link', [[ <%= link_to {} %> ]], i(0)),
	tab('render', [[ <%= render {} %> ]], i(0)),
	tab('frame', [[
		<%= turbo_frame_tag {} do %>
			{}
		<% end %>
	]], i(1), i(0)),
	auto('if (.*) then', [[
		<% if {} %>
			{}
		<% end %>
	]], 1, i(0)),

	auto('for (.* in .*) do', [[
		<% for {} %>
			{}
		<% end %>
	]], 1, i(0)),
}
