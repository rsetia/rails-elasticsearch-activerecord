require 'search' 

class Ticket < ActiveRecord::Base
  include Elasticsearch::Model
  include Search

  belongs_to :submitter, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :organization
  has_many :ticket_tags

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :id, type: "integer"
      indexes :url, type: "keyword", null_value: "__NULL__"
      indexes :external_id, type: "keyword", null_value: "__NULL__"
      indexes :created_at, type: "date"
      indexes :ticket_type, type: "keyword", null_value: "__NULL__"
      indexes :subject, type: "keyword", null_value: "__NULL__"
      indexes :description, type: "keyword", null_value: "__NULL__"
      indexes :priority, type: "keyword", null_value: "__NULL__"
      indexes :status, type: "keyword", null_value: "__NULL__"
      indexes :submitter_id, type: "integer"
      indexes :assignee_id, type: "integer"
      indexes :organization_id, type: "integer"
      indexes :tags, type: "keyword", null_value: "__NULL__"
      indexes :has_incidents, type: "boolean"
      indexes :due_at, type: "date"
      indexes :via, type: "keyword", null_value: "__NULL__"
    end
  end

  def as_indexed_json(options={})
    {
      id: self.id,
      url: self.url,
      external_id: self.external_id,
      created_at: self.created_at,
      type: self.ticket_type,
      subject: self.subject,
      description: self.description,
      priority: self.priority,
      status: self.status,
      submitter_id: self.submitter_id,
      assignee_id: self.assignee_id,
      organization_id: self.organization_id,
      tags: self.ticket_tags.map(&:value),
      has_incidents: self.has_incidents,
      due_at: self.due_at,
      via: self.via
    }
  end

  def as_json(options={})
    {
      id: self.id,
      url: self.url,
      external_id: self.external_id,
      created_at: self.created_at,
      type: self.ticket_type,
      subject: self.subject,
      description: self.description,
      priority: self.priority,
      status: self.status,
      submitter: self.submitter.name,
      assignee: self.assignee.name,
      organization: self.organization.name,
      tags: self.ticket_tags.map(&:value),
      has_incidents: self.has_incidents,
      due_at: self.due_at,
      via: self.via
    }
  end
end