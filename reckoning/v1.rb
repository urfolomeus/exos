class ReckoningV1 < Sinatra::Base

  # Create a score (to preserve creation date for scores)
  # This is idempotent
  # TODO: write tests
  # TODO: remove duplicate
  put '/scores/:uid/touch' do |uid|
    score = Score.find_or_create_by_uid(uid)

    if score.new_record?
      score.save!
      response.status = 201
    end
    "Ok"
  end

  # Create a score (to preserve creation date for scores)
  # This is idempotent
  # TODO: write tests
  # TODO: remove duplicate
  post '/scores/:uid/touch' do |uid|
    score = Score.find_or_create_by_uid(uid)

    if score.new_record?
      score.save!
      response.status = 201
    end
    "Ok"
  end

end

