require 'json'

def loadJson(filename)
  dataFile = File.open(filename, "r")
  doc = ""
  dataFile.each do |line|
    doc << line
  end
  dataFile.close
  JSON.parse(doc)
end

def loadOrganizations()
  jsonData = loadJson("./scripts/data/organizations.json")
  jsonData.each { |org| 
    org["id"] = org.delete("_id")
    domains = org.delete("domain_names")
    tags = org.delete("tags")
    
    Organization.create(org)

    domains.each { |domain_value| 
      DomainName.create(organization_id: org["id"], value: domain_value)
    }

    tags.each { |tag_value| 
      OrganizationTag.create(organization_id: org["id"], value: tag_value)
    }
  }
end

def loadUsers()
  jsonData = loadJson("./scripts/data/users.json")
  jsonData.each { |user| 
    user["id"] = user.delete("_id")
    tags = user.delete("tags")
    
    begin 
      User.create(user)

      tags.each { |tag_value| 
        UserTag.create(user_id: user["id"], value: tag_value)
      }
    rescue ActiveRecord::InvalidForeignKey
      puts "foreign key invalid for #{user}"
    end
  }
end

def loadTickets()
  jsonData = loadJson("./scripts/data/tickets.json")
  jsonData.each { |ticket| 
    ticket["id"] = ticket.delete("_id")
    ticket["ticket_type"] = ticket.delete("type")
    tags = ticket.delete("tags")
    
    begin 
      Ticket.create(ticket)

      tags.each { |tag_value| 
        TicketTag.create(ticket_id: ticket["id"], value: tag_value)
      }
    rescue ActiveRecord::InvalidForeignKey
      puts "foreign key invalid for #{ticket}"
    end

  }
end

loadOrganizations()
loadUsers()
loadTickets()

Organization.__elasticsearch__.create_index!
User.__elasticsearch__.create_index!
Ticket.__elasticsearch__.create_index!
Organization.import
User.import
Ticket.import 
