require 'search' 

class Organization < ActiveRecord::Base
  include Elasticsearch::Model
  include Search

  has_many :domain_names 
  has_many :organization_tags

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :id, type: "integer"
      indexes :url, type: "keyword", null_value: "__NULL__"
      indexes :external_id, type: "keyword", null_value: "__NULL__"
      indexes :name, type: "keyword", null_value: "__NULL__"
      indexes :created_at, type: "date"
      indexes :details, type: "keyword", null_value: "__NULL__"
      indexes :shared_tickets, type: "boolean"
      indexes :domain_names, type: "keyword", null_value: "__NULL__"
      indexes :tags, type: "keyword", null_value: "__NULL__"
    end
  end

  def as_indexed_json(options={})
    {
      id: self.id,
      url: self.url,
      external_id: self.external_id,
      name: self.name,
      created_at: self.created_at,
      details: self.details,
      shared_tickets: self.shared_tickets,
      domain_names: self.domain_names.map(&:value),
      tags: self.organization_tags.map(&:value)
    }
  end

  def users()
    User.where(organization_id: self.id)
  end

  def tickets()
    Ticket.where(organization_id: self.id)
  end

  def as_json(options={})
    {
      id: self.id,
      url: self.url,
      external_id: self.external_id,
      name: self.name,
      created_at: self.created_at,
      details: self.details,
      shared_tickets: self.shared_tickets,
      domain_names: self.domain_names.map(&:value),
      tags: self.organization_tags.map(&:value),
      users: self.users().map(&:name),
      tickets: self.tickets().map(&:subject)
    }
  end
end