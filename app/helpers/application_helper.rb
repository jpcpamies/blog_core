module ApplicationHelper
	# Le paso dos parámetros para poder hacer que sea dinámico y usarlo por separado en cada vista independientemente.
	def article_cover url, options={}
		html_class = options[:class]
		html_style = "background:url(#{url});background-size:cover;"
		html = "<header style='#{html_style}' class='#{html_class}'></header>"
		html.html_safe
	end
	
end
