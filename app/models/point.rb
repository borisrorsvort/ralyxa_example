# frozen_string_literal: true

class Point < ActiveRecord::Base
  include PgSearch
  pg_search_scope :that_sounds_like,
                  against: :name,
                  using: {trigram: {threshold: 0.5}}
end
