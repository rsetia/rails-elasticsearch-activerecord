require 'search' 

class User < ActiveRecord::Base
  include Elasticsearch::Model

  belongs_to :organization
  has_many :user_tags

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :id, type: "integer"
      indexes :url, type: "keyword", null_value: "__NULL__"
      indexes :external_id, type: "keyword", null_value: "__NULL__"
      indexes :name, type: "keyword", null_value: "__NULL__"
      indexes :alias, type: "keyword", null_value: "__NULL__"
      indexes :created_at, type: "date"
      indexes :active, type: "boolean"
      indexes :verified, type: "boolean"
      indexes :shared, type: "boolean"
      indexes :locale, type: "keyword", null_value: "__NULL__"
      indexes :timezone, type: "keyword", null_value: "__NULL__"
      indexes :last_login_at, type: "date"
      indexes :email, type: "keyword", null_value: "__NULL__"
      indexes :phone, type: "keyword", null_value: "__NULL__"
      indexes :signature, type: "keyword", null_value: "__NULL__"
      indexes :organization_id, type: "integer"
      indexes :tags, type: "keyword", null_value: "__NULL__"
      indexes :suspended, type: "boolean"
      indexes :role, type: "keyword", null_value: "__NULL__"
    end
  end

  def as_indexed_json(options={})
    {
      id: self.id,
      url: self.url,
      external_id: self.external_id,
      name: self.name,
      alias: self.alias,
      created_at: self.created_at,
      active: self.active,
      verified: self.verified,
      shared: self.shared,
      locale: self.locale,
      timezone: self.timezone,
      last_login_at: self.last_login_at,
      email: self.email,
      phone: self.phone,
      signature: self.signature,
      organization_id: self.organization_id,
      tags: self.user_tags.map(&:value),
      suspended: self.suspended,
      role: self.role
    }
  end

  def as_json(options={})
    {
      id: self.id,
      url: self.url,
      external_id: self.external_id,
      name: self.name,
      alias: self.alias,
      created_at: self.created_at,
      active: self.active,
      verified: self.verified,
      shared: self.shared,
      locale: self.locale,
      timezone: self.timezone,
      last_login_at: self.last_login_at,
      email: self.email,
      phone: self.phone,
      signature: self.signature,
      organization: self.organization.name,
      tags: self.user_tags.map(&:value),
      suspended: self.suspended,
      role: self.role
    }
  end
end