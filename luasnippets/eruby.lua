return {
	s('form', fmt([[
		<%= form_with model: {} do |form| %>
			{}
		<% end %>
	]], { i(1), i(0) })),
	s('cache', fmt([[
		<% cache {} do %>
			{}
		<% end %>
	]], { i(1), i(0) })),
	s('label', fmt('<%= form.label :{} %>', { i(0) })),
	s('input', fmt('<%= form.text_field :{} %>', { i(0) })),
	s('input:text', fmt('<%= form.text_field :{} %>', { i(0) })),
	s('input:password', fmt('<%= form.password_field :{} %>', { i(0) })),
	s('input:email', fmt('<%= form.email_field :{} %>', { i(0) })),
	s('input:submit', fmt('<%= form.submit :{} %>', { i(0) })),
	s('input:button', fmt('<%= form.submit :{} %>', { i(0) })),
	s('link', fmt('<%= link_to "{}", {} %>', { i(1), i(0) })),
	s('button', fmt('<%= button_to "{}", {}, method: :{} %>', { i(1), i(2), i(0) })),
}
