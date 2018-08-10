module Search
	def scopeSearch(scope, field, value)
		query = { query: { match: { field => value } } }
		case scope
			when :organizations
				res = Organization.search query
			when :users
				res = User.search query
			when :tickets
				res = Ticket.search query
		end
		res.records.to_a
	end
end 