# frozen_string_literal: true

# # frozen_string_literal: true

require 'fuzzy_match'

intent 'RequestTime' do
  slot_value = request.slot_value('STIB_STOP')
  matching_points_ids = Point.that_sounds_like(slot_value).first(10).map(&:stib_id)

  return ask('je ne connais pas cet arrêt, pouvez-vous répétez?', start_over: true) if matching_points_ids.none?

  points = ::Services::StibRequest.waiting_time(matching_points_ids)['points']

  if points.any?
    out_speech = []

    points.each do |point|
      time_difference = []
      first_passing_time = point['passingTimes']
      destination = first_passing_time.first['destination']['fr']
      line_id = first_passing_time.first['lineId']
      point['passingTimes'].first(2).each do |passing_time|
        # Check if they is deviation
        if passing_time["message"]
          time_difference << passing_time["message"]["fr"]
        else
          start_time = DateTime.now
          end_time = DateTime.parse(passing_time['expectedArrivalTime'])
          time_difference << ::Services::TimeDifferenceFormatter.new(start_time, end_time).humanize
        end
      end
      puts out_speech
      out_speech << "Ligne #{line_id} à destination de #{destination} arrive dans #{time_difference.compact.join(', puis dans ')}"
    end
    puts out_speech
    tell(out_speech.compact.join('. '))
  else
    tell("Désolé, il n’y a plus de passage pour l’arrêt #{slot_value}")
  end
end
