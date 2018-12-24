# frozen_string_literal: true

require 'time_difference'

module Services
  class TimeDifferenceFormatter
    def initialize(start_time, end_time)
      @time_diff = TimeDifference.between(start_time, end_time)
    end
  
    def humanize
      I18n.locale = :fr
  
      diff_parts = []
  
      @time_diff.in_general.each do |part, quantity|
        next if quantity <= 0
  
        diff_parts << I18n.t(part.to_s.singularize, count: quantity)
      end
  
      last_part = diff_parts.pop
  
      return last_part if diff_parts.empty?
  
      [diff_parts.join(', '), last_part].join(I18n.t('join_word'))
    end
  end
  
end