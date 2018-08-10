require 'optparse'
require 'search'
include Search

ARGV << '-h' if ARGV.empty?

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: search.rb [options]"

  opts.on("-s", "--scope SCOPE", [:organizations, :users, :tickets], "Search scope (organizations, users, tickets)") do |v|
    options[:scope] = v
  end

  opts.on("-f", "--field FIELD", "Field to search within the scope") do |v|
    options[:field] = v
  end

  opts.on("-v", "--value VALUE", "Value to search within the field") do |v|
    options[:value] = v
  end
end

begin
  optparse.parse!  
  raise OptionParser::MissingArgument unless options[:scope] and options[:field] and options[:value]                                               
rescue OptionParser::InvalidOption, OptionParser::MissingArgument      
  puts $!.to_s                                                           
  puts optparse                                                          
  exit                                                                   
end  

options[:value] = "__NULL__" if options[:value] == ""

begin 
	puts scopeSearch(options[:scope], options[:field], options[:value]).to_json
rescue Elasticsearch::Transport::Transport::Errors::BadRequest
	puts "invalid value #{options[:value]} for the given field \"#{options[:field]}\""
end
